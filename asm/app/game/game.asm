memusage_game:
;=======================================================

game:
			; init
			call game_stats_init
			call hero_game_init
			call levels_init
			call dialogs_init
			call game_ui_init
			call reset_game_updates_required_counter

@loop:		; main loop
			call game_update
			call game_draw
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
			mvi a, GLOBAL_REQ_END_HOME
			sta global_request
			POP_H(1) ; bypass RET to return to main_start loop
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

;@codePerfStart_monsters_sort_pos_y:
			call monsters_sort_pos_y
;@codePerfEnd_monsters_sort_pos_y:

			;call hero_draw
			call monsters_draw
			call bullets_draw

			call hero_copy_to_scr
			call monsters_copy_to_scr
			call bullets_copy_to_scr

			call hero_erase
			call monsters_erase
			call bullets_erase
			ret



