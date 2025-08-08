@memusage_fart

;=========================================================
; This is a quest overlay
; init: it gives a hero game_status_fart
; it lasts some certain time, then destroys itself
; when dies: it sets its status GAME_STATUS_USED
; when it's alive, it constantly spawns puff vfx
; the quest to scary away knight_heavy char
;=========================================================

; statuses.
FART_STATUS_LIFE		= ACTOR_STATUS_INIT
FART_STATUS_LIFE_TIME	= 20

; init for non-preshifted VFX (x coord aligned to 8 pixels )
fart_init:
			; a hero got fart
			mvi a, GAME_STATUS_ACQUIRED
			sta game_status_fart

			lxi d, 0 ; speed
			; speed_y
			push d
			; speed_x
			push d
			; pos_xy
			lxi h, hero_pos_x + 1
			mov b, m
			HL_ADVANCE(hero_pos_x + 1, hero_pos_y + 1)
			mov c, m
			push b
			; OVERLAY_ANIM_PTR
			lxi h, vfx_puff_loop_anim
			push h
			; OVERLAY_STATUS | OVERLAY_STATUS_TIMER<<8
			lxi h, FART_STATUS_LIFE_TIME<<8 | FART_STATUS_LIFE
			push h
			; OVERLAY_DRAW_PTR
			lxi h, vfx_draw
			push h
			; OVERLAY_UPDATE_PTR
			lxi b, fart_update
			jmp overlay_init

; anim and a gameplay logic update
; in:
; de - ptr to overlay_update_ptr
fart_update:
			; advance to overlay_status_timer
			xchg
			L_ADVANCE(overlay_update_ptr, overlay_status_timer, BY_A)
			; hl - ptr to overlay_update_ptr
@fraction_timer:
			mvi a, 1
			rlc
			sta @fraction_timer + 1
			jnc @update_movement

			dcr m
			jz @die ; time is over

@update_movement:
			; hl - ptr to overlay_status_timer
			; advance hl to overlay_speed_y + 1
			L_ADVANCE(overlay_status_timer, overlay_pos_x + 1, BY_A)

			; update pos
			xchg
			lhld hero_erase_scr_addr
			xchg

			mov m, d
			; advance hl to overlay_pos_y + 1
			INX_H(2)
			mov m, e

			L_ADVANCE(overlay_pos_y + 1, overlay_anim_timer, BY_A)
			; update_anim
			mvi a, SPARKER_ANIM_SPEED_MOVE
			call actor_anim_update
			ret
@die:
			; make game_status_fart not_acquired
			A_TO_ZERO(GAME_STATUS_NOT_ACQUIRED)
			sta game_status_fart
			; destroy fart vfx
			; hl points to overlay_status_timer
			; advance hl to overlay_update_ptr + 1
			L_ADVANCE(overlay_status_timer, overlay_update_ptr + 1, BY_A)
			ACTOR_DESTROY()
			ret
