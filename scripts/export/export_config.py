import os
import json

import utils.build as build
import utils.common as common
from export import export_font
from export import export_music
from export import export_level_data
from export import export_level_gfx
from export import export_sprite
from export import export_fdd

#==============================================================================
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

	# aggregate assets
	fdd_files = {}
	for load_name, load_set in config_j["loads"].items():
		for mem_type, asset_j_paths in load_set.items():
			for asset_j_path in asset_j_paths:
				fdd_files[asset_j_path] = {}

	# export assets
	for asset_j_path in fdd_files:
		if not os.path.exists(asset_j_path):
			build.exit_error(f'export_config ERROR: file not found: {asset_j_path}')

		asm_meta_path, asm_data_path, bin_path, asset_type \
			= get_asset_export_paths(asset_j_path, build_bin_dir)

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

		fdd_files[asset_j_path] = {
			"asm_meta_path": asm_meta_path,
			"asm_data_path": asm_data_path,
			"bin_path": bin_path
		}

	# ===============================================================================

	# export the code to load assets & a memory usage report
	loads_path = export_loads(config_j, fdd_files, build_code_dir)

	# export a consts
	export_build_consts(config_j, build_code_dir)

	# export a build includes
	export_build_includes(config_j, fdd_files, [loads_path])

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
		basefdd_path = config_j["basefdd_path"],
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

	for reservation in config_j["ram_disk_reservations"]:
		idx = reservation["bank_idx"]
		asm += f"RAM_DISK_M_{reservation["name"]} = RAM_DISK_M{idx}\n"
		asm += f"RAM_DISK_S_{reservation["name"]} = RAM_DISK_S{idx}\n"

	# export consts
	for const in config_j["consts"]:
		asm += const + "\n"

	# save the file
	with open(build_consts_path, 'w') as f:
		f.write(asm)


def export_build_includes(config_j, fdd_files, extra_includes):
	# prepare the include path
	build_include_path = build.BUILD_PATH + "build_includes" + build.EXT_ASM

	# delete output file if it exists
	if os.path.exists(build_include_path):
		os.remove(build_include_path)

	build_include = ""

	# include all meta files
	for asset_j_path in fdd_files:
		build_include += f'.include "{fdd_files[asset_j_path]["asm_meta_path"]}"\n'
	build_include += "\n"

	# include all includes
	for include_path in extra_includes:
		build_include += f'.include "{include_path}"\n'
	build_include += "\n"

	# save the file
	with open(build_include_path, 'w') as f:
		f.write(build_include)

def export_loads(config_j, fdd_files, build_code_dir):
	# prepare the include path
	load_path = build_code_dir + "loads" + build.EXT_ASM

	# delete output file if it exists
	if os.path.exists(load_path):
		os.remove(load_path)

	report = "/*\n"
	asm = ""

	# report a ram permanent usage
	permanent_load_name = config_j["permanent_load_name"]
	permanent_load = config_j["loads"].pop(permanent_load_name)
	
	ram_reserved = 0
	ram_disk_bank_idx = 0
	ram_disk_load_addr = 0 
	
	usage_report, end_ram_addr, end_bank_idx, load_end_addr, ram_load, ram_disk_load = get_load_mem_usage_report(
		permanent_load_name, permanent_load, fdd_files, ram_reserved, ram_disk_bank_idx, ram_disk_load_addr, config_j["ram_disk_reservations"])
	
	ram_reserved = end_ram_addr
	ram_disk_bank_idx = end_bank_idx
	ram_disk_load_addr = load_end_addr
	report += usage_report

	# export the load asm
	load_asm = get_load_asm(permanent_load_name, ram_load, ram_disk_load)
	asm += load_asm 

	# report loads usage
	loaded_max_len = 0
	for load_name, load in config_j["loads"].items():
		usage_report, end_ram_addr, _, _, ram_load, ram_disk_load = get_load_mem_usage_report(
		load_name, load, fdd_files, ram_reserved, ram_disk_bank_idx, ram_disk_load_addr, config_j["ram_disk_reservations"])
		report += usage_report
		
		load_asm = get_load_asm(load_name, ram_load, ram_disk_load)
		asm += load_asm

		if end_ram_addr > loaded_max_len:
			loaded_max_len = end_ram_addr


	report += "*/\n"

	asm = report + asm

	# store the lowest addr of the loaded data
	# to check if it is not overlapped with the main program (runtime data)
	asm += f"LOADED_DATA_START_ADDR = STACK_MIN_ADDR - {loaded_max_len}\n"

	# save the file
	with open(load_path, 'w') as f:
		f.write(asm)

	return load_path

# ===============================================================================

def get_load_mem_usage_report(
		load_name,
		load,
		fdd_files,
		ram_reserved,
		ram_disk_bank_idx,
		ram_disk_bank_perm_load_addr,
		ram_disk_reservations,
		):

	report = ""
	ram_load = []
	ram_disk_load = []

	# report a ram usage
	report += f"Ram '{load_name}' usage:\n"

	ram_free = build.RAM_LEN - build.SCR_BUFFS_LEN - ram_reserved
	ram_used = 0
	file_addr = ram_reserved

	ram_files = load["ram"]

	for i, asset_j_path in enumerate(ram_files):
		bin_path = fdd_files[asset_j_path]["bin_path"]
		file_len = os.path.getsize(bin_path)
		fdd_files[asset_j_path]["addr"] = ram_used
		ram_used += file_len
		# check if ram is overloaded
		if ram_used >= ram_free:
			build.exit_error(f'export_config ERROR: ram is overloaded: '
				f'ram_used ({ram_used}) >= free ram ({ram_free}). File: {bin_path}')

		report += "	" if i == 0 else ""
		report += f"{os.path.basename(bin_path)} [{file_len}], "

		load_file = {
			"name" : common.path_to_basename(bin_path).upper(),
			"bin_path": bin_path,
			"len": file_len,
			"addr": file_addr
		}
		ram_load.append(load_file)

		file_addr += file_len

	report += "\n" if len(ram_files) > 0 else ""
	report += f"reserved: {ram_reserved}\n"
	report += f"used: {ram_used}\n"
	report += f"free: {ram_free - ram_used}\n"
	report += "\n"

	# report a ram-disk usage
	report += f"Ram-disk '{load_name}' usage:\n"

	ram_disk_load_used = 0
	ram_disk_load_addr = ram_disk_bank_perm_load_addr
	ram_disk_files = load["ram-disk"]
	ram_disk_reserved = (ram_disk_bank_idx * build.RAM_DISK_BANK_LEN +
							ram_disk_bank_perm_load_addr)

	for asset_j_path in ram_disk_files:

		bin_path = fdd_files[asset_j_path]["bin_path"]
		file_len = os.path.getsize(bin_path)
		ram_disk_load_used += file_len

		# adjust the file load addr if it lies inside the reserved space
		for bank_reservation in ram_disk_reservations:
			if bank_reservation["bank_idx"] == ram_disk_bank_idx:

				bank_reservation_len = int(bank_reservation["length"], 16)
				bank_reservation_addr = int(bank_reservation["addr"], 16)
				bank_reservation_end_addr = bank_reservation_addr + bank_reservation_len

				if (ram_disk_load_addr + file_len >= bank_reservation_addr and
					ram_disk_load_addr + file_len < bank_reservation_end_addr):

					report +="\n"
					report += f"	>>> EMPTY_SPACE <<< " \
						f"[bank idx: {ram_disk_bank_idx}, " \
						f"addr: {ram_disk_load_addr}, len:{bank_reservation_addr - ram_disk_load_addr}]\n\n"
					
					ram_disk_load_addr = bank_reservation_addr + bank_reservation_len				
					ram_disk_reserved += bank_reservation_len

		# adjust the file load addr if it lies outside the bank space
		if (ram_disk_load_addr + file_len > build.RAM_DISK_BANK_LEN):
			ram_disk_bank_idx += 1
			ram_disk_load_addr = 0

		# check if the ramk disk is overloaded
		if (ram_disk_bank_idx > build.RAM_DISK_IDX_MAX):
			build.exit_error(f'export_config ERROR: ram-disk is overloaded: '
				f'File: {bin_path}')

		report += "	"

		report += f"{os.path.basename(bin_path)} " \
			f"[bank idx: {ram_disk_bank_idx}, " \
			f"addr: {ram_disk_load_addr}, len:{file_len}], \n"
		
		
		load_file = {
			"name" : common.path_to_basename(bin_path).upper(),
			"bin_path": bin_path,
			"len": file_len,
			"addr": ram_disk_load_addr,
			"bank_idx": ram_disk_bank_idx
		}
		ram_disk_load.append(load_file)

		ram_disk_load_addr += file_len

	report += "\n" if len(ram_disk_files) > 0 else ""
	report += f"reserved: {ram_disk_reserved}\n"
	report += f"used: {ram_disk_load_used}\n"
	report += f"free: {build.RAM_DISK_LEN - ram_disk_load_used}\n"
	report += "\n"

	return report, ram_reserved + ram_used, ram_disk_bank_idx, ram_disk_load_addr, ram_load, ram_disk_load

# ===============================================================================

def get_load_asm(load_name, ram_load, ram_disk_load):
	
	asm = ""
	asm += f";===============================================\n"
	asm += f"; {load_name}\n"
	asm += f";===============================================\n"
	asm += f".function load_{load_name}\n"
	asm += "			; ram:\n"
	asm += "\n"

	for load_file in ram_load:
		name = load_file["name"]
		asm += f"			{name}_ADDR = STACK_MIN_ADDR - {load_file['addr']} - {name}_FILE_LEN\n"
		asm += f"			LOAD_FILE({name}_FILENAME_PTR, 0, {name}_ADDR, {name}_FILE_LEN)\n\n"

	
	asm += "			; ram-disk:\n"
	for load_file in ram_disk_load:
		name = load_file["name"]
		asm += f"			RAM_DISK_S_{name} = RAM_DISK_S{load_file['bank_idx']}\n"
		asm += f"			{name}_ADDR = {load_file['addr']}\n"
		asm += f"			LOAD_FILE({name}_FILENAME_PTR, RAM_DISK_S_{name}, {name}_ADDR, {name}_FILE_LEN)\n\n"

	asm += f".endf\n"
	return asm

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

def get_bin_paths(fdd_files):
	bin_paths = []

	for asset_j_path in fdd_files:
		bin_path = fdd_files[asset_j_path]["bin_path"]
		bin_paths.append(bin_path)

	return bin_paths