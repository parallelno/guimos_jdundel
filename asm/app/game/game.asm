memusage_game:
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

game_loop:
@loop:
@codePerfStart_draw:
			call game_update
@codePerfEnd_draw:
@codePerfStart_update:
			call game_draw
@codePerfEnd_update:			
			jmp	@loop

game_update:
			lxi h, game_update_counter
			inr m
@loop:
			CHECK_GAME_UPDATE_COUNTER(game_updates_required)

			; check the pause
			lda global_request
			cpi GAME_REQ_PAUSE
			jz @pause
			cpi GAME_REQ_END_HOME
			jz @end
			cpi GAME_REQ_LV1
			jz @lv1

			call hero_update
			call monsters_update
			call bullets_update
			call level_update
@pause:
			call backs_update
			call game_ui_update

			; to check repeated key-pressing
			lda action_code
			sta action_code_old
			jmp @loop
@end:
			mvi a, GLOBAL_REQ_MENU_STATS
			sta global_request
			; bypass RET in the game_update func
			POP_H(1)
			; return stright to main_start loop
			ret
@lv1:
			mvi a, GLOBAL_REQ_LOAD_LEVEL1
			sta global_request
			; bypass RET in the game_update func
			POP_H(1)
			; return stright to main_start loop
			ret
			
game_draw:
			; update counter to calc fps
			lhld game_draw_counter
			inx h
			shld game_draw_counter

			; draw funcs
			call backs_draw

			; return if the game paused
			lda global_request
			cpi GAME_REQ_PAUSE
			rz

			call monsters_sort_pos_y

			call monsters_draw ; it also calls call hero_draw
			call bullets_draw

			call hero_copy_to_scr
			call monsters_copy_to_scr
			call bullets_copy_to_scr

			call hero_erase
			call monsters_erase
			call bullets_erase
			ret



