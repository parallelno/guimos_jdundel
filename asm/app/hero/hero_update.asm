@memusage_hero_update
.include "app/hero/hero_attack.asm"
.include "app/hero/hero_update_dead.asm"

; advances the current animation to the next frame
.macro HERO_UPDATE_ANIM(anim_speed)
			lxi h, hero_anim_timer
			mov a, m
			adi anim_speed
			mov m, a
			jnc @skipAnimUpdate
			lhld hero_anim_ptr
			mov e, m
			inx h
			mov d, m
			dad d
			shld hero_anim_ptr
@skipAnimUpdate:
.endmacro

hero_update:
			lxi h, hero_status
			mov a, m
			ani ~ACTOR_STATUS_BITS

			; call hero_check_keys if the status
			; ACTOR_STATUS_HERO_IDLE or
			; ACTOR_STATUS_HERO_MOVE or
			; ACTOR_STATUS_HERO_INVINCIBLE
			cpi ACTOR_STATUS_HERO_INVINCIBLE + 1
			jc hero_check_keys

			cpi ACTOR_STATUS_HERO_ATTACK
			jz hero_attack_update
			cpi ACTOR_STATUS_KICKOFF
			jz hero_kickoff_update
			cpi ACTOR_STATUS_HERO_DEATH_WAIT_SPARKER + 1
			jc hero_dead
			ret


hero_check_keys:
			; check if an attack key is pressed
			lhld action_code
			; h - action_code_old
			; l - action_code

			mvi a, CONTROL_CODE_FIRE1
			ana l
			jnz hero_attack_init

			mvi a, CONTROL_CODE_FIRE2
			ana l
			jz @arrow_key_handling
@fire2_handling:
			; a = CONTROL_CODE_FIRE2
			ana h
			; call only if CONTROL_CODE_FIRE2 was pressed now and the last time
			; TODO: check if it's really necessary to check the last time
			jz game_ui_res_select_next

@arrow_key_handling:
			mvi a, CONTROL_CODE_LEFT | CONTROL_CODE_RIGHT | CONTROL_CODE_UP | CONTROL_CODE_DOWN
			ana l
			jz hero_idle_update ; if no arrow key is pressed, handle IDLE

			; some arrow keys got pressed
			; if the status was idle last time, check the pressed keys
			lda hero_status
			cpi ACTOR_STATUS_HERO_IDLE
			jz @check_move_keys

			; if not the same keys were pressed the prev update
			mov a, l
			cmp h
			jnz @check_move_keys

			; continue the same direction
			HERO_UPDATE_ANIM(HERO_ANIM_SPEED_MOVE)
			jmp hero_update_temp_pos

@check_move_keys:
			mvi a, ACTOR_STATUS_HERO_MOVE
			sta hero_status

			mov a, l
@set_anim_run_r:
			cpi CONTROL_CODE_RIGHT
			jnz @setAnimRunRU

			lxi h, HERO_RUN_SPEED
			shld hero_speed_x
			lxi h, 0
			shld hero_speed_y

			lxi h, hero_dir
			mov a, m
			ani HERO_DIR_HORIZ_RESET
			ori HERO_DIR_RIGHT
			mov m, a

			lxi h, hero_run_r_anim
			shld hero_anim_ptr
			jmp hero_update_temp_pos

@setAnimRunRU:
			cpi CONTROL_CODE_RIGHT | CONTROL_CODE_UP
			jnz @setAnimRunRD

			lxi h, HERO_RUN_SPEED_D
			shld hero_speed_x
			shld hero_speed_y

			mvi a, HERO_DIR_RIGHT | HERO_DIR_UP
			sta hero_dir
			lxi h, hero_run_r_anim
			shld hero_anim_ptr
			jmp hero_update_temp_pos

@setAnimRunRD:
			cpi CONTROL_CODE_RIGHT | CONTROL_CODE_DOWN
			jnz @set_anim_run_l

			lxi h, HERO_RUN_SPEED_D
			shld hero_speed_x
			LXI_H_NEG(HERO_RUN_SPEED_D)
			shld hero_speed_y

			mvi a, HERO_DIR_RIGHT | HERO_DIR_DOWN
			sta hero_dir
			lxi h, hero_run_r_anim
			shld hero_anim_ptr
			jmp hero_update_temp_pos

@set_anim_run_l:
			cpi CONTROL_CODE_LEFT
			jnz @setAnimRunLU

			LXI_H_NEG(HERO_RUN_SPEED)
			shld hero_speed_x
			lxi h, 0
			shld hero_speed_y

			lxi h, hero_dir
			mov a, m
			ani HERO_DIR_HORIZ_RESET
			ori HERO_DIR_LEFT
			mov m, a

			lxi h, hero_run_l_anim
			shld hero_anim_ptr
			jmp hero_update_temp_pos

@setAnimRunLU:
			cpi CONTROL_CODE_LEFT | CONTROL_CODE_UP
			jnz @setAnimRunLD

			LXI_H_NEG(HERO_RUN_SPEED_D)
			shld hero_speed_x
			lxi h, HERO_RUN_SPEED_D
			shld hero_speed_y

			mvi a, HERO_DIR_LEFT | HERO_DIR_UP
			sta hero_dir
			lxi h, hero_run_l_anim
			shld hero_anim_ptr
			jmp hero_update_temp_pos

@setAnimRunLD:
			cpi CONTROL_CODE_LEFT | CONTROL_CODE_DOWN
			jnz @setAnimRunU

			LXI_H_NEG(HERO_RUN_SPEED_D)
			shld hero_speed_x
			shld hero_speed_y

			mvi a, HERO_DIR_LEFT | HERO_DIR_DOWN
			sta hero_dir
			lxi h, hero_run_l_anim
			shld hero_anim_ptr
			jmp hero_update_temp_pos

@setAnimRunU:
			cpi CONTROL_CODE_UP
			jnz @setAnimRunD

			lxi h, 0
			shld hero_speed_x
			lxi h, HERO_RUN_SPEED
			shld hero_speed_y

			lxi h, hero_dir
			mov a, m
			ani HERO_DIR_VERT_RESET
			ori HERO_DIR_UP
			mov m, a
			rrc
			jnc @setAnimRunUfaceL

			lxi h, hero_run_r_anim
			shld hero_anim_ptr
			jmp hero_update_temp_pos
@setAnimRunUfaceL:
			lxi h, hero_run_l_anim
			shld hero_anim_ptr
			jmp hero_update_temp_pos
@setAnimRunD:
			cpi CONTROL_CODE_DOWN
			rnz

			lxi h, 0
			shld hero_speed_x
			LXI_H_NEG(HERO_RUN_SPEED)
			shld hero_speed_y

			lxi h, hero_dir
			mov a, m
			ani HERO_DIR_VERT_RESET
			ori HERO_DIR_DOWN
			mov m, a
			rrc
			jnc @setAnimRunDfaceL

			lxi h, hero_run_r_anim
			shld hero_anim_ptr
			jmp hero_update_temp_pos
@setAnimRunDfaceL:
			lxi h, hero_run_l_anim
			shld hero_anim_ptr

hero_update_temp_pos:
			; apply the hero speed
			lhld hero_pos_x
			xchg
			lhld hero_speed_x
			dad d
			shld char_temp_x
			mov b, h
			lhld hero_pos_y
			xchg
			lhld hero_speed_y
			dad d
			shld char_temp_y

			; check the collision tiles
			mov d, b ; pos_x
			mov e, h ; pos_y
			lxi b, (HERO_COLLISION_WIDTH-1)<<8 | HERO_COLLISION_HEIGHT-1
			call room_get_collision_tiledata
			ani TILEDATA_FUNC_MASK
			jz hero_no_collision_no_tiledata ; if there is no tiledata to analize, move a hero and return
			ani TILEDATA_COLLIDABLE
			jz hero_no_collision

@collides:
			; check if there is any collidable tiledata
			; hl - (top-left), (top-right)
			; de - (bottom-left), (bottom-right)
			; hero collision ptr bit layout:
			; (bottom-left), (bottom-right), (top_right), (top-left), 0, 0

			; check the bottom-left corner
			mvi b, 256-TILEDATA_COLLIDABLE
			mov a, e
			add b
			mvi a, 0
			ral
			mov c, a

			; check the bottom-right corner
			mov a, d
			add b
			mov a, c
			ral
			mov c, a

			; check the top-right corner
			mov a, h
			add b
			mov a, c
			ral
			mov c, a

			; check the top-left corner
			mov a, l
			add b
			mov a, c
			ral

			; handle a collision data around a hero
			; if a hero is inside the collision, move him out
			ADD_A(2) ; to make a jmp table ptr with a 4 byte allignment
			mov c, a
			mvi b, 0
			lxi h, hero_collision_func_table
			dad b
			pchl

; handle tiledata around a hero.
hero_check_tiledata:
			lxi h, hero_pos_x + 1
			mov d, m
			HL_ADVANCE(hero_pos_x + 1, hero_pos_y + 1)
			mov e, m
			TILEDATA_HANDLING(HERO_COLLISION_WIDTH, HERO_COLLISION_HEIGHT, hero_tile_func_tbl)
			ret


hero_idle_init:
			; set status
			mvi a, ACTOR_STATUS_HERO_IDLE
			sta hero_status
			jmp hero_idle_anim_start

hero_idle_anim_start:
			; reset the anim timer
			A_TO_ZERO(NULL)
			sta hero_anim_timer

			; speed = 0
			lxi h, 0
			shld hero_speed_x
			shld hero_speed_y
			; set direction
			lda hero_dir
			rrc
			jnc @setAnimIdleL

			lxi h, hero_idle_r_anim
			shld hero_anim_ptr
			ret
@setAnimIdleL:
			lxi h, hero_idle_l_anim
			shld hero_anim_ptr
			ret

; in:
; h - action_code_old
; l - action_code
hero_idle_update:
			; no key pressed now. check the last one
			mov a, l
			cmp h
			; if the last time a key was pressed, start idle
			jnz hero_idle_init
			; or continue idle
			HERO_UPDATE_ANIM(HERO_ANIM_SPEED_IDLE)

			; handle invincibility
			lxi h, hero_status
			mov a, m
			ani ACTOR_STATUS_HERO_INVINCIBLE
			jnz hero_invincible_update
			ret


; called by a char's bullet, a char, etc. to affect a hero
; handling the damage
; in:
; c - damage (positive number)
; uses:
; a, hl, de
hero_impacted:
.if DEBUG
			ret
.endif
			; to make sure the impact once per upcomming damage
			lda hero_status
			ani ACTOR_STATUS_BIT_INVINCIBLE
			rnz

			; c - damage
			lxi h, hero_res_health
			mov a, m
			sub c
			; clamp to 0
			jnc @no_clamp
			A_TO_ZERO(0)
@no_clamp:
			mov m, a
			jnz @not_dead
			; dead
			mvi a, ACTOR_STATUS_HERO_DEATH_FADE_INIT_GB
			sta hero_status
			jmp @sfx
@not_dead:
			call hero_kickoff_init
@sfx:
			; SFX
			lxi h, sfx_bomb_attack
			call v6_sfx_play

			jmp game_ui_draw_health_text


; sets the kick off backward movement
; uses:
; hl, de, a
hero_kickoff_init:
			; set the status
			lxi h, hero_status
			mvi m, ACTOR_STATUS_BIT_INVINCIBLE | ACTOR_STATUS_KICKOFF

			HL_ADVANCE(hero_status, hero_status_timer)
			mvi m, HERO_STATUS_KICKOFF_DURATION

			; set backward speed
			; check hero's horizontal direction
			lxi d, hero_dir
			ldax d
			ani HERO_DIR_HORIZ_MASK
			jz @no_horiz_move
			rrc
			lxi h, HERO_RUN_SPEED_IMPACTED_N
			jc @set_speed_x
			lxi h, HERO_RUN_SPEED_IMPACTED
@set_speed_x:
			shld hero_speed_x

			; check hero's vertical direction
@check_dir_vert:
			ldax d
			ani HERO_DIR_VERT_MASK
			jz @no_vert_move
			RRC_(3)
			lxi h, HERO_RUN_SPEED_IMPACTED_N
			jc @set_speed_y
			lxi h, HERO_RUN_SPEED_IMPACTED
@set_speed_y:
			shld hero_speed_y
			ret
@no_horiz_move:
			lxi h, 0
			jmp @set_speed_x
@no_vert_move:
			lxi h, 0
			jmp @set_speed_y

; backward movement
; in:
; hl - points to hero_status
hero_kickoff_update:
			call hero_blink
			; hl - points to hero_status
			HL_ADVANCE(hero_status, hero_status_timer)
			dcr m
			jz hero_invincible_init
			; move the hero
			jmp hero_update_temp_pos

; indicates invincibility. it periodicly changes visibility
; in:
; hl - points to hero_status
hero_blink:
@state_blink:
			mvi a, %01010101
 			rrc
 			sta @state_blink + 1
			rnc
			; invert the visibility bit
			mov a, m
			xri ACTOR_STATUS_BIT_INVIS
			mov m, a
			ret

; a hero remins invincible after kickoff
; until the timer is off or the player press the button
hero_invincible_init:
			; set the status
			lxi h, hero_status
			mvi m, ACTOR_STATUS_BIT_INVINCIBLE | ACTOR_STATUS_HERO_INVINCIBLE

			HL_ADVANCE(hero_status, hero_status_timer)
			mvi m, HERO_STATUS_INVINCIBLE_DURATION

			; reset key data to prevent a pressing repetition pattern in the next update
			A_TO_ZERO(CONTROL_CODE_NO)
			sta action_code
			jmp hero_idle_anim_start

; invincible mode until the timer is off or the player press the button
; in:
; hl - points to hero_status
hero_invincible_update:
			call hero_blink
			; hl - points to hero_status
			HL_ADVANCE(hero_status, hero_status_timer)
			dcr m
			rnz
			jmp hero_idle_init