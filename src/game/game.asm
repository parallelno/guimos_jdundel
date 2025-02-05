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

			call v6_sound_init

//==========================================================
			di
; loading destination addr
SONG01_DATA_ADDR = 0x4000
FONT_DATA_ADDR = SONG01_DATA_ADDR + SONG01_META_FILE_LEN + (SONG01_META_FILE_LEN & 1) ; +1 because _len must be div by 2

			;======================
			; SONG01
			;======================

			LOAD_FILE(SONG01_META_filename, 0, SONG01_DATA_ADDR, SONG01_META_FILE_LEN)
			
			lxi d, SONG01_DATA_ADDR
			lxi h, v6_gc_ay_reg_data_ptrs
			call v6_gc_init_song
			call v6_gc_start

			;======================
			; FONT
			;======================
			//LOAD_FILE(FONT_META_filename, 0, FONT_DATA_ADDR, FONT_META_FILE_LEN)
			
			lxi d, FONT_DATA_ADDR
			mvi c, GFX_PTRS_LEN
			lxi h, font_gfx_ptrs
			update_labels()

.breakpoint			
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



