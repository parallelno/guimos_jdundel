game_start:
			call game_init
@loop:
			call game_update
			call game_draw
			jmp @loop

game_init:
			di			
			; clear the screen
			lxi b, 0
			lxi d, 1023
			A_TO_ZERO(0)
			MEM_ERASE_SP()

			lxi d, _lv0_palette
			mvi h, 0
			copy_palette_request_update()
			ei
			hlt
			di

			call v6_sound_init
//==========================================================

;.breakpoint
			load_permanent()
;.breakpoint
			load_level0()
;.breakpoint

			lxi d, 0x80a0
			lxi b, _lv0_tile0 + LV0_GFX_ADDR
			;RAM_DISK_ON(RAM_DISK_S_LV0_GFX | RAM_DISK_M_BACKBUFF | RAM_DISK_M_8F)
			RAM_DISK_ON(RAM_DISK_S_LV0_GFX | 0 | 0)
			call draw_tile_16x16
			RAM_DISK_OFF()

			;======================
			; SONG01
			;======================
			
			lxi d, SONG01_ADDR
			lxi h, SONG01_ay_reg_data_ptrs
			call v6_gc_init_song
			call v6_gc_start

			;======================
			; FONT
			;======================
	
			lxi d, FONT_ADDR
			mvi c, GFX_PTRS_LEN
			lxi h, font_gfx_ptrs
			update_labels()

			; draw a test text
			lxi h, __text_main_menu_settings
			lxi b, (0)<<8 | 100
			CALL_RAM_DISK_FUNC(text_ex_scr1, 0)

			ei
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
