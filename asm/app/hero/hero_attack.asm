hero_attack_init:
			; set the status
			lxi h, hero_status
			mvi m, ACTOR_STATUS_HERO_ATTACK

			; set status timer
			HL_ADVANCE(hero_status, hero_status_timer)
			mvi m, HERO_STATUS_ATTACK_DURATION

			; reset anim timer
			A_TO_ZERO(NULL)
			sta hero_anim_timer

			; speed = 0
			lxi h, 0
			shld hero_speed_x
			shld hero_speed_y

			lda game_ui_res_selected_id
			cpi <hero_res_sword
			jz hero_attack_use_sword
			cpi <hero_res_snowflake
			jz hero_attack_use_snowflake
			cpi <hero_res_popsicle_pie
			jz hero_attack_use_popsicle_pie
			cpi <hero_res_cabbage
			jz hero_attack_use_cabbage
			cpi <hero_res_spoon
			jz hero_attack_use_spoon
			cpi <hero_res_clothes
			jz hero_attack_use_clothes
			jmp hero_attack_use_hands

hero_attack_use_snowflake:
			lxi h, hero_res_snowflake
			mov a, m
			CPI_ZERO()
			rz
			dcr m
			lxi h, hero_res_sword
			call game_ui_res_select_and_draw

			call snowflake_init
			jmp hero_attack_anim_init

hero_attack_use_cabbage:
			lxi h, hero_res_cabbage
			mov a, m
			CPI_ZERO()
			rz
			dcr m

			; count how many cabbages were eaten
			lxi h, game_status_cabbage_eaten
			INR_WRAP_M(RES_CABBAGE_FART, @no_fart)

			call fart_init
@no_fart:

			; check if a hero uses cabbage the first time
			lda game_status_cabbage_healing
			CPI_ZERO()
			jnz @no_cabbage_healing_dialog
			inr a
			sta game_status_cabbage_healing
			; init a dialog
			mvi a, GAME_REQ_PAUSE
			lxi h, @cabbage_callback
			lxi d, _storytelling_hero_use_cabbage
			jmp dialog_init
@cabbage_callback:
			call dialog_callback_room_redraw

@no_cabbage_healing_dialog:
			lxi h, hero_res_health
			mov a, m
			adi RES_CABBAGE_HEALTH_VAL
			CLAMP_A(RES_HEALTH_MAX)
			mov m, a

			; play vfx if a health is not max
			; a - hero health
			cpi RES_HEALTH_MAX
			jz @no_vfx
			lxi h, hero_erase_scr_addr
			mov c, m
			HL_ADVANCE(hero_erase_scr_addr, hero_erase_scr_addr + 1)
			mov b, m
			lxi d, vfx_reward_anim
			call vfx_init
@no_vfx:

			lxi h, hero_res_sword
			call game_ui_res_select_and_draw
			call game_ui_draw_health_text
			jmp hero_attack_use_hands

hero_attack_use_popsicle_pie:
			; check if a hero uses a popsicle pie the first time
			lda game_status_use_pie
			CPI_ZERO()
			jnz @no_hero_use_pie_dialog
			inr a
			sta game_status_use_pie
			; init a dialog
			mvi a, GAME_REQ_PAUSE
			lxi h, @pie_callback
			lxi d, _dialogs_hero_use_pie
			jmp dialog_init
@pie_callback:
			call dialog_callback_room_redraw
@no_hero_use_pie_dialog:

			lxi h, hero_res_sword
			call game_ui_res_select_and_draw
			jmp hero_attack_use_hands

hero_attack_use_clothes:
			; check if a hero uses clothes the first time
			lda game_status_use_clothes
			CPI_ZERO()
			jnz @no_hero_use_clothes_dialog
			inr a
			sta game_status_use_clothes
			; init a dialog
			mvi a, GAME_REQ_PAUSE
			lxi h, @clothes_callback
			lxi d, _dialogs_hero_use_clothes
			jmp dialog_init
@clothes_callback:
			call dialog_callback_room_redraw
@no_hero_use_clothes_dialog:

			lxi h, hero_res_sword
			call game_ui_res_select_and_draw
			jmp hero_attack_use_hands

hero_attack_use_spoon:
			lxi h, hero_res_popsicle_pie
			mov a, m
			CPI_ZERO()
			rz ; return if no pie
			dcr m
			lxi h, hero_res_snowflake
			mov a, m
			adi RES_POPSICLE_PIE_MANA_VAL
			CLAMP_A(RES_SNOWFLAKES_MAX)
			mov m, a

			; check if a hero uses a spoon the first time
			lda game_status_use_spoon
			CPI_ZERO()
			jnz @no_hero_use_spoon_dialog
			inr a
			sta game_status_use_spoon
			; init a dialog
			mvi a, GAME_REQ_PAUSE
			lxi h, @spoon_callback
			lxi d, _storytelling_hero_use_spoon
			jmp dialog_init
@spoon_callback:
			call dialog_callback_room_redraw
@no_hero_use_spoon_dialog:

			lxi h, hero_res_sword
			call game_ui_res_select_and_draw
			jmp hero_attack_use_hands


hero_attack_anim_init:
			lda hero_dir
			rrc
			jnc @set_anim_attk_l

			lxi h, hero_attk_r_anim
			shld hero_anim_ptr
			ret
@set_anim_attk_l:
			lxi h, hero_attk_l_anim
			shld hero_anim_ptr
			ret

hero_attack_use_sword:
			call hero_attack_anim_init
			jmp sword_init

hero_attack_use_hands:
			call hero_attack_anim_init
			jmp hero_attack_check_chars

HANDS_COLLISION_WIDTH	= 15
HANDS_COLLISION_HEIGHT	= 16
HANDS_COLLISION_OFFSET_X = 0
HANDS_COLLISION_OFFSET_Y = 0

SWORD_TILE_COLLISION_WIDTH	= 15
SWORD_TILE_COLLISION_HEIGHT	= 16
SWORD_TILE_COLLISION_OFFSET_X_R = 8
SWORD_TILE_COLLISION_OFFSET_X_L = <(-7)
SWORD_TILE_COLLISION_OFFSET_Y = 3

; Check if the area near the hero collides with an allay (npc, pets, friendly animals, etc) char
hero_attack_check_chars:
			lxi h, hero_pos_x + 1
			; get the pos_xy
			mov d, m
			HL_ADVANCE(hero_pos_x + 1, hero_pos_y + 1)
			mov e, m

			lxi h, HANDS_COLLISION_OFFSET_X<<8 | HANDS_COLLISION_OFFSET_Y
			; de - pos_xy
			; add a collision offset
			dad d


			; check if a hand collision intersects with a char
			mvi a, HANDS_COLLISION_WIDTH
			lxi b, CHAR_TYPE_ALLY<<8 | HANDS_COLLISION_HEIGHT
			; hl - collision pos_xy
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
			mvi c, HERO_WEAPON_ID_HANDS
			; call a char_impact func
			pchl

hero_attack_update:
			HERO_UPDATE_ANIM(HERO_ANIM_SPEED_ATTACK)
			lxi h, hero_status_timer
			dcr m
			rnz
			; if the timer == 0, set the status to Idle
			jmp hero_idle_init


; check the tiledata under a sword collision
hero_attack_check_tiledata:
			; if no sword, do not init a sword, check and handle the collision
			; get a hero pos
			lxi h, hero_pos_x + 1
			mov d, m
			HL_ADVANCE(hero_pos_x + 1, hero_pos_y + 1)
			mov e, m
			; de - the hero pos

			; offset the sword collision horizontally depending on the hero move
			lda hero_dir
			rrc
			mvi h, SWORD_TILE_COLLISION_OFFSET_X_L
			jnc @left
@right:
			mvi h, SWORD_TILE_COLLISION_OFFSET_X_R
@left:
			; offset the sword collision vertically depending on the hero move
			RRC_(2)
			mvi l, SWORD_TILE_COLLISION_OFFSET_Y
			jc @up
			mvi l, <(-SWORD_TILE_COLLISION_OFFSET_Y)
@up:
			dad d
			xchg
			; de - the sword collision pos
			TILEDATA_HANDLING(SWORD_TILE_COLLISION_WIDTH, SWORD_TILE_COLLISION_HEIGHT, sword_tile_func_tbl)
			ret
