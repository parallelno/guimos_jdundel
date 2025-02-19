game_start:
			call game_init
@loop:
			call game_update
			call game_draw
			jmp @loop

game_init:
			di
			; clear the screen
			lxi h, 0
			lxi d, 1023
			A_TO_ZERO(0)
			MEM_ERASE_SP()

			lxi h, _lv0_palette
			copy_palette_request_update()
			ei
			hlt
			di

			call v6_sound_init
//==========================================================
			load_permanent()
			load_level0()


			;======================
			; LV0 tile 0
			;======================
			lxi d, 0x80A0
			lxi b, _lv0_tile0 + LV0_GFX_ADDR
			mvi a, RAM_DISK_S_LV0_GFX
			call tile_draw_16x16

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
			;lxi d, __text_main_menu_settings
			lxi b, (0)<<8 | 100
			lxi h, >SCR_BUFF1_ADDR
			;call text_ex_draw

			ei

			;======================
			; preshift test hero_r_idle0
			;======================
			lxi d, _burner_preshifted_sprites
			lxi h, BURNER_ADDR
			sprite_update_labels()

			;======================
			; tiled img test
			;======================
			mvi a, RAM_DISK_S_TI0_DATA
			mvi c, RAM_DISK_S_TI0_GFX
			lxi d, TI0_DATA_ADDR
			lxi h, TI0_GFX_ADDR
			call tiled_img_init
			lxi d, _ti0_title1
			call tiled_img_draw


		frame .var 0
		shift .var 0
@loop:			
			shift = 2

			frame = 0
			lhld 2 + _burner_dash + (2 + 8)*frame + shift*2
			mov c, l
			mov b, h
			;lxi h, _burner_dash_3_0 + BURNER_ADDR
			lxi d, 0xB0A0
			mvi a, RAM_DISK_S_BURNER
			call sprite_draw_vm
			call wait

			frame = 1
			lhld 2 + _burner_dash + (2 + 8)*frame + shift*2
			mov c, l
			mov b, h
			lxi d, 0xB0A0
			mvi a, RAM_DISK_S_BURNER
			call sprite_draw_vm
			call wait

			frame = 2
			lhld 2 + _burner_dash + (2 + 8)*frame + shift*2
			mov c, l
			mov b, h
			lxi d, 0xB0A0
			mvi a, RAM_DISK_S_BURNER
			call sprite_draw_vm
			call wait

			frame = 3
			lhld 2 + _burner_dash + (2 + 8)*frame + shift*2
			mov c, l
			mov b, h
			lxi d, 0xB0A0
			mvi a, RAM_DISK_S_BURNER
			call sprite_draw_vm
			call wait			

			jmp @loop		

			
			ret

wait:
			lxi h, 10000
@loop:
			dcx h
			mov a, h
			ora l
			jnz @loop
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

