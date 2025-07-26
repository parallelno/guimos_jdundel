@memusage_scarecrow

SCARECROW_ANIM_SPEED_IDLE = 30
SCARECROW_HEALTH = 10

SCARECROW_FIELD_ROOM_ID = 15

;========================================================
; spawn and init a char
; in:
; c - tile_idx in the room_tiledata array.
; a - char_id * 4
; out:
; a = TILEDATA_RESTORE_TILE
scarecrow_init:
			push psw
			lda room_id
			cpi SCARECROW_FIELD_ROOM_ID
			jz @field_room
@backyard_room:
			lda game_status_bob
			cpi BOB_STATUS_GOT_SCARECROW
			jc @visible
			jmp @invisible

@field_room:
			lda game_status_bob
			cpi BOB_STATUS_SET_SCARECROW
			jc @invisible
@visible:
			pop psw
			CHAR_INIT(scarecrow_update, npc_draw, scarecrow_impacted, SCARECROW_HEALTH, ACTOR_STATUS_INIT, npc_scarecrow_idle_anim, False, CHAR_TYPE_ALLY)

@invisible:
			pop psw
			CHAR_INIT(scarecrow_update, npc_draw, scarecrow_impacted, SCARECROW_HEALTH, ACTOR_STATUS_BIT_INVIS, npc_scarecrow_idle_anim, False, CHAR_TYPE_ALLY)

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

			lxi h, game_status_bob
			mov a, m
			cpi BOB_STATUS_SET_SCARECROW
			rnc
			cpi BOB_STATUS_GOT_SCARECROW
			jnc @setting_scarecrow

@getting_scarecrow:
			; a hero used hands, collect the scarecrow
			lda room_id
			cpi SCARECROW_FIELD_ROOM_ID
			rz
			; hl - game_status_bob
			mvi m, BOB_STATUS_GOT_SCARECROW
			mvi a, MOM_STATUS_HELP_BOB
			sta game_status_mom

			; de - ptr to char_impacted_ptr+1
			HL_ADVANCE(char_impacted_ptr+1, char_update_ptr+1, BY_HL_FROM_DE)
			call char_destroy

			; add the scarecrow to the items
			lxi h, hero_res_scarecrow
			mvi m, 1
			; hl - selected res
			call game_ui_res_select_and_draw

			; init a dialog
			mvi a, GAME_REQ_PAUSE
			lxi h, dialog_callback_room_redraw
			lxi d, _dialogs_got_scarecrow
			jmp dialog_init

@setting_scarecrow:
			; the hero is setting a scarecrow
			lda room_id
			cpi SCARECROW_FIELD_ROOM_ID
			rnz
			; hl - game_status_bob
			mvi m, BOB_STATUS_SET_SCARECROW

			; make it visible
			; de - ptr to char_impacted_ptr+1
			HL_ADVANCE(char_impacted_ptr+1, char_status, BY_HL_FROM_DE)
			mvi m, ACTOR_STATUS_INIT

			lxi h, hero_res_scarecrow
			dcr m
			; redraw ui
			; hl - selected res
			call game_ui_res_select_and_draw
			; add score points
			lxi d, TILEDATA_FUNC_ID_RESOURCES<<8 | RES_ID_SCARECROW
			call game_score_add
			jmp game_ui_draw_score_text