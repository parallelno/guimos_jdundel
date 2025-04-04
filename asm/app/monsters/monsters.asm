.include "asm/app/monsters/monsters_data.asm"
.include "asm/app/monsters/monster_macros.asm"
.include "asm/app/monsters/skeleton.asm"
.include "asm/app/monsters/skeleton_quest.asm"
.include "asm/app/monsters/vampire.asm"
.include "asm/app/monsters/burner.asm"
.include "asm/app/monsters/burner_quest.asm"
.include "asm/app/monsters/knight.asm"
.include "asm/app/monsters/knight_heavy.asm"
.include "asm/app/monsters/firepool.asm"

monsters_init:
			; monsters_runtime_data_sorted got inited in level_init with NULL
			; set the last marker byte of runtime_data
			mvi a, ACTOR_RUNTIME_DATA_END
			sta monsters_runtime_data_end_marker + 1
			; erase runtime_data
			ACTOR_ERASE_RUNTIME_DATA(monster_update_ptr)
			ret


; monster initialization
; in:
; c - tile_idx in the room_tiledata array.
; a - monster_id * 4
; out:
; a - TILEDATA_RESTORE_TILE
;ex. MONSTER_INIT(knight_update, knight_draw, monster_impacted, KNIGHT_HEALTH, ACTOR_STATUS_KNIGHT_DETECT_HERO_INIT, _knight_idle)
.macro MONSTER_INIT(MONSTER_UPDATE_PTR, MONSTER_DRAW_PTR, MONSTER_IMPACT_PTR, MONSTER_HEALTH, MONSTER_STATUS, MONSTER_ANIM_PTR, spawn_rate_check = True)
		.if spawn_rate_check
			mvi b, 1
		.endif
		.if spawn_rate_check == False
			mvi b, 0
		.endif

			lxi d, @init_data
			jmp monster_init

			.word TEMP_WORD  ; safety word because "call actor_get_empty_data_ptr"
			.word TEMP_WORD  ; safety word because an interruption can call
@init_data:
			.word MONSTER_UPDATE_PTR, MONSTER_DRAW_PTR, MONSTER_STATUS<<8 | MONSTER_HEALTH, MONSTER_ANIM_PTR, MONSTER_IMPACT_PTR
.endmacro

; monster initialization
; in:
; de - ptr to monster_data: .word MONSTER_UPDATE_PTR, MONSTER_DRAW_PTR, MONSTER_STATUS<<8 | MONSTER_HEALTH, MONSTER_ANIM_PTR, MONSTER_IMPACT_PTR
; c - tile_idx in the room_tiledata array.
; b - spawn_rate_check
;		1 - yes
;		0 - no
; a - monster_id * 4
; out:
; a - TILEDATA_RESTORE_TILE
monster_init:
			lxi h, 0
			dad	sp
			shld @restore_sp + 1
			xchg
			sphl

			RRC_(2) ; to get monster_id
			sta @monster_id+1

			A_TO_ZERO(0)
			cmp b
			jz @no_spawn_rate_check

			ROOM_SPAWN_RATE_CHECK(rooms_spawn_rate_monsters, @restore_sp)
@no_spawn_rate_check:
			lxi h, monster_update_ptr+1
			mvi e, MONSTER_RUNTIME_DATA_LEN
			call actor_get_empty_data_ptr
			jnz @restore_sp ; return when it's too many objects

			mov a, c
			; a - tile_idx in the room_tiledata array
			; hl - ptr to monster_update_ptr + 1

			; advance hl to monster_update_ptr
			;dcx h
			HL_ADVANCE(monster_update_ptr + 1, monster_update_ptr)
			pop b ; using bc to read from the stack is requirenment
			; bc - ptr to monster_update_ptr
			mov m, c
			;inx h
			HL_ADVANCE(monster_update_ptr, monster_update_ptr + 1)
			mov m, b
			; advance hl to monster_draw_ptr
			;inx h
			HL_ADVANCE(monster_update_ptr + 1, monster_draw_ptr)
			pop b
			; bc - ptr to monster_draw_ptr
			mov m, c
			;inx h
			HL_ADVANCE(monster_draw_ptr, monster_draw_ptr + 1)
			mov m, b

			; a - tile_idx in the room_tiledata array
			mov e, a
			; e - tile_idx

			; advance hl to monster_status
			;inx h
			HL_ADVANCE(monster_draw_ptr + 1, monster_status)
			pop b
			; b - MONSTER_STATUS
			mov m, b
			mov a, c
			; a - MONSTER_HEALTH
			sta @health + 1

			; advance hl to monster_anim_ptr
			HL_ADVANCE(monster_status, monster_anim_ptr)

			pop b
			; bc - monster_anim_ptr
			mov m, c
			;inx h
			HL_ADVANCE(monster_anim_ptr, monster_anim_ptr + 1)
			mov m, b

			; e - tile_idx
			; pos_x = tile_idx % ROOM_WIDTH * TILE_WIDTH
			mvi a, %00001111
			ana e
			RLC_(4)
			sta @pos_x + 1
			; scr_x = pos_x/8 + $a0
			RRC_(3)
			adi SPRITE_X_SCR_ADDR
			mov d, a
			; pos_y = (tile_idx % ROOM_WIDTH) * TILE_WIDTH
			mvi a, %11110000
			ana e
			mvi e, 0
			; d = scr_x
			; a = pos_y
			; e = 0 and SPRITE_W_PACKED_MIN
			; hl - ptr to monster_anim_ptr + 1

			; advance hl to monster_erase_scr_addr
			;inx h
			HL_ADVANCE(monster_anim_ptr + 1, monster_erase_scr_addr)
			mov m, a
			;inx h
			HL_ADVANCE(monster_erase_scr_addr, monster_erase_scr_addr + 1)
			mov m, d
			; advance hl to monster_erase_scr_addr_old
			;inx h
			HL_ADVANCE(monster_erase_scr_addr + 1, monster_erase_scr_addr_old)
			mov m, a
			;inx h
			HL_ADVANCE(monster_erase_scr_addr_old, monster_erase_scr_addr_old + 1)
			mov m, d
			; advance hl to monster_erase_wh
			;inx h
			HL_ADVANCE(monster_erase_scr_addr_old + 1, monster_erase_wh)
			mvi m, SPRITE_H_MIN
			;inx h
			HL_ADVANCE(monster_erase_wh, monster_erase_wh + 1)
			mov m, e
			; advance hl to monster_erase_wh_old
			;inx h
			HL_ADVANCE(monster_erase_wh + 1, monster_erase_wh_old)
			mvi m, SPRITE_H_MIN
			;inx h
			HL_ADVANCE(monster_erase_wh_old, monster_erase_wh_old + 1)
			mov m, e
			; advance hl to monster_pos_x
			;inx h
			HL_ADVANCE(monster_erase_wh_old + 1, monster_pos_x)
			mov m, e
			;inx h
			HL_ADVANCE(monster_pos_x, monster_pos_x + 1)
@pos_x:
			mvi m, TEMP_BYTE ; pos_x
			; advance hl to monster_pos_y
			;inx h
			HL_ADVANCE(monster_pos_x + 1, monster_pos_y)
			mov m, e
			;inx h
			HL_ADVANCE(monster_pos_y, monster_pos_y + 1)
			mov m, a

			; advance hl to monster_impacted_ptr
			HL_ADVANCE(monster_pos_y + 1, monster_impacted_ptr, BY_DE)
			pop b
			; bc - ptr to monster_impacted_ptr
			mov m, c
			;inx h
			HL_ADVANCE(monster_impacted_ptr, monster_impacted_ptr + 1)
			mov m, b

			; advance hl to monster_id
			;inx h
			HL_ADVANCE(monster_impacted_ptr + 1, monster_id)
@monster_id:
			mvi m, TEMP_BYTE
			; advance hl to monster_type
			;inx h
			HL_ADVANCE(monster_id, monster_type)
			mvi m, MONSTER_TYPE_ENEMY
			; advance hl to monster_health
			;inx h
			HL_ADVANCE(monster_type, monster_health)
@health:
			mvi m, TEMP_BYTE

@restore_sp:
			lxi sp, TEMP_ADDR
			RAM_DISK_OFF()
			; return TILEDATA_RESTORE_TILE to make the tile where a monster spawned walkable and restorable
			mvi a, TILEDATA_RESTORE_TILE
			ret

; in:
; hl - 	pos_x, pos_y
; a  - 	collider width
; c  - 	collider height
; out:
; no collision 	- (hl) >= ACTOR_RUNTIME_DATA_DESTR
; collision 	- hl points to a collided monster_update_ptr+1, (hl) < ACTOR_RUNTIME_DATA_DESTR
; use:
; b
monsters_get_first_collided:
			sta @collider_width+1
			mov a, c
			sta @collider_height+1
			mov a, h
			sta @collider_pos_x+1
			mov a, l
			sta @collider_pos_y+1
			lxi h, monster_update_ptr+1

@loop:
			mov a, m
			cpi ACTOR_RUNTIME_DATA_DESTR
			jc @check_collision
			cpi ACTOR_RUNTIME_DATA_LAST
			jc @next_data
			; no collision against all alive monsters
			ret
@check_collision:
			push h
			; advance hl to monster_type
			HL_ADVANCE(monster_update_ptr+1, monster_type, BY_BC)
			mov a, m
			CPI_ZERO(MONSTER_TYPE_ENEMY)
			jnz @no_collision

			; advance hl to monster_pos_x+1
			HL_ADVANCE(monster_type, monster_pos_x+1, BY_BC)
			; horizontal check
			mov c, m 	; monster pos_x
@collider_pos_x:
			mvi a, TEMP_BYTE
			mov b, a	; tmp
@collider_width:
			adi TEMP_BYTE
			cmp c
			jc @no_collision
			mvi a, SKELETON_COLLISION_WIDTH-1
			add c
			cmp b
			jc @no_collision
			; vertical check
			INX_H(2)
			mov c, m ; monster pos_y
@collider_pos_y:
			mvi a, TEMP_BYTE
			mov b, a
@collider_height:
			adi TEMP_BYTE
			cmp c
			jc @no_collision
			mvi a, SKELETON_COLLISION_HEIGHT-1
			add c
			cmp b
			jc @no_collision

			; collides
			pop h
			ret
@no_collision:
			pop h
@next_data:
			lxi b, MONSTER_RUNTIME_DATA_LEN
			dad b
			jmp @loop

monsters_update:
			ACTORS_INVOKE_IF_ALIVE(monster_update_ptr, monster_update_ptr, MONSTER_RUNTIME_DATA_LEN, true)

monsters_draw:
			ACTORS_INVOKE_IF_ALIVE(monster_draw_ptr, monster_update_ptr, MONSTER_RUNTIME_DATA_LEN, true)

monsters_copy_to_scr:
			ACTORS_CALL_IF_ALIVE(monster_copy_to_scr, monster_update_ptr, MONSTER_RUNTIME_DATA_LEN, true)

monsters_erase:
			ACTORS_CALL_IF_ALIVE(monster_erase, monster_update_ptr, MONSTER_RUNTIME_DATA_LEN, true)

; copy sprites from a backbuffer to a scr
; in:
; hl - ptr to monster_update_ptr+1
monster_copy_to_scr:
			; advance to monster_status
			HL_ADVANCE(monster_update_ptr+1, monster_status)
			jmp actor_copy_to_scr

; erase a sprite or restore the background behind a sprite
; in:
; hl - ptr to monster_update_ptr+1
; a - MONSTER_RUNTIME_DATA_* status
; cc ~ 3480 if it mostly restores a background
monster_erase:
			LXI_D_TO_DIFF(monster_update_ptr+1, monster_status)
			jmp actor_erase

; in:
; de - ptr to monster_impacted_ptr + 1
; c - hero_weapon_id
monster_impacted:
			; check the weapon_id
			mvi a, HERO_WEAPON_ID_SNOWFLAKE
			cmp c
			jz @set_state_freeze
			ROOM_SPAWN_RATE_UPDATE(rooms_spawn_rate_monsters, MONSTER_SPAWN_RATE_DELTA, MONSTER_SPAWN_RATE_MAX)

			; play a hit vfx
			; de - ptr to monster_impacted_ptr + 1
			; advance hl to monster_pos_x+1
			HL_ADVANCE(monster_impacted_ptr+1, monster_pos_x+1, BY_HL_FROM_DE)

			mov b, m
			; advance hl to monster_pos_y+1
			INX_H(2)
			mov c, m
			lxi d, _vfx4_hit
			push h
			call vfx_init4
			pop h

			; decrease monster's health
			HL_ADVANCE(monster_pos_y+1, monster_health, BY_DE)
			dcr m
			rnz

			; add score points
			push h
			; advance hl to monster_id
			HL_ADVANCE(monster_health, monster_id)
			mov e, m
			mvi d, TILEDATA_FUNC_ID_MONSTERS
			call game_score_add
			call game_ui_draw_score_text
			pop h

			; mark this monster dead
			; advance hl to monster_update_ptr+1
			HL_ADVANCE(monster_health, monster_update_ptr+1, BY_DE)
			ACTOR_DESTROY()
			ret

@set_state_freeze:
			; de - ptr to monster_impacted_ptr+1
			; advance hl to monster_pos_x+1
			HL_ADVANCE(monster_impacted_ptr+1, monster_status, BY_HL_FROM_DE)
			mvi m,ACTOR_STATUS_FREEZE
			; advance hl to monster_status_timer
			inx h
			mvi m, ACTOR_STATUS_FREEZE_TIME

			; check if a hero uses a snowflake the first time
			lda game_status_first_freeze
			CPI_ZERO()
			rnz
			inr a
			sta game_status_first_freeze
			; init a dialog
			mvi a, GAME_REQ_PAUSE
			lxi h, dialog_callback_room_redraw
			lxi d, _storytelling_hero_freeze_monster
			jmp dialog_init


; common freeze update func.
; it does nothing except counting down the status time
; in:
; hl = monster_status
monster_update_freeze:
			; hl = monster_status
			; advance hl to monster_status_timer
			inx h
			dcr m
			rnz
			; advance hl to monster_status
			dcx h
			mvi m, ACTOR_STATUS_INIT
			ret

