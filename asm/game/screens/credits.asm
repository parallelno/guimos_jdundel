.if LOCALIZATION == 0
	CREDITS_POS = $18e0
.endif
.if LOCALIZATION == 1			
	CREDITS_POS = $12e0
.endif
CREDITS_LINE_SPACING = 12
CREDITS_PARAG_SPACING = 24

credits_screen:
			lda global_request
			sta @global_req+1
			call credits_screen_init

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

credits_screen_text_draw:
			call text_ex_rd_reset_spacing
			; credits
			;lxi h, CREDITS_POS
			lxi d, _credits_screen_credits
			call text_ex_draw
			ret

credits_screen_init:
			call screen_simple_init
			call screen_palette_and_frame
			call screen_draw_return_text_button

			call credits_screen_text_draw

			call reset_game_updates_required_counter
			ret