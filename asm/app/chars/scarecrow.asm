@memusage_scarecrow

SCARECROW_ANIM_SPEED_IDLE = 30

scarecrow_init:
			CHAR_INIT(scarecrow_update, npc_draw, scarecrow_impacted, NPC_HEALTH, ACTOR_STATUS_INIT, npc_scarecrow_idle_anim, False, CHAR_TYPE_ALLY)

;=============================================================================
; anim and a gameplay logic update
; in:
; de - ptr to char_update_ptr
scarecrow_update:
			; advance hl to char_anim_timer
			HL_ADVANCE(char_update_ptr, char_anim_timer, BY_HL_FROM_DE)
			mvi a, SCARECROW_ANIM_SPEED_IDLE
			; hl - char_anim_timer
			; a - anim speed
			call actor_anim_update
			ret

;=============================================================================
; in:
; de - ptr to char_impacted_ptr + 1
; c - hero_weapon_id
scarecrow_impacted:
			; check the weapon_id
			mvi a, HERO_WEAPON_ID_SNOWFLAKE
			cmp c
			rz ; return if the hero used a snowflake
			; de - ptr to char_impacted_ptr+1

			; prevents multiple calls this function
			; when a hero hits multiple triggers at once
			call dialog_is_inited
			rz

			lda game_status_mom
			CPI_ZERO(MOM_STATUS_FIRST_HI)
			jz @quest_help_bob

			ret

@quest_help_bob:
			mvi a, MOM_STATUS_HELP_BOB
			sta game_status_mom

			; init a dialog
			mvi a, GAME_REQ_PAUSE
			lxi h, dialog_callback_room_redraw
			lxi d, _dialogs_mom_first_hi
			jmp dialog_init
