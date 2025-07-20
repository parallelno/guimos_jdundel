@memusage_game
;=======================================================

game_init:
			call hero_game_init
			call levels_init
			call dialogs_init
			call game_ui_init
			call reset_game_updates_required_counter
			call game_stats_init

			; erase switch statuses
			lxi h, 0
			shld switch_statuses
			ret

game_level_init:
			call hero_level_init
			call level_init
			jmp game_ui_draw

game_loop:
@codePerfStart_game_update:
			call game_update
@codePerfEnd_game_update:
@codePerfStart_game_draw:
			call game_draw
@codePerfEnd_game_draw:
			jmp	game_loop

game_update:
@loop:
			CHECK_GAME_UPDATE_COUNTER(game_updates_required)
			; check the pause
			lda app_request

			CPI_ZERO(GLOBAL_REQ_NONE)
			jz @update

			cpi GAME_REQ_ROOM_INIT_AND_DRAW
			jz @room_init_and_draw
			cpi GAME_REQ_ROOM_REDRAW
			jz @room_redraw
			cpi GAME_REQ_PAUSE
			jz @pause
			cpi GAME_REQ_ROOM_INIT_AND_DRAW_FADE_IN
			jz @room_init_and_draw_fade_in
			; must be the last req check
			ani GAME_REQ
			jz @to_app_loop

@update:
			call hero_update
			call monsters_update
			call bullets_update
			;call level_update
@pause:
			call backs_update
			call game_ui_update

			; to check repeated key-pressing
			lda action_code
			sta action_code_old
			jmp @loop

@to_app_loop:
			; bypass RET in game_update func
			; return stright to app_loop
			POP_H(1)
			ret

@room_init_and_draw:
			call level_room_init_and_draw
			jmp @loop

@room_redraw:
			call level_room_redraw
			jmp @loop

@room_init_and_draw_fade_in:
			call level_room_init_and_draw
			mvi a, LEVEL_PALETTE_FADE_IN
			call level_palette_fade
			jmp @loop

game_draw:
			; update counter to calc fps
			lhld game_draw_counter
			inx h
			shld game_draw_counter

			; draw funcs
			call backs_draw

			; return if the game paused
			lda app_request
			cpi GAME_REQ_PAUSE
			rz

			call monsters_sort_pos_y

			call monsters_draw ; it also calls hero_draw
			call bullets_draw

			call hero_copy_to_scr
			call monsters_copy_to_scr
			call bullets_copy_to_scr

			call hero_erase
			call monsters_erase
			call bullets_erase
			ret
