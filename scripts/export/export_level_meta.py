import os
from pathlib import Path
import json

import export.export_level_utils as export_level_utils
import utils.common as common
import utils.build as build

def export_if_updated(asset_j_path, asm_meta_path, asm_data_path, bin_path,
		force_export):

	if (force_export or
		export_level_utils.is_source_updated(asset_j_path, build.ASSET_TYPE_LEVEL_DATA)):

		export_asm(asset_j_path, asm_meta_path, asm_data_path, bin_path)
		print(f"export_level_data: {asset_j_path} got exported.")


def export_asm(asset_j_path, asm_meta_path, asm_data_path, bin_path):

	with open(asset_j_path, "rb") as file:
		asset_j = json.load(file)

	asset_dir = str(Path(asset_j_path).parent) + "/"
	level_j_path = asset_dir + asset_j["path_level"]

	asm_ram_disk_data, data_ptrs, \
	resources, resource_max_tiledata, \
	containers, container_max_tiledata = ram_disk_data_to_asm(level_j_path)

	asm_ram_data = ram_data_to_asm(data_ptrs, level_j_path,
								resources, resource_max_tiledata,
								containers, container_max_tiledata)

	# save the asm gfx
	asm_data_dir = str(Path(asm_data_path).parent) + "/"
	if not os.path.exists(asm_data_dir):
		os.mkdir(asm_data_dir)
	with open(asm_data_path, "w") as file:
		file.write(asm_ram_disk_data)

	# compile and save the gfx bin files
	build.export_fdd_file(asm_meta_path, asm_data_path, bin_path, asm_ram_data)

	return True

def ram_disk_data_to_asm(level_j_path):

	with open(level_j_path, "rb") as file:
		level_j = json.load(file)

	level_dir = str(Path(level_j_path).parent) + "/"
	room_paths = level_j["rooms"]

	#=====================================================================
	# room data
		
	rooms_j = get_rooms_j(level_dir, room_paths)

	# make a tile index remap dictionary, to have the first idx = 0
	remap_idxs = export_level_utils.remap_index(rooms_j)

	# data for rooms_resources_tbl and rooms_resources
	resources = {}
	resource_max_tiledata = 0
	# data for rooms_containers_tbl and rooms_containers
	containers = {}
	container_max_tiledata = 0
	breakables_count = 0
	
	room_data_asm = ""
	room_data_ptrs = {}
	room_addr_offset = 0

	# per room data
	for room_id, room_j in enumerate(rooms_j):
		room_path = room_paths[room_id]['path']

		# clamp tiledata values into the range
		tiledatas_unclamped = room_j["layers"][1]["data"]
		tiledatas = [x % 256 for x in tiledatas_unclamped]

		width = room_j["width"]
		height = room_j["height"]

		asm_room_data = export_level_utils.room_tiles_to_asm(room_j["layers"][0], remap_idxs)
		asm_room_data += export_level_utils.room_tiles_data_to_asm(tiledatas, width, height, room_path)

		room_data_label = export_level_utils.get_room_data_label(room_path)
		compressed_room_asm, data_len = common.asm_compress_to_asm(asm_room_data)

		room_data_asm += "			.word 0 ; safety pair of bytes for reading by POP B\n"
		room_data_asm += "; " + room_path + "\n"
		room_data_asm += room_data_label + ":\n"
		room_data_asm += compressed_room_asm + "\n"

		room_data_ptrs[room_data_label] = room_addr_offset
		room_addr_offset += data_len
		room_addr_offset += 2 # safety pair of bytes for reading by POP B

		# collect resource data

		for i, tiledata in enumerate(tiledatas):
			width = room_j["width"]
			height = room_j["height"]
			dy, dx = divmod(i, width)
			tile_idx = (height - 1 - dy) * width + dx
			if export_level_utils.TILEDATA_RESOURCE <= tiledata < export_level_utils.TILEDATA_RESOURCE + export_level_utils.RESOURCES_UNIQUE_MAX:
				if tiledata not in resources:
					resources[tiledata] = []
				resources[tiledata].append((room_id, tile_idx))
				if resource_max_tiledata < tiledata:
					resource_max_tiledata = tiledata

			if export_level_utils.TILEDATA_CONTAINER <= tiledata < export_level_utils.TILEDATA_CONTAINER + export_level_utils.CONTAINERS_UNIQUE_MAX:
				if tiledata not in containers:
					containers[tiledata] = []
				containers[tiledata].append((room_id, tile_idx))
				if container_max_tiledata < tiledata:
					container_max_tiledata = tiledata

			if export_level_utils.TILEDATA_BREAKABLES <= tiledata < export_level_utils.TILEDATA_BREAKABLES + export_level_utils.BREAKABLES_UNIQUE_MAX:
				breakables_count += 1
				if breakables_count > export_level_utils.BREAKABLES_MAX:
					build.exit_error(f"ERROR: {level_j_path} has breakables amount > {export_level_utils.BREAKABLES_MAX}")
	
	
	asm = ""
	local_ptrs = {}
	local_addrs = 2 # added safety pair of bytes for reading by POP B

	#=====================================================================
	# rooms data

	asm += room_data_asm
	# add the room data pointers
	for label, addr in room_data_ptrs.items():
		local_ptrs[label] = addr + local_addrs
	
	#=====================================================================

	return asm, local_ptrs, \
		resources, resource_max_tiledata, \
		containers, container_max_tiledata

def get_resources_inst_data(level_j_path, resources, resource_max_tiledata):

	data_len = build.SAFE_WORD_LEN

	level_prefix = common.path_to_basename(level_j_path)
	label = f"_{level_prefix}_resources_inst_data_ptrs"

	asm = ""
	asm += f"{label}:\n"

	# make resources_inst_data_ptrs data
	if len(resources) > 0:
		asm += "			.byte "		

		# add resource tiledata which is not present in the level to
		# make resources_inst_data_ptrs array contain contiguous data
		# for example: all the rooms contain only res_id=1 and res_id=3
		# to make a proper data we need to add null_ptrs for res_id=0 and res_id=2
		# to let the asm code look up it by the res_id
		for tiledata in range(export_level_utils.TILEDATA_RESOURCE, resource_max_tiledata + 1):
			if tiledata not in resources:
				resources[tiledata] = []

		resources_sorted = dict(sorted(resources.items()))

		ptr = 0
		resources_inst_data_ptrs_len = len(resources_sorted) + 1

		for i, tiledata in enumerate(resources_sorted):
			inst_len = len(resources_sorted[tiledata]) * build.WORD_LEN
			if len(resources_sorted[tiledata]) > 0:
				data_byte = ptr + resources_inst_data_ptrs_len
			else:
				data_byte = ptr + inst_len + resources_inst_data_ptrs_len

			asm += str(data_byte) + ", "
			ptr += inst_len
			data_len += build.BYTE_LEN

		asm += str(ptr + resources_inst_data_ptrs_len) + ", "
		data_len += build.BYTE_LEN

		# make resources_inst_data data
		asm += f"\n_{level_prefix}_resources_inst_data:\n"
		for i, tiledata in enumerate(resources_sorted):
			if len(resources_sorted[tiledata]) > 0:
				asm += f";			tiledata = {tiledata}, data below is pairs of tile_idx, room_id\n"
				data = []
				for room_id, tile_idx in resources_sorted[tiledata]:
					data.append(tile_idx)
					data.append(room_id)
				asm += common.bytes_to_asm(data)
				data_len += len(data)


		if ptr + resources_inst_data_ptrs_len > 256:
			build.exit_error(f"ERROR: {level_j_path} has resource instance data > {export_level_utils.RESOURCES_LEN} bytes")

	asm += "\n"

	return asm, label, data_len

def get_containers_inst_data(level_j_path, containers, container_max_tiledata):

	data_len = build.SAFE_WORD_LEN

	level_prefix = common.path_to_basename(level_j_path)
	label = f"_{level_prefix}_containers_inst_data_ptrs"

	asm = ""
	asm += f"{label}:\n"

	# make containers_inst_data_ptrs data
	if len(containers) > 0:
		asm += "			.byte "

		# add container tiledata which is not present in the level
		# to make containers_inst_data_ptrs array contain contiguous data
		# for example: all the rooms contain only container_id=1 and container_id=3
		# to make a proper data we need to add null_ptrs for container_id=0 and container_id=2
		# to let the asm code look up it by the container_id
		for tiledata in range(export_level_utils.TILEDATA_CONTAINER, container_max_tiledata + 1):
			if tiledata not in containers:
				containers[tiledata] = []

		containers_sorted = dict(sorted(containers.items()))

		ptr = 0
		containers_inst_data_ptrs_len = len(containers_sorted) + 1
		for i, tiledata in enumerate(containers_sorted):
			inst_len = len(containers_sorted[tiledata]) * build.WORD_LEN
			if len(containers_sorted[tiledata]) > 0:
				byte_data = ptr + containers_inst_data_ptrs_len
			else:
				byte_data = ptr + inst_len + containers_inst_data_ptrs_len

			asm += str(byte_data) + ", "
			ptr += inst_len
			data_len += build.BYTE_LEN

		asm += str(ptr + containers_inst_data_ptrs_len) + ", "
		data_len += build.BYTE_LEN

		# make containers_inst_data data
		asm += f"\n_{level_prefix}_containers_inst_data:\n"
		for i, tiledata in enumerate(containers_sorted):
			if len(containers_sorted[tiledata]) > 0:
				asm += f";			tiledata = {tiledata}, data below is pairs of tile_idx, room_id\n"
				data = []
				
				for room_id, tile_idx in containers_sorted[tiledata]:
					data.append(tile_idx)
					data.append(room_id)

				asm += common.bytes_to_asm(data)
				data_len += len(data)

		if 	ptr + containers_inst_data_ptrs_len > 256:
			build.exit_error(f"ERROR: {level_j_path} has container instance data > {export_level_utils.CONTAINERS_LEN} bytes")

	asm += "\n"

	return asm, label, data_len


def ram_data_to_asm(data_ptrs, level_j_path,
					resources, resource_max_tiledata,
					containers, container_max_tiledata):

	with open(level_j_path, "rb") as file:
		level_j = json.load(file)

	room_paths = level_j["rooms"]

	asm = ""

	#=====================================================================
	# player's start pose
	level_name = common.path_to_basename(level_j_path)

	player_start_pose = f"_{level_name}_start_pos"
	asm += f"{player_start_pose}:					; a hero starting pos\n"
	asm += f'			.byte {level_j["hero_start_pos"]["y"]}			; pos_y\n'
	asm += f'			.byte {level_j["hero_start_pos"]["x"]}			; pos_x\n'
	asm += "\n"

	#=====================================================================
	# rooms data (gfx_idx + tiledata) pointers
	data_asm, label, data_len = export_level_utils.get_list_of_rooms(room_paths, level_name)
	asm += data_asm
	
	#=====================================================================
	# resources data
	data_asm, label, data_len = \
		get_resources_inst_data(level_j_path, resources, resource_max_tiledata)
	asm += data_asm
	
	#=====================================================================
	# containers data
	data_asm, label, data_len = \
		get_containers_inst_data(level_j_path, containers, container_max_tiledata)
	asm += data_asm
	
	#=====================================================================
	# list of rooms
	for label, addr in data_ptrs.items():
		asm += f"{label} = {addr}\n"
	asm += "\n"

	return asm

def get_rooms_j(asset_dir, room_paths):

	rooms_j = []
	# load and process tiled map
	for room_path_p in room_paths:
		room_path = room_path_p['path']
		with open(asset_dir + room_path, "rb") as file:
			rooms_j.append(json.load(file))

	return rooms_j