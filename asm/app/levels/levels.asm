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

			call breakables_init

			jmp level_init

;================================================================
;	level data initialization every level start
;
level_init:
			; get the level init data ptr of the current level
			lda level_id
			HL_TO_AX2_PLUS_INT16(levels_init_tbls_ptrs)

			mov e, m
			inx h
			mov d, m
			xchg
			; hl - source (level00_init_tbls)
			; copy a level init data
			lxi d, level_init_tbl
			lxi b, LEVEL_INIT_TBL_LEN
			call mem_copy_len

			; init the screen
			call level_init_palette
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
			lxi h, monsters_runtime_data_sorted
			lxi b, monsters_runtime_data_end
			call mem_erase

			; setup resources
			lhld level_resources_inst_data_pptr
			lxi d, resources_inst_data_ptrs
			lxi b, RESOURCES_LEN
			lda level_ram_disk_s_data
			mem_copy_from_ram_disk()

			; setup containers
			lhld level_containers_inst_data_pptr
			lxi d, containers_inst_data_ptrs
			lxi b, CONTAINERS_LEN
			lda level_ram_disk_s_data
			mem_copy_from_ram_disk()

			; reset room_id
			lhld room_id
			mvi l, ROOM_ID_0
			A_TO_ZERO(GLOBAL_REQ_NONE)
			call room_teleport
			
			call room_init
			call hero_respawn
			jmp hero_room_init

; copy a palette from the ram-disk, then request for using it
level_init_palette:
			lhld level_palette_ptr
			jmp copy_palette_request_update

level_update:
			lda global_request
			CPI_ZERO(GLOBAL_REQ_NONE)
			rz
			cpi GAME_REQ_ROOM_INIT
			jz @room_load_draw
			cpi GAME_REQ_LEVEL_INIT
			jz @level_load
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
@level_load:
			call level_init
			jmp game_ui_draw
@respawn:
			; teleport the hero to the home room
			lxi h, LEVEL_FIRST<<8 | ROOM_ID_0
			A_TO_ZERO(GLOBAL_REQ_NONE)
			call room_teleport

			call breakables_init
			call game_ui_draw
			call hero_respawn
			jmp @room_load_draw

