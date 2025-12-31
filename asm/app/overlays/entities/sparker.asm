@memusage_sparker:

;=========================================================
; This is a non-gameplay overlay
; It is used for the hero's death in-game cinematic
; statuses to spawn sparks along the line
;=========================================================

; overlay AI:
; init:
;	status = move_forward
;	status_timer = moveForwardTimer
;	speed = caster dir
; move_forward:
;	decr status_timer
;	if status_timer = 0
;		death
;	else:
;		try to move a overlay
;		if overlay collides with tiles:
;			death
;		else:
;			accept new pos
;			update_anim
;			check overlay-hero collision,
;			if overlay collides with hero:
;				impact hero
;				death

SPARKER_MOVE_SPEED		= $0400				; low byte is a subpixel speed, high byte is a speed in pixels
SPARKER_MOVE_SPEED_NEG	= $ffff - $0400 + 1	; low byte is a subpixel speed, high byte is a speed in pixels

; statuses.
SPARKER_STATUS_MOVE = ACTOR_STATUS_INIT

; status duration in updates. can be 2,4,8,16,32, etc
; when updated do not forget update the code below (posDiffX / SPARKER_STATUS_MOVE_TIME) to match the new value
SPARKER_STATUS_MOVE_TIME	= 64

; animation speed (the less the slower, 0-255, 255 means the next frame is almost every update)
SPARKER_ANIM_SPEED_MOVE	= 130

; the rate when it is time to spawn a sparkle vfx.
VFX_SPAWN_RATE = 5

; in:
; bc - pos_xy
sparker_init:
			; set a projectile speed towards the hero
			; pos_diff =  hero_pos - burner_pos
			; speed = pos_diff / ACTOR_STATUS_VAMPIRE_DASH_TIME

			; init speed_y
			lda hero_pos_y + 1
			sub c
			call @init_speed
			; hl - speed_y
			push h

			; init speed_x
			lda hero_pos_x + 1
			sub b
			call @init_speed
			; hl - speed_x
			push h

			; pos_xy
			push b
			; OVERLAY_ANIM_PTR
			lxi h, vfx4_spark_anim
			push h
			; OVERLAY_STATUS | OVERLAY_STATUS_TIMER<<8
			lxi h, SPARKER_STATUS_MOVE_TIME<<8 | SPARKER_STATUS_MOVE
			push h
			; OVERLAY_DRAW_PTR
			lxi h, vfx_draw4
			push h
			; OVERLAY_UPDATE_PTR
			lxi b, sparker_update
			jmp overlay_init

; in:
; a = pos_diff (hero_pos - pos_x)
; out:
; hl - speed
@init_speed:
			mov l, a
			mvi a, 0
			; if pos_diff < 0, then d = $ff, else d = 0
			sbb a
			mov h, a
			; pos_diff / SPARKER_STATUS_MOVE_TIME (it uses the fact that HL>>5 is the same as HL<<3)
			dad h
			dad h
			;dad h
			; to fill up L with %1111 if pos_diff < 0
			;ani %111 ; <(%0000000011111111 / BOMB_STATUS_DASH_TIME)
			ani %11 ; <(%0000000011111111 / SPARKER_STATUS_DASH_TIME)
			ora l
			mov l, a
			ret


; anim and a gameplay logic update
; in:
; de - ptr to overlay_update_ptr
sparker_update:
			; advance to overlay_status_timer
			HL_ADVANCE(overlay_update_ptr, overlay_status_timer, BY_HL_FROM_DE)
			dcr m
			jz @die
@update_movement:
			call actor_move
			; hl - ptr to overlay_pos_x + 1

			shld @sparker_pos_ptr + 1
			; hl points to overlay_pos_x + 1
			; advance hl to overlay_anim_timer
			L_ADVANCE(overlay_pos_x + 1, overlay_anim_timer, BY_A)
			mvi a, SPARKER_ANIM_SPEED_MOVE
			call actor_anim_update

			; check if it is time to spawn VFX
			lxi h, @vfx_spawn_rate
			dcr m
			rnz
			mvi m, VFX_SPAWN_RATE
			; draw vfx
			; bc - vfx scr_xy
			; de - vfx_anim_ptr (ex. vfx_puff_anim)
@sparker_pos_ptr:
			lxi h, TEMP_ADDR
			; hl points to overlay_pos_x + 1
			mov b, m
			L_ADVANCE(overlay_pos_x + 1, overlay_pos_x + 1)
			mov c, m
			lxi d, vfx_reward_anim
			call vfx_init
			ret
@die:
			; hl points to overlay_status_timer
			; advance hl to overlay_update_ptr + 1
			L_ADVANCE(overlay_status_timer, overlay_update_ptr + 1, BY_A)
			ACTOR_DESTROY()
			ret
@vfx_spawn_rate:
			.byte VFX_SPAWN_RATE
