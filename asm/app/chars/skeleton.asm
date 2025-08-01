@memusage_skeleton
; mob AI:
; init:
;	 status = detectHeroInit
; detectHeroInit:
;	status = detect_hero
;	status_timer = detectHeroTime
;	anim = idle.
; detect_hero:
;	decr status_timer
;	if status_timer == 0:
;		status = move_init
;	else:
;		if distance(mob, hero) < a shooting radius:
;			status = shoot_prep
;			status_timer = shootPrepTime
;			anim to the hero dir
;		else:
;			update_anim
;			check mod-hero collision, impact if collides
; shoot_prep:
;	decr status_timer
;	if status_timer == 0:
;		status = shoot
;	else:
;		update_anim
;		check mod-hero collision, impact if collides
; shoot:
;	status = relax
;	status_timer = relax_time
;	spawn a projectile along the mob dir
; relax:
;	decr status_timer
;	if status_timer == 0:
;		status = move_init
;	else:
;		update_anim
;		check mod-hero collision, impact if collides
; move_init:
;	status = move
;	status_timer = random
;	speed = random dir
;	set anim along the dir
; move:
;	decr status_timer
;	if status_timer = 0
;		status = detectHeroInit
;	else:
;		try to move a mob
;		if mob collides with tiles:
;			status = move_init
;		else:
;			accept new pos
;			update_anim
;			check mod-hero collision, impact if collides

; statuses.
; personal actor statuses must be in a range of 0 to ACTOR_STATUS_CUSTOM including.
ACTOR_STATUS_SKELETON_DETECT_HERO_INIT	= ACTOR_STATUS_CUSTOM
ACTOR_STATUS_SKELETON_DETECT_HERO		= 1
ACTOR_STATUS_SKELETON_SHOOT_PREP		= 2
ACTOR_STATUS_SKELETON_SHOOT				= 3
ACTOR_STATUS_SKELETON_RELAX				= 4
ACTOR_STATUS_SKELETON_MOVE_INIT			= 5
ACTOR_STATUS_SKELETON_MOVE				= 6

; status duration in updates.
ACTOR_STATUS_SKELETON_DETECT_HERO_TIME	= 50
ACTOR_STATUS_SKELETON_SHOOT_PREP_TIME	= 10
ACTOR_STATUS_SKELETON_RELAX_TIME		= 25
ACTOR_STATUS_SKELETON_MOVE_TIME			= 50

; animation speed (the less the slower, 0-255, 255 means the next frame is almost every update)
SKELETON_ANIM_SPEED_DETECT_HERO	= 30
SKELETON_ANIM_SPEED_RELAX		= 20
SKELETON_ANIM_SPEED_MOVE		= 50
SKELETON_ANIM_SPEED_SHOOT_PREP	= 1

; gameplay
SKELETON_DAMAGE = 1
SKELETON_HEALTH = 3

SKELETON_COLLISION_WIDTH	= 15
SKELETON_COLLISION_HEIGHT	= 10

SKELETON_MOVE_SPEED		= $0100
SKELETON_MOVE_SPEED_NEG	= $ffff - $100 + 1

SKELETON_DETECT_HERO_DISTANCE = 60

;========================================================
; spawn and init a char
; in:
; c - tile_idx in the room_tiledata array.
; a - char_id * 4
; out:
; a = TILEDATA_RESTORE_TILE
skeleton_init:
			CHAR_INIT(skeleton_update, skeleton_draw, char_impacted, SKELETON_HEALTH, ACTOR_STATUS_SKELETON_DETECT_HERO_INIT, skeleton_idle_anim)

;========================================================
; anim and a gameplay logic update
; in:
; de - ptr to char_update_ptr
skeleton_update:
			; advance hl to char_status
			HL_ADVANCE(char_update_ptr, char_status, BY_HL_FROM_DE)
			mov a, m
			/*
			NOT TODO: a call table is not faster than properly sorted cpi/jz.
						it requres a change callig func signatures (de will
						contain a ptr to char_status instead of hl.
						a call table takes 17*4cc. it includes xchg in calling
						func and JMP_4 to call it.
						if status IDs take a big range like now (
						ACTOR_STATUS_SKELETON_DETECT_HERO = 1,
						ACTOR_STATUS_FREEZE = 0x50)
						it will blow up the call table and waist memory.
			*/
			cpi ACTOR_STATUS_SKELETON_MOVE
			jz skeleton_update_move
			cpi ACTOR_STATUS_SKELETON_DETECT_HERO
			jz skeleton_update_detect_hero
			cpi ACTOR_STATUS_SKELETON_RELAX
			jz skeleton_update_relax
			cpi ACTOR_STATUS_SKELETON_SHOOT_PREP
			jz skeleton_update_shoot_prep
			cpi ACTOR_STATUS_SKELETON_MOVE_INIT
			jz skeleton_update_move_init
			cpi ACTOR_STATUS_SKELETON_DETECT_HERO_INIT
			jz skeleton_update_detect_hero_init
			cpi ACTOR_STATUS_SKELETON_SHOOT
			jz skeleton_update_shoot
			cpi ACTOR_STATUS_FREEZE
			jz char_update_freeze
			ret

; in:
; hl - ptr to char_status
skeleton_update_detect_hero_init:
			; hl = char_status
			mvi m, ACTOR_STATUS_SKELETON_DETECT_HERO
			inx h
			mvi m, ACTOR_STATUS_SKELETON_DETECT_HERO_TIME
			HL_ADVANCE(char_status_timer, char_anim_ptr)
			mvi m, <skeleton_idle_anim
			inx h
			mvi m, >skeleton_idle_anim
			ret

; in:
; hl - ptr to char_status
skeleton_update_detect_hero:
			CHAR_UPDATE_DETECT_HERO(SKELETON_DETECT_HERO_DISTANCE, ACTOR_STATUS_SKELETON_SHOOT_PREP, ACTOR_STATUS_SKELETON_SHOOT_PREP_TIME, skeleton_idle_anim, SKELETON_ANIM_SPEED_DETECT_HERO, skeleton_update_anim_check_collision_hero, ACTOR_STATUS_SKELETON_MOVE_INIT, ACTOR_STATUS_SKELETON_MOVE_TIME)

; in:
; hl - ptr to char_status
skeleton_update_move_init:
			; hl = char_status
			mvi m, ACTOR_STATUS_SKELETON_MOVE
			xchg
			call random
			; advance hl to char_speed_x
			HL_ADVANCE(char_status, char_speed_x, BY_HL_FROM_DE)
			mvi c, 0 ; tmp c=0
			cpi $40
			jc @speed_x_positive
			cpi $80
			jc @speed_y_positive
			cpi $c0
			jc @speed_x_negative
@speed_y_negative:
			mov m, c
			inx h
			mov m, c
			inx h
			mvi m, <SKELETON_MOVE_SPEED_NEG
			inx h
			mvi m, >SKELETON_MOVE_SPEED_NEG
			jmp @set_anim
@speed_y_positive:
			mov m, c
			inx h
			mov m, c
			inx h
			mvi m, <SKELETON_MOVE_SPEED
			inx h
			mvi m, >SKELETON_MOVE_SPEED
			jmp @set_anim
@speed_x_negative:
			mvi m, <SKELETON_MOVE_SPEED_NEG
			inx h
			mvi m, >SKELETON_MOVE_SPEED_NEG
			inx h
			mov m, c
			inx h
			mov m, c
			jmp @set_anim
@speed_x_positive:
			mvi m, <SKELETON_MOVE_SPEED
			inx h
			mvi m, >SKELETON_MOVE_SPEED
			inx h
			mov m, c
			inx h
			mov m, c
@set_anim:
			HL_ADVANCE(char_speed_y+1, char_anim_ptr, BY_BC)
			; a = rnd
			CPI_ZERO()
			; if rnd is positive (up or right movement), then play skeleton_run_r_anim anim
			jp @set_anim_run_r
@set_anim_run_l:
			mvi m, <skeleton_run_l_anim
			inx h
			mvi m, >skeleton_run_l_anim
			ret
@set_anim_run_r:
			mvi m, <skeleton_run_r_anim
			inx h
			mvi m, >skeleton_run_r_anim
            ret

; in:
; hl - ptr to char_status
skeleton_update_move:
			; hl = char_status
			; advance hl to char_status_timer
			inx h
			dcr m
			jz @set_detect_hero_init
@update_movement:
			ACTOR_UPDATE_MOVEMENT_CHECK_TILE_COLLISION(SKELETON_COLLISION_WIDTH, SKELETON_COLLISION_HEIGHT, @set_move_init)

			; hl points to char_pos_y+1
			; advance hl to char_anim_timer
			HL_ADVANCE(char_pos_y+1, char_anim_timer, BY_BC)
			mvi a, SKELETON_ANIM_SPEED_MOVE
			jmp skeleton_update_anim_check_collision_hero

@set_move_init:
			; hl points to char_pos_x
			; advance hl to char_status
			HL_ADVANCE(char_pos_x, char_status, BY_BC)
			mvi m, ACTOR_STATUS_SKELETON_MOVE_INIT
			inx h
			mvi m, ACTOR_STATUS_SKELETON_MOVE_TIME
			ret
@set_detect_hero_init:
 			; hl - ptr to char_status_timer
			mvi m, ACTOR_STATUS_SKELETON_MOVE_TIME
			; advance hl to char_status
			dcx h
			mvi m, ACTOR_STATUS_SKELETON_DETECT_HERO_INIT
			ret

; in:
; hl - ptr to char_status
skeleton_update_relax:
			; hl = char_status
			; advance hl to char_status_timer
			inx h
			dcr m
			jz @set_move_init
			; advance hl to char_anim_timer
			HL_ADVANCE(char_status_timer, char_anim_timer)
			mvi a, SKELETON_ANIM_SPEED_RELAX
			jmp skeleton_update_anim_check_collision_hero
 @set_move_init:
 			; hl - ptr to char_status_timer
			mvi m, ACTOR_STATUS_SKELETON_MOVE_TIME
			; advance hl to char_status
			dcx h
			mvi m, ACTOR_STATUS_SKELETON_MOVE_INIT
			ret

; in:
; hl - ptr to char_status
skeleton_update_shoot_prep:
			; hl = char_status
			; advance hl to char_status_timer
			inx h
			dcr m
			jz @set_shoot
			; advance hl to char_anim_timer
			HL_ADVANCE(char_status_timer, char_anim_timer)
			mvi a, SKELETON_ANIM_SPEED_SHOOT_PREP
			jmp skeleton_update_anim_check_collision_hero
 @set_shoot:
  			; hl - ptr to char_status_timer
			; advance hl to char_status
			dcx h
			mvi m, ACTOR_STATUS_SKELETON_SHOOT
			ret

; in:
; hl - ptr to char_status
skeleton_update_shoot:
			; hl = char_status
			mvi m, ACTOR_STATUS_SKELETON_RELAX
			; advance hl to char_status_timer
			inx h
			mvi m, ACTOR_STATUS_SKELETON_RELAX_TIME

			HL_ADVANCE(char_status_timer, char_speed_x, BY_BC)
			mov a, m
			inx h
			ora m
			jz @shoot_vert
			mov a, m
			CPI_ZERO()
			mvi a, BULLET_DIR_R
			jp @shoot_right
@shoot_left:
			mvi a, BULLET_DIR_L
@shoot_right:
			LXI_B_TO_DIFF(char_speed_x+1, char_pos_x+1)
			jmp @set_bullet_pos
@shoot_vert:
			; advance hl to char_speed_y+1
			INX_H(2)
			mov a, m
			CPI_ZERO()
			mvi a, BULLET_DIR_U
			jp @shoot_up
@shoot_down:
			mvi a, BULLET_DIR_D
@shoot_up:
			LXI_B_TO_DIFF(char_speed_y+1, char_pos_x+1)
@set_bullet_pos:
			dad b
			mov b, m
			INX_H(2)
			mov c, m
.if DEBUG
			jmp scythe_init
			ret
.endif


; in:
; hl - char_anim_timer
; a - anim speed
skeleton_update_anim_check_collision_hero:
			call actor_anim_update
			CHAR_CHECK_COLLISION_HERO(SKELETON_COLLISION_WIDTH, SKELETON_COLLISION_HEIGHT, SKELETON_DAMAGE)

; draw a sprite into a backbuffer
; in:
; de - ptr to char_draw_ptr
skeleton_draw:
			lhld skeleton_get_scr_addr
			lda skeleton_ram_disk_s_cmd
			jmp actor_draw