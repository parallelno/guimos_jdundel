import struct
import sys
import os
import json
from pathlib import Path
import utils.common as common
import utils.build as build
import lhafile
import io


def export_if_updated(		asset_j_path, asm_meta_path, asm_data_path, bin_path,
		force_export):

	if force_export or is_source_updated(asset_j_path):
		export_asm(asset_j_path, asm_meta_path, asm_data_path, bin_path)
		print(f"export_music: {asset_j_path} got exported.")

def is_source_updated(asset_j_path):
	with open(asset_j_path, "rb") as file:
		source_j = json.load(file)
	
	source_dir = str(Path(asset_j_path).parent) + "/"
	path_ym = source_dir + source_j["path_ym"]

	if build.is_file_updated(asset_j_path) | build.is_file_updated(path_ym):
		return True
	return False

def export_asm(asset_j_path, asm_meta_path, asm_data_path, bin_path, clean_tmp = True):

	# create a folder
	export_dir = str(Path(asm_meta_path).parent) + "/"
	if not os.path.exists(export_dir):
		os.mkdir(export_dir)

	try:
		with open(asset_j_path, "rb") as file:
			source_j = json.load(file)

			source_dir = str(Path(asset_j_path).parent) + "/"
			song_path = source_dir + source_j["path_ym"]

		[reg_data, comment1, comment2, comment3] = readym(song_path)
	except:
		build.exit_error(f'export_music ERROR: reading file: {song_path}')

	ay_reg_data_ptrs = ""
	ay_reg_data_lens = []

	# save the asm
	source_name = os.path.splitext(asset_j_path)[0]
	with open(asm_data_path, "w") as file_inc:
		# task stacks
		# song's credits
		file_inc.write(f'; {comment1}\n; {comment2}\n; {comment3}\n')
		
		# org
		file_inc.write(f'.org 0\n')

		for i, c in enumerate(reg_data[0:14]):
			bin_file = f"source_name{i:02d}{build.EXT_BIN}"
			zx0File = f"source_name{i:02d}{build.packer_ext}"
			with open(bin_file, "wb") as f:
				f.write(c)
			
			common.delete_file(zx0File)
			common.run_command(f"{build.packer_path.replace('/', '\\')} -w 256 {bin_file} {zx0File}")

			with open(zx0File, "rb") as f:
				dbname = f"ay_reg_data{i:02d}"
				data = f.read()
				file_inc.write(f'{dbname}: .byte ' + ",".join("$%02x" % x for x in data) + "\n")
				ay_reg_data_lens.append(len(data))

			if clean_tmp:
				print("export_music: clean up tmp resources")
				common.delete_file(bin_file)
				common.delete_file(zx0File)

	# reg_data ptrs. 
	addr = 0
	for i, reg_data_len in enumerate(ay_reg_data_lens):
		label_name = f'ay_reg_data{i:02d}'
		ay_reg_data_ptrs += f'{label_name} = {addr}\n'
		addr += reg_data_len

	ay_reg_data_ptrs += '\n'
		
	ay_reg_data_ptrs += f'v6_gc_ay_reg_data_ptrs:\n			.word '
	for i, _ in enumerate(reg_data[0:14]):
		ay_reg_data_ptrs += f'ay_reg_data{i:02d}, '
	ay_reg_data_ptrs += '\n'

	# save the bin
	build.export_fdd_file(asm_meta_path, asm_data_path, bin_path, ay_reg_data_ptrs)

	return True


def chunker(seq, size):
	return (seq[pos:pos + size] for pos in range(0, len(seq), size))

def drop_comment(f):
	comment = ''
	print("export_music: song name/credits: ")
	while True:
		b = f.read(1)
		if b[0] == 0:
			break
		comment = comment + chr(b[0])
		print(chr(b[0]), end='')
	print()
	return comment 

def readym(filename):
	try:
		lf = lhafile.Lhafile(filename)
		data = lf.read(lf.namelist()[0])
		f = io.BytesIO(data)
	except:
		f = open(filename, "rb")

	hdr = f.read(12) # YM6!LeOnArD!               # 12
	print('export_music: hdr=', hdr)
	nframes = struct.unpack(">I", f.read(4))[0]      # 16

	print("export_music: YM6 file has ", nframes, " frames")

	attrib = struct.unpack(">I", f.read(4))       # 20
	digidrums = struct.unpack(">h", f.read(2))    # 22
	masterclock = struct.unpack(">I", f.read(4))  # 26
	framehz = struct.unpack(">h", f.read(2))      # 28
	loopfrm = struct.unpack(">I", f.read(4))      # 32
	f.read(2) # additional data                   # 34
	print("export_music: Masterclock: ", masterclock, "Hz")
	print("export_music: Frame: ", framehz, "Hz")

	# skip digidrums but we don't do that here..

	comment1 = drop_comment(f)
	comment2 = drop_comment(f)
	comment3 = drop_comment(f)

	regs=[]
	for i in range(16):
		complete = list(f.read(nframes))
		chu = chunker(complete, 2)
		#decimated = [x if x < y else y for x, y in chu]
		#decimated = complete[::2]
		#decimated = [x if x != 255 else y for x, y in chu]
		decimated = complete
		decbytes = bytes(decimated)
		regs.append(decbytes)  ## brutal decimator

	f.close()

	return [regs, comment1, comment2, comment3]