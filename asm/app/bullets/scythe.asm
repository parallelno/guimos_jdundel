@memusage_scythe
;=================================================
; bullet AI:
; init:
;	status = move_forward
;	status_timer = moveForwardTimer
;	speed = caster dir
; move_forward:
;	decr status_timer
;	if status_timer = 0
;		status = move_backward
;		status_timer = moveBackwardTimer
;	else:
;		try to move a bullet
;		if bullet collides with tiles:
;			if status = move_backward:
;				die
;			else:
;				status = move_backward
;		else:
;			accept new pos
;			update_anim
;			check bullet-hero collision
;			if bullet collides with hero:
;				impact hero
;				death
; move_backward:
;	decr status_timer
;	if status_timer = 0
;		death
;	else:
;		try to move a bullet
;		if bullet collides with tiles:
;			death
;		else:
;			accept new pos
;			update_anim
;			check bullet-hero collision
;			if bullet collides with hero:
;				impact hero
;				death


SCYTHE_MOVE_SPEED		= $0400				; low byte is a subpixel speed, high byte is a speed in pixels
SCYTHE_MOVE_SPEED_NEG	= $ffff - $0400 + 1	; low byte is a subpixel speed, high byte is a speed in pixels

; statuses.
SCYTHE_STATUS_MOVE_THROW = ACTOR_STATUS_INIT
SCYTHE_STATUS_MOVE_BOUNCE = 1

; status duration in updates.
SCYTHE_STATUS_MOVE_TIME	= 25

; animation speed (the less the slower, 0-255, 255 means the next frame is almost every update)
SCYTHE_ANIM_SPEED_MOVE	= 130

; gameplay
SCYTHE_DAMAGE = 4
SCYTHE_COLLISION_WIDTH	= 12
SCYTHE_COLLISION_HEIGHT	= 12

; in:
; bc - caster pos
; a - direction (BULLET_DIR_*)
scythe_init:
			lxi d, 0
			lxi h, SCYTHE_MOVE_SPEED

			cpi BULLET_DIR_R
			jz @init_speed
			cpi BULLET_DIR_L
			jz @move_left
			cpi BULLET_DIR_U
			jz @move_up
@move_down:
			lxi h, SCYTHE_MOVE_SPEED_NEG
@move_up:
			xchg
			jmp @init_speed
@move_left:
			lxi h, SCYTHE_MOVE_SPEED_NEG
@init_speed:
			; speed_y
			push d
			; speed_x
			push h

			; pos_xy
			push b
			; BULLET_ANIM_PTR
			lxi h, scythe_run_anim
			push h
			; BULLET_STATUS | BULLET_STATUS_TIMER<<8
			lxi h, SCYTHE_STATUS_MOVE_TIME<<8 | SCYTHE_STATUS_MOVE_THROW
			push h
			; BULLET_DRAW_PTR
			lxi h, scythe_draw
			push h
			; BULLET_UPDATE_PTR
			lxi b, scythe_update
			jmp bullet_init

; anim and a gameplay logic update
; in:
; de - ptr to bullet_update_ptr
scythe_update:
			; advance to bullet_status_timer
			HL_ADVANCE(bullet_update_ptr, bullet_status_timer, BY_HL_FROM_DE)
			dcr m
			jz @die
@update_movement:
			ACTOR_UPDATE_MOVEMENT_CHECK_TILE_COLLISION(SCYTHE_COLLISION_WIDTH, SCYTHE_COLLISION_HEIGHT, @set_bounce_after_tile_collision)

			; hl points to bullet_pos_y+1
			; advance hl to bullet_anim_timer
			L_ADVANCE(bullet_pos_y+1, bullet_anim_timer, BY_A)
			mvi a, SCYTHE_ANIM_SPEED_MOVE
			BULLET_UPDATE_ANIM_CHECK_COLLISION_HERO(SCYTHE_COLLISION_WIDTH, SCYTHE_COLLISION_HEIGHT, SCYTHE_DAMAGE)
@die_after_damage:
			; advance hl to bullet_update_ptr+1
			L_ADVANCE(bullet_pos_y+1, bullet_update_ptr+1, BY_A)
			ACTOR_DESTROY()
			ret
@set_bounce_after_tile_collision:
			; hl points to pos_x
			; advance hl to bullet_status_timer
			L_ADVANCE(bullet_pos_x, bullet_status_timer, BY_A)
@set_bounce:
			; hl - ptr to bullet_status_timer
			; advance hl to bullet_status
			dcx h
			mvi m, SCYTHE_STATUS_MOVE_BOUNCE
			; advance hl to bullet_speed_x
			L_ADVANCE(bullet_status, bullet_speed_x, BY_A)
			mov a, m
			inx h
			ora m
			jz @set_move_vert
			jp @set_move_left
@set_move_right:
			mvi m, >SCYTHE_MOVE_SPEED
			dcx h
			mvi m, <SCYTHE_MOVE_SPEED
			ret
@set_move_left:
			mvi m, >SCYTHE_MOVE_SPEED_NEG
			dcx h
			mvi m, <SCYTHE_MOVE_SPEED_NEG
			ret
@set_move_vert:
			; advance hl to bullet_speed_y+1
			INX_H(2)
			mov a, m
			CPI_ZERO()
			jp @set_move_down
@set_move_up:
			mvi m, >SCYTHE_MOVE_SPEED
			dcx h
			mvi m, <SCYTHE_MOVE_SPEED
			ret
@set_move_down:
			mvi m, >SCYTHE_MOVE_SPEED_NEG
			dcx h
			mvi m, <SCYTHE_MOVE_SPEED_NEG
			ret
@die:
			; hl points to bullet_status_timer
			; advance hl to bullet_update_ptr+1
			L_ADVANCE(bullet_status_timer, bullet_update_ptr+1, BY_A)
			ACTOR_DESTROY()
			ret

; draw a sprite into a backbuffer
; in:
; de - ptr to bullet_draw_ptr
scythe_draw:
			lhld scythe_get_scr_addr
			lda scythe_ram_disk_s_cmd
			jmp actor_draw