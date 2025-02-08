import os
from PIL import Image
from pathlib import Path
import json
import utils.common as common
import utils.common as common_gfx
import utils.build as build

# TODO: get this from asm file
TILEDATA_RESOURCE	= 7*16
RESOURCES_UNIQUE_MAX = 16
RESOURCES_LEN	= 0x100		
# collect container data
TILEDATA_CONTAINER	= 11*16 
CONTAINERS_UNIQUE_MAX = 16
CONTAINERS_LEN	= 0x100
TILEDATA_BREAKABLES	= 13*16
BREAKABLES_UNIQUE_MAX = 16
BREAKABLES_MAX = 1016

WORD_LEN			= 2
NULL			= "NULL"


def is_source_updated(asset_j_path, type):
	
	with open(asset_j_path, "rb") as file:
		asset_j = json.load(file)

	asset_dir = str(Path(asset_j_path).parent) + "/"
	level_j_path = asset_dir + asset_j["path_level"]


	with open(level_j_path, "rb") as file:
		level_j = json.load(file)
	
	level_dir = str(Path(level_j_path).parent) + "/"
	path_png = level_dir + level_j["path_png"]

	room_paths = level_j["rooms"]
	
	if build.is_file_updated(asset_j_path):
		return True
	if build.is_file_updated(level_j_path):
		return True
	
	if type == build.ASSET_TYPE_LEVEL_DATA:
		for room_path_p in room_paths:
			room_path = room_path_p['path']
			if build.is_file_updated(room_path):
				return True

	if type == build.ASSET_TYPE_LEVEL_GFX:
		if build.is_file_updated(path_png):
			return True

	return False

def remap_index(rooms_j):
	unique_idxs = [] # old idx : new idx
	for room_j in rooms_j:
		for idx in room_j["layers"][0]["data"]:
			if idx in unique_idxs:
				continue
			unique_idxs.append(idx)
	remap_idxs = {} # old idx : new idx
	for i, idx in enumerate(unique_idxs):
		remap_idxs[idx] = i
	
	return remap_idxs

def get_list_of_rooms(room_paths, label_prefix):
	asm = "\n			.word 0 ; safety pair of bytes for reading by POP B\n"
	asm += label_prefix + "_rooms_addr:\n			.word "

	for i, room_path_p in enumerate(room_paths):
		room_path = room_path_p['path']
		asm += get_room_data_label(room_path) + ", "

		if i != len(room_paths)-1:
			# two safety fytes
			asm += "0, "
	asm += "\n"
	return asm

def get_room_data_label(room_path):
	return '_' + common.path_to_basename(room_path)

def room_tiles_to_asm(room_j, remap_idxs):
	asm = ""
	width = room_j["width"]
	height = room_j["height"]
	width * height

	for y in reversed(range(height)):
		asm += "			.byte "
		for x in range(width):
			i = y*width + x
			t_idx = room_j["data"][i]
			asm += str(remap_idxs[t_idx]) + ", "
		asm += "\n"
	return asm

def room_tiles_data_to_asm(data, width, height, room_path):
	asm = "; " + room_path + "\n"
	label_prefix = common.path_to_basename(room_path)

	asm += label_prefix + "_tilesData:\n"

	for y in reversed(range(height)):
		asm += "			.byte "
		for x in range(width):
			i = y*width + x
			t_idx = data[i]
			asm += str(t_idx) + ", "
		asm += "\n"
	return asm

def get_tiledata(bytes0, bytes1, bytes2, bytes3):
	all_bytes = [bytes0, bytes1, bytes2, bytes3]
	# data structure description is in draw_tile.asm
	mask = 0
	data = []
	for bytes in all_bytes:
		mask >>=  1
		if common.is_bytes_zeros(bytes) : 
			continue
		mask += 8

		x = 0
		for y in reversed(range(16)):
			byte = bytes[y * 2 + x]
			data.append(byte)
		x = 1
		for y in range(16):
			byte = bytes[y * 2 + x]
			data.append(byte)

	return data, mask