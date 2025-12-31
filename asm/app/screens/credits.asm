@memusage_credits:
;=======================================================

credits_screen:
			lda app_request
			sta @global_req + 1
			call credits_screen_init

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

credits_screen_text_draw:
			call text_ex_reset_spacing
			; credits
			lxi d, _credits_screen_credits
			call text_ex_draw
			ret

credits_screen_init:
			call screen_fade_out
			call screen_simple_init
			call screen_draw_frame

			call screen_fade_in

			call screen_draw_return_text_button
			call credits_screen_text_draw

			jmp reset_game_updates_required_counter