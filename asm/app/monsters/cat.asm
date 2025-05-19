memusage_cat:


; statuses.
; personal actor statuses must be in a range of 0 to ACTOR_STATUS_CUSTOM including.
ACTOR_STATUS_CAT_DETECT_HERO_INIT	= ACTOR_STATUS_INIT
ACTOR_STATUS_CAT_DETECT_HERO			= 1 * JMP_4_LEN ; TODO: why * JMP_4_LEN???
ACTOR_STATUS_CAT_DASH_PREP			= 2 * JMP_4_LEN
ACTOR_STATUS_CAT_DASH				= 3 * JMP_4_LEN
ACTOR_STATUS_CAT_RELAX				= 4 * JMP_4_LEN
ACTOR_STATUS_CAT_MOVE_INIT			= 5 * JMP_4_LEN
ACTOR_STATUS_CAT_MOVE				= 6 * JMP_4_LEN

; status duration in updates.
ACTOR_STATUS_CAT_DETECT_HERO_TIME	= 50
ACTOR_STATUS_CAT_DASH_PREP_TIME		= 10
ACTOR_STATUS_CAT_DASH_TIME			= 16
ACTOR_STATUS_CAT_RELAX_TIME			= 25
ACTOR_STATUS_CAT_MOVE_TIME			= 60

; animation speed (the less the slower, 0-255, 255 means the next frame is almost every update)
CAT_ANIM_SPEED_DETECT_HERO	= 50
CAT_ANIM_SPEED_RELAX			= 20
CAT_ANIM_SPEED_MOVE			= 60
CAT_ANIM_SPEED_DASH_PREP		= 100
CAT_ANIM_SPEED_DASH			= 150

; gameplay
CAT_DAMAGE = 1
CAT_HEALTH = 6

CAT_COLLISION_WIDTH	= 15
CAT_COLLISION_HEIGHT	= 10

CAT_MOVE_SPEED		= $0100
CAT_MOVE_SPEED_NEG	= $ffff - $100 + 1

CAT_DETECT_HERO_DISTANCE = 60

;========================================================
; spawn and init a monster
; in:
; c - tile_idx in the room_tiledata array.
; a - monster_id * 4
; out:
; a = TILEDATA_RESTORE_TILE
cat_init:
			MONSTER_INIT(cat_update, cat_draw, monster_impacted, CAT_HEALTH, ACTOR_STATUS_CAT_DETECT_HERO_INIT, cat_idle_anim)

; uppdate for CAT_ID
; anim and a gameplay logic update
; in:
; de - ptr to monster_update_ptr 
cat_update:
			; advance hl to monster_status
			HL_ADVANCE(monster_update_ptr, monster_status, BY_HL_FROM_DE)
			mov a, m
			cpi ACTOR_STATUS_CAT_MOVE
			jz cat_update_move
			cpi ACTOR_STATUS_CAT_DETECT_HERO
			jz cat_update_detect_hero
			cpi ACTOR_STATUS_CAT_DASH
			jz cat_update_dash		
			cpi ACTOR_STATUS_CAT_RELAX
			jz cat_update_relax
			cpi ACTOR_STATUS_CAT_DASH_PREP
			jz cat_update_dash_prep
			cpi ACTOR_STATUS_CAT_MOVE_INIT
			jz cat_update_move_init
			cpi ACTOR_STATUS_CAT_DETECT_HERO_INIT
			jz cat_update_detect_hero_init
			cpi ACTOR_STATUS_FREEZE
			jz cat_update_freeze
			ret

; cat is immune to freeze
; in:
; hl - ptr to monster_status
cat_update_freeze:
			mvi m, ACTOR_STATUS_CAT_DETECT_HERO_INIT
			ret

; in:
; hl - ptr to monster_status
cat_update_detect_hero_init:
			; hl = monster_status
			mvi m, ACTOR_STATUS_CAT_DETECT_HERO
			inx h
			mvi m, ACTOR_STATUS_CAT_DETECT_HERO_TIME
			HL_ADVANCE(monster_status_timer, monster_anim_ptr)
			mvi m, <cat_idle_anim
			inx h
			mvi m, >cat_idle_anim
			ret

; in:
; hl - ptr to monster_status
cat_update_detect_hero:
			MONSTER_UPDATE_DETECT_HERO(CAT_DETECT_HERO_DISTANCE, ACTOR_STATUS_CAT_DASH_PREP, ACTOR_STATUS_CAT_DASH_PREP_TIME, cat_run_l_anim, CAT_ANIM_SPEED_DETECT_HERO, cat_update_anim_check_collision_hero, ACTOR_STATUS_CAT_MOVE_INIT, ACTOR_STATUS_CAT_MOVE_TIME)

; in:
; hl - ptr to monster_status
cat_update_move_init:
			mvi m, ACTOR_STATUS_CAT_MOVE

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
			mvi m, <CAT_MOVE_SPEED_NEG
			inx h
			mvi m, >CAT_MOVE_SPEED_NEG
			jmp @set_anim
@speed_y_positive:
			mov m, c
			inx h
			mov m, c
			inx h
			mvi m, <CAT_MOVE_SPEED
			inx h
			mvi m, >CAT_MOVE_SPEED
			jmp @set_anim
@speed_x_negative:
			mvi m, <CAT_MOVE_SPEED_NEG
			inx h
			mvi m, >CAT_MOVE_SPEED_NEG
			inx h
			mov m, c
			inx h
			mov m, c
			jmp @set_anim
@speed_x_positive:
			mvi m, <CAT_MOVE_SPEED
			inx h
			mvi m, >CAT_MOVE_SPEED
			inx h
			mov m, c
			inx h
			mov m, c
@set_anim:
			HL_ADVANCE(monster_speed_y+1, monster_anim_ptr, BY_BC)
			; a = rnd
			CPI_ZERO()
			; if rnd is positive (up or right movement), then play cat_run_r anim
			jp @set_anim_run_r
@set_anim_run_l:
			mvi m, <cat_run_l_anim
			inx h
			mvi m, >cat_run_l_anim
			ret
@set_anim_run_r:
			mvi m, <cat_run_r_anim
			inx h
			mvi m, >cat_run_r_anim
            ret

; in:
; hl - ptr to monster_status
cat_update_move:
			; advance hl to monster_status_timer
			inx h
			dcr m
			jz @set_detect_hero_init
@update_movement:
			ACTOR_UPDATE_MOVEMENT_CHECK_TILE_COLLISION(monster_status_timer, monster_pos_x, CAT_COLLISION_WIDTH, CAT_COLLISION_HEIGHT, @set_move_init) 
			
			; hl points to monster_pos_y+1
			; advance hl to monster_anim_timer
			HL_ADVANCE(monster_pos_y+1, monster_anim_timer, BY_BC)
			mvi a, CAT_ANIM_SPEED_MOVE
			jmp cat_update_anim_check_collision_hero

@set_move_init:
			; hl points to monster_pos_x
			; advance hl to monster_status
			HL_ADVANCE(monster_pos_x, monster_status, BY_BC)
			mvi m, ACTOR_STATUS_CAT_MOVE_INIT
			inx h
			mvi m, ACTOR_STATUS_CAT_MOVE_TIME
			ret
@set_detect_hero_init:
 			; hl - ptr to monster_status_timer
			; advance hl to monster_status
			dcx h
			mvi m, ACTOR_STATUS_CAT_DETECT_HERO_INIT
			ret

; in:
; hl - ptr to monster_status
cat_update_relax:
			; hl = monster_status
			; advance hl to monster_status_timer
			inx h
			dcr m
			jz @set_move_init
			; advance hl to monster_anim_timer
			HL_ADVANCE(monster_status_timer, monster_anim_timer)
			mvi a, CAT_ANIM_SPEED_RELAX
			jmp cat_update_anim_check_collision_hero
 @set_move_init:
 			; hl - ptr to monster_status_timer
			mvi m, ACTOR_STATUS_CAT_MOVE_TIME
			; advance hl to monster_status
			dcx h
			mvi m, ACTOR_STATUS_CAT_MOVE_INIT
			ret

; in:
; hl - ptr to monster_status
cat_update_dash_prep:
			; hl = monster_status
			; advance hl to monster_status_timer
			inx h
			dcr m
			jz @set_dash
			; advance hl to monster_anim_timer
			HL_ADVANCE(monster_status_timer, monster_anim_timer)
			mvi a, CAT_ANIM_SPEED_DASH_PREP
			jmp cat_update_anim_check_collision_hero
 @set_dash:
  			; hl - ptr to monster_status_timer
			mvi m, ACTOR_STATUS_CAT_DASH_TIME
			; advance hl to monster_status
			dcx h
			mvi m, ACTOR_STATUS_CAT_DASH
			; advance hl to monster_pos_x
			HL_ADVANCE(monster_status, monster_pos_x, BY_BC)
			; reset sub pixel pos_x
			mvi m, 0
			; advance hl to pos_x+1
			inx h
			; pos_diff =  hero_pos - catPosX
			; speed = pos_diff / ACTOR_STATUS_CAT_DASH_TIME
			lda hero_pos_x+1
			sub m
			mov e, a 
			mvi a, 0
			; if posDiffX < 0, then d = $ff, else d = 0
			sbb a
			mov d, a
			xchg
			; posDiffX / ACTOR_STATUS_CAT_DASH_TIME 
			dad h 
			dad h 
			dad h 
			dad h
			; to fill up L with %1111 if pos_diff < 0
			ani %1111 ; <(%0000000011111111 / ACTOR_STATUS_CAT_DASH_TIME)
			ora l
			mov l, a
			push h
			xchg
			; advance hl to pos_y
			inx h
			; reset sub pixel pos_y
			mvi m, 0
			; advance hl to pos_y+1
			inx h
			; do the same for Y
			lda hero_pos_y+1
			sub m
			mov e, a 
			mvi a, 0
			; if posDiffY < 0, then d = $ff, else d = 0
			sbb a
			mov d, a 
			xchg
			; posDiffY / ACTOR_STATUS_CAT_DASH_TIME 
			dad h 
			dad h 
			dad h 
			dad h 
			; to fill up L with %1111 if pos_diff < 0
			ani %1111 ; <(%0000000011111111 / ACTOR_STATUS_CAT_DASH_TIME)
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
; hl - ptr to monster_status
cat_update_dash:
			; hl = monster_status
			; advance hl to monster_status_timer
			inx h
			dcr m
			jm @set_move_init
@apply_movement:
			ACTOR_UPDATE_MOVEMENT()
			; hl - ptr to monster_pos_x+1
			; advance hl to monster_anim_timer
			HL_ADVANCE(monster_pos_x+1, monster_anim_timer, BY_BC)
			mvi a, CAT_ANIM_SPEED_DASH
			jmp actor_anim_update
@set_move_init:
			; hl points to monster_status_timer
			mvi m, ACTOR_STATUS_CAT_MOVE_TIME			
			; advance hl to monster_status
			dcx h
			mvi m, ACTOR_STATUS_CAT_MOVE_INIT
			ret	


; in:
; hl - monster_anim_timer
; a - anim speed
cat_update_anim_check_collision_hero:
			call actor_anim_update
			MONSTER_CHECK_COLLISION_HERO(CAT_COLLISION_WIDTH, CAT_COLLISION_HEIGHT, CAT_DAMAGE)

; draw a sprite into a backbuffer
; in:
; de - ptr to monster_draw_ptr 
cat_draw:
			ACTOR_DRAW(sprite_get_scr_addr_npc4, RAM_DISK_S_NPC4, false)
