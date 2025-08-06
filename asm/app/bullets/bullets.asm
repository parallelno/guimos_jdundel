.include "app/bullets/bullets_macros.asm"
.include "app/bullets/vfx_consts.asm"
.include "app/bullets/sword.asm"
.include "app/bullets/snowflake.asm"
.include "app/bullets/scythe.asm"
.include "app/bullets/bomb.asm"
.include "app/bullets/sparker.asm"
.include "app/bullets/fart.asm"
.include "app/bullets/vfx.asm"
.include "app/bullets/cursor.asm"
.include "app/bullets/trap.asm"

@memusage_bullets

bullets_init:
			; set the last marker byte of runtime_data
			mvi a, ACTOR_RUNTIME_DATA_END
			sta bullets_runtime_data_end_marker + 1
			; erase runtime_data
			ACTOR_ERASE_RUNTIME_DATA(bullet_update_ptr)
			ret


; bullet initialization
; in:
; BC - BULLET_UPDATE_PTR
; top stack:
; 		.word BULLET_DRAW_PTR
; 		.word BULLET_STATUS | BULLET_STATUS_TIMER<<8
; 		.word BULLET_ANIM_PTR
; 		.word pos_xy
; 		.word speed_x
; 		.word speed_y
; out:
; hl - bullet_speed_y + 1 when bullet created
; CY = 0 - bullet not created (too many objects)
; CY = 1 - bullet created

; rev1. 876 cc
; rev2. 804 cc
; rev3. 836 cc ( init speed_xy)
; rev4. 580 cc
bullet_init:
			lxi h, bullet_update_ptr + 1
			mvi e, BULLET_RUNTIME_DATA_LEN
			call actor_get_empty_data_ptr
			jnz @restore_sp ; return when it's too many objects

			; hl - ptr to bullet_update_ptr + 1
			; advance hl to bullet_update_ptr
			dcx h
			mov m, c
			inx h
			mov m, b
			; advance hl to bullet_draw_ptr
			inx h
			pop b
			mov m, c
			inx h
			mov m, b
			; advance hl to bullet_status
			inx h
			pop b
			mov m, c
			; advance hl to bullet_status_timer
			inx h
			mov m, b
			; advance hl to bullet_anim_timer
			inx h
			mvi m, 0
			; advance hl to bullet_anim_ptr
			inx h
			pop b
			mov m, c
			inx h
			mov m, b

			pop b
			; bc - pos_xy
			mov a, b
			; a - pos_x
			; scr_x = pos_x/8 + SPRITE_X_SCR_ADDR
			RRC_(3)
			ani %00011111
			adi SPRITE_X_SCR_ADDR
			mvi e, 0
			; a = scr_x
			; b = pos_x
			; c = pos_y
			; e = 0 and SPRITE_W_PACKED_MIN

			; advance hl to bullet_erase_scr_addr
			inx h
			mov m, c
			inx h
			mov m, a
			; advance hl to bullet_erase_scr_addr_old
			inx h
			mov m, c
			inx h
			mov m, a
			; advance hl to bullet_erase_wh
			inx h
			mvi m, SPRITE_H_MIN
			inx h
			mov m, e
			; advance hl to bullet_erase_wh_old
			inx h
			mvi m, SPRITE_H_MIN
			inx h
			mov m, e
			; advance hl to bullet_pos_x
			inx h
			mov m, e
			inx h
			mov m, b
			; advance hl to bullet_pos_y
			inx h
			mov m, e
			inx h
			mov m, c

			pop b
			; bc - speed_x
			; advance hl to bullet_speed_x
			inx h
			mov m, c
			inx h
			mov m, b

			pop b
			; bc - speed_y
			; advance hl to bullet_speed_y
			inx h
			mov m, c
			inx h
			mov m, b

			; return TILEDATA_RESTORE_TILE
			; to make the tile (where a char spawned) walkable and restorable
			mvi a, TILEDATA_RESTORE_TILE
			stc ; set CY = 1
			ret

@restore_sp:
			POP_H(7) ; pop out non-used init data to restore the SP
			mvi a, TILEDATA_RESTORE_TILE
			ora a ; set CY = 0
			ret


bullets_update:
			ACTORS_INVOKE_IF_ALIVE(bullet_update_ptr, bullet_update_ptr, BULLET_RUNTIME_DATA_LEN, true)

bullets_draw:
			ACTORS_INVOKE_IF_ALIVE(bullet_draw_ptr, bullet_update_ptr, BULLET_RUNTIME_DATA_LEN, true)

bullets_copy_to_scr:
			ACTORS_CALL_IF_ALIVE(bullet_copy_to_scr, bullet_update_ptr, BULLET_RUNTIME_DATA_LEN, true)

bullets_erase:
			ACTORS_CALL_IF_ALIVE(bullet_erase, bullet_update_ptr, BULLET_RUNTIME_DATA_LEN, true)

; copy sprites from a backbuffer to a scr
; in:
; hl - ptr to bullet_update_ptr+1
bullet_copy_to_scr:
			; advance to bullet_status
			HL_ADVANCE(bullet_update_ptr+1, bullet_status)
			jmp actor_copy_to_scr

; erase a sprite or restore the background behind a sprite
; in:
; hl - ptr to bullet_update_ptr+1
; a - BULLET_RUNTIME_DATA_* status
bullet_erase:
			LXI_D_TO_DIFF(bullet_update_ptr+1, bullet_status)
			jmp actor_erase