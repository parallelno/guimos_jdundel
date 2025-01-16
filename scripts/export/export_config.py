import os
import json

import utils.build as build
import utils.common as common
from export import export_segment
from export import export_data_asm
from export import export_data_init
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
	assembler_path = source_j["assembler_path"][2:].lstrip(".").replace("/", "\\")
	build.set_assembler_path(assembler_path)
	build.set_assembler_labels_cmd(source_j["assembler_labels_cmd"])
	build.set_packer(build.PACKER_ZX0_SALVADORE)
	build.set_emulator_path(source_j["emulator_path"])
	build.build_db_init(source_j["build_db_path"])

	# check dependencies
	dependency_paths_j = source_j["dependencies"]
	global_force_export = False
	for path in dependency_paths_j["global"]:
		global_force_export |= build.is_file_updated(path)

	asset_types_dependencies = dependency_paths_j["asset_types"]
	asset_types_force_export = {}
	for asset_type in asset_types_dependencies:
		asset_types_force_export[asset_type] = global_force_export | build.is_file_updated(asset_types_dependencies[asset_type])

	build_code_dir = source_j["export_dir"]["code"]
	build_bin_dir = source_j["export_dir"]["bin"]
	
	# make directories
	os.makedirs(os.path.dirname(build.build_subfolder), exist_ok=True)	
	os.makedirs(os.path.dirname(build.build_subfolder + build_code_dir), exist_ok=True)
	os.makedirs(os.path.dirname(build.build_subfolder + build_bin_dir), exist_ok=True)

	segments_info = []
	ram_disk_data_asm_force_export = global_force_export

	# export args
	path = build.BUILD_PATH + "args" + build.EXT_ASM
	export_args(source_j, path)

	'''
	# export all segments into bin files, then zip them, then split them into chunks (files <= 24KB)
	for bank_j in source_j["banks"]:
		seg_id = -1
		bank_id = int(bank_j["bank_id"])
		for segment_j in bank_j["segments"]:
			seg_id += 1
			exported, segment_info = export_segment.export(
				bank_id, seg_id, segment_j, source_j["includes"]["segment"],
				global_force_export, asset_types_force_export,
				build_code_dir, build_bin_dir, localization_id)

			ram_disk_data_asm_force_export |= exported
			segments_info.append(segment_info)
 
	if ram_disk_data_asm_force_export:
		# generate ram_disk_data.asm. it includes the ram-disk data		
		export_data_asm.export(source_j, source_j_path, build_code_dir, build_bin_dir, segments_info)
		
		# generate ram_disk_init.asm. it copies and preprocess the ram-disk data
		export_data_init.export(source_j, source_j_path, build_code_dir, segments_info)

	# processing main.asm
	source_path = source_j["main_asm_path"]

	rom_name = "main_asm"
	bin_path = build_bin_dir + rom_name + build.EXT_BIN
	common.delete_file(bin_path)

	# compile the main.asm
	labels_path = build_bin_dir + build.DEBUG_FILE_NAME
	build.compile_asm(source_path, bin_path, labels_path)
	main_asm_labels, comments = build.export_labels(labels_path, False, False)

	build.printc(comments, build.TextColor.YELLOW)

	zx0_path = bin_path + build.packer_ext
	common.compress(bin_path, zx0_path)

	# processing main_unpacker.asm
	source_path = source_j["main_unpacker_path"]
	rom_dir = "rom\\"
	
	rom_name = os.path.basename(os.getcwd())
	bin_path = rom_dir + rom_name + build.EXT_BIN
	rom_path = rom_dir + rom_name + build.EXT_ROM
	
	common.delete_file(bin_path)
	common.delete_file(rom_path)

	# export ram_data_labels.asm
	# export_ram_data_labels(build_code_dir, segments_info, main_asm_labels)

	labels_path = rom_dir + build.DEBUG_FILE_NAME
	build.compile_asm(source_path, bin_path, labels_path)
	labels, comments = build.export_labels(labels_path, False, False)
	build.printc(comments, build.TextColor.YELLOW)
	labels.update(main_asm_labels)
	build.store_labels(labels, labels_path)
	
	common.run_command(f"ren {bin_path} {rom_name + build.EXT_ROM}")
	'''
	# processing main.asm
	main_asm_path = source_j["main_asm_path"]
	bin_path = build.build_subfolder[2:] + build_bin_dir + \
		common.path_to_basename(main_asm_path) + \
		build.EXT_BIN
	common.delete_file(bin_path)

	# compile the main.asm
	raw_labels_path = build.build_subfolder + build_bin_dir + build.DEBUG_FILE_NAME
	exported_labels_path = build.build_subfolder + source_j['game_name'] + build.EXT_JSON
	build.compile_asm(main_asm_path, bin_path, raw_labels_path)
	_, comments = build.export_labels(raw_labels_path, False, exported_labels_path)
	build.printc(comments, build.TextColor.YELLOW)

	# make a rom file
	max_chars = 8
	com_filename = (source_j['com_filename'][:max_chars] + build.EXT_COM).upper()
	com_path = build.build_subfolder[2:] + \
		build_bin_dir + \
		com_filename
	common.rename_file(bin_path, com_path, True)

	# export autoexec
	autoexec_path = build.build_subfolder + build_bin_dir + 'autoexec' + build.EXT_BAT
	export_autoexec(com_filename, autoexec_path)

	# export fdd
	fdd_files = [autoexec_path, com_path]
	fdd_path = build.build_subfolder + source_j['game_name'] + build.EXT_FDD
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