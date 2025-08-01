@memusage_snowflake
;=================================================
; statuses.
; a status describes what set of animations and behavior is active
; for ex. ACTOR_STATUS_HERO_ATTACK plays hero_attk_r or hero_attk_l depending on the direction and it spawns a weapon trail
SNOWFLAKE_STATUS_ATTACK = 0

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

SNOWFLAKE_SPEED		= $300

snowflake_init:
			; advance hl to bullet_pos_x+1
			lxi h, hero_pos_x+1
			mov b, m
			; advance hl to bullet_pos_y+1
			INX_H(2)
			mov c, m
			; bc - hero_pos
			BULLET_INIT(snowflake_update, snowflake_draw, ACTOR_STATUS_BIT_INVIS, SNOWFLAKE_STATUS_INVIS_TIME, snowflake_run_anim, snowflake_init_speed)
; the move dir along with the hero dir
; in:
; de - ptr to bullet_speed_x
snowflake_init_speed:
			xchg
			; hl - ptr to bullet_speed_x
			; check hero's horizontal direction
			lxi b, hero_dir
			ldax b
			ani HERO_DIR_HORIZ_MASK
			cpi HERO_DIR_LEFT ; check the dir_h bit. if it is disabled, no horiz move.
			lxi d, 0
			jc @set_speed_x
			LXI_D_NEG(SNOWFLAKE_SPEED)
			jz @set_speed_x
			lxi d, SNOWFLAKE_SPEED
@set_speed_x:
			call @set_speed

			; check hero's vertical direction
@check_dir_vert:
			ldax b
			ani HERO_DIR_VERT_MASK
			cpi HERO_DIR_DOWN ; check the dir_v bit. if it is disabled, no vert move.
			lxi d, 0
			jc @set_speed
			LXI_D_NEG(SNOWFLAKE_SPEED)
			jz @set_speed
			lxi d, SNOWFLAKE_SPEED
@set_speed:
			mov m, e
			inx h
			mov m, d
			inx h
			ret

; anim and a gameplay logic update
; in:
; de - ptr to bullet_update_ptr
snowflake_update:
			; advance to bullet_status
			HL_ADVANCE(bullet_update_ptr, bullet_status, BY_HL_FROM_DE)
			mov a, m
			ani ACTOR_STATUS_BIT_INVIS
			jnz @delay_update

			; hl - ptr to bullet_status
			; advance hl and decr bullet_status_timer
			inx h
			shld @die_after_char_collides+1
			; check if it's time to die
			dcr m
			jz @die_over_time
@update_movement:
			ACTOR_UPDATE_MOVEMENT_CHECK_TILE_COLLISION(SNOWFLAKE_COLLISION_WIDTH, SNOWFLAKE_COLLISION_HEIGHT, @die)

			; hl points to bullet_pos_y+1
			; advance hl to bullet_anim_timer
			L_ADVANCE(bullet_pos_y+1, bullet_anim_timer, BY_A)
			mvi a, SNOWFLAKE_ANIM_SPEED_ATTACK
			call actor_anim_update
			; hl points to bullet_anim_ptr
@check_char_collision:
			; check sprite collision
			; hl - ptr to bullet_anim_ptr
			; advance hl to bullet_pos_x+1
			L_ADVANCE(bullet_anim_ptr, bullet_pos_x+1, BY_A)
			; add a collision offset
			mov d, m
			INX_H(2)
			mov e, m
			lxi h, SNOWFLAKE_COLLISION_OFFSET_X<<8 | SNOWFLAKE_COLLISION_OFFSET_Y
			dad d

			; store pos_xy
			push h
			; check if a bullet collides with a enemy
			mvi a, SNOWFLAKE_COLLISION_WIDTH-1
			lxi b, CHAR_TYPE_ALL<<8 | SNOWFLAKE_COLLISION_HEIGHT-1
			call chars_get_first_collided

			; hl - ptr to a collided char_update_ptr+1
			mov a, m
			cpi ACTOR_RUNTIME_DATA_DESTR
			pop d
			; de - pos_xy
			; if a char's not alive or no char, return
			rnc
.breakpoint:

			; advance hl to char_impacted_ptr
			HL_ADVANCE(char_update_ptr+1, char_impacted_ptr, BY_BC)
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
			; hl - ptr to bullet_status_timer
			lxi h, TEMP_ADDR
@die_over_time:
			; hl - ptr to bullet_status_timer
			L_ADVANCE(bullet_status_timer, bullet_update_ptr+1, BY_A)
			ACTOR_DESTROY()
			ret
@die:
			; hl - ptr to bullet_pos_x
			L_ADVANCE(bullet_pos_x, bullet_update_ptr+1, BY_A)
			ACTOR_DESTROY()
			ret

@delay_update:
			; hl - ptr to bullet_status
			; advance and decr bullet_status_timer
			inx h
			dcr m
			rnz

			; hl - ptr to bullet_status_duration
			; set the attack
			mvi m, SNOWFLAKE_STATUS_ATTACK_TIME
			; advance and set bullet_status
			dcx h
			mvi m, SNOWFLAKE_STATUS_ATTACK
			ret


; draw a sprite into a backbuffer
; in:
; de - ptr to bullet_draw_ptr
snowflake_draw:
			lhld snowflake_get_scr_addr
			lda snowflake_ram_disk_s_cmd
			jmp actor_draw