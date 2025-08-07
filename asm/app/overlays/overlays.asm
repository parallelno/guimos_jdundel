.include "app/overlays/overlays_macros.asm"
.include "app/overlays/vfx_consts.asm"
.include "app/overlays/sword.asm"
.include "app/overlays/snowflake.asm"
.include "app/overlays/scythe.asm"
.include "app/overlays/bomb.asm"
.include "app/overlays/sparker.asm"
.include "app/overlays/fart.asm"
.include "app/overlays/vfx.asm"
.include "app/overlays/cursor.asm"
.include "app/overlays/trap.asm"

@memusage_overlays

overlays_init:
			; set the last marker byte of runtime_data
			mvi a, ACTOR_RUNTIME_DATA_END
			sta overlays_runtime_data_end_marker + 1
			; erase runtime_data
			ACTOR_ERASE_RUNTIME_DATA(overlay_update_ptr)
			ret


; overlay initialization
; in:
; BC - OVERLAY_UPDATE_PTR
; top stack:
; 		.word OVERLAY_DRAW_PTR
; 		.word OVERLAY_STATUS | OVERLAY_STATUS_TIMER<<8
; 		.word OVERLAY_ANIM_PTR
; 		.word pos_xy
; 		.word speed_x
; 		.word speed_y
; out:
; hl - overlay_speed_y + 1 when overlay created
; CY = 0 - overlay not created (too many objects)
; CY = 1 - overlay created

; rev1. 876 cc
; rev2. 804 cc
; rev3. 836 cc ( init speed_xy)
; rev4. 548 cc
overlay_init:
			lxi h, overlay_update_ptr + 1
			mvi e, OVERLAY_RUNTIME_DATA_LEN
			call actor_get_empty_data_ptr
			jnz @restore_sp ; return when it's too many objects

			; consts for faster init
			lxi d, SPRITE_W_PACKED_MIN<<8 | SPRITE_H_MIN
		.if SPRITE_W_PACKED_MIN != 0
			.error "SPRITE_W_PACKED_MIN must be 0"
		.endif

			; hl - ptr to overlay_update_ptr + 1
			; advance hl to overlay_update_ptr
			dcx h
			mov m, c
			inx h
			mov m, b
			; advance hl to overlay_draw_ptr
			inx h
			pop b
			mov m, c
			inx h
			mov m, b
			; advance hl to overlay_status
			inx h
			pop b
			mov m, c
			; advance hl to overlay_status_timer
			inx h
			mov m, b
			; advance hl to overlay_anim_timer
			inx h
			mvi m, d ; 0
			; advance hl to overlay_anim_ptr
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
			; a = scr_x
			; b = pos_x
			; c = pos_y

			; advance hl to overlay_erase_scr_addr
			inx h
			mov m, c
			inx h
			mov m, a
			; advance hl to overlay_erase_scr_addr_old
			inx h
			mov m, c
			inx h
			mov m, a
			; advance hl to overlay_erase_wh
			inx h
			mvi m, e ; SPRITE_H_MIN
			inx h
			mov m, d ; SPRITE_W_PACKED_MIN
			; advance hl to overlay_erase_wh_old
			inx h
			mvi m, e ; SPRITE_H_MIN
			inx h
			mov m, d ; SPRITE_W_PACKED_MIN
			; advance hl to overlay_pos_x
			inx h
			mov m, d ; 0
			inx h
			mov m, b
			; advance hl to overlay_pos_y
			inx h
			mov m, d ; 0
			inx h
			mov m, c

			pop b
			; bc - speed_x
			; advance hl to overlay_speed_x
			inx h
			mov m, c
			inx h
			mov m, b

			pop b
			; bc - speed_y
			; advance hl to overlay_speed_y
			inx h
			mov m, c
			inx h
			mov m, b

			stc ; set CY = 1
			ret

@restore_sp:
			POP_H(7) ; pop out non-used init data to restore the SP
			ora a ; set CY = 0
			ret


overlays_update:
			ACTORS_INVOKE_IF_ALIVE(overlay_update_ptr, overlay_update_ptr, OVERLAY_RUNTIME_DATA_LEN, true)

overlays_draw:
			ACTORS_INVOKE_IF_ALIVE(overlay_draw_ptr, overlay_update_ptr, OVERLAY_RUNTIME_DATA_LEN, true)

overlays_copy_to_scr:
			ACTORS_CALL_IF_ALIVE(overlay_copy_to_scr, overlay_update_ptr, OVERLAY_RUNTIME_DATA_LEN, true)

overlays_erase:
			ACTORS_CALL_IF_ALIVE(overlay_erase, overlay_update_ptr, OVERLAY_RUNTIME_DATA_LEN, true)

; copy sprites from a backbuffer to a scr
; in:
; hl - ptr to overlay_update_ptr+1
overlay_copy_to_scr:
			; advance to overlay_status
			HL_ADVANCE(overlay_update_ptr+1, overlay_status)
			jmp actor_copy_to_scr

; erase a sprite or restore the background behind a sprite
; in:
; hl - ptr to overlay_update_ptr+1
; a - OVERLAY_RUNTIME_DATA_* status
overlay_erase:
			LXI_D_TO_DIFF(overlay_update_ptr+1, overlay_status)
			jmp actor_erase