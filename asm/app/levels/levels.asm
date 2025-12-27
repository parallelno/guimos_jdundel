@memusage_levels
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
			lxi h, rooms_spawn_rate
			lxi b, rooms_spawn_rate_end
			call mem_erase

			; erase backs buffs
			lxi h, backs_runtime_data
			lxi b, backs_runtime_data_end
			call mem_erase

			; erase overlays buffs
			lxi h, overlays_runtime_data
			lxi b, overlays_runtime_data_end
			call mem_erase

			; erase chars buffs
			lxi h, chars_runtime_data
			lxi b, chars_runtime_data_end
			call mem_erase

			; erase the actor list
			lxi h, NULL
			shld actor_data_head_ptr

			; setup resources
			lhld lv_resources_inst_data_pptr
			lxi d, resources_inst_data_ptrs
			lxi b, RESOURCES_INST_DATA_PTRS_LEN
			lda lv_ram_disk_s_data
			call mem_copy_from_ram_disk

			; setup containers
			lhld lv_containers_inst_data_pptr
			lxi d, containers_inst_data_ptrs
			lxi b, CONTAINERS_INST_DATA_PTRS_LEN
			lda lv_ram_disk_s_data
			call mem_copy_from_ram_disk

			; reset room_id
			lhld room_id
			mvi l, ROOM_ID_0
			mvi a, GAME_REQ_ROOM_INIT_AND_DRAW_FADE_IN
			jmp room_teleport

; when a hero enters a room
level_room_init_and_draw:
			; load a new room
			call room_init
			call hero_room_init
			A_TO_ZERO(GLOBAL_REQ_NONE)
			sta app_request
			jmp reset_game_updates_required_counter

; restore the room after an opened dialog
level_room_redraw:
			call room_redraw
			A_TO_ZERO(GLOBAL_REQ_NONE)
			sta app_request
 			jmp reset_game_updates_required_counter


; fades in/out the palette when a hero enters or leaves the level
; in:
; a - 1 fade in, 0 fade out
level_palette_fade:
			lxi h, pallete_fade_out
			CPI_ZERO(NULL)
			jz @fade_out
@fade_in:
			lxi h, pallete_fade_in
@fade_out:
			push h

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
			pop h
			pchl