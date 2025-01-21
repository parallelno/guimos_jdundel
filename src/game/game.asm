.include "build/debug/font/font_gfx_ptrs.asm"

main_start:
			; init the files data ptr
			lxi h, 0x6000
			shld os_file_data_ptr
			; load the music player
			LOAD_FILE(FONT_filename, FONT_FILE_LEN)
			font
			ret