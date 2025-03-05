

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
			
			ei
			
			lxi h, level00_init_tbls
			lxi d, level_init_tbl
			lxi b, level00_init_tbls_end
			call mem_copy
			call room_init
			
			; draw a test text
			lxi d, _options_screen_settings_names
			call text_ex_draw

			lxi d, _ti0_title1
			call tiled_img_draw


			;======================
			; sprite test
			;======================
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

