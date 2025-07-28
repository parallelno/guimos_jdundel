@memusage_trap

;=============================================================================
; This is a quest trap.
; It looks like a metal can propped up by a small wooden stick.
; If a caterpillar touches it, the trap is triggered and captures the caterpillar.
;
; When placed on the ground, a countdown timer starts.
; If the timer expires, the trap opens and any captured caterpillars are released.
;
; The hero must lift the trap before the timer runs out.
; Once time is up, the trap changes appearance:
; - If a caterpillar was caught, the trap stands upright.
; - If nothing was caught, it falls over.

; statuses.
TRAP_STATUS_ON		= ACTOR_STATUS_INIT
TRAP_STATUS_SUCCESS	= 1
TRAP_STATUS_FAIL	= 2

TRAP_STATUS_ON_TIME	= $FF


; in:
; bc - caster pos
trap_init:
/*
BULLET_INIT(bomb_update, bomb_draw, BOMB_STATUS_MOVE_THROW, BOMB_STATUS_MOVE_TIME, bomb_dmg_anim, empty_func)

; vfx_draw func used for this trap bullet requires a specific pos_y and pos_x format
; this function provides it
; in:
; de - ptr to bullet_speed_x
trap_init_post:
			HL_ADVANCE(bullet_speed_x, bullet_pos_x + 1, BY_HL_FROM_DE)
			; hl - ptr to bullet_pos_x + 1
			mov a, m
			; a - pos_x
			; make a scr addr
			ani %00011111
			ori SPRITE_X_SCR_ADDR
			mov m, a
			; advance hl to bullet_pos_y
			inx h
			mvi m, 2 ; anim ptr offset. used in the vfx_draw func
			; a hero got trap
			mvi a, GAME_STATUS_ACQUIRED
			sta game_status_trap
			ret

; anim and a gameplay logic update
; in:
; de - ptr to bullet_update_ptr
trap_update:
			; advance to bullet_status_timer
			xchg
			L_ADVANCE(bullet_update_ptr, bullet_status_timer, BY_A)
			; hl - ptr to bullet_update_ptr
@fraction_timer:
			mvi a, 1
			rlc
			sta @fraction_timer + 1
			jnc @update_movement

			dcr m
			jz @die ; time is over

@update_movement:
			; hl - ptr to bullet_status_timer
			; advance hl to bullet_speed_y + 1
			L_ADVANCE(bullet_status_timer, bullet_pos_x + 1, BY_A)

			; update pos
			xchg
			lhld hero_erase_scr_addr
			xchg

			mov m, d
			; advance hl to bullet_pos_y + 1
			INX_H(2)
			mov m, e

			L_ADVANCE(bullet_pos_y + 1, bullet_anim_timer, BY_A)
			; update_anim
			mvi a, SPARKER_ANIM_SPEED_MOVE
			call actor_anim_update
			ret
@die:
			; make game_status_trap not_acquired
			A_TO_ZERO(GAME_STATUS_NOT_ACQUIRED)
			sta game_status_trap
			; destroy trap vfx
			; hl points to bullet_status_timer
			; advance hl to bullet_update_ptr + 1
			L_ADVANCE(bullet_status_timer, bullet_update_ptr+1, BY_A)
			ACTOR_DESTROY()
			ret
*/