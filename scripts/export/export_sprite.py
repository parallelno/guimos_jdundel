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
	_, colors = common_gfx.palette_to_asm(image, asset_j)
	image = common_gfx.remap_colors(image, colors)

	asm_ram_disk_data, data_ptrs = gfx_to_asm("_", asset_name, asset_j, image, asset_j_path)
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


def anims_to_asm(label_prefix, asset_name, asset_j, data_ptrs, source_j_path):
	asm = ""

	preshifted_sprites = asset_j.get("preshifted_sprites", 1)

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
	for anim_name in asset_j["anims"]:
		asm += f"{label_prefix}{asset_name}_{anim_name}, "
	asm += "0, \n"

	# make a list of sprites for an every anim
	for anim_name in asset_j["anims"]:

		asm += f"{label_prefix}{asset_name}_{anim_name}:\n"

		frames = asset_j["anims"][anim_name]["frames"]
		loop = asset_j["anims"][anim_name]["loop"]
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
	frame_relative_labels_asm = "; relative frame labels\n"
	for label_name, addr in data_ptrs.items():
		frame_relative_labels_asm += f"{label_name} = {addr}\n"
	frame_relative_labels_asm += "\n"
	asm = frame_relative_labels_asm + asm

	return asm


def gfx_to_asm(label_prefix, asset_name, asset_j, image, source_j_path):

	sprites_j = asset_j["sprites"]
	mask_flag = 1 if "mask" in asset_j and asset_j["mask"] == True else 0

	asm = f"{label_prefix}{asset_name}_sprites:"

	data_ptrs = {}
	sprite_data_relative_addr = 2 # safety pair of bytes for reading by POP B

	preshifted_sprites_num = asset_j.get("preshifted_sprites", 1)

	if (preshifted_sprites_num != 1 and
		preshifted_sprites_num != 4 and preshifted_sprites_num != 8):
		build.exit_error(f'export_sprite ERROR: preshifted_sprites can be only equal 1, 4, 8. Path: {source_j_path}')

	for sprite in sprites_j:

		sprite_name = sprite["name"]

		x = sprite["x"]
		y = sprite["y"]
		w = sprite["width"]
		h = sprite["height"]
		offset_x = sprite["offset_x"] if sprite.get("offset_x") is not None else 0
		offset_y = sprite["offset_y"] if sprite.get("offset_y") is not None else 0
		mask_alpha = sprite["mask_alpha"]
		mask_color = sprite["mask_color"]

		# 2d pixel array RGB
		sprite_img = []
		mask_bits = None

		for pos_y in reversed(range(y, y + h)) : # Y is reversed because it is from bottom to top in the game
			line = []
			for pos_x in range(x, x + w) :
				color_idx = image.getpixel((pos_x, pos_y))
				line.append(color_idx)

			sprite_img.append(line)

		# 2d pixel array mask
		if mask_flag == 1:
			mask_bits = []
			# get a sprite as a color index 2d array
			x = sprite["mask_x"]
			y = sprite["mask_y"]

			for pos_y in reversed(range(y, y + h)) : # Y is reversed because it is from bottomto top in the game
				for pos_x in range(x, x+w) :
					color_idx = image.getpixel((pos_x, pos_y))
					mask = 1 if color_idx == mask_alpha else 0
					mask_bits.append(mask)


		# preshifted sprite data
		for preshift in range(0, preshifted_sprites_num):

			# make frame asm
			shift = 8 // preshifted_sprites_num * preshift
			frame_label = f"{label_prefix}{asset_name}_{sprite_name}_{preshift}"

			frame_asm, frame_data_len = img_to_preshifted_sprite(
				frame_label, sprite_img, mask_bits,
				w, h, offset_x, offset_y, shift)

			asm += frame_asm
			# collect a label and its relative addr
			data_ptrs[frame_label] = sprite_data_relative_addr
			sprite_data_relative_addr += frame_data_len

	return asm, data_ptrs

def img_to_preshifted_sprite(
		frame_label, sprite_img, mask_bits,
		w, h, offset_x, offset_y, shift):

	# convert indexes into bit lists.
	bits0, bits1, bits2, bits3 = common_gfx.indexes_to_bit_lists(sprite_img)
 
	# preshift image
	if (shift > 0):
		#bits0 = shift_bits(bits0, w, h, shift)
		bits1 = shift_bits(bits1, w, h, shift)
		bits2 = shift_bits(bits2, w, h, shift)
		bits3 = shift_bits(bits3, w, h, shift)
		if (mask_bits):
			mask_bits = shift_bits(mask_bits, w, h, shift, 1)

		w += 8

	# find the first visible pixel from left and right
	bits_to_check = []
	if mask_bits:
		bits_to_check = [mask_bits]
	else:
		bits_to_check = [bits1, bits2, bits3]

	vis_bit_l = 0
	vis_bit_r = w
	enabled = 1 if mask_bits == None else 0
	for bits in bits_to_check:
		l = find_leftest_bit(bits, w, h, enabled)
		if l > vis_bit_l:
			vis_bit_l = l
		
		r = find_rightest_bit(bits, w, h, enabled)
		if r < vis_bit_r:
			vis_bit_r = r

	# crop a sprite to rounded by 8 pixels (bytes)
	local_offset_x = vis_bit_l // 8 * 8
	new_w_unrounded = vis_bit_r - local_offset_x
	new_w = (new_w_unrounded // 8) * 8 
	if (new_w_unrounded % 8) > 0:
		new_w += 8
	
	bits1 = crop_bits(bits1, w, h, new_w, local_offset_x)
	bits2 = crop_bits(bits2, w, h, new_w, local_offset_x)
	bits3 = crop_bits(bits3, w, h, new_w, local_offset_x)
	if mask_bits:
		mask_bits = crop_bits(mask_bits, w, h, new_w, local_offset_x)


	# combine bits into byte lists
	#bytes0 = common.combine_bits_to_bytes(bits0) # 8000-9FFF # from left to right, from bottom to top
	bytes1 = common.combine_bits_to_bytes(bits1) # A000-BFFF
	bytes2 = common.combine_bits_to_bytes(bits2) # C000-DFFF
	bytes3 = common.combine_bits_to_bytes(bits3) # E000-FFFF

	mask_bytes = common.combine_bits_to_bytes(mask_bits) if mask_bits else None

	# packing bytes to the sprite data
	data = sprite_data(bytes1, bytes2, bytes3, new_w, h, mask_bytes) 

	offset_x_packed = (offset_x + local_offset_x) // 8
	new_w_packed = new_w // 8 - 1 

	asm = ""
	asm += "\n"
	asm += f"			.word 0  ; safety pair of bytes for reading by POP B\n"
	asm += f"{frame_label}:\n"
	asm += f"			.byte {str( offset_y )}, {str( offset_x_packed )}; offset_y, offset_x\n"
	asm += f"			.byte {str( h )}, {str( new_w_packed )}; h, w\n"
	asm += common.bytes_to_asm(data)
	asm += "\n"

	frame_data_len = len(data)
	frame_data_len += 2 # safety pair of bytes for reading by POP B
	frame_data_len += 4 # offset_y, offset_x_packed, h, width_packed

	return asm, frame_data_len

def crop_bits(bits, w, h, new_w, offset_x):
	if w == new_w:
		return bits
	cropped = []
	for y in range(h):
		for x in range(w):
			if x < offset_x or x >= offset_x + new_w:
				continue
			b = bits[y*w + x]
			cropped.append(b)
			
	return cropped


# find the most leftest or rightest enabled bit in a 2d bit array
# return its dx
def find_leftest_bit(bits, w, h, enabled):
	dx = w
	for y in range(h):
		for x in range(w):
			b = bits[y*w + x]
			if b == enabled and x < dx:
				dx = x
				break
	return dx

def find_rightest_bit(bits, w, h, enabled):
	dx = 0
	for y in range(h):
		for x in reversed(range(w)):
			b = bits[y*w + x]
			if b == enabled and x > dx:
				dx = x
				break
	return dx

def shift_bits(bits, w, h, shift, filler = 0):
	shifted_bits = []
	shifted_w = w + 8
	for y in range(h):
		for x in range(shift):
			shifted_bits.append(filler)
		
		for x in range(w):
			b = bits[w*y + x]
			shifted_bits.append(b)

		for x in range(8 - shift):
			shifted_bits.append(filler)
			
	return shifted_bits


def get_sprite_params(dx_l, dx_r, shift):
	shifted_dx_l = shift + dx_l
	shifted_dx_r = shift + dx_r

	offset_x_preshifted_local = shifted_dx_l//8 * 8
	width_new = (shifted_dx_r//8+1) * 8 - offset_x_preshifted_local
	return offset_x_preshifted_local, width_new

def make_empty_sprite_data(has_mask, w, h):
	src_buff_count = 3
	data = []
	for dy in range(h):
		for dx in range(w // 8 * src_buff_count):
			if has_mask:
				data.append(255)
			data.append(0)

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


def sprite_data(bytes1, bytes2, bytes3, width, h, mask_bytes = None): 
	# sprite data structure description is in draw_sprite.asm
	# sprite uses only 3 out of 4 screen buffers.
	# the w is devided by 8 because there is 8 pixels per a byte
	w = width // 8
	data = []
	for y in range(h):
		even_line = y % 2 == 0
		if even_line:
			for x in range(w): 
				i = y*w+x
				if mask_bytes:
					data.append(mask_bytes[i])
				data.append(bytes1[i]) 
			for x in range(w):
				i = y*w+w-x-1
				if mask_bytes:
					data.append(mask_bytes[i])
				data.append(bytes2[i])
			for x in range(w):
				i = y*w+w-x-1
				if mask_bytes:
					data.append(mask_bytes[i])
				data.append(bytes3[i])
		else:
			for x in range(w):
				i = y*w+x
				if mask_bytes:
					data.append(mask_bytes[i])
				data.append(bytes3[i])
			for x in range(w):
				i = y*w+w-x-1
				if mask_bytes:
					data.append(mask_bytes[i])
				data.append(bytes2[i])
			for x in range(w):
				i = y*w+w-x-1
				if mask_bytes:
					data.append(mask_bytes[i])
				data.append(bytes1[i])

	return data
