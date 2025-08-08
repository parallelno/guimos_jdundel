@memusage_snowflake
;=================================================
; statuses.
; a status describes what set of animations and behavior is active
; for ex. ACTOR_STATUS_HERO_ATTACK plays hero_attk_r or hero_attk_l depending on the direction and it spawns a weapon trail
SNOWFLAKE_STATUS_ATTACK = ACTOR_STATUS_INIT

; duration of statuses (in update_durations)
SNOWFLAKE_STATUS_INVIS_TIME		= 6
SNOWFLAKE_STATUS_ATTACK_TIME	= 30

; animation speed (the less the slower, 0-255, 255 means next frame every update)
SNOWFLAKE_ANIM_SPEED_ATTACK	= 90

; gameplay
SNOWFLAKE_COLLISION_WIDTH	= 12
SNOWFLAKE_COLLISION_HEIGHT	= 12

SNOWFLAKE_COLLISION_OFFSET_X = <(-3)
SNOWFLAKE_COLLISION_OFFSET_Y = <(0)

SNOWFLAKE_SPEED			= $300

/*
TODO:
1. combine overlay_init/vfx_init/vfx4_init/char_init
4. update all relative inits to use new overlay_init/vfx_init/vfx4_init/char_init
*/
snowflake_init:
			; check hero's vertical direction
			lxi b, hero_dir
			ldax b
			call @init_speed
			xchg
			; de - speed_x

			; check hero's vertical direction
			ldax b
			RRC_(2)
			call @init_speed
			; speed_y
			push h
			; speed_x
			push d

			; pos_xy
			lxi h, hero_pos_x + 1
			mov b, m
			HL_ADVANCE(hero_pos_x + 1, hero_pos_y + 1)
			mov c, m
			; add a init projectile offset
			lxi h, HERO_PROJECTILE_OFFSET_X<<8 | HERO_PROJECTILE_OFFSET_Y
			dad b
			push h
			; OVERLAY_ANIM_PTR
			lxi h, snowflake_run_anim
			push h
			; OVERLAY_STATUS | OVERLAY_STATUS_TIMER<<8
			lxi h, SNOWFLAKE_STATUS_INVIS_TIME<<8 | ACTOR_STATUS_BIT_INVIS
			push h
			; OVERLAY_DRAW_PTR
			lxi h, snowflake_draw
			push h
			; OVERLAY_UPDATE_PTR
			lxi b, snowflake_update
			jmp overlay_init

; defines the horizontal/vertical speed
; in:
; a - hero_dir (0 - no move, %11 - right/up, %10 - left/down)
; out:
; hl - speed
@init_speed:
			; check the dir bit
			ani HERO_DIR_HORIZ_MASK ; mask out dir bits
			cpi HERO_DIR_LEFT
			LXI_H_NEG(SNOWFLAKE_SPEED)
			rz
			lxi h, SNOWFLAKE_SPEED
			rnc
			lxi h, 0 ; speed=0
			ret

; anim and a gameplay logic update
; in:
; de - ptr to overlay_update_ptr
snowflake_update:
			; advance to overlay_status
			HL_ADVANCE(overlay_update_ptr, overlay_status, BY_HL_FROM_DE)
			mov a, m
			ani ACTOR_STATUS_BIT_INVIS
			jnz @delay_update

			; hl - ptr to overlay_status
			; advance hl and decr overlay_status_timer
			inx h
			shld @die_after_char_collides + 1
			; check if it's time to die
			dcr m
			jz @die_over_time
@update_movement:
			ACTOR_UPDATE_MOVEMENT_CHECK_TILE_COLLISION(SNOWFLAKE_COLLISION_WIDTH, SNOWFLAKE_COLLISION_HEIGHT, @die)

			; hl points to overlay_pos_y + 1
			; advance hl to overlay_anim_timer
			L_ADVANCE(overlay_pos_y + 1, overlay_anim_timer, BY_A)
			mvi a, SNOWFLAKE_ANIM_SPEED_ATTACK
			call actor_anim_update
			; hl points to overlay_anim_ptr
@check_char_collision:
			; check sprite collision
			; hl - ptr to overlay_anim_ptr
			; advance hl to overlay_pos_x + 1
			L_ADVANCE(overlay_anim_ptr, overlay_pos_x + 1, BY_A)
			; add a collision offset
			mov d, m
			INX_H(2)
			mov e, m
			lxi h, SNOWFLAKE_COLLISION_OFFSET_X<<8 | SNOWFLAKE_COLLISION_OFFSET_Y
			dad d

			; store pos_xy
			push h
			; check if a overlay collides with a enemy
			mvi a, SNOWFLAKE_COLLISION_WIDTH-1
			lxi b, CHAR_TYPE_ALL<<8 | SNOWFLAKE_COLLISION_HEIGHT-1
			call chars_get_first_collided

			; hl - ptr to a collided char_update_ptr + 1
			mov a, m
			cpi ACTOR_RUNTIME_DATA_DESTR
			pop d
			; de - pos_xy
			; if a char's not alive or no char, return
			rnc

			; advance hl to char_impacted_ptr
			HL_ADVANCE(char_update_ptr + 1, char_impacted_ptr, BY_BC)
			mov e, m
			inx h
			mov d, m
			xchg
			; call a char_impact func
			lxi b, @die_after_char_collides
			push b
			mvi c, HERO_WEAPON_ID_SNOWFLAKE
			pchl
@die_after_char_collides:
			; hl - ptr to overlay_status_timer
			lxi h, TEMP_ADDR
@die_over_time:
			; hl - ptr to overlay_status_timer
			L_ADVANCE(overlay_status_timer, overlay_update_ptr + 1, BY_A)
			ACTOR_DESTROY()
			ret
@die:
			; hl - ptr to overlay_pos_x
			L_ADVANCE(overlay_pos_x, overlay_update_ptr + 1, BY_A)
			ACTOR_DESTROY()
			ret

@delay_update:
			; hl - ptr to overlay_status
			; advance and decr overlay_status_timer
			inx h
			dcr m
			rnz

			; hl - ptr to overlay_status_duration
			; set the attack
			mvi m, SNOWFLAKE_STATUS_ATTACK_TIME
			; advance and set overlay_status
			dcx h
			mvi m, SNOWFLAKE_STATUS_ATTACK
			ret


; draw a sprite into a backbuffer
; in:
; de - ptr to overlay_draw_ptr
snowflake_draw:
			lhld snowflake_get_scr_addr
			lda snowflake_ram_disk_s_cmd
			jmp actor_draw