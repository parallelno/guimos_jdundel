@memusage_bob

bob_init:
			CHAR_INIT(npc_update, npc_draw, @impacted, NPC_HEALTH, ACTOR_STATUS_INIT, npc_bob_idle_anim, False, CHAR_TYPE_ALLY)

; in:
; de - ptr to char_impacted_ptr + 1
; c - hero_weapon_id
@impacted:
			; check the weapon_id
			mvi a, HERO_WEAPON_ID_SNOWFLAKE
			cmp c
			rz ; return if the hero used a snowflake
			; de - ptr to char_impacted_ptr+1

			; prevents multiple calls this function
			; when a hero hits multiple triggers at once
			call dialog_is_inited
			rz

			lda game_status_bob
			CPI_ZERO(BOB_STATUS_FIRST_HI)
			jz @quest_help_bob
			cpi BOB_STATUS_WAITING_SCARE
			jz @quest_waits_scare
			ret

@quest_help_bob:
			mvi a, BOB_STATUS_WAITING_SCARE
			sta game_status_bob

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