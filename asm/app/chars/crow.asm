@memusage_crow


; statuses.
; personal actor statuses must be in a range of 0 to ACTOR_STATUS_CUSTOM including.
ACTOR_STATUS_CROW_CHECK_SCARE		= ACTOR_STATUS_INIT
ACTOR_STATUS_CROW_RELAX_INIT		= 1
ACTOR_STATUS_CROW_RELAX				= 2
ACTOR_STATUS_CROW_MOVE_INIT			= 3
ACTOR_STATUS_CROW_MOVE				= 4
ACTOR_STATUS_CROW_ESCAPE_INIT		= 5 ; after being scared by the scarecrow
ACTOR_STATUS_CROW_ESCAPE			= 6

; status duration in updates.
ACTOR_STATUS_CROW_RELAX_TIME		= 25
ACTOR_STATUS_CROW_MOVE_TIME			= 60

; animation speed (the less the slower, 0-255, 255 means the next frame is almost every update)
CROW_ANIM_SPEED_RELAX		= 20
CROW_ANIM_SPEED_MOVE		= 60
CROW_ANIM_SPEED_ESCAPE		= 200

; gameplay
CROW_DAMAGE = 1
CROW_HEALTH = 6

CROW_COLLISION_WIDTH	= 15
CROW_COLLISION_HEIGHT	= 10

CROW_MOVE_SPEED		= $0100
CROW_MOVE_SPEED_NEG	= $ffff - $100 + 1
CROW_ESCAPE_SPEED	= $0200

;========================================================
; spawn and init a char
; in:
; c - tile_idx in the room_tiledata array.
; a - char_id * 4
; out:
; a = TILEDATA_RESTORE_TILE
crow_init:
			CHAR_INIT(crow_update, npc4_draw, char_impacted, CROW_HEALTH, ACTOR_STATUS_CROW_CHECK_SCARE, npc4_crow_idle_anim)

; uppdate for CROW_ID
; anim and a gameplay logic update
; in:
; de - ptr to char_update_ptr
crow_update:
			; advance hl to char_status
			HL_ADVANCE(char_update_ptr, char_status, BY_HL_FROM_DE)
			mov a, m
			cpi ACTOR_STATUS_CROW_MOVE
			jz crow_update_move
			cpi ACTOR_STATUS_CROW_RELAX
			jz crow_update_relax
			cpi ACTOR_STATUS_CROW_MOVE_INIT
			jz crow_update_move_init
			cpi ACTOR_STATUS_CROW_RELAX_INIT
			jz crow_update_relax_init
			cpi ACTOR_STATUS_CROW_ESCAPE
			jz crow_update_escape
			cpi ACTOR_STATUS_CROW_ESCAPE_INIT
			jz crow_update_escape_init
			cpi ACTOR_STATUS_CROW_CHECK_SCARE
			jz crow_update_check_scare_init
			cpi ACTOR_STATUS_FREEZE
			jz char_update_freeze
			ret

; in:
; hl - ptr to char_status
crow_update_check_scare_init:
			; hl = char_status
			lda game_status_bob
			cpi BOB_STATUS_SET_SCARECROW
			jc crow_update_relax_init
			; die because it's gone
			HL_ADVANCE(char_status, char_update_ptr+1)
			jmp char_destroy

crow_update_relax_init:
			mvi m, ACTOR_STATUS_CROW_RELAX
			inx h
			mvi m, ACTOR_STATUS_CROW_RELAX_TIME
			HL_ADVANCE(char_status_timer, char_anim_ptr)
			mvi m, <npc4_crow_idle_anim
			inx h
			mvi m, >npc4_crow_idle_anim
			ret

; in:
; hl - ptr to char_status
crow_update_move_init:
			mvi m, ACTOR_STATUS_CROW_MOVE

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
			mvi m, <CROW_MOVE_SPEED_NEG
			inx h
			mvi m, >CROW_MOVE_SPEED_NEG
			jmp @set_anim
@speed_y_positive:
			mov m, c
			inx h
			mov m, c
			inx h
			mvi m, <CROW_MOVE_SPEED
			inx h
			mvi m, >CROW_MOVE_SPEED
			jmp @set_anim
@speed_x_negative:
			mvi m, <CROW_MOVE_SPEED_NEG
			inx h
			mvi m, >CROW_MOVE_SPEED_NEG
			inx h
			mov m, c
			inx h
			mov m, c
			jmp @set_anim
@speed_x_positive:
			mvi m, <CROW_MOVE_SPEED
			inx h
			mvi m, >CROW_MOVE_SPEED
			inx h
			mov m, c
			inx h
			mov m, c
@set_anim:
			HL_ADVANCE(char_speed_y+1, char_anim_ptr, BY_BC)
			; a = rnd
			CPI_ZERO()
			; if rnd is positive (up or right movement), then play npc4_crow_run_l_anim anim
			jp @set_anim_run_r
@set_anim_run_l:
			mvi m, <npc4_crow_run_l_anim
			inx h
			mvi m, >npc4_crow_run_l_anim
			ret
@set_anim_run_r:
			mvi m, <npc4_crow_run_r_anim
			inx h
			mvi m, >npc4_crow_run_r_anim
            ret

; in:
; hl - ptr to char_status
crow_update_move:
			; check the scarecrow
			lda game_status_bob
			cpi BOB_STATUS_SET_SCARECROW
			jc @not_scared
			; scared
			mvi m, ACTOR_STATUS_CROW_ESCAPE_INIT
			ret

@not_scared:
			; advance hl to char_status_timer
			inx h
			dcr m
			jz @set_relax_init

@update_movement:
			ACTOR_UPDATE_MOVEMENT_CHECK_TILE_COLLISION(CROW_COLLISION_WIDTH, CROW_COLLISION_HEIGHT, @set_move_init)

			; hl points to char_pos_y+1
			; advance hl to char_anim_timer
			HL_ADVANCE(char_pos_y+1, char_anim_timer, BY_BC)
			mvi a, CROW_ANIM_SPEED_MOVE
			jmp crow_update_anim_check_collision_hero

@set_move_init:
			; hl points to char_pos_x
			; advance hl to char_status
			HL_ADVANCE(char_pos_x, char_status, BY_BC)
			mvi m, ACTOR_STATUS_CROW_MOVE_INIT
			inx h
			mvi m, ACTOR_STATUS_CROW_MOVE_TIME
			ret
@set_relax_init:
 			; hl - ptr to char_status_timer
			; advance hl to char_status
			dcx h
			mvi m, ACTOR_STATUS_CROW_RELAX_INIT
			ret

; in:
; hl - ptr to char_status
crow_update_relax:
			; hl = char_status
			; advance hl to char_status_timer
			inx h
			dcr m
			jz @set_move_init
			; advance hl to char_anim_timer
			HL_ADVANCE(char_status_timer, char_anim_timer)
			mvi a, CROW_ANIM_SPEED_RELAX
			jmp crow_update_anim_check_collision_hero
 @set_move_init:
 			; hl - ptr to char_status_timer
			mvi m, ACTOR_STATUS_CROW_MOVE_TIME
			; advance hl to char_status
			dcx h
			mvi m, ACTOR_STATUS_CROW_MOVE_INIT
			ret

; in:
; hl - ptr to char_status
crow_update_escape_init:
			; hl = char_status
			mvi m, ACTOR_STATUS_CROW_ESCAPE

			; set a vertical random speed
			HL_ADVANCE(char_status, char_speed_x, BY_BC)
			; double the horizontal speed
			mov a, m
			add a
			mov m, a
			HL_ADVANCE(char_speed_x, char_speed_y)
			mvi m, <CROW_ESCAPE_SPEED
			HL_ADVANCE(char_speed_y, char_speed_y+1)
			mvi m, >CROW_ESCAPE_SPEED
			ret

; in:
; hl - ptr to char_status
crow_update_escape:
			; if it collides with the room border, die
			HL_ADVANCE(char_status, char_pos_x+1, BY_BC)
			lxi d, CROW_COLLISION_WIDTH<<8 | CROW_COLLISION_HEIGHT
			call room_check_border
			; CY is set if collides
			; hl - actor_pos_y+1
			jc @die

@apply_movement:
			HL_ADVANCE(char_pos_y+1, char_status_timer, BY_BC)
			call actor_move
			; hl - ptr to char_pos_x+1
			; advance hl to char_anim_timer
			HL_ADVANCE(char_pos_x+1, char_anim_timer, BY_BC)
			mvi a, BURNER_ANIM_SPEED_DASH
			jmp actor_anim_update
@die:
			HL_ADVANCE(char_pos_y+1, char_update_ptr+1, BY_BC)
			jmp char_destroy

; in:
; hl - char_anim_timer
; a - anim speed
crow_update_anim_check_collision_hero:
			call actor_anim_update
			CHAR_CHECK_COLLISION_HERO(CROW_COLLISION_WIDTH, CROW_COLLISION_HEIGHT, CROW_DAMAGE)
