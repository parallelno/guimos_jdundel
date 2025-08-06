@memusage_cursor

;=========================================================
; This is a non-gameplay bullet object
; It is used in the main menu as a cursor to select the option
;=========================================================
CURSOR_STATUS_IDLE		= ACTOR_STATUS_INIT
CURSOR_STATUS_IDLE_TIME	= 0


CURSOR_MOVE_SPEED_MAX		= 14

; animation speed (the less the slower, 0-255, 255 means the next frame is almost every update)
CURSOR_ANIM_SPEED_MOVE	= 30

; in:
; bc - pos
cursor_init:
			lxi h, 0
			; hl - speed_y
			push h
			; hl - speed_x
			push h
			; pos_xy
			push b
			; BULLET_ANIM_PTR
			lxi h, bomb_run_anim
			push h
			; BULLET_STATUS | BULLET_STATUS_TIMER<<8
			lxi h, CURSOR_STATUS_IDLE_TIME<<8 | CURSOR_STATUS_IDLE
			push h
			; BULLET_DRAW_PTR
			lxi h, bomb_draw
			push h
			; BULLET_UPDATE_PTR
			lxi b, cursor_update
			jmp bullet_init

; anim and a gameplay logic update
; in:
; de - ptr to bullet_update_ptr
cursor_update:
			; de - ptr to bullet_update_ptr
			; advance hl to bullet_pos_y+1
			HL_ADVANCE(bullet_update_ptr, bullet_pos_y+1, BY_HL_FROM_DE)
			; calc a bullet velocity which is = (hero_pos_y - bullet_pos_y) / 4
			lda hero_pos_y+1
			sub m
			jc @move_down
			inr a
			inr a
			; move up
			RRC_(2)
			ani %0011_1111
			; clamp to max speed
			cpi CURSOR_MOVE_SPEED_MAX
			jc @no_clamp
			mvi a, CURSOR_MOVE_SPEED_MAX
@no_clamp:
			jmp @apply_pos
@move_down:
			RRC_(2)
			ori %1100_0000
			; clamp to max speed
			cpi -CURSOR_MOVE_SPEED_MAX
			jnc @no_clamp2
			mvi a, -CURSOR_MOVE_SPEED_MAX
@no_clamp2:
@apply_pos:
			; add velocity to the bullet pos
			add m
			mov m, a

			; hl points to bullet_pos_y+1
			; advance hl to bullet_anim_timer
			L_ADVANCE(bullet_pos_y+1, bullet_anim_timer, BY_A)
			mvi a, CURSOR_ANIM_SPEED_MOVE
			call actor_anim_update
			ret
@die:
			; hl points to bullet_status_timer
			; advance hl to bullet_update_ptr+1
			L_ADVANCE(bullet_status_timer, bullet_update_ptr+1, BY_A)
			ACTOR_DESTROY()
			ret
@vfx_spawn_rate:
			.byte VFX_SPAWN_RATE