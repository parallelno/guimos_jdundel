

game_start:
			call game_init
@loop:
			call game_update
			call game_draw
			jmp @loop

game_init:
			di
			; clear the screen
			MEM_ERASE_SP(0x8000, 0x8000)

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
			; DECALS0
			;======================
			// lxi h, decals0_gfx_ptrs
			// lxi b, DECALS0_ADDR		
			// call update_labels_eod

			;======================
			; BACKS0
			;======================
			// lxi d, _backs0_preshifted_sprites
			// lxi h, BACKS0_ADDR
			// call sprite_update_labels 
			;======================
			; LV0 room 0
			;======================
			// lxi h, _lv0_tiles_ptrs
			// lxi b, LV0_GFX_ADDR
			// call update_labels_eod

			// lxi h, _lv0_rooms_ptrs
			// lxi b, LV0_DATA_ADDR		
			// call update_labels_eod

			lxi h, level00_init_tbls
			lxi d, level_init_tbl
			lxi b, level00_init_tbls_end
			call mem_copy

			call room_init

			;======================
			; SONG01
			;======================
			// lxi d, SONG01_ADDR
			// lxi h, SONG01_ay_reg_data_ptrs
			// call v6_gc_init_song
			// CALL_RAM_DISK_FUNC_NO_RESTORE(v6_gc_start, RAM_DISK_S_SONG01 | RAM_DISK_M_SONG01 | RAM_DISK_M_8F)

			;======================
			; FONT
			;======================
			; init font
			// mvi a, RAM_DISK_S_FONT
			// lxi h, font_gfx_ptrs
			// lxi b, FONT_ADDR
			// call text_ex_init_font
			; init text
			// mvi a, RAM_DISK_S_TEXT_LV0
			// lxi h, TEXT_LV0_ADDR
			// call text_ex_init_text

			; draw a test text
			lxi d, _options_screen_settings_names
			call text_ex_draw

			ei

			;======================
			; tiled img test
			;======================
			// mvi a, RAM_DISK_S_TI0_DATA
			// mvi c, RAM_DISK_S_TI0_GFX
			// lxi d, TI0_DATA_ADDR
			// lxi h, TI0_GFX_ADDR
			// call tiled_img_init

			lxi d, _ti0_title1
			call tiled_img_draw


			;======================
			; sprite test
			;======================
			// lxi d, _burner_preshifted_sprites
			// lxi h, BURNER_ADDR
			// call sprite_update_labels

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
			CALL_RAM_DISK_FUNC(sprite_draw_vm, RAM_DISK_S_BURNER)
			call wait

			frame = 1
			lhld 2 + _burner_dash + (2 + 8)*frame + shift*2
			mov c, l
			mov b, h
			lxi d, 0xB0A0
			CALL_RAM_DISK_FUNC(sprite_draw_vm, RAM_DISK_S_BURNER)
			call wait

			frame = 2
			lhld 2 + _burner_dash + (2 + 8)*frame + shift*2
			mov c, l
			mov b, h
			lxi d, 0xB0A0
			CALL_RAM_DISK_FUNC(sprite_draw_vm, RAM_DISK_S_BURNER)
			call wait

			frame = 3
			lhld 2 + _burner_dash + (2 + 8)*frame + shift*2
			mov c, l
			mov b, h
			lxi d, 0xB0A0			
			CALL_RAM_DISK_FUNC(sprite_draw_vm, RAM_DISK_S_BURNER)
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

