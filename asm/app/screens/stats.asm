@memusage_stats
;=======================================================

END_GAME_LINE_SPACING	= 12

.if LOCALIZATION == 0
	STATS_NUMBERS_SCR_ADDR = $b0aa
.endif
.if LOCALIZATION == 1
	STATS_NUMBERS_SCR_ADDR = $b2aa
.endif


stats_screen:
			lda app_request
			sta @global_req+1
			call stats_screen_init

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

stats_screen_text_draw:
			call text_ex_reset_spacing
			; draw a text
			lxi d, _stats_game_stats
			call text_ex_draw


			; draw chars stats
			mvi c, TILEDATA_FUNC_ID_CHARS
			call game_stats_get
			xchg
			; hl - stats
			lxi b, STATS_NUMBERS_SCR_ADDR
			call text_mono_draw_int16

			; draw items stats
			mvi c, TILEDATA_FUNC_ID_ITEMS
			call game_stats_get
			xchg
			; hl - stats
			lxi b, STATS_NUMBERS_SCR_ADDR - END_GAME_LINE_SPACING * 1
			call text_mono_draw_int16

			; draw coins stats
			mvi c, TILEDATA_FUNC_ID_RESOURCES
			call game_stats_get
			xchg
			; hl - stats
			lxi b, STATS_NUMBERS_SCR_ADDR - END_GAME_LINE_SPACING * 2
			call text_mono_draw_int16

			; draw containers stats
			mvi c, TILEDATA_FUNC_ID_CONTAINERS
			call game_stats_get
			xchg
			; hl - stats
			lxi b, STATS_NUMBERS_SCR_ADDR - END_GAME_LINE_SPACING * 3
			call text_mono_draw_int16

			; draw doors stats
			mvi c, TILEDATA_FUNC_ID_DOORS
			call game_stats_get
			xchg
			; hl - stats
			lxi b, STATS_NUMBERS_SCR_ADDR - END_GAME_LINE_SPACING * 4
			call text_mono_draw_int16

			; draw breakables stats
			mvi c, TILEDATA_FUNC_ID_BREAKABLES
			call game_stats_get
			xchg
			; hl - stats
			lxi b, STATS_NUMBERS_SCR_ADDR - END_GAME_LINE_SPACING * 5
			call text_mono_draw_int16

			; TODO: add stats of the secret rooms entered

			; draw total stats
			lxi h, game_ui_score_txt
			lxi b, STATS_NUMBERS_SCR_ADDR - END_GAME_LINE_SPACING * 7
			jmp text_mono_draw

stats_screen_init:
			call screen_fade_out
			call screen_simple_init
			call screen_draw_frame
			call screen_draw_return_text_button

			call stats_screen_text_draw

			call reset_game_updates_required_counter
			jmp screen_fade_in