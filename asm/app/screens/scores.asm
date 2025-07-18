memusage_scores:
;=======================================================

SCORES_LINE_SPACING = 14

scores_screen:
			lda app_request
			sta @global_req+1
			call scores_screen_init

@loop:
			; return when a user hits a space button
			lda app_request
@global_req:
			cpi TEMP_BYTE
			rnz

			lxi h, screen_space_checking
			call screen_simple_update
			call screen_simple_draw
			jmp	@loop

scores_screen_text_draw:
			lxi d, _scores_screen_score_title
			call text_ex_draw

			mvi c, SCORES_MAX
			lxi h, 0 ; offset_x = 0, offset_y = 0
@loop:
			push b
			push h
			lxi d, _scores_screen_buff
			call text_ex_draw_pos_offset_set
			pop h
			pop b
			; new line pos
			LXI_D(-SCORES_LINE_SPACING)
			dad d

			dcr c
			jnz @loop
			ret

scores_screen_init:
			call screen_fade_out
			call screen_simple_init
			call screen_draw_frame

			call screen_fade_in

			call screen_draw_return_text_button
			call scores_screen_text_draw

			jmp reset_game_updates_required_counter