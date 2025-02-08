import os
from PIL import Image
from pathlib import Path
import json

import export.level_utils as level_utils
import utils.common as common
import utils.common_gfx as common_gfx
import utils.build as build

def export_if_updated(asset_j_path, asm_meta_path, asm_data_path, bin_path,
		force_export):

	if force_export or level_utils.is_source_updated(asset_j_path, build.ASSET_TYPE_LEVEL_GFX):
		export_asm(asset_j_path, asm_meta_path, asm_data_path, bin_path)
		print(f"export_level_gfx: {asset_j_path} got exported.")

def export_asm(asset_j_path, asm_meta_path, asm_data_path, bin_path):

	with open(asset_j_path, "rb") as file:
		asset_j = json.load(file)

	asset_dir = str(Path(asset_j_path).parent) + "/"
	level_j_path = asset_dir + asset_j["path_level"]

	asm_ram_disk_data, data_ptrs, remap_idxs = data_to_asm(level_j_path)
	asm_ram_data = data_ptrs_to_asm(level_j_path, data_ptrs, remap_idxs)

	# save the asm gfx
	asm_data_dir = str(Path(asm_data_path).parent) + "/"
	if not os.path.exists(asm_data_dir):
		os.mkdir(asm_data_dir)
	with open(asm_data_path, "w") as file:
		file.write(asm_ram_disk_data)
	
	# compile and save the gfx bin files 
	build.export_fdd_file(asm_meta_path, asm_data_path, bin_path, asm_ram_data)

	return True

def data_to_asm(level_j_path):

	with open(level_j_path, "rb") as file:
		level_j = json.load(file)

	level_name = common.path_to_basename(level_j_path)
	level_dir = str(Path(level_j_path).parent) + "/"

	path_png = level_dir + level_j["path_png"]
	image = Image.open(path_png)
	
	_, colors = common_gfx.palette_to_asm(image, level_j, path_png, "_" + level_name)

	image = common_gfx.remap_colors(image, colors)
	
	room_paths = level_j["rooms"]
	rooms_j = []
	# load and parse tiled map
	for room_path_p in room_paths:
		room_path = level_dir + room_path_p['path']
		with open(room_path, "rb") as file:
			rooms_j.append(json.load(file))

	# make a tile index remap dictionary, to have the first idx = 0
	remap_idxs = level_utils.remap_index(rooms_j)

	# list of tiles addreses
	png_name = common.path_to_basename(path_png)
	
	# tile gfx data to asm
	asm, gfx_ptrs = gfx_to_asm(rooms_j[0], image, path_png, remap_idxs, "_" + png_name)

	return asm, gfx_ptrs, remap_idxs

def data_ptrs_to_asm(level_j_path, data_ptrs, remap_idxs):
	
	with open(level_j_path, "rb") as file:
		level_j = json.load(file)

	level_name = common.path_to_basename(level_j_path)
	level_dir = str(Path(level_j_path).parent) + "/"

	asm = ""

	path_png = level_dir + level_j["path_png"]
	image = Image.open(path_png)
	
	# palette
	palette_asm, colors = common_gfx.palette_to_asm(image, level_j, path_png, "_" + level_name)
	asm += palette_asm + "\n"

	
	# list of tiles
	for label, addr in data_ptrs.items():
		asm += f"{label} = {addr}\n"
	asm += "\n"
	
	png_name = common.path_to_basename(path_png)
	asm += common_gfx.get_list_of_tiles(remap_idxs, "_" + level_name, png_name)

	return asm


def gfx_to_asm(room_j, image, path, remap_idxs, label_prefix):
	asm = "; " + path + "\n"
	asm += label_prefix + "_tiles:\n"

	tileW = room_j["tilewidth"]
	tileH = room_j["tileheight"]
	
	width = room_j["layers"][0]["width"]
	height = room_j["layers"][0]["height"]
	
	tile_ptrs = {}
	tile_addr_offset = 2 # added safety pair of bytes for reading by POP B

	# extract tile images and convert them into asm
	for t_idx in remap_idxs:
		# get a tile as a color index 2d array
		tile_img = []
		idx = (t_idx - 1) % 256 # because in Tiled exported data the first tile index is 1 instead of 0.
		sx = idx % width * tileW
		sy = idx // width * tileH
		for y in range(sy, sy + tileH):
			line = []
			for x in range(sx, sx + tileW):
				color_idx = image.getpixel((x, y))
				line.append(color_idx)
				#x += 1
			tile_img.append(line)
			#y += 1
		
		# convert indexes into bit lists.
		bits0, bits1, bits2, bits3 = common_gfx.indexes_to_bit_lists(tile_img)

		# combite bits into byte lists
		bytes0 = common.combine_bits_to_bytes(bits0) # 8000-9FFF # from left to right, from bottom to top
		bytes1 = common.combine_bits_to_bytes(bits1) # A000-BFFF
		bytes2 = common.combine_bits_to_bytes(bits2) # C000-DFFF
		bytes3 = common.combine_bits_to_bytes(bits3) # E000-FFFF

		# to support a tile render function
		data, mask = level_utils.get_tiledata(bytes0, bytes1, bytes2, bytes3)

		label = label_prefix + "_tile" + str(remap_idxs[t_idx])

		asm += "			.word 0 ; safety pair of bytes for reading by POP B\n"
		asm += label + ":\n"
		asm += "			.byte " + str(mask) + " ; mask\n"
		asm += "			.byte 4 ; counter\n"
		asm += common.bytes_to_asm(data)

		tile_ptrs[label] = tile_addr_offset
		tile_addr_offset += 4 + len(data)

	return asm, tile_ptrs
