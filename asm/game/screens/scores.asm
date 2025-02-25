SCORES_TITLE_POS = $58d8

SCORES_POS = $38b8
SCORES_LINE_SPACING = 14
SCORES_PARAG_SPACING = 24

scores_screen:
			lda global_request
			sta @global_req+1
			call scores_screen_init

@loop:
			; return when a user hits a space button
			lda global_request
@global_req:
			cpi TEMP_BYTE  
			rnz

			lxi h, screen_space_checking	
			call screen_simple_update
			call screen_simple_draw
			jmp	@loop

scores_screen_text_draw:
			;lxi h, SCORES_TITLE_POS
			lxi d, _scores_screen_score_title
			call text_ex_draw

			mvi e, SCORES_MAX
			lxi b, SCORES_POS
@loop:
			push b
			push d
			lxi d, _scores_screen_buff
			call text_ex_draw
			pop d
			pop b

			LXI_H(-SCORES_LINE_SPACING)
			dad b
			mov b, h
			mov c, l

			dcr e
			jnz @loop
			ret

scores_screen_init:
			call screen_simple_init
			call screen_palette_and_frame
			call screen_draw_return_text_button

			call scores_screen_text_draw

			call reset_game_updates_required_counter
			ret