import os
import json

from utils import build
from utils import common
from export import config_utils
from export import export_font
from export import export_music
from export import export_level_data
from export import export_level_gfx
from export import export_sprite
from export import export_fdd
from export import export_tiled_img_data
from export import export_tiled_img_gfx
from export import export_text
from export import export_decal
from export import export_back


def export(config_j_path):

	build.printc(";===========================================================================", build.TextColor.MAGENTA)
	build.printc(";", build.TextColor.MAGENTA)
	build.printc(f"; ram-disk data export: {config_j_path}", build.TextColor.MAGENTA)
	build.printc(";", build.TextColor.MAGENTA)
	build.printc(";===========================================================================", build.TextColor.MAGENTA)
	print("\n")

	common.CheckPath(config_j_path, "Config file not found")
	with open(config_j_path, "rb") as file:
			config_j = json.load(file)

	common.CheckJsonField(
		config_j, "asset_type",
		f'export_config ERROR: asset_type != "{build.ASSET_TYPE_CONFIG}", path: {config_j_path}',
		build.ASSET_TYPE_CONFIG)

	# set the global vars
	# strip of the path to make it approprite for windows console processor
	assembler_path = config_j["assembler_path"]
	build.set_assembler_path(assembler_path)
	build.set_assembler_labels_cmd(config_j["assembler_labels_cmd"])
	build.set_packer(build.PACKER_ZX0_SALVADORE, config_j["packer_path"])
	build.set_emulator_path(config_j["emulator_path"])
	build.build_db_init(config_j["build_db_path"])

	# make necessary directories
	build_code_dir = build.build_subfolder + config_j["export_dir"]["code"]
	build_bin_dir = build.build_subfolder + config_j["export_dir"]["bin"]
	os.makedirs(os.path.dirname(build.build_subfolder), exist_ok=True)
	os.makedirs(os.path.dirname(build_code_dir), exist_ok=True)
	os.makedirs(os.path.dirname(build_bin_dir), exist_ok=True)

	# check if general scripts were updated
	dependency_paths_j = config_j["dependencies"]
	global_force_export = False
	for path in dependency_paths_j["scripts"]:
		if not os.path.exists(path):
			build.exit_error(f'export_config ERROR: script file not found: {path}')
		global_force_export |= build.is_file_updated(path)
	asset_types_dependencies = dependency_paths_j["exporters"]


	# check if asset-type-related scripts were updated
	asset_types_force_export = {}
	for asset_type in asset_types_dependencies:
		path = asset_types_dependencies[asset_type]
		if not os.path.exists(path):
			build.exit_error(f'export_config ERROR: script file not found: {path}')
		asset_types_force_export[asset_type] = global_force_export | build.is_file_updated(path)

	# export assets
	assets = []
	# export the loads
	for load_name in config_j["loads"]:
		for asset_j_path in config_j["loads"][load_name]:

			if not os.path.exists(asset_j_path):
				build.exit_error(f'export_config ERROR: file not found: {asset_j_path}')

			asm_meta_path, asm_data_path, bin_path, asset_type = \
				get_asset_export_paths(asset_j_path, build_bin_dir)

			force_export = asset_types_force_export[asset_type]

			match asset_type:
				case build.ASSET_TYPE_FONT:
					export_font.export_if_updated(
							asset_j_path,
							asm_meta_path, asm_data_path, bin_path,
							force_export)

				case build.ASSET_TYPE_MUSIC:
					export_music.export_if_updated(
							asset_j_path,
							asm_meta_path, asm_data_path, bin_path,
							force_export)
				
				case build.ASSET_TYPE_LEVEL_DATA:
					export_level_data.export_if_updated(
							asset_j_path,
							asm_meta_path, asm_data_path, bin_path,
							force_export)
					
				case build.ASSET_TYPE_LEVEL_GFX:
					export_level_gfx.export_if_updated(
							asset_j_path,
							asm_meta_path, asm_data_path, bin_path,
							force_export)
					
				case build.ASSET_TYPE_SPRITE:
					export_sprite.export_if_updated(
							asset_j_path,
							asm_meta_path, asm_data_path, bin_path,
							force_export)
					
				case build.ASSET_TYPE_TILED_IMG_DATA:
					export_tiled_img_data.export_if_updated(
							asset_j_path,
							asm_meta_path, asm_data_path, bin_path,
							force_export)
					
				case build.ASSET_TYPE_TILED_IMG_GFX:
					export_tiled_img_gfx.export_if_updated(
							asset_j_path,
							asm_meta_path, asm_data_path, bin_path,
							force_export)
					
				case build.ASSET_TYPE_TEXT_ENG:
					export_text.export_if_updated(
							asset_j_path,
							asm_meta_path, asm_data_path, bin_path,
							force_export, build.LOCAL_ENG)
					
				case build.ASSET_TYPE_TEXT_RUS:
					export_text.export_if_updated(
							asset_j_path,
							asm_meta_path, asm_data_path, bin_path,
							force_export, build.LOCAL_RUS)
					
				case build.ASSET_TYPE_DECAL:
					export_decal.export_if_updated(
							asset_j_path,
							asm_meta_path, asm_data_path, bin_path,
							force_export)
					
				case build.ASSET_TYPE_BACK:
					export_back.export_if_updated(
							asset_j_path,
							asm_meta_path, asm_data_path, bin_path,
							force_export)
			asset = {
				"load_name": load_name,
				"asset_j_path" : asset_j_path,				
				"asm_meta_path": asm_meta_path,
				"asm_data_path": asm_data_path,
				"bin_path": bin_path,
				"type": asset_type,
				"len": os.path.getsize(bin_path)
			}
			assets.append(asset)


	# export the code to load assets & a memory usage report
	loads_path = config_utils.export_loads(config_j, assets, build_code_dir, build_bin_dir)

	# export a build includes
	export_build_includes(assets, [loads_path])

	# export a consts
	export_build_consts(config_j, build_code_dir)

	# processing main.asm
	main_asm_path = config_j["main_asm_path"]

	com_filename = build.get_cpm_filename(config_j['com_filename'], build.EXT_COM)
	com_path = build_bin_dir + \
		com_filename
	bin_path = common.rename_extention(com_path, build.EXT_BIN)
	common.delete_file(bin_path)

	# compile the main.asm
	raw_labels_path = build_bin_dir + build.DEBUG_FILE_NAME
	build.compile_asm(main_asm_path, bin_path)
	common.rename_file(bin_path, com_path, True)

	# export the debug data
	debug_data_path = common.rename_extention(com_path, build.EXT_JSON)
	debug_data = build.export_debug_data(raw_labels_path, debug_data_path)

	# export autoexec
	autoexec_path = build_bin_dir + build.get_cpm_filename('autoexec', build.EXT_BAT)
	export_autoexec(com_filename, autoexec_path)

	# export fdd
	asset_autoexec = {"bin_path": autoexec_path}
	asset_executible = {"bin_path": com_path}
	assets += [asset_autoexec, asset_executible]
	
	bin_paths = [asset["bin_path"] for asset in assets]
	fdd_path = common.rename_extention(com_path, build.EXT_FDD)

	export_fdd.export(
		input_files = bin_paths,
		basefdd_path = config_j["basefdd_path"],
		output_fdd = fdd_path)

	build.printc(f";===========================================================================", build.TextColor.GREEN)
	build.printc(f";", build.TextColor.GREEN)
	build.printc(f"; config export: Success.", build.TextColor.GREEN)
	build.printc(f";", build.TextColor.GREEN)
	build.printc(f";===========================================================================", build.TextColor.GREEN)

	return fdd_path

#===============================================================================
#
# helper funcs
#
#===============================================================================

def export_ram_data_labels(build_code_dir, segments_info, main_asm_labels):
	# use the main programm labels to find preshift anim labels and their addrs
	asm = "; ram_data_labels:\n"

	for seg_info in segments_info:
		ram_data_paths = seg_info["ram_include_paths"]
		for ram_data_path in ram_data_paths:
			if len(ram_data_path) != 0:
				asm += export_sprite.get_anim_labels(ram_data_path, main_asm_labels)
	asm += "\n"

	path = f"{build_code_dir}ram_data_labels{build.EXT_ASM}"
	with open(path, "w") as file:
		file.write(asm)

def export_autoexec(com_filename, autoexec_path):
	# delete output file if it exists
	if os.path.exists(autoexec_path):
		os.remove(autoexec_path)

	with open(autoexec_path, 'w') as f:
		f.write("A:\n")
		f.write(com_filename + "\n")

def export_build_consts(config_j, build_code_dir):

	# save an inter-build const file
	inter_build_consts_path = build.BUILD_PATH + "build_consts" + build.EXT_ASM	
	with open(inter_build_consts_path, 'w') as f:
		f.write(f'.include "{build_code_dir}/build_consts.asm"')
	
	build_consts_path = build_code_dir + "build_consts" + build.EXT_ASM
	
	asm = ""

	for reservation in config_j["ram_disk_reserve"]:
		idx = reservation["bank_idx"]
		asm += f"RAM_DISK_M_{reservation["name"]} = RAM_DISK_M{idx}\n"
		asm += f"RAM_DISK_S_{reservation["name"]} = RAM_DISK_S{idx}\n"

	# export consts
	for const in config_j["consts"]:
		asm += const + "\n"

	# save the file
	with open(build_consts_path, 'w') as f:
		f.write(asm)


def export_build_includes(assets, extra_includes):
	# prepare the include path
	build_include_path = build.BUILD_PATH + "build_includes" + build.EXT_ASM

	# delete output file if it exists
	if os.path.exists(build_include_path):
		os.remove(build_include_path)

	build_include = ""

	# include all meta files
	for asset in assets:
		build_include += f'.include "{asset["asm_meta_path"]}"\n'
	build_include += "\n"

	# include all includes
	for include_path in extra_includes:
		build_include += f'.include "{include_path}"\n'
	build_include += "\n"

	# save the file
	with open(build_include_path, 'w') as f:
		f.write(build_include)


def get_asset_export_paths(asset_j_path, build_bin_dir):
	with open(asset_j_path, "rb") as file:
		asset_j = json.load(file)
 
	asset_name = common.path_to_basename(asset_j_path)
	asset_type = asset_j["asset_type"]
	export_asm_dir = build.build_subfolder + asset_type + "/"

	# linked to the main program
	asm_meta_path = export_asm_dir + asset_name + "_meta" + build.EXT_ASM
	# exported into the fdd file
	asm_data_path = export_asm_dir + asset_name + "_data" + build.EXT_ASM
	bin_path = build_bin_dir + build.get_cpm_filename(asset_name)

	return asm_meta_path, asm_data_path, bin_path, asset_type
