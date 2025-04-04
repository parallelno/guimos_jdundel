;===========================================================================
; when the hero looses all the health
trigger_hero_no_health:
			; disable hero updates
			mvi a, ACTOR_STATUS_NO_UPDATE | ACTOR_STATUS_BIT_INVIS
			sta hero_status

			; init a dialog
			lxi h, @callback
			lxi d, _dialogs_no_health
			A_TO_ZERO(GLOBAL_REQ_NONE)
			jmp dialog_init

@callback:
			; requesting a level loading
			mvi a, GAME_REQ_RESPAWN
			sta global_request
			; restore a hero health
			mvi a, RES_HEALTH_INIT
			sta hero_res_health
			ret

;===========================================================================
; when the hero knocks his home door.
; The game ends after showing the dialog
trigger_hero_knocks_his_home_door:
			; check if the hero has a popsicle pie
			lda hero_res_popsicle_pie
			CPI_ZERO()
			rz
			; take all his pies if so
			A_TO_ZERO(0)
			sta hero_res_popsicle_pie
			lxi h, hero_res_sword
			call game_ui_res_select_and_draw			

			; init a dialog
			mvi a, GAME_REQ_PAUSE
			lxi h, dialog_callback_room_redraw
			lxi d, _dialogs_knocked_his_home_door
			jmp dialog_init

;===========================================================================
; when the hero knocks his friend door
; A hero gets a key 0 to open the backyard
trigger_hero_knocks_his_friend_door:
			; fix for multiple calls this function when a hero hits several trigger tiledatas
			call dialog_is_inited
			rz

			lxi h, global_items + ITEM_ID_KEY_0 - 1 ; because the first item_id = 1
			; check the key 0 status
			A_TO_ZERO(ITEM_STATUS_NOT_ACQUIRED)
			cmp m
			jnz @check_clothes; if it is acquired or used, check clothes item

			; if a key_0 isn't acquired, set key_0 status = ITEM_STATUS_ACQUIRED
			mvi m, ITEM_STATUS_ACQUIRED
			
			lxi d, TILEDATA_FUNC_ID_ITEMS<<8 | ITEM_ID_KEY_0
			call game_score_add
			call game_ui_draw_score_text

			; init a dialog
			mvi a, GAME_REQ_PAUSE
			lxi h, dialog_callback_room_redraw
			lxi d, _dialogs_knocked_his_friend_door
			jmp dialog_init

@check_clothes:
			; key_0 is acquired
			; check if clothes are acquired
			lxi h, hero_res_clothes
			A_TO_ZERO(0)
			cmp m
			jnz @clothes_acquired
@clothes_not_acquired:
			; the hero returns without clothes
			mvi a, GAME_REQ_PAUSE
			lxi h, dialog_callback_room_redraw
			lxi d, _dialogs_knocked_his_friend_door_no_clothes
			jmp dialog_init

@clothes_acquired:
			; a hero returns with clothes
			; remove the clothes item
			; a = 0
			mov m, a
			lxi h, hero_res_popsicle_pie
			inr m
			lxi h, hero_res_sword
			call game_ui_res_select_and_draw

			lxi d, TILEDATA_FUNC_ID_RESOURCES<<8 | RES_ID_PIE
			call game_score_add
			call game_ui_draw_score_text

			; init a dialog
			mvi a, GAME_REQ_PAUSE
			lxi h, dialog_callback_room_redraw
			lxi d, _dialogs_knocked_his_friend_door_clothes_returns
			jmp dialog_init
			
;===========================================================================
; when the hero knocks a dungeon entrance
; The game ends after showing the dialog
trigger_hero_knocks_dungeon_entrance:
			mvi a, GAME_REQ_PAUSE
			lxi h, @callback
			lxi d, _dialogs_knocked_dungeon_entrance
			jmp dialog_init

@callback:
			mvi a, GAME_REQ_END_HOME
			sta global_request
			ret




