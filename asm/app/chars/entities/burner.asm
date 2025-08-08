@memusage_burner
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
;		if distance(mob, hero) < a dashing radius:
;			status = dash_prep
;			status_timer = dashPrepTime
;			anim to the hero dir
;		else:
;			update_anim
;			check mod-hero collision, impact if collides
; dash_prep:
;	decr status_timer
;	if status_timer == 0:
;		status = dash
;		anim = run
;		speed directly to the hero pos
;	else:
;		update_anim
;		check mod-hero collision, impact if collides
; dash:
;	decr status_timer
;	if status_timer == 0:
;		status = relax
;		status_timer = relax_time
;	else:
;		move a mob
;		update_anim
;		check mod-hero collision, impact if collides
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
ACTOR_STATUS_BURNER_DETECT_HERO_INIT	= ACTOR_STATUS_INIT
ACTOR_STATUS_BURNER_DETECT_HERO			= 1 * JMP_4_LEN ; TODO: remove JMP_4_LEN. it was used for tests (case insttead bunch of if else. P.S. if else won!)
ACTOR_STATUS_BURNER_DASH_PREP			= 2 * JMP_4_LEN
ACTOR_STATUS_BURNER_DASH				= 3 * JMP_4_LEN
ACTOR_STATUS_BURNER_RELAX				= 4 * JMP_4_LEN
ACTOR_STATUS_BURNER_MOVE_INIT			= 5 * JMP_4_LEN
ACTOR_STATUS_BURNER_MOVE				= 6 * JMP_4_LEN

; status duration in updates.
ACTOR_STATUS_BURNER_DETECT_HERO_TIME	= 50
ACTOR_STATUS_BURNER_DASH_PREP_TIME		= 10
ACTOR_STATUS_BURNER_DASH_TIME			= 16
ACTOR_STATUS_BURNER_RELAX_TIME			= 25
ACTOR_STATUS_BURNER_MOVE_TIME			= 60

; animation speed (the less the slower, 0-255, 255 means the next frame is almost every update)
BURNER_ANIM_SPEED_DETECT_HERO	= 50
BURNER_ANIM_SPEED_RELAX			= 20
BURNER_ANIM_SPEED_MOVE			= 60
BURNER_ANIM_SPEED_DASH_PREP		= 100
BURNER_ANIM_SPEED_DASH			= 150

; gameplay
BURNER_DAMAGE = 1
BURNER_HEALTH = 6

BURNER_COLLISION_WIDTH	= 15
BURNER_COLLISION_HEIGHT	= 10

BURNER_MOVE_SPEED		= $0100
BURNER_MOVE_SPEED_NEG	= $ffff - $100 + 1

BURNER_DETECT_HERO_DISTANCE = 60

;========================================================
; spawn and init a char
; in:
; c - tile_idx in the room_tiledata array.
; a - char_id * 4
; out:
; a = TILEDATA_RESTORE_TILE
burner_init:
			CHAR_INIT(burner_update, burner_draw, char_impacted, BURNER_HEALTH, ACTOR_STATUS_BURNER_DETECT_HERO_INIT, burner_idle_anim)

; uppdate for BURNER_ID
; anim and a gameplay logic update
; in:
; de - ptr to char_update_ptr
burner_update:

/*
; TODO: test. is it faster to copy the actor run-time data
; to the temp buffer, when access it via lhld/shld instead
; of
;			HL_ADVANCE(char_status_timer, char_anim_ptr),
;			mvi m, <burner_idle_anim
;			inx h
; the tests showed that the average burner Update takes 903 cc.
; If we copy the current actor run-time data to the temp buffer,
; it will take 588 cc. Copying back can be same or slower, so
; it is not worth it.


; in:
; de - source
; 588 cc to copy 32 bytes
.macro TEST_ACTOR_RUNTIME_DATA_COPY2(chars_runtime_tmp_data)
			di
			; store sp
			lxi h, 0x0000
			dad sp
			xchg
			sphl
			; de - stack addr

		@tmp_ram_data_addr .var chars_runtime_tmp_data
		.loop CHAR_RUNTIME_DATA_LEN / 2
			pop h
			shld @tmp_ram_data_addr
			@tmp_ram_data_addr += 2
			; 11*4=44cc
		.endloop

@restore_sp:
			xchg
			sphl
			ei
			ret
.endmacro
*/
@codePerfStart_burner_update:
			call @test
@codePerfEnd_burner_update:
			ret
@test:
			; advance hl to char_status
			HL_ADVANCE(char_update_ptr, char_status, BY_HL_FROM_DE)
			mov a, m
			cpi ACTOR_STATUS_BURNER_MOVE
			jz burner_update_move
			cpi ACTOR_STATUS_BURNER_DETECT_HERO
			jz burner_update_detect_hero
			cpi ACTOR_STATUS_BURNER_DASH
			jz burner_update_dash
			cpi ACTOR_STATUS_BURNER_RELAX
			jz burner_update_relax
			cpi ACTOR_STATUS_BURNER_DASH_PREP
			jz burner_update_dash_prep
			cpi ACTOR_STATUS_BURNER_MOVE_INIT
			jz burner_update_move_init
			cpi ACTOR_STATUS_BURNER_DETECT_HERO_INIT
			jz burner_update_detect_hero_init
			cpi ACTOR_STATUS_FREEZE
			jz burner_update_freeze
			ret

; burner is immune to freeze
; in:
; hl - ptr to char_status
burner_update_freeze:
			mvi m, ACTOR_STATUS_BURNER_DETECT_HERO_INIT
			ret

; in:
; hl - ptr to char_status
burner_update_detect_hero_init:
			; hl = char_status
			mvi m, ACTOR_STATUS_BURNER_DETECT_HERO
			inx h
			mvi m, ACTOR_STATUS_BURNER_DETECT_HERO_TIME
			HL_ADVANCE(char_status_timer, char_anim_ptr)
			mvi m, <burner_idle_anim
			inx h
			mvi m, >burner_idle_anim
			ret

; in:
; hl - ptr to char_status
burner_update_detect_hero:
			CHAR_UPDATE_DETECT_HERO(BURNER_DETECT_HERO_DISTANCE, ACTOR_STATUS_BURNER_DASH_PREP, ACTOR_STATUS_BURNER_DASH_PREP_TIME, burner_dash_anim, BURNER_ANIM_SPEED_DETECT_HERO, burner_update_anim_check_collision_hero, ACTOR_STATUS_BURNER_MOVE_INIT, ACTOR_STATUS_BURNER_MOVE_TIME)

; in:
; hl - ptr to char_status
burner_update_move_init:
			mvi m, ACTOR_STATUS_BURNER_MOVE

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
			mvi m, <BURNER_MOVE_SPEED_NEG
			inx h
			mvi m, >BURNER_MOVE_SPEED_NEG
			jmp @set_anim
@speed_y_positive:
			mov m, c
			inx h
			mov m, c
			inx h
			mvi m, <BURNER_MOVE_SPEED
			inx h
			mvi m, >BURNER_MOVE_SPEED
			jmp @set_anim
@speed_x_negative:
			mvi m, <BURNER_MOVE_SPEED_NEG
			inx h
			mvi m, >BURNER_MOVE_SPEED_NEG
			inx h
			mov m, c
			inx h
			mov m, c
			jmp @set_anim
@speed_x_positive:
			mvi m, <BURNER_MOVE_SPEED
			inx h
			mvi m, >BURNER_MOVE_SPEED
			inx h
			mov m, c
			inx h
			mov m, c
@set_anim:
			HL_ADVANCE(char_speed_y + 1, char_anim_ptr, BY_BC)
			; a = rnd
			CPI_ZERO()
			; if rnd is positive (up or right movement), then play burner_run_r anim
			jp @set_anim_run_r
@set_anim_run_l:
			mvi m, <burner_run_l_anim
			inx h
			mvi m, >burner_run_l_anim
			ret
@set_anim_run_r:
			mvi m, <burner_run_r_anim
			inx h
			mvi m, >burner_run_r_anim
            ret

; in:
; hl - ptr to char_status
burner_update_move:
			; advance hl to char_status_timer
			inx h
			dcr m
			jz @set_detect_hero_init
@update_movement:
			ACTOR_UPDATE_MOVEMENT_CHECK_TILE_COLLISION(BURNER_COLLISION_WIDTH, BURNER_COLLISION_HEIGHT, @set_move_init)

			; hl points to char_pos_y + 1
			; advance hl to char_anim_timer
			HL_ADVANCE(char_pos_y + 1, char_anim_timer, BY_BC)
			mvi a, BURNER_ANIM_SPEED_MOVE
			jmp burner_update_anim_check_collision_hero

@set_move_init:
			; hl points to char_pos_x
			; advance hl to char_status
			HL_ADVANCE(char_pos_x, char_status, BY_BC)
			mvi m, ACTOR_STATUS_BURNER_MOVE_INIT
			inx h
			mvi m, ACTOR_STATUS_BURNER_MOVE_TIME
			ret
@set_detect_hero_init:
 			; hl - ptr to char_status_timer
			; advance hl to char_status
			dcx h
			mvi m, ACTOR_STATUS_BURNER_DETECT_HERO_INIT
			ret

; in:
; hl - ptr to char_status
burner_update_relax:
			; hl = char_status
			; advance hl to char_status_timer
			inx h
			dcr m
			jz @set_move_init
			; advance hl to char_anim_timer
			HL_ADVANCE(char_status_timer, char_anim_timer)
			mvi a, BURNER_ANIM_SPEED_RELAX
			jmp burner_update_anim_check_collision_hero
 @set_move_init:
 			; hl - ptr to char_status_timer
			mvi m, ACTOR_STATUS_BURNER_MOVE_TIME
			; advance hl to char_status
			dcx h
			mvi m, ACTOR_STATUS_BURNER_MOVE_INIT
			ret

; in:
; hl - ptr to char_status
burner_update_dash_prep:
			; hl = char_status
			; advance hl to char_status_timer
			inx h
			dcr m
			jz @set_dash
			; advance hl to char_anim_timer
			HL_ADVANCE(char_status_timer, char_anim_timer)
			mvi a, BURNER_ANIM_SPEED_DASH_PREP
			jmp burner_update_anim_check_collision_hero
 @set_dash:
  			; hl - ptr to char_status_timer
			mvi m, ACTOR_STATUS_BURNER_DASH_TIME
			; advance hl to char_status
			dcx h
			mvi m, ACTOR_STATUS_BURNER_DASH
			; advance hl to char_pos_x
			HL_ADVANCE(char_status, char_pos_x, BY_BC)
			; reset sub pixel pos_x
			mvi m, 0
			; advance hl to pos_x + 1
			inx h
			; pos_diff =  hero_pos - burnerPosX
			; speed = pos_diff / ACTOR_STATUS_BURNER_DASH_TIME
			lda hero_pos_x + 1
			sub m
			mov e, a
			mvi a, 0
			; if posDiffX < 0, then d = $ff, else d = 0
			sbb a
			mov d, a
			xchg
			; posDiffX / ACTOR_STATUS_BURNER_DASH_TIME
			dad h
			dad h
			dad h
			dad h
			; to fill up L with %1111 if pos_diff < 0
			ani %1111 ; <(%0000000011111111 / ACTOR_STATUS_BURNER_DASH_TIME)
			ora l
			mov l, a
			push h
			xchg
			; advance hl to pos_y
			inx h
			; reset sub pixel pos_y
			mvi m, 0
			; advance hl to pos_y + 1
			inx h
			; do the same for Y
			lda hero_pos_y + 1
			sub m
			mov e, a
			mvi a, 0
			; if posDiffY < 0, then d = $ff, else d = 0
			sbb a
			mov d, a
			xchg
			; posDiffY / ACTOR_STATUS_BURNER_DASH_TIME
			dad h
			dad h
			dad h
			dad h
			; to fill up L with %1111 if pos_diff < 0
			ani %1111 ; <(%0000000011111111 / ACTOR_STATUS_BURNER_DASH_TIME)
			ora l
			mov l, a
			xchg
			; advance hl to speed_x
			inx h
			pop b ; speed_x
			mov m, c
			inx h
			mov m, b
			; advance hl to speed_y
			inx h
			mov m, e
			inx h
			mov m, d
			ret

; in:
; hl - ptr to char_status
burner_update_dash:
			; hl = char_status
			; advance hl to char_status_timer
			inx h
			dcr m
			jm @set_move_init
@apply_movement:
			call actor_move
			; hl - ptr to char_pos_x + 1
			; advance hl to char_anim_timer
			HL_ADVANCE(char_pos_x + 1, char_anim_timer, BY_BC)
			mvi a, BURNER_ANIM_SPEED_DASH
			jmp actor_anim_update
@set_move_init:
			; hl points to char_status_timer
			mvi m, ACTOR_STATUS_BURNER_MOVE_TIME
			; advance hl to char_status
			dcx h
			mvi m, ACTOR_STATUS_BURNER_MOVE_INIT
			ret


; in:
; hl - char_anim_timer
; a - anim speed
burner_update_anim_check_collision_hero:
			call actor_anim_update
			CHAR_CHECK_COLLISION_HERO(BURNER_COLLISION_WIDTH, BURNER_COLLISION_HEIGHT, BURNER_DAMAGE)

; draw a sprite into a backbuffer
; in:
; de - ptr to char_draw_ptr
burner_draw:
			lhld burner_get_scr_addr
			lda burner_ram_disk_s_cmd
			jmp actor_draw
