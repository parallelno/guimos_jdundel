import os
import utils.build as build
import utils.common as common

def export_loads(config_j, assets, build_code_dir, build_bin_dir):
	
	# prepare the include path
	load_path = build_code_dir + "loads" + build.EXT_ASM

	# delete output file if it exists
	if os.path.exists(load_path):
		os.remove(load_path)

	# make the ram-disk segment layout
	segments = get_ram_disk_layout(config_j)

	asm = ""
	report_asm = ""

	# permanent load
	perm_load_name = config_j["permanent_load_name"]
	perm_load = config_j["loads"][perm_load_name] if perm_load_name in config_j["loads"] else None
	if perm_load and len(perm_load) > 0:
		config_j["loads"].pop(perm_load_name)
		# get memory usage 
		allocation, free_space, error_s = pack_files(perm_load_name, assets, segments)
		report_asm += get_usage_report(perm_load_name, allocation, free_space, segments)
		asm += get_load_asm(perm_load_name, allocation, segments)

	if error_s:
		build.exit_error(error_s)

	# the segment load_addr points to the free space after loading a permanent load
	# keep it for each load
	for seg_name, seg in segments.items(): 
		seg["non_permanent_load_addr"] = seg["load_addr"]

	for load_name, load in config_j["loads"].items():
		# get memory usage
		allocation, free_space, error_s = pack_files(load_name, assets, segments)
		report_asm += get_usage_report(load_name, allocation, free_space, segments)
		asm += get_load_asm(load_name, allocation, segments)
		# restore the segment load_addr
		for seg_name, seg in segments.items():
			seg["load_addr"] = seg["non_permanent_load_addr"]

 
	asm = "/*\n" + report_asm + "*/\n\n" + asm

	# save the file
	with open(load_path, 'w') as f:
		f.write(asm)

	return load_path


def get_usage_report(load_name, allocation, free_space, segments):
	total_used = 0
	
	report = ""
	report +=  ";===============================================\n"
	report += f"; {load_name}\n"
	report +=  ";===============================================\n"
	report += "\n"

	report += "Ram-disk usage:\n"
	total_reserved = 0
	for seg_name, seg in allocation.items():
		if len(seg) > 0:
			report += f"--- {seg_name} -----------------\n"
			used_len = 0
			for asset in seg: 
				bin_file_name = os.path.basename(asset["bin_path"])
				asset_addr = asset["addr"]
				asset_len = asset["len"]
				report += f"	{bin_file_name}: addr: {asset_addr}, len: {asset_len}\n"
				used_len += asset_len
			
			non_perm_load_addr = segments[seg_name]["non_permanent_load_addr"]
			start_addr = segments[seg_name]["start_addr"]
			reserved = non_perm_load_addr - start_addr
			total_reserved += reserved 

			report += f"Used: {used_len}, Free: {segments[seg_name]["len"] - used_len - reserved}\n\n"
			total_used += used_len			

	if total_reserved > 0:
		report += f"Permanent load: {total_reserved}, "
	report += f"Current Load: {total_used}, Free Space: {free_space}\n\n"

	return report

def get_ram_disk_layout(config_j):
	# make the ram-disk segment layout
	ram_disk_reserve = config_j["ram_disk_reserve"]
	segments = {}
	for bank_idx in range(build.RAM_DISK_BANKS_MAX):
		# segment before stack
		seg_name0 = f"bank{bank_idx} addr0"
		seg_len0 = build.RAM_DISK_SEGMENT_LEN - build.ALL_STACKS_LEN
		seg_addr0 = 0
		segments[seg_name0] = {
			"bank_idx": bank_idx,
			"start_addr": seg_addr0,
			"load_addr": seg_addr0,
			"non_permanent_load_addr" : seg_addr0,
			"len": seg_len0
			}
		
		# segment after stack
		seg_name1 = f"bank{bank_idx} addr8000"
		seg_addr1 = build.SCR_ADDR
		seg_len1 = build.RAM_DISK_SEGMENT_LEN
		seg_reservation_idx = next((i for i, x in enumerate(ram_disk_reserve) if x["bank_idx"] == bank_idx), -1)

		if seg_reservation_idx >= 0:
			ser_reserve_len_s = ram_disk_reserve[seg_reservation_idx]["len"]
			seg_len1 -= common.hex_str_to_int(ser_reserve_len_s)

		segments[seg_name1] = {
			"bank_idx": bank_idx,
			"start_addr": seg_addr1,
			"load_addr": seg_addr1,
			"non_permanent_load_addr" : seg_addr1,
			"len": seg_len1

			}

	return segments

def pack_files(load_name, assets, segments):
	# Split files into special (after stack only) and regular
	special_types = [build.ASSET_TYPE_MUSIC, build.ASSET_TYPE_LEVEL_DATA]
	
	special = []
	regular = []
	for asset in assets:
		if asset["load_name"] != load_name:
			continue
		if asset["type"] in special_types:
			special.append(asset)
		else:
			regular.append(asset)
	
	# Sort by size descending
	special = sorted(special, key=lambda x: x["len"], reverse=True)
	regular = sorted(regular, key=lambda x: x["len"], reverse=True)
	
	# Segment space and allocation
	seg_space = {}
	for seg_name, seg in segments.items():
		reserved = seg["non_permanent_load_addr"] - seg["start_addr"]
		seg_space[seg_name] = seg["len"] - reserved

	allocation = {seg_name: [] for seg_name in segments}
	after_stack_segs = [seg_name for seg_name, s in segments.items() if s["start_addr"] == build.SCR_ADDR]
	
	# Step 1: Place special files in after-stack segments
	for asset in special:
		asset_len = asset["len"]
		bin_path = asset["bin_path"]
		placed = False
		# Prefer larger segments (Bank 2 or 3 After Stack)
		for seg_name in sorted(after_stack_segs, key=lambda x: seg_space[x], reverse=True):
			if asset_len <= seg_space[seg_name]:
				asset["addr"] = segments[seg_name]["load_addr"]
				segments[seg_name]["load_addr"] += asset_len
				allocation[seg_name].append(asset)
				seg_space[seg_name] -= asset_len
				placed = True
				break
		if not placed:
			return None, None, \
				f"Can't fit special files into after stack segments. bin_path:{bin_path}"
	
	# Step 2: Place regular files in any segment
	for asset in regular:
		asset_len = asset["len"]
		bin_path = asset["bin_path"]		
		placed = False
		# Try all segments, preferring fullest fit
		for seg_name in sorted(seg_space.keys(), key=lambda x: seg_space[x]):
			if asset_len <= seg_space[seg_name]:
				asset["addr"] = segments[seg_name]["load_addr"]
				segments[seg_name]["load_addr"] += asset_len				
				allocation[seg_name].append(asset)
				seg_space[seg_name] -= asset_len
				placed = True
				break
		if not placed:
			return None, None,\
				f"Can't fit file into the ram-disk. bin_path:{bin_path}"
	
	free_space = sum(seg_space.values())
	return allocation, free_space, None


def get_load_asm(load_name, allocation, segments):
	
	asm = ""
	asm += f";===============================================\n"
	asm += f"; {load_name}\n"
	asm += f";===============================================\n"
	asm += f".function load_{load_name}\n"
	
	# load the data
	asm += "			; ram-disk:\n"
	for seg_name, seg in allocation.items():
		for asset in seg:
			bank_idx = segments[seg_name]["bank_idx"]
			NAME = common.path_to_basename(asset["bin_path"]).upper()
			name_low = common.path_to_basename(asset["asset_j_path"])

			const_ram_disk_m = f"RAM_DISK_M_{NAME}"
			const_ram_disk_s = f"RAM_DISK_S_{NAME}"
			const_addr = f"{NAME}_ADDR"
			
			asm += f"			{const_ram_disk_m} = RAM_DISK_M{bank_idx}\n"
			asm += f"			{const_ram_disk_s} = RAM_DISK_S{bank_idx}\n"
			asm += f"			{const_addr} = {asset['addr']}\n"
			asm += f"			LOAD_FILE({NAME}_FILENAME_PTR, {const_ram_disk_s}, {const_addr}, {NAME}_FILE_LEN)\n"

			asset_type = asset["type"]
			match asset_type:
				case build.ASSET_TYPE_FONT:
					asm += f"			mvi a, {const_ram_disk_s}\n"
					asm += f"			lxi h, {name_low}_gfx_ptrs\n"
					asm += f"			lxi b, {const_addr}\n"
					asm += f"			call text_ex_init_font\n"

				case build.ASSET_TYPE_TEXT_ENG:
					asm += f"			mvi a, {const_ram_disk_s}\n"
					asm += f"			lxi h, {const_addr}\n"
					asm += f"			call text_ex_init_text\n"

				case build.ASSET_TYPE_TEXT_RUS:
					asm += f"			mvi a, {const_ram_disk_s}\n"
					asm += f"			lxi h, {const_addr}\n"
					asm += f"			call text_ex_init_text\n"					
				
				case build.ASSET_TYPE_MUSIC:
					asm += f"			lxi d, {const_addr}\n"
					asm += f"			lxi h, _{name_low}_ay_reg_data_ptrs\n"
					asm += f"			call v6_gc_init_song\n"

				case build.ASSET_TYPE_LEVEL_DATA:
					asm += f"			lxi h, _{name_low}_rooms_ptrs\n"
					asm += f"			lxi b, {const_addr}\n"
					asm += f"			call update_labels_eod\n"

				case build.ASSET_TYPE_LEVEL_GFX:
					asm += f"			lxi h, _{name_low}_tiles_ptrs\n"
					asm += f"			lxi b, {const_addr}\n"
					asm += f"			call update_labels_eod\n"

				case build.ASSET_TYPE_SPRITE:
					asm += f"			lxi d, _{name_low}_preshifted_sprites\n"
					asm += f"			lxi h, {const_addr}\n"
					asm += f"			call sprite_update_labels\n"

				case build.ASSET_TYPE_TILED_IMG_DATA:
					asm += f"			mvi a, {const_ram_disk_s}\n"
					asm += f"			lxi h, {const_addr}\n"
					asm += f"			call tiled_img_init_idxs\n"

				case build.ASSET_TYPE_TILED_IMG_GFX:
					asm += f"			mvi a, {const_ram_disk_s}\n"
					asm += f"			lxi h, {const_addr}\n"
					asm += f"			call tiled_img_init_gfx\n"

				case build.ASSET_TYPE_DECAL:
					asm += f"			lxi h, _{name_low}_gfx_ptrs\n"
					asm += f"			lxi b, {const_addr}\n"
					asm += f"			call update_labels_eod\n"

				case build.ASSET_TYPE_BACK:
					asm += f"			lxi d, _{name_low}_preshifted_sprites\n"
					asm += f"			lxi h, {const_addr}\n"
					asm += f"			call sprite_update_labels\n"

			
			asm += f"\n"

	asm += f".endf\n"
	return asm