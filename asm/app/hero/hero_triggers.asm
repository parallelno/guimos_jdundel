memusage_hero_triggers:

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
			mvi a, GLOBAL_REQ_RESPAWN
			sta app_request
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
; when the hero knocks a dungeon entrance
; The game ends after showing the dialog
trigger_hero_knocks_dungeon_entrance:
			mvi a, GAME_REQ_PAUSE
			lxi h, @callback
			lxi d, _dialogs_knocked_dungeon_entrance
			jmp dialog_init

@callback:
			mvi a, GLOBAL_REQ_MENU_STATS
			sta app_request
			ret

; TODO: Load level 1 for tests
trigger_test_load_lv1:
			mvi a, GAME_REQ_PAUSE
			lxi h, @callback
			lxi d, _dialogs_knocked_dungeon_entrance
			jmp dialog_init

@callback:
			mvi a, GLOBAL_REQ_LOAD_LEVEL1
			sta app_request
			ret
