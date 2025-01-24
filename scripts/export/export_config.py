import os
import json

import utils.build as build
import utils.common as common
from export import export_font
from export import export_music
from export import export_sprite
from export import export_fdd

#==============================================================================
def export(source_j_path):

	build.printc(";===========================================================================", build.TextColor.MAGENTA)
	build.printc(";", build.TextColor.MAGENTA)
	build.printc(f"; ram-disk data export: {source_j_path}", build.TextColor.MAGENTA)
	build.printc(";", build.TextColor.MAGENTA)
	build.printc(";===========================================================================", build.TextColor.MAGENTA)
	print("\n")

	common.CheckPath(source_j_path, "Config file not found")
	with open(source_j_path, "rb") as file:
			source_j = json.load(file)

	common.CheckJsonField(
		source_j, "asset_type", 
		f'export_config ERROR: asset_type != "{build.ASSET_TYPE_CONFIG}", path: {source_j_path}',
		build.ASSET_TYPE_CONFIG)
	
	# set the global vars
	# strip of the path to make it approprite for windows console processor
	assembler_path = source_j["assembler_path"]
	build.set_assembler_path(assembler_path)
	build.set_assembler_labels_cmd(source_j["assembler_labels_cmd"])
	build.set_packer(build.PACKER_ZX0_SALVADORE, source_j["packer_path"])
	build.set_emulator_path(source_j["emulator_path"])
	build.build_db_init(source_j["build_db_path"])

	# make necessary directories
	build_code_dir = build.build_subfolder + source_j["export_dir"]["code"]
	build_bin_dir = build.build_subfolder + source_j["export_dir"]["bin"]
	os.makedirs(os.path.dirname(build.build_subfolder), exist_ok=True)	
	os.makedirs(os.path.dirname(build_code_dir), exist_ok=True)
	os.makedirs(os.path.dirname(build_bin_dir), exist_ok=True)

	# export args
	path = build.BUILD_PATH + "args" + build.EXT_ASM
	export_args(source_j, path)

	# check dependencies
	dependency_paths_j = source_j["dependencies"]
	global_force_export = False
	for path in dependency_paths_j["scripts"]:
		global_force_export |= build.is_file_updated(path)
	asset_types_dependencies = dependency_paths_j["exporters"]
	asset_types_force_export = {}
	for asset_type in asset_types_dependencies:
		asset_types_force_export[asset_type] = global_force_export | build.is_file_updated(asset_types_dependencies[asset_type])

	fdd_files = []
	# export assets
	for load_set_name, load_set in source_j["export_files"].items():
		for path in load_set:
			if not os.path.exists(path):
				build.exit_error(f'export_config ERROR: file not found: {path}')

			with open(path, "rb") as file:
				asset_j = json.load(file)

			asset_type = asset_j["asset_type"]
			export_dir = build.build_subfolder + asset_type + "/"
			force_export = asset_types_force_export[asset_type]

			bin_gfx_path = None
			match asset_type:
				case build.ASSET_TYPE_FONT:
					bin_gfx_path = export_font.export_if_updated(
							path,
							export_dir,
							build_bin_dir,
							force_export)
				
				case build.ASSET_TYPE_MUSIC:
					bin_gfx_path = export_music.export_if_updated(
							path,
							export_dir,
							build_bin_dir,
							force_export)
				
			if bin_gfx_path:
				fdd_files.append(bin_gfx_path)

	# ===============================================================================
 
	# processing main.asm
	main_asm_path = source_j["main_asm_path"]
	
	com_filename = build.get_cpm_filename(source_j['com_filename'], build.EXT_COM)
	com_path = build_bin_dir + \
		com_filename
	bin_path = common.rename_extention(com_path, build.EXT_BIN)
	common.delete_file(bin_path)

	# compile the main.asm
	raw_labels_path = build_bin_dir + build.DEBUG_FILE_NAME
	build.compile_asm(main_asm_path, bin_path)
	exported_labels_path = common.rename_extention(com_path, build.EXT_JSON)
	_, comments = build.export_labels(raw_labels_path, False, exported_labels_path)
	build.printc(comments, build.TextColor.YELLOW)

	# make a com file
	common.rename_file(bin_path, com_path, True)

	# export autoexec
	autoexec_path = build_bin_dir + build.get_cpm_filename('autoexec', build.EXT_BAT)
	export_autoexec(com_filename, autoexec_path)

	# export fdd
	fdd_files += [autoexec_path, com_path]
	fdd_path = common.rename_extention(com_path, build.EXT_FDD)
	export_fdd.export(
		input_files = fdd_files,
		basefdd_path = source_j["basefdd_path"],
		output_fdd = fdd_path)

	build.printc(f";===========================================================================", build.TextColor.GREEN)
	build.printc(f";", build.TextColor.GREEN)
	build.printc(f"; config export: Success.", build.TextColor.GREEN)
	build.printc(f";", build.TextColor.GREEN)
	build.printc(f";===========================================================================", build.TextColor.GREEN)

	return fdd_path	

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

def export_args(source_j, output_path):
	
	# delete output file if it exists
	if os.path.exists(output_path):
		os.remove(output_path)

	with open(output_path, 'w') as f:
		for str in source_j["args"]:
			f.write(str + "\n")


def export_autoexec(com_filename, autoexec_path):
	# delete output file if it exists
	if os.path.exists(autoexec_path):
		os.remove(autoexec_path)

	with open(autoexec_path, 'w') as f:
		f.write("A:\n")
		f.write(com_filename + "\n")