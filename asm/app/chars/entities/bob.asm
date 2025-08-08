@memusage_bob

bob_init:
			CHAR_INIT(npc_update, npc_draw, @impacted, NPC_HEALTH, ACTOR_STATUS_INIT, npc_bob_idle_anim, False, CHAR_TYPE_ALLY)

; the hero interracts with it
; in:
; de - ptr to char_impacted_ptr + 1
; c - hero_weapon_id
@impacted:
			; check the weapon_id
			mvi a, HERO_WEAPON_ID_SNOWFLAKE
			cmp c
			jz @hit_by_snowflake ; the hero used a snowflake
			; de - ptr to char_impacted_ptr + 1

			; prevents multiple calls this function
			; when a hero hits multiple triggers at once
			call dialog_is_inited
			rz

			lxi h, game_status_bob
			mov a, m
			CPI_ZERO(BOB_STATUS_FIRST_HI)
			jz @quest_help_bob
			cpi BOB_STATUS_WAITING_SCARE
			jz @quest_waits_scare
			cpi BOB_STATUS_GOT_SCARECROW
			jz @quest_waits_scare
			cpi BOB_STATUS_SET_SCARECROW
			jz @quest_completed
			cpi BOB_STATUS_HAPPY
			jz @bob_happy
			ret

@quest_help_bob:
			mvi m, BOB_STATUS_WAITING_SCARE

			mvi a, ITEM_STATUS_ACQUIRED
			sta global_items + ITEM_ID_KEY_2 - 1 ; because the first item_id = 1

			; init a dialog
			mvi a, GAME_REQ_PAUSE
			lxi h, dialog_callback_room_redraw
			lxi d, _dialogs_bob_first_hi
			jmp dialog_init

@quest_waits_scare:
			; init a dialog
			mvi a, GAME_REQ_PAUSE
			lxi h, dialog_callback_room_redraw
			lxi d, _dialogs_bob_waits_scare
			jmp dialog_init

@quest_completed:
			mvi m, BOB_STATUS_HAPPY
			lxi h, game_status_mom
			mvi m, MOM_STATUS_CATCH_CATERPILLARS

			; init a dialog
			mvi a, GAME_REQ_PAUSE
			lxi h, @dialog_callback
			lxi d, _dialogs_set_scarecrow
			jmp dialog_init
@dialog_callback:
			call dialog_callback_room_redraw

			; play vfx
			lxi h, hero_pos_x + 1
			mov b, m
			HL_ADVANCE(hero_pos_x + 1, hero_pos_y + 1)
			mov c, m
			lxi d, vfx_reward_anim
			call vfx_init

			lxi h, hero_res_trap
			inr m

			; redraw ui
			call game_ui_res_select_and_draw
			; add score points
			lxi d, TILEDATA_FUNC_ID_RESOURCES<<8 | RES_ID_TRAP
			call game_score_add
			jmp game_ui_draw_score_text

@bob_happy:
			; init a dialog
			mvi a, GAME_REQ_PAUSE
			lxi h, dialog_callback_room_redraw
			lxi d, _dialogs_bob_happy
			jmp dialog_init

@hit_by_snowflake:
			; init a dialog
			mvi a, GAME_REQ_PAUSE
			lxi h, dialog_callback_room_redraw
			lxi d, _dialogs_mom_hit_by_snowflake
			jmp dialog_init