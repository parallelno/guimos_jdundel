; in:
; a - container_id
; c - tile_idx
sword_func_container:
			sta @restore_container_id+1
			push b ; store tile_idx

			; find a container
			lxi h, room_id
			mov d, m
			mov l, a
			FIND_INSTANCE(@no_container_found, containers_inst_data_ptrs)
			; c = tile_idx
			; hl ptr to tile_idx
			; remove this container from containers_inst_data
			inx h
			mvi m, <CONTAINERS_STATUS_ACQUIRED

@no_container_found:
			; erase container_id from tiledata
			mvi b, >room_tiledata
			mvi a, TILEDATA_RESTORE_TILE
			stax b

			call draw_tile_16x16_buffs
			; draw vfx
			; bc - tile screen addr
			lxi d, vfx_reward_anim
			call vfx_init

			pop b
			; c - tile_idx in the room_tiledata array
@restore_container_id:
			mvi a, TEMP_BYTE
			ADD_A(1) ; container_id to WORD ptr
			sta room_decal_draw_ptr_offset+1
			ROOM_DECAL_DRAW(containers_opened_gfx_ptrs, true)

			; update a hero container
			lxi h, hero_cont_func_tbl
			lda @restore_container_id+1
			mov e, a
			HL_TO_AX4_PLUS_INT16(hero_cont_func_tbl)
			push h

			; add score points
			; e - container_id
			mvi d, TILEDATA_FUNC_ID_CONTAINERS
			call game_score_add
			call game_ui_draw_score_text
			pop h
			; hl - a container handler func ptr
			pchl ; run a container handler

; in:
; a - door_id
; c - tile_idx
sword_func_door:
			mov e, a
			; a, e - door_id
			; store tile_idx
			lxi h, @tile_idx + 1
			mov m, c

			; requirement for ROOM_DECAL_DRAW
			ADD_A(1) ; to make a WORD ptr
			sta room_decal_draw_ptr_offset + 1

			; check the global item status
			rrc ; divide WORD ptr by 2 to make it back door_id
			rar ; divide door_id by 2 to get the key_id because two doors (L and R) share the same key_id
			adi <global_items ; because the first door_id = 0
			mov l, a
			mvi h, >global_items
			mov a, m
			cpi <ITEM_STATUS_NOT_ACQUIRED
			rz	; if status == ITEM_STATUS_NOT_ACQUIRED, means a hero doesn't have a proper key to open the door

			; update the key status
			mvi m, <ITEM_STATUS_USED

			; add score points
			push b ; store c - tile_idx
			; e - door_id
			mvi d, TILEDATA_FUNC_ID_DOORS
			call game_score_add
			call game_ui_draw_score_text
			pop b ; restore c - tile_idx

			; erase breakable_id from tiledata
			mvi b, >room_tiledata
			mvi a, TILEDATA_RESTORE_TILE
			stax b

			; c - tile_idx
			call draw_tile_16x16_buffs
			; draw vfx
			; bc - tile screen addr
			lxi d, vfx_puff_anim
			call vfx_init

@tile_idx:
			mvi c, TEMP_BYTE
			; c - tile_idx in the room_tiledata array
			ROOM_DECAL_DRAW(doors_opened_gfx_ptrs, true, true)


; in:
; a - breakable_id
; c - tile_idx
sword_func_breakable:
			mov e, a
			; check if a sword is available
			lda hero_res_sword
			CPI_ZERO(RES_EMPTY)
			rz ; return if no sword

			; if breakable_id == BREAKABLE_ID_CABBAGE, spawn a fart bullet
			; e - breakable_id
			mvi a, BREAKABLE_ID_CABBAGE
			cmp e
			jnz @not_cabbage
@cabbage:
			; add the cabbage resource
			lxi h, hero_res_cabbage
			INR_CLAMP_M(RES_CABBAGE_MAX)
@not_cabbage:
			; add score points
			push b
			; e - breakable_id
			mvi d, TILEDATA_FUNC_ID_BREAKABLES
			call game_score_add
			call game_ui_draw_score_text
			pop b

			; erase breakable_id from tiledata
			mvi b, >room_tiledata
			mvi a, TILEDATA_RESTORE_TILE
			stax b

			; c - tile_idx
			call draw_tile_16x16_buffs
			; draw vfx
			; bc - tile screen addr
			lxi d, vfx_puff_anim
			call vfx_init
			jmp game_ui_draw_res

; in:
; a - trigger_id
; c - tile_idx
sword_func_triggers:
			cpi TRIGGER_ID_HOME_DOOR
			jz trigger_hero_knocks_his_home_door
			cpi TRIGGER_ID_LV0
			jz trigger_load_lv0
			cpi TRIGGER_ID_LV1
			jz trigger_load_lv1
			cpi TRIGGER_ID_MAIN_MENU
			jz trigger_load_main_menu
			cpi TRIGGER_ID_END_GAME
			jz trigger_end_game

			ret