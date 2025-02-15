import os
from PIL import Image
from pathlib import Path
import json

import export.level_utils as level_utils
import utils.common as common
import utils.common as common_gfx
import utils.build as build


def export_gfx_if_updated(source_path, generated_dir, force_export):
	source_name = common.path_to_basename(source_path)

	export_paths = {"ram_disk" : generated_dir + source_name + "_gfx" + build.EXT_ASM }

	if force_export or is_source_updated(source_path):
		export_gfx( source_path, export_paths["ram_disk"])
			
		print(f"export_level: {source_path} got exported.")		
		return True, export_paths
	else:
		return False, export_paths

def export_gfx(source_j_path, export_gfx_path):
	with open(source_j_path, "rb") as file:
		source_j = json.load(file)

	source_dir = str(Path(source_j_path).parent) + "\\"

	if "asset_type" not in source_j or source_j["asset_type"] != build.ASSET_TYPE_TILED_IMG:
		build.exit_error(f'export_tiled_img ERROR: asset_type != "{build.ASSET_TYPE_TILED_IMG}", path: {source_j_path}')

	path_png = source_dir + source_j["path_png"]
	image = Image.open(path_png)

	source_name = common.path_to_basename(source_j_path)
	
	asm = ""
	asm = f"__RAM_DISK_S_{source_name.upper()}_GFX = RAM_DISK_S\n"
	asm += f"__RAM_DISK_M_{source_name.upper()}_GFX = RAM_DISK_M\n"
	
	palette_asm, colors = common_gfx.palette_to_asm(image, source_j, path_png, "_" + source_name)
	asm += palette_asm

	image = common_gfx.remap_colors(image, colors)

	tiled_file_path = source_dir + source_j['path']
	with open(tiled_file_path, "rb") as file:
		tiled_file_j = json.load(file)

	# make a tile index remap dictionary, to have the first idx = 0
	remap_idxs = remap_indices(tiled_file_j)

	if len(remap_idxs) > TILED_IMG_GFX_IDX_MAX:
		build.exit_error(f'export_tiled_img ERROR: gfx_idxs > "{TILED_IMG_GFX_IDX_MAX}", path: {source_j_path}')

	# list of tiles addreses
	png_name = common.path_to_basename(path_png)

	# remove it because this gives a big overhead for such small tiles.
	# asm += common_gfx.get_list_of_tiles(remap_idxs, "__" + source_name, png_name)
	
	# tile gfx data to asm
	asm += gfx_to_asm(image, remap_idxs, "__" + png_name)

	# save asm
	export_dir = str(Path(export_gfx_path).parent) + "\\"		
	if not os.path.exists(export_dir):
		os.mkdir(export_dir)	
	with open(export_gfx_path, "w") as file:
		file.write(asm)	
