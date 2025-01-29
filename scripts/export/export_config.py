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

	# check if general scripts were updated
	dependency_paths_j = source_j["dependencies"]
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

	# aggregate assets
	fdd_files = {}
	for asset_j_path in source_j["fdd_files"]["permanent"]["ram"]:
		fdd_files[asset_j_path] = {}
	for asset_j_path in source_j["fdd_files"]["permanent"]["ram-disk"]:
		fdd_files[asset_j_path] = {}
	for memory_name, load_sets in source_j["fdd_files"]["reload"].items():
		for load_set_name, load_set in load_sets.items():
			for asset_j_path in load_set:
				fdd_files[asset_j_path] = {}

	# export assets
	for asset_j_path in fdd_files:
		if not os.path.exists(asset_j_path):
			build.exit_error(f'export_config ERROR: file not found: {asset_j_path}')

		asm_meta_path, asm_data_path, bin_path = get_asset_export_paths(asset_j_path, build_bin_dir)
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
					
		fdd_files[asset_j_path] = {
			"asm_meta_path": asm_meta_path,
			"asm_data_path": asm_data_path,
			"bin_path": bin_path
		}

	# ===============================================================================

	# export a build includes
	export_build_includes(source_j, fdd_files)
 
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
	common.rename_file(bin_path, com_path, True)

	# export the debug data
	debug_data_path = common.rename_extention(com_path, build.EXT_JSON)
	debug_data = build.export_debug_data(raw_labels_path, debug_data_path)

	# export a memory usage report
	export_memory_usage_report(source_j, debug_data, fdd_files)

	# export autoexec
	autoexec_path = build_bin_dir + build.get_cpm_filename('autoexec', build.EXT_BAT)
	export_autoexec(com_filename, autoexec_path)

	# export fdd
	fdd_files[autoexec_path] = {
		"bin_path": autoexec_path
	}
	fdd_files[com_path] = {
		"bin_path": com_path
	}
	bin_paths = get_bin_paths(fdd_files)

	fdd_path = common.rename_extention(com_path, build.EXT_FDD)
	export_fdd.export(
		input_files = bin_paths,
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

def export_args(source_j):
	args = ""
	for str in source_j["args"]:
		args += str + "\n"

def export_autoexec(com_filename, autoexec_path):
	# delete output file if it exists
	if os.path.exists(autoexec_path):
		os.remove(autoexec_path)

	with open(autoexec_path, 'w') as f:
		f.write("A:\n")
		f.write(com_filename + "\n")


def export_build_includes(config_j, fdd_files):
	# prepare the include path
	build_include_path = build.BUILD_PATH + "build_includes" + build.EXT_ASM

	# delete output file if it exists
	if os.path.exists(build_include_path):
		os.remove(build_include_path)

	build_include = ""

	# export args
	for arg in config_j["args"]:
		build_include += arg + "\n"
	build_include += "\n"

	# include all meta files
	for asset_j_path in fdd_files:
		build_include += f'.include "{fdd_files[asset_j_path]["asm_meta_path"]}"\n'
	build_include += "\n"

	# save the file
	with open(build_include_path, 'w') as f:
		f.write(build_include)

def export_memory_usage_report(config_j, debug_data, fdd_files):
	# prepare the include path
	report_path = build.BUILD_PATH + "mem_usage_report" + build.EXT_ASM

	# delete output file if it exists
	if os.path.exists(report_path):
		os.remove(report_path)

	report = ""
	
	ram_peramanent = config_j["fdd_files"]["permanent"]["ram"]
	ram_disk_peramanent = config_j["fdd_files"]["permanent"]["ram-disk"]

	# report for a ram	
	report += f"Ram permanent usage:\n"
	report += "	"

	free = 0x8000 # because of the screen buffer
	reserved = int(debug_data["labels"]["runtime_data_end"], 16)
	used = 0

	for asset_j_path in ram_peramanent:
		bin_path = fdd_files[asset_j_path]["bin_path"]
		file_size = os.path.getsize(bin_path)
		report += f"{os.path.basename(bin_path)} [{file_size}], "
		used += file_size

	report += "\n"
	report += f"reserved: {reserved}\n"
	report += f"used: {used}\n"
	free = free - reserved - used
	report += f"free: {free}\n"
	report += "\n\n"

	# report for a ram-disk
	report += f"Ram-disk permanent usage:\n"
	report += "	"
	
	reserved = 0
	ram_disk_reserved = config_j["ram_disk_reserved"]	
	for reservation in ram_disk_reserved:
		reserved += int(reservation["length"], 16)
		report += f"{reservation['name']} [{int(reservation['length'], 16)}], "

	bank_len = 0x10000 # ram-disk bank size
	banks = 4
	free = bank_len * banks
	used = 0
	
	for json_path in ram_disk_peramanent:
		bin_path = fdd_files[asset_j_path]["bin_path"]
		file_size = os.path.getsize(bin_path)
		report += f"{os.path.basename(bin_path)} [{file_size}], "
		used += file_size

	report += "\n"
	report += f"reserved: {reserved}\n"	
	report += f"used: {used}\n"
	free = free - reserved - used
	report += f"free: {free}\n"
	report += "\n\n"

	# save the file
	with open(report_path, 'w') as f:
		f.write(report)		

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

	return asm_meta_path, asm_data_path, bin_path

def get_bin_paths(fdd_files):
	bin_paths = []

	for asset_j_path in fdd_files:
		bin_path = fdd_files[asset_j_path]["bin_path"]
		bin_paths.append(bin_path)

	return bin_paths