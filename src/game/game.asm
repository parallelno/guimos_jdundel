game_start:
			call game_init
@loop:
			call game_update
			call game_draw
			jmp @loop

game_init:
			; clear the screen
			lxi b, 0
			lxi d, 1023
			A_TO_ZERO(0)
			MEM_ERASE_SP(true)

			lxi d, __level00_palette
			mvi h, 0
			copy_palette_request_update()


			; init the files data ptr
			lxi h, 0x4000
			shld os_file_data_ptr

			push h

			; load the font
			LOAD_FILE(SONG01_META_filename, SONG01_META_FILE_LEN)

			call v6_sound_init
			pop d
			; de - song ptr
			lxi h, v6_gc_ay_reg_data_ptrs
			call v6_gc_set_song
			
			call v6_gc_start

			lhld os_file_data_ptr
			push h

			; load the font
			LOAD_FILE(FONT_META_filename, FONT_META_FILE_LEN)

			pop d
			mvi c, GFX_PTRS_LEN
			lxi h, font_gfx_ptrs
			update_labels()

			; draw a test text
			lxi h, __text_main_menu_settings
			lxi b, (0)<<8 | 100
			CALL_RAM_DISK_FUNC(text_ex_scr1, 0)
			ret

game_update:
			ret

game_draw:
			; update counter to calc fps
			lhld game_draws_counter
			inx h
			shld game_draws_counter

.if DEBUG
			hlt
.endif

			ret

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