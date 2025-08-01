@memusage_sword
;=================================================

.include "app/bullets/sword_tile_funcs.asm"

; statuses.
; a status describes what set of animations and behavior is active
; for ex. ACTOR_STATUS_HERO_ATTACK plays hero_attk_r or hero_attk_l depending on the direction and it spawns a weapon trail
SWORD_STATUS_ATTACK = 0

; duration of statuses (in update_durations)
SWORD_STATUS_INVIS_TIME	= 6
SWORD_STATUS_ATTACK_TIME	= 6

; animation speed (the less the slower, 0-255, 255 means next frame every update)
SWORD_ANIM_SPEED_ATTACK	= 150

; gameplay
SWORD_DAMAGE = 1

SWORD_CHAR_COLLISION_WIDTH	= 15
SWORD_CHAR_COLLISION_HEIGHT	= 29
SWORD_CHAR_COLLISION_OFFSET_X_R = 8
SWORD_CHAR_COLLISION_OFFSET_Y_R = <(-7)
SWORD_CHAR_COLLISION_OFFSET_X_L = <(-7)
SWORD_CHAR_COLLISION_OFFSET_Y_L = <(-7)

; funcs to handle the tiledata. tiledata format is in level_data.asm->room_tiledata
sword_tile_func_tbl:
			RET_4()								; func_id == 1 ; spawn a char
			RET_4()								; func_id == 2 ; teleport
			RET_4()								; func_id == 3 ; teleport
			RET_4()								; func_id == 4 ; teleport
			RET_4()								; func_id == 5 ; teleport
			RET_4()								; func_id == 6
			RET_4()								; func_id == 7
			RET_4()								; func_id == 8
			RET_4()								; func_id == 9
			JMP_4( sword_func_triggers)			; func_id == 10
			JMP_4( sword_func_container)		; func_id == 11
			JMP_4( sword_func_door)				; func_id == 12
			JMP_4( sword_func_breakable)		; func_id == 13 ; breakable
			RET_4()								; func_id == 14
			RET_4()								; func_id == 15 ; collision

sword_init:
			lxi h, hero_pos_x + 1
			mov b, m
			HL_ADVANCE(hero_pos_x + 1, hero_pos_y + 1)
			mov c, m
			; bc - hero_pos
			BULLET_INIT(sword_update, sword_draw, ACTOR_STATUS_BIT_INVIS, SWORD_STATUS_INVIS_TIME, NULL, empty_func)


; anim and a gameplay logic update
; in:
; de - ptr to bullet_update_ptr
sword_update:
			; advance to bullet_status
			HL_ADVANCE(bullet_update_ptr, bullet_status, BY_HL_FROM_DE)
			mov a, m
			ani ACTOR_STATUS_BIT_INVIS
			jnz @delay_update

@attk_update:
			; hl - ptr to bullet_status
			; advance and decr bullet_status_timer
			inx h
			; check if it's time to die
			dcr m
			jz @die

@attk_anim_update:
			; advance to bullet_anim_timer
			inx h
			mvi a, SWORD_ANIM_SPEED_ATTACK
			jmp actor_anim_update

@die:
			L_ADVANCE(bullet_status_timer, bullet_update_ptr+1, BY_A)
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
			mvi m, SWORD_STATUS_ATTACK_TIME
			; advance and set bullet_status
			dcx h
			mvi m, SWORD_STATUS_ATTACK

			; advance and reset bullet_anim_timer
			INX_H(2)
			mvi m, 0
			; advance and set bullet_anim_ptr
			inx h
			lda hero_dir
			rrc
			jnc @attkL
@attkR:
			mvi m, < sword_attk_r_anim
			inx h
			mvi m, > sword_attk_r_anim

			; check enemies-sword sprite collision
			L_ADVANCE(bullet_anim_ptr+1, bullet_pos_x+1, BY_A)
			mvi a, HERO_DIR_RIGHT
			jmp sword_check_chars

@attkL:
			mvi m, < sword_attk_l_anim
			inx h
			mvi m, > sword_attk_l_anim

			; check enemies-sword sprite collision
			L_ADVANCE(bullet_anim_ptr + 1, bullet_pos_x + 1, BY_A)
			mvi a, HERO_DIR_LEFT
			jmp sword_check_chars

; check if a sword collides with a char
; in:
; hl - bullet_pos_x + 1
; a - hero dir
sword_check_chars:
			; get the pos_xy
			mov d, m
			HL_ADVANCE(bullet_pos_x + 1, bullet_pos_y + 1)
			mov e, m

			; a - hero_dir
			rrc
			lxi h, SWORD_CHAR_COLLISION_OFFSET_X_L<<8 | SWORD_CHAR_COLLISION_OFFSET_Y_L
			jnc @attkL
			lxi h, SWORD_CHAR_COLLISION_OFFSET_X_R<<8 | SWORD_CHAR_COLLISION_OFFSET_Y_R
@attkL:
			; de - pos_xy
			; add a collision offset
			dad d


			; check if a bullet collides with a char
			mvi a, SWORD_CHAR_COLLISION_WIDTH
			lxi b, CHAR_TYPE_ALL<<8 | SWORD_CHAR_COLLISION_HEIGHT
			; de - collision pos_xy
			call chars_get_first_collided

			; hl - ptr to a collided char_update_ptr + 1
			mov a, m
			cpi ACTOR_RUNTIME_DATA_DESTR
			; if no collision with a char, check the tiledata it is on.
			jnc hero_attack_check_tiledata

			; impact the char
			; advance hl to char_impacted_ptr
			HL_ADVANCE(char_update_ptr+1, char_impacted_ptr, BY_BC)
			mov e, m
			inx h
			mov d, m
			xchg
			mvi c, HERO_WEAPON_ID_SWORD
			; call a char_impact func
			pchl


; draw a sprite into a backbuffer
; in:
; de - ptr to bullet_draw_ptr
sword_draw:
			lhld sword_get_scr_addr
			lda sword_ram_disk_s_cmd
			jmp actor_draw