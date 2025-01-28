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
	asset_paths = source_j["fdd_files"]["permanent"]["ram"]
	asset_paths += source_j["fdd_files"]["permanent"]["ram-disk"]
	for memory_name, load_sets in source_j["fdd_files"]["reload"].items():
		for load_set_name, load_set in load_sets.items():
			for json_path in load_set:
				asset_paths.append(json_path)

	# export assets
	fdd_files = []
	for path in asset_paths:
		if not os.path.exists(path):
			build.exit_error(f'export_config ERROR: file not found: {path}')

		with open(path, "rb") as file:
			asset_j = json.load(file)

		asset_type = asset_j["asset_type"]
		export_dir = build.build_subfolder + asset_type + "/"
		force_export = asset_types_force_export[asset_type]

		bin_data_path = None
		match asset_type:
			case build.ASSET_TYPE_FONT:
				bin_data_path = export_font.export_if_updated(
						path,
						export_dir,
						build_bin_dir,
						force_export)
			
			case build.ASSET_TYPE_MUSIC:
				bin_data_path = export_music.export_if_updated(
						path,
						export_dir,
						build_bin_dir,
						force_export)
					
		if bin_data_path:
			fdd_files.append(bin_data_path)
		else:
			build.exit_error(f'export_config ERROR: failed asset export: {path}')

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
	common.rename_file(bin_path, com_path, True)

	# export the debug data
	debug_data_path = common.rename_extention(com_path, build.EXT_JSON)
	debug_data = build.export_debug_data(raw_labels_path, debug_data_path)

	# build a memory usage report
	report_path = build.build_subfolder + 'mem_usage_report' + build.EXT_TXT
	get_mem_usage_report(source_j["fdd_files"], debug_data, report_path, build_bin_dir)

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

def get_mem_usage_report(fdd_files_j, debug_data, report_path, build_bin_dir):
	report = ""
	
	ram_peramanent = fdd_files_j["permanent"]["ram"]
	ram_disk_peramanent = fdd_files_j["permanent"]["ram-disk"]

	runtime_data_end = int(debug_data["labels"]["runtime_data_end"], 16)

	total_free_ram = 0x8000 - runtime_data_end
	
	# report for a ram
	report += f"Ram permanent usage:\n"
	report += "	"
	used = 0
	for json_path in ram_peramanent:
		bin_path = get_bin_file_path(json_path, build_bin_dir)
		file_size = os.path.getsize(bin_path)
		report += f"{os.path.basename(bin_path)} [{file_size}], "
		used += file_size

	report += "\n"
	report += f"used: {used}\n"
	free = total_free_ram - used
	report += f"free: {free}\n"
	report += "\n\n"

	# report for a ram-disk
	report += f"Ram-disk permanent usage:\n"
	report += "	"
	used = 0
	for json_path in ram_disk_peramanent:
		bin_path = get_bin_file_path(json_path, build_bin_dir)
		file_size = os.path.getsize(bin_path)
		report += f"{os.path.basename(bin_path)} [{file_size}], "
		used += file_size

	report += "\n"
	report += f"used: {used}\n"
	free = total_free_ram - used
	report += f"free: {free}\n"
	report += "\n\n"

	with open(report_path, 'w') as f:
		f.write(report + "\n")

	return report

def get_bin_file_path(json_path, build_bin_dir):
	with open(json_path, "rb") as file:
		asset_j = json.load(file)

	asset_type = asset_j["asset_type"]
	source_name = common.path_to_basename(json_path)	
	bin_path = build_bin_dir + build.get_cpm_filename(source_name)
	return bin_path