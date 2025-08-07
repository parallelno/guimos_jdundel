@memusage_bomb
;=============================================================================
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

; 16-bit speed. low byte is a subpixel speed, high byte is a speed in pixels
BOMB_MOVE_SPEED		= $0400
BOMB_MOVE_SPEED_NEG	= $ffff - $0400 + 1

; statuses.
BOMB_STATUS_MOVE_THROW = ACTOR_STATUS_INIT

; status duration in updates.
; when updated do not forget update the code below
; (pos_diff_x / SPARKER_STATUS_MOVE_TIME) to match the new value
BOMB_STATUS_MOVE_TIME	= 32

; animation speed (the less the slower, 0-255, 255 means the next frame is almost every update)
BOMB_ANIM_SPEED_MOVE	= 130

; gameplay
BOMB_DAMAGE = 1
BOMB_COLLISION_WIDTH	= 10
BOMB_COLLISION_HEIGHT	= 10

; in:
; bc - pos_xy
; rev1. 372 cc
; rev2. 452 cc (twice smaller size, compatible with overlay_init rev4)
bomb_dmg_init:
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
			lxi h, bomb_dmg_anim
			push h
			; OVERLAY_STATUS | OVERLAY_STATUS_TIMER<<8
			lxi h, BOMB_STATUS_MOVE_TIME<<8 | BOMB_STATUS_MOVE_THROW
			push h
			; OVERLAY_DRAW_PTR
			lxi h, bomb_draw
			push h
			; OVERLAY_UPDATE_PTR
			lxi b, bomb_update
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
			; pos_diff / BOMB_STATUS_MOVE_TIME (it uses the fact that HL>>5 is the same as HL<<3)
			dad h
			dad h
			dad h
			; to fill up L with %1111 if pos_diff < 0
			ani %111 ; <(%0000000011111111 / BOMB_STATUS_DASH_TIME)
			ora l
			mov l, a
			ret

; anim and a gameplay logic update
; in:
; de - ptr to overlay_update_ptr
bomb_update:
			; advance to overlay_status_timer
			HL_ADVANCE(overlay_update_ptr, overlay_status_timer, BY_HL_FROM_DE)
			dcr m
			jz @die
@update_movement:
			call actor_move
			; hl - ptr to overlay_pos_x+1
			; advance hl to overlay_anim_timer
			L_ADVANCE(overlay_pos_x+1, overlay_anim_timer, BY_A)
			mvi a, BOMB_ANIM_SPEED_MOVE
			OVERLAY_UPDATE_ANIM_CHECK_COLLISION_HERO(BOMB_COLLISION_WIDTH, BOMB_COLLISION_HEIGHT, BOMB_DAMAGE)
			; @die_after_damage:
			; advance hl to overlay_update_ptr+1
			L_ADVANCE(overlay_pos_y+1, overlay_update_ptr+1, BY_A)
			ACTOR_DESTROY()
			ret
@die:
			; hl points to overlay_status_timer
			; advance hl to overlay_update_ptr+1
			L_ADVANCE(overlay_status_timer, overlay_update_ptr+1, BY_A)
			ACTOR_DESTROY()
			ret

; draw a sprite into a backbuffer
; in:
bomb_draw:
; de - ptr to overlay_draw_ptr
			lhld bomb_get_scr_addr
			lda bomb_ram_disk_s_cmd
			jmp actor_draw