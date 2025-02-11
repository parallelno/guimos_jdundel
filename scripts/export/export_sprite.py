import os
from pathlib import Path
from PIL import Image
import json
import utils.common as common
import utils.common_gfx as common_gfx
import utils.build as build


def export_if_updated(
		asset_j_path, asm_meta_path, asm_data_path, bin_path,
		force_export):
	
	if force_export or is_source_updated(asset_j_path):
		export_asm(asset_j_path, asm_meta_path, asm_data_path, bin_path)
		print(f"export_sprite: {asset_j_path} got exported.")


def is_source_updated(asset_j_path):
	with open(asset_j_path, "rb") as file:
		asset_j = json.load(file)
	
	asset_dir = str(Path(asset_j_path).parent) + "/"
	path_png = asset_dir + asset_j["path_png"]

	if build.is_file_updated(asset_j_path) | build.is_file_updated(path_png):
		return True
	return False


def export_asm(asset_j_path, asm_meta_path, asm_data_path, bin_path):

	with open(asset_j_path, "rb") as file:
		asset_j = json.load(file)

	asset_name = common.path_to_basename(asset_j_path)
	asset_dir = str(Path(asset_j_path).parent) + "/"
	path_png = asset_dir + asset_j["path_png"]
	image = Image.open(path_png)
	has_mask = str(asset_j["mask"])
	_, colors = common_gfx.palette_to_asm(image, asset_j)
	image = common_gfx.remap_colors(image, colors)

	asm_ram_disk_data, data_ptrs = gfx_to_asm("_", asset_name, asset_j, image, has_mask, asset_j_path)
	asm_ram_data = anims_to_asm("_", asset_name, asset_j, data_ptrs, asset_j_path)

	# save the asm gfx
	asm_gfx_dir = str(Path(asm_data_path).parent) + "/"
	if not os.path.exists(asm_gfx_dir):
		os.mkdir(asm_gfx_dir)
	with open(asm_data_path, "w") as file:
		file.write(asm_ram_disk_data)
	
	# compile and save the gfx bin files
	build.export_fdd_file(asm_meta_path, asm_data_path, bin_path, asm_ram_data)

	return True


def sprite_data(bytes1, bytes2, bytes3, w, h, mask_bytes = None):
	# sprite data structure description is in draw_sprite.asm
	# sprite uses only 3 out of 4 screen buffers.
	# the width is devided by 8 because there is 8 pixels per a byte
	width = w // 8
	data = []
	for y in range(h):
		even_line = y % 2 == 0
		if even_line:
			for x in range(width):
				i = y*width+x
				if mask_bytes:
					data.append(mask_bytes[i])
				data.append(bytes1[i])
			for x in range(width):
				i = y*width+width-x-1
				if mask_bytes:
					data.append(mask_bytes[i])
				data.append(bytes2[i])
			for x in range(width):
				i = y*width+width-x-1
				if mask_bytes:
					data.append(mask_bytes[i])
				data.append(bytes3[i])
		else:
			for x in range(width):
				i = y*width+x
				if mask_bytes:
					data.append(mask_bytes[i])
				data.append(bytes3[i])
			for x in range(width):
				i = y*width+width-x-1
				if mask_bytes:
					data.append(mask_bytes[i])
				data.append(bytes2[i])
			for x in range(width):
				i = y*width+width-x-1
				if mask_bytes:
					data.append(mask_bytes[i])
				data.append(bytes1[i])

	return data

def get_anim_labels(path, main_ram_labels_addrs):
	with open(path, "r") as file:
		lines = file.readlines()

	anim_j_path = lines[0][2:]
	sprite_name = common.path_to_basename(anim_j_path)

	anim_labels = ""
	
	for i, line in enumerate(lines):
		if line.find(sprite_name) == 0 and line.find(':') != -1:
			label_name_end = line.find(":")
			label_name = line[:label_name_end]
			addr = main_ram_labels_addrs[label_name]
			anim_labels += f"{label_name} = ${addr:X}\n"
							
	return 	anim_labels

def anims_to_asm(label_prefix, asset_name, source_j, data_ptrs, source_j_path):
	asm = ""

	preshifted_sprites = source_j.get("preshifted_sprites", 1)
	
	if (preshifted_sprites != 1 and
		preshifted_sprites != 4 and preshifted_sprites != 8):
		build.exit_error(f'export_sprite ERROR: preshifted_sprites can be only equal 1, 4, 8", path: {source_j_path}')

	if preshifted_sprites == 4 or preshifted_sprites == 8:
		asm += f"sprite_get_scr_addr_{asset_name} = sprite_get_scr_addr{preshifted_sprites}\n\n"
		asm += f"{label_prefix}{asset_name}_preshifted_sprites:\n"
		asm += f"			.byte {str(preshifted_sprites)}\n"

	# make a list of anim_names
	asm += f"{label_prefix}{asset_name}_anims:\n"
	asm += "			.word "
	for anim_name in source_j["anims"]:
		asm += f"{label_prefix}{asset_name}_{anim_name}, "
	asm += "0, \n"

	# make a list of sprites for an every anim
	for anim_name in source_j["anims"]:

		asm += f"{label_prefix}{asset_name}_{anim_name}:\n"
 
		frames = source_j["anims"][anim_name]["frames"]
		loop = source_j["anims"][anim_name]["loop"]
		frame_count = len(frames)
		for i, frame in enumerate(frames):

			if i < frame_count-1:
				next_frame_offset = preshifted_sprites * 2 # every frame consists of preshifted_sprites pointers
				next_frame_offset += 1 # increase the offset to save one instruction in the game code
				asm += f"			.byte {str(next_frame_offset)}, 0 ; offset to the next frame\n"
			else:
				next_frame_offset_hi_str = "$ff"
				if loop == False:
					next_frame_offset_low = -1
					comment = "offset to the same last frame"
				else:
					offset_addr = 1
					next_frame_offset_low = 255 - (frame_count - 1) * (preshifted_sprites + offset_addr) * 2 + 1
					next_frame_offset_low -= 1 # decrease the offset to save one instruction in the game code
					comment = "offset to the first frame"
					
				asm += f"			.byte {next_frame_offset_low}, {next_frame_offset_hi_str} ; {comment}\n"

			asm += "			.word "
			for i in range(preshifted_sprites):
				frame_label = f"{label_prefix}{asset_name}_{str(frame)}_{str(i)}"
				asm += frame_label + ", "
			asm += "\n"

	# add the list of frame labels and their addresses
	frame_relative_labels_asm = "; relative labels. to make it global call __text_ex_rd_init\n"
	for label_name, addr in data_ptrs.items():
		frame_relative_labels_asm += f"{label_name} = {addr}\n"
	frame_relative_labels_asm += "\n"
	asm = frame_relative_labels_asm + asm 

	return asm

def get_sprite_params(dx_l, dx_r, shift):
	shifted_dx_l = shift + dx_l
	shifted_dx_r = shift + dx_r

	offset_x_preshifted_local = shifted_dx_l//8 * 8
	width_new = (shifted_dx_r//8+1) * 8 - offset_x_preshifted_local
	return offset_x_preshifted_local, width_new

def make_empty_sprite_data(has_mask, width, height):
	src_buff_count = 3
	data = []
	for dy in range(height):
		for dx in range(width // 8 * src_buff_count):		
			if has_mask:
				data.append(255)
			data.append(0)

	return data

def gfx_to_asm(label_prefix, asset_name, source_j, image, has_mask, source_j_path):
	sprites_j = source_j["sprites"]
	asm = f"{label_prefix}{asset_name}_sprites:"

	data_ptrs = {}
	sprite_data_relative_addr = 2 # safety pair of bytes for reading by POP B

	preshifted_sprites = source_j.get("preshifted_sprites", 1)
	
	if (preshifted_sprites != 1 and
		preshifted_sprites != 4 and preshifted_sprites != 8):
		build.exit_error(f'export_sprite ERROR: preshifted_sprites can be only equal 1, 4, 8. Path: {source_j_path}')

	for sprite in sprites_j:
		sprite_name = sprite["name"]
		
		x = sprite["x"]
		y = sprite["y"]
		width = sprite["width"]
		height = sprite["height"]
		offset_x = sprite["offset_x"] if sprite.get("offset_x") is not None else 0
		offset_y = sprite["offset_y"] if sprite.get("offset_y") is not None else 0
		mirrored = sprite["mirrored"] if sprite.get("mirrored") is not None else False
		mask_alpha = sprite["mask_alpha"]
		mask_color = sprite["mask_color"]

		# get a sprite as a color index 2d array
		sprite_img = []
		for pos_y in reversed(range(y, y + height)) : # Y is reversed because it is from bottom to top in the game
			line = []
			for pos_x in range(x, x+width) :
				color_idx = image.getpixel((pos_x, pos_y))
				line.append(color_idx)

			sprite_img.append(line)

		# convert indexes into bit lists.
		bits0, bits1, bits2, bits3 = common_gfx.indexes_to_bit_lists(sprite_img)
		
		# combine bits into byte lists
		#bytes0 = common.combine_bits_to_bytes(bits0) # 8000-9FFF # from left to right, from bottom to top
		bytes1 = common.combine_bits_to_bytes(bits1) # A000-BFFF
		bytes2 = common.combine_bits_to_bytes(bits2) # C000-DFFF
		bytes3 = common.combine_bits_to_bytes(bits3) # E000-FFFF

		mask_bytes = None
		if has_mask:
			# get a sprite as a color index 2d array
			x = sprite["mask_x"]
			y = sprite["mask_y"]

			mask_img = []
			for py in reversed(range(y, y + height)) : # Y is reversed because it is from bottomto top in the game
				for px in range(x, x+width) :
					color_idx = image.getpixel((px, py))
					if color_idx == mask_alpha:
						mask_img.append(1)
					else:
						mask_img.append(0)

			mask_bytes = common.combine_bits_to_bytes(mask_img)

		if mirrored:
			l = len(bytes1)
			bytes1 = [0] * l
			bytes2 = [0] * l
			bytes3 = [0] * l
			if mirrored:
				lm = len(mask_bytes)
				mask_bytes = [0] * lm

		# packing bytes to the sprite data
		data = sprite_data(bytes1, bytes2, bytes3, width, height, mask_bytes)

		if has_mask:
			mask_flag = 1
		else: 
			mask_flag = 0

		asm += "\n"
		asm += f"			.byte {mask_flag},1  ; safety pair of bytes for reading by POP B, and also (mask_flag, preshifting is done)\n"
		frame_label = f"{label_prefix}{asset_name}_{sprite_name}_0"
		asm += f"{frame_label}:\n"

		width_packed = width//8 - 1
		offset_x_packed = offset_x//8
		asm += f"			.byte {str( offset_y )}, {str( offset_x_packed )}; offset_y, offset_x\n"
		asm += f"			.byte {str( height )}, {str( width_packed )}; height, width\n"

		asm += common.bytes_to_asm(data)
		
		data_ptrs[frame_label] = sprite_data_relative_addr
		sprite_data_relative_addr += len(data)
		sprite_data_relative_addr += 2 # safety pair of bytes for reading by POP B
		sprite_data_relative_addr += 4 # offset_y, offset_x_packed, height, width_packed


		# find leftest pixel dx
		dx_l = common_gfx.find_sprite_horiz_border(True, sprite_img, mask_alpha, width, height)
		# find rightest pixel dx
		dx_r = common_gfx.find_sprite_horiz_border(False, sprite_img, mask_alpha, width, height) 

		# calculate preshifted sprite data
		for i in range(1, preshifted_sprites):
			shift = 8 // preshifted_sprites * i

			offset_x_preshifted_local, width_preshifted = get_sprite_params(dx_l, dx_r, shift)
			offset_x_preshifted = offset_x + offset_x_preshifted_local
			asm += "\n"

			copy_from_buff_offset = offset_x_preshifted_local//8
			#if width_preshifted == 8:
			#	copy_from_buff_offset -= 1

			frame_label = f"{label_prefix}{asset_name}_{sprite_name}_{str(i)}"
			asm += f"			.byte {str(copy_from_buff_offset)}, {str(mask_flag)} ; safety pair of bytes for reading by POP B and also (copy_from_buff_offset, mask_flag)\n"
			asm += f"{frame_label}:\n"

			width_preshifted_packed = width_preshifted//8 - 1 
			offset_x_preshifted_packed = offset_x_preshifted//8
			asm += f"			.byte {str( offset_y )}, {str( offset_x_preshifted_packed )}; offset_y, offset_x\n"
			asm += f"			.byte {str( height )}, {str( width_preshifted_packed )}; height, width\n"

			frame_data = make_empty_sprite_data(has_mask, width_preshifted, height)
			asm += common.bytes_to_asm(frame_data)
			
			data_ptrs[frame_label] = sprite_data_relative_addr
			sprite_data_relative_addr += len(frame_data)

	return asm, data_ptrs

