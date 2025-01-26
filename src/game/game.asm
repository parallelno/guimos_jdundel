main_start:
			; clear the screen
			lxi b, 0
			lxi d, 1023
			A_TO_ZERO(0)
			MEM_ERASE_SP(true)

			lxi d, __level00_palette
			mvi h, 0
			copy_palette_request_update()


			; init the files data ptr
			lxi h, SCR_ADDR
			shld os_file_data_ptr
			; load the font
			LOAD_FILE(FONT_META_filename, FONT_META_FILE_LEN)
			
			lxi b, 0x6000
			text_ex_init()

			; draw a test text
			lxi h, __text_main_menu_settings
			lxi b, (0)<<8 | 100
			CALL_RAM_DISK_FUNC(text_ex_scr1, 0)

			jmp main_loop
			ret


main_loop:


			jmp main_loop

__text_main_menu_settings:
			TEXT("START GAME", _LINE_BREAK_)
			TEXT("OPTIONS", _LINE_BREAK_)
			TEXT("SCORES", _LINE_BREAK_)
			TEXT("CREDITS", )

__level00_palette:
			.byte %01100101, %01010010, %01011100, %01101011, 
			.byte %10100100, %01101100, %10110111, %01101111, 
			.byte %10011011, %11111101, %10101111, %01011111, 
			.byte %11111111, %11100010, %01100010, %00011111,			