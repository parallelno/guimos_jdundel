@memusage_scarecrow

SCARECROW_ANIM_SPEED_IDLE = 30
SCARECROW_HEALTH = 10

scarecrow_init:
			CHAR_INIT(scarecrow_update, npc_draw, scarecrow_impacted, SCARECROW_HEALTH, ACTOR_STATUS_INIT, npc_scarecrow_idle_anim, False, CHAR_TYPE_ALLY)

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
			A_TO_ZERO(HERO_WEAPON_ID_HANDS)
			cmp c
			jnz char_impacted
			; de - ptr to char_impacted_ptr+1

			; prevents multiple calls this function
			; when a hero hits multiple triggers at once
			call dialog_is_inited
			rz

			lda game_status_bob
			cpi BOB_STATUS_WAITING_SCARE
			jnz @set_scarecrow

@get_scarecrow:
			; de - ptr to char_impacted_ptr+1
			xchg
			shld @char_impacted_ptr + 1

			; a hero used hands, collect the scarecrow
			mvi a, MOM_STATUS_HELP_BOB
			sta game_status_bob

			; init a dialog
			mvi a, GAME_REQ_PAUSE
			lxi h, @dialog_callback
			lxi d, _dialogs_got_scarecrow
			jmp dialog_init
@dialog_callback:
			call dialog_callback_room_redraw
			; add the scarecrow to the items
			mvi a, 1
			sta hero_res_scarecrow
			lxi h, hero_res_sword
			call game_ui_res_select_and_draw

@char_impacted_ptr:
			lxi h, TEMP_ADDR
			; hl - ptr to char_impacted_ptr+1

			; mark this char dead to remove it from the backyard
			HL_ADVANCE(char_impacted_ptr+1, char_update_ptr+1, BY_DE)
			jmp char_destroy

@set_scarecrow:
			ret