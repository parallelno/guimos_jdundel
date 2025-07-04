memusage_levels:
;================================================================
;	levels data initialization every game start
;
levels_init:
			A_TO_ZERO(LEVEL_FIRST)
			sta level_id

			; erase global item statuses
			lxi h, global_items
			lxi b, global_items_end
			call mem_erase
			; erase game statuses
			lxi h, game_status
			lxi b, game_status_end
			call mem_erase
			jmp breakables_init

;================================================================
;	level data initialization every level start
;
level_init:
			; init the screen
			mvi a, 1
			sta border_color_idx
			mvi a, SCR_VERTICAL_OFFSET_DEFAULT
			sta scr_offset_y

			; erase rooms spawn data
			lxi h, rooms_spawn_rates
			lxi b, rooms_spawn_rates_end
			call mem_erase

			; erase backs buffs
			lxi h, backs_runtime_data
			lxi b, backs_runtime_data_end
			call mem_erase

			; erase bullets buffs
			lxi h, bullets_runtime_data
			lxi b, bullets_runtime_data_end
			call mem_erase

			; erase monsters buffs
			lxi h, monster_data_head_ptr
			lxi b, monsters_runtime_data_end
			call mem_erase

			; setup resources
			lhld lv_resources_inst_data_pptr
			lxi d, resources_inst_data_ptrs
			lxi b, RESOURCES_LEN
			lda lv_ram_disk_s_data
			mem_copy_from_ram_disk()

			; setup containers
			lhld lv_containers_inst_data_pptr
			lxi d, containers_inst_data_ptrs
			lxi b, CONTAINERS_LEN
			lda lv_ram_disk_s_data
			mem_copy_from_ram_disk()

			; reset room_id
			lhld room_id
			mvi l, ROOM_ID_0
			A_TO_ZERO(GLOBAL_REQ_NONE)
			call room_teleport
			call room_init
			call level_palette_fade_in
			call hero_respawn
			jmp hero_room_init

level_update:
			lda global_request
			CPI_ZERO(GLOBAL_REQ_NONE)
			rz
			cpi GAME_REQ_ROOM_INIT
			jz @room_load_draw
			cpi GAME_REQ_ROOM_DRAW
			jz @room_draw
			cpi GAME_REQ_RESPAWN
			jz @respawn
			ret
@room_load_draw:
			; load a new room
			call room_init
			call hero_room_init
			A_TO_ZERO(GLOBAL_REQ_NONE)
			sta global_request
			jmp reset_game_updates_required_counter
@room_draw:
			call room_redraw
			A_TO_ZERO(GLOBAL_REQ_NONE)
			sta global_request
 			jmp reset_game_updates_required_counter
@respawn:
			; teleport the hero to the home room
			lxi h, LEVEL_FIRST<<8 | ROOM_ID_0
			A_TO_ZERO(GLOBAL_REQ_NONE)
			call room_teleport

			call breakables_init
			call game_ui_draw
			call hero_respawn
			jmp @room_load_draw


; the palette fade-in
level_palette_fade_in:
			lda level_id
			CPI_ZERO(LEVEL_FIRST)
@lv0_palette:
			lxi d, LEVEL0_PAL_LV0_ADDR + _pal_lv0_palette_fade_to_black_relative
			mvi a, LEVEL0_PAL_LV0_RAM_DISK_S
			jz @set_palette
@lv1_palette:
			lxi d, PERMANENT_PAL_LV1_ADDR + _pal_lv1_palette_fade_to_black_relative
			mvi a, PERMANENT_PAL_LV1_RAM_DISK_S
@set_palette:
			jmp pallete_fade_in
