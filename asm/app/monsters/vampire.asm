memusage_vampire:
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
;		if distance(mob, hero) < a casting radius:
;			status = cast_prep
;			status_timer = castPrepTime
;			anim = cast
;		else:
;			update_anim
;			check mod-hero collision, impact if collides
; cast_prep:
;	decr status_timer
;	if status_timer == 0:
;		status = cast
;		anim = cast
;	else:
;		update_anim
;		check mod-hero collision, impact if collides
; cast:
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
ACTOR_STATUS_VAMPIRE_DETECT_HERO_INIT	= ACTOR_STATUS_CUSTOM
ACTOR_STATUS_VAMPIRE_DETECT_HERO		= 1
ACTOR_STATUS_VAMPIRE_SHOOT_PREP		= 2
ACTOR_STATUS_VAMPIRE_SHOOT			= 3
ACTOR_STATUS_VAMPIRE_RELAX			= 4
ACTOR_STATUS_VAMPIRE_MOVE_INIT		= 5
ACTOR_STATUS_VAMPIRE_MOVE			= 6

; status duration in updates.
ACTOR_STATUS_VAMPIRE_DETECT_HERO_TIME	= 50
ACTOR_STATUS_VAMPIRE_SHOOT_PREP_TIME	= 30
ACTOR_STATUS_VAMPIRE_RELAX_TIME			= 25
ACTOR_STATUS_VAMPIRE_MOVE_TIME			= 55

; animation speed (the less the slower, 0-255, 255 means the next frame is almost every update)
VAMPIRE_ANIM_SPEED_DETECT_HERO	= 30
VAMPIRE_ANIM_SPEED_RELAX		= 20
VAMPIRE_ANIM_SPEED_MOVE			= 50
VAMPIRE_ANIM_SPEED_SHOOT_PREP	= 1

; gameplay
VAMPIRE_DAMAGE = 1
VAMPIRE_HEALTH = 5

VAMPIRE_COLLISION_WIDTH		= 15
VAMPIRE_COLLISION_HEIGHT	= 10

VAMPIRE_MOVE_SPEED		= $00c0
VAMPIRE_MOVE_SPEED_NEG	= $ffff - $c0 + 1

VAMPIRE_DETECT_HERO_DISTANCE = 90

;========================================================
; spawn and init a monster
; in:
; c - tile_idx in the room_tiledata array.
; a - monster_id * 4
; out:
; a = TILEDATA_RESTORE_TILE
vampire_init:
			MONSTER_INIT(vampire_update, vampire_draw, monster_impacted, VAMPIRE_HEALTH, ACTOR_STATUS_VAMPIRE_DETECT_HERO_INIT, vampire_idle_anim)

;========================================================
; anim and a gameplay logic update
; in:
; de - ptr to monster_update_ptr 
vampire_update:
			; advance hl to monster_status
			HL_ADVANCE(monster_update_ptr, monster_status, BY_HL_FROM_DE)
			mov a, m
			; a - monster_status
			cpi ACTOR_STATUS_VAMPIRE_MOVE
			jz vampire_update_move
			cpi ACTOR_STATUS_VAMPIRE_DETECT_HERO
			jz vampire_update_detect_hero
			cpi ACTOR_STATUS_VAMPIRE_RELAX
			jz vampire_update_relax
			cpi ACTOR_STATUS_VAMPIRE_SHOOT_PREP
			jz vampire_update_shoot_prep
			cpi ACTOR_STATUS_VAMPIRE_MOVE_INIT
			jz vampire_update_move_init
			cpi ACTOR_STATUS_VAMPIRE_DETECT_HERO_INIT
			jz vampire_update_detect_hero_init
			cpi ACTOR_STATUS_VAMPIRE_SHOOT
			jz vampire_update_shoot
			cpi ACTOR_STATUS_FREEZE
			jz monster_update_freeze
			ret

vampire_update_detect_hero_init:
			; hl = monster_status
			mvi m, ACTOR_STATUS_VAMPIRE_DETECT_HERO
			inx h
			mvi m, ACTOR_STATUS_VAMPIRE_DETECT_HERO_TIME
			HL_ADVANCE(monster_status_timer, monster_anim_ptr)
			mvi m, <vampire_idle_anim
			inx h
			mvi m, >vampire_idle_anim
			ret

; in:
; hl - ptr to monster_status
vampire_update_detect_hero:
MONSTER_UPDATE_DETECT_HERO(VAMPIRE_DETECT_HERO_DISTANCE, ACTOR_STATUS_VAMPIRE_SHOOT_PREP, ACTOR_STATUS_VAMPIRE_SHOOT_PREP_TIME, vampire_cast_anim, VAMPIRE_ANIM_SPEED_DETECT_HERO, vampire_update_anim_check_collision_hero, ACTOR_STATUS_VAMPIRE_MOVE_INIT, ACTOR_STATUS_VAMPIRE_MOVE_TIME)

; in:
; hl - ptr to monster_status
vampire_update_move_init:
			; hl = monster_status
			mvi m, ACTOR_STATUS_VAMPIRE_MOVE
			xchg
			call random
			; advance hl to monster_speed_x
			HL_ADVANCE(monster_status, monster_speed_x, BY_HL_FROM_DE)
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
			mvi m, <VAMPIRE_MOVE_SPEED_NEG
			inx h
			mvi m, >VAMPIRE_MOVE_SPEED_NEG
			jmp @set_anim
@speed_y_positive:
			mov m, c
			inx h
			mov m, c
			inx h
			mvi m, <VAMPIRE_MOVE_SPEED
			inx h
			mvi m, >VAMPIRE_MOVE_SPEED
			jmp @set_anim
@speed_x_negative:
			mvi m, <VAMPIRE_MOVE_SPEED_NEG
			inx h
			mvi m, >VAMPIRE_MOVE_SPEED_NEG
			inx h
			mov m, c
			inx h
			mov m, c
			jmp @set_anim
@speed_x_positive:
			mvi m, <VAMPIRE_MOVE_SPEED
			inx h
			mvi m, >VAMPIRE_MOVE_SPEED
			inx h
			mov m, c
			inx h
			mov m, c
@set_anim:
			HL_ADVANCE(monster_speed_y+1, monster_anim_ptr, BY_BC)
			; a = rnd
			CPI_ZERO()
			; if rnd is positive (up or right movement), then play vampire_run_r_anim anim
			jp @set_anim_run_r
@set_anim_run_l:
			mvi m, <vampire_run_l_anim
			inx h
			mvi m, >vampire_run_l_anim
			ret
@set_anim_run_r:
			mvi m, <vampire_run_r_anim
			inx h
			mvi m, >vampire_run_r_anim
            ret

; in:
; hl - ptr to monster_status
vampire_update_move:
			; hl = monster_status
			; advance hl to monster_status_timer
			inx h
			dcr m
			jz @set_detect_hero_init
@update_movement:
			ACTOR_UPDATE_MOVEMENT_CHECK_TILE_COLLISION(monster_status_timer, monster_pos_x, VAMPIRE_COLLISION_WIDTH, VAMPIRE_COLLISION_HEIGHT, @set_move_init) 
			
			; hl points to monster_pos_y+1
			; advance hl to monster_anim_timer
			HL_ADVANCE(monster_pos_y+1, monster_anim_timer, BY_BC)
			mvi a, VAMPIRE_ANIM_SPEED_MOVE
			jmp vampire_update_anim_check_collision_hero

@set_move_init:
			; hl points to monster_pos_x
			; advance hl to monster_status
			HL_ADVANCE(monster_pos_x, monster_status, BY_BC)
			mvi m, ACTOR_STATUS_VAMPIRE_MOVE_INIT
			inx h
			mvi m, ACTOR_STATUS_VAMPIRE_MOVE_TIME
			ret
@set_detect_hero_init:
 			; hl - ptr to monster_status_timer
			; advance hl to monster_status
			dcx h
			mvi m, ACTOR_STATUS_VAMPIRE_DETECT_HERO_INIT
			ret

vampire_update_relax:
			; hl = monster_status
			; advance hl to monster_status_timer
			inx h
			dcr m
			jz @set_move_init
			; advance hl to monster_anim_timer
			HL_ADVANCE(monster_status_timer, monster_anim_timer)
			mvi a, VAMPIRE_ANIM_SPEED_RELAX
			jmp vampire_update_anim_check_collision_hero
 @set_move_init:
 			; hl - ptr to monster_status_timer
			mvi m, ACTOR_STATUS_VAMPIRE_MOVE_TIME
			; advance hl to monster_status
			dcx h
			mvi m, ACTOR_STATUS_VAMPIRE_MOVE_INIT
			ret

; in:
; hl - ptr to monster_status
vampire_update_shoot_prep:
			; hl = monster_status
			; advance hl to monster_status_timer
			inx h
			dcr m
			jz @set_shoot
			; advance hl to monster_anim_timer
			HL_ADVANCE(monster_status_timer, monster_anim_timer)
			mvi a, VAMPIRE_ANIM_SPEED_SHOOT_PREP
			jmp vampire_update_anim_check_collision_hero
 @set_shoot:
  			; hl - ptr to monster_status_timer
			; advance hl to monster_status
			dcx h
			mvi m, ACTOR_STATUS_VAMPIRE_SHOOT
			
			lxi h, sfx_vampire_attack
			call v6_sfx_play
			ret

; in:
; hl - ptr to monster_status
vampire_update_shoot:
			; hl = monster_status
			mvi m, ACTOR_STATUS_VAMPIRE_RELAX
			; advance hl to monster_status_timer
			inx h
			mvi m, ACTOR_STATUS_VAMPIRE_RELAX_TIME

			; advance hl to monster_pos_x+1
			HL_ADVANCE(monster_status_timer, monster_pos_x+1, BY_BC)
			mov b, m
			HL_ADVANCE(monster_pos_x+1, monster_pos_y+1)
			mov c, m
			jmp bomb_dmg_init

; in:
; hl - monster_anim_timer
; a - anim speed
vampire_update_anim_check_collision_hero:
			call actor_anim_update
			MONSTER_CHECK_COLLISION_HERO(VAMPIRE_COLLISION_WIDTH, VAMPIRE_COLLISION_HEIGHT, VAMPIRE_DAMAGE)

; draw a sprite into a backbuffer
; in:
; de - ptr to monster_draw_ptr 
vampire_draw:
			lhld vampire_get_scr_addr
			lda vampire_ram_disk_s_cmd
			jmp actor_draw