@memusage_mom

mom_init:
			CHAR_INIT(npc_update, npc_draw, @impacted, NPC_HEALTH, ACTOR_STATUS_INIT, npc_mom_idle_anim, False, CHAR_TYPE_ALLY)

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

			lxi h, game_status_mom
			mov a, m
			CPI_ZERO(MOM_STATUS_FIRST_HI)
			jz @quest_help_bob
			cpi MOM_STATUS_CATCH_CATERPILLARS
			jz @quest_catch_caterpillars

			ret

@quest_help_bob:
			mvi m, MOM_STATUS_HELP_BOB

			; init a dialog
			mvi a, GAME_REQ_PAUSE
			lxi h, dialog_callback_room_redraw
			lxi d, _dialogs_mom_first_hi
			jmp dialog_init

@hit_by_snowflake:
			; init a dialog
			mvi a, GAME_REQ_PAUSE
			lxi h, dialog_callback_room_redraw
			lxi d, _dialogs_mom_hit_by_snowflake
			jmp dialog_init

@quest_catch_caterpillars:
			; init a dialog
			mvi a, GAME_REQ_PAUSE
			lxi h, dialog_callback_room_redraw
			lxi d, _dialogs_mom_catch_caterpillars
			jmp dialog_init