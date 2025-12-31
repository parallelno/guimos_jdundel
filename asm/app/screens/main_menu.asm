@memusage_main_menu:
;=======================================================

MAIN_MENU_CURSOR_POS_X		= $5800 ; .word
MAIN_MENU_CURSOR_POS_Y_MAX	= $8100 ; .word

SETTING_LINE_SPACING = 18

MAIN_MENU_OPTIONS_MAX = 4

main_menu_cursor_option_id:
			.byte 0


; the area in between min-max is used to spawn bacground vfx
MAIN_MENU_FX_POS_MAX1 = $3090
MAIN_MENU_FX_POS_MIN1 = $1030

MAIN_MENU_FX_POS_MAX2 = $E090
MAIN_MENU_FX_POS_MIN2 = $B830

MAIN_MENU_FX_POS_MAX3 = $20E0
MAIN_MENU_FX_POS_MIN3 = $10B0

MAIN_MENU_FX_POS_MAX4 = $E0E0
MAIN_MENU_FX_POS_MIN4 = $D8A0

main_scr_vfx_spawn_rate = 10 ;(0 - no spawn, 255 - spawn every update)

main_menu:
			lda app_request
			sta @global_req + 1
			call main_menu_init

@loop:
			; return when a user hits any option in the main menu
			lda app_request
@global_req:
			cpi TEMP_BYTE
			rnz

			lxi h, main_menu_cursor_update
			call screen_simple_update
			call screen_simple_draw
			jmp	 @loop

main_menu_backgound_draw:
			call screen_draw_frame
			; settings frame & title
			lxi d, _tim_main_menu_front
			call tiled_img_draw

			@line_spacing = <(-SETTING_LINE_SPACING)
			lxi b, @line_spacing<<8 | @line_spacing
			call text_ex_set_spacing
			; draw main menu settings
			lxi d, _main_menu_settings
			call text_ex_draw

			; draw licensing
			lxi d, _main_menu_license
			call text_ex_draw
			ret

main_menu_cursor_update:
			; spawn vfx
			call random
			sui main_scr_vfx_spawn_rate
			cc @spawn_vfx

			; check keys
			; check if the space key pressed
			lhld action_code
			; h - action_code_old
			; l - action_code

			; return if the same key was pressed last time
			; to avoid multiple times pressing
			mov a, l
			cmp h
			rz

			mvi a, CONTROL_CODE_KEY_SPACE | CONTROL_CODE_FIRE1
			ana l
			jnz @space_handling

@check_arrows:
			mov a, l
			; a - action_code
			cpi CONTROL_CODE_DOWN
			jz @cursor_move_down
			cpi CONTROL_CODE_UP
			rnz
@cursor_move_up:
			; check if a selected option is outside ofthe range [0 - MAIN_MENU_OPTIONS_MAX]
			lda main_menu_cursor_option_id
			dcr a
			rm ; return if a selected option = -1
			sta main_menu_cursor_option_id

			lxi h, hero_pos_y + 1
			mov a, m
			adi SETTING_LINE_SPACING
			mov m, a
			ret
@cursor_move_down:
			; check if a selected option is outside ofthe range [0 - MAIN_MENU_OPTIONS_MAX]
			lda main_menu_cursor_option_id
			inr a
			cpi MAIN_MENU_OPTIONS_MAX
			rnc ; return if a selected option >= MAIN_MENU_OPTIONS_MAX
			sta main_menu_cursor_option_id

			lxi h, hero_pos_y + 1
			mov a, m
			sui SETTING_LINE_SPACING
			mov m, a
			ret
@spawn_vfx:
			; randomly chose an area to play vfx
			call random
			; hl - 16-bit pseudo-random number
			; a = h

			ani %11
			jz @bottom_l
			cpi 1
			jz @bottom_r
			cpi 2
			jz @top_l
@top_r:
			; pos_x min/max
			lxi d, >MAIN_MENU_FX_POS_MIN4<<8 | >MAIN_MENU_FX_POS_MAX4
			push d
			; pos_x mask
			mvi a, %0001_1111
			push psw
			; pos_y min/max
			lxi d, <MAIN_MENU_FX_POS_MIN4<<8 | <MAIN_MENU_FX_POS_MAX4
			; pos_y mask
			mvi a, %0011_1111
			jmp @vfx_init
@top_l:
			; pos_x min/max
			lxi d, >MAIN_MENU_FX_POS_MIN3<<8 | >MAIN_MENU_FX_POS_MAX3
			push d
			; pos_x mask
			mvi a, %0001_1111
			push psw
			; pos_y min/max
			lxi d, <MAIN_MENU_FX_POS_MIN3<<8 | <MAIN_MENU_FX_POS_MAX3
			; pos_y mask
			mvi a, %0011_1111
			jmp @vfx_init

@bottom_r:
			; pos_x min/max
			lxi d, >MAIN_MENU_FX_POS_MIN2<<8 | >MAIN_MENU_FX_POS_MAX2
			push d
			; pos_x mask
			mvi a, %0011_1111
			push psw
			; pos_y min/max
			lxi d, <MAIN_MENU_FX_POS_MIN2<<8 | <MAIN_MENU_FX_POS_MAX2
			; pos_y mask
			mvi a, %0111_1111
			jmp @vfx_init

@bottom_l:
			; pos_x min/max
			lxi d, >MAIN_MENU_FX_POS_MIN1<<8 | >MAIN_MENU_FX_POS_MAX1
			push d
			; pos_x mask
			mvi a, %0011_1111
			push psw
			; pos_y min/max
			lxi d, <MAIN_MENU_FX_POS_MIN1<<8 | <MAIN_MENU_FX_POS_MAX1
			; pos_y mask
			mvi a, %0111_1111
			jmp @vfx_init

; calcs the rnd pos and draws a vfx
; in:
; hl - 16-bit rnd val
; de - MAIN_MENU_FX_POS_MIN_Y<<8 | MAIN_MENU_FX_POS_MAX_Y
; a - pos_y mask to extract the offset_y from rnd val
; stack:
; pos_x mask to extract the offset_x from rnd val
; MAIN_MENU_FX_POS_MIN_X<<8 | MAIN_MENU_FX_POS_MAX_X
@vfx_init:
			; hl - 16-bit rnd val
			; de - <MAIN_MENU_FX_POS_MIN<<8 | <MAIN_MENU_FX_POS_MAX
			; a - pos_y mask to extract the offset_y from rnd val
			ana h
			call @add_offset
			mov c, a

			pop psw
			pop d
			; de - <MAIN_MENU_FX_POS_MIN<<8 | <MAIN_MENU_FX_POS_MAX
			; hl - 16-bit rnd val
			; a - pos_x mask to extract the offset_x from rnd val
			ana l
			call @add_offset
			mov b, a

			lxi d, vfx_reward_anim
			jmp vfx_init

; a = min(d + a, e)
; adds an offset and clamps the pos between
; the min and max poses
; in:
; d - min pos
; a - offset
; e - max pos
; out:
; a - pos
@add_offset:
			add d
			cmp e
			rc
			mov a, e
			ret

@space_handling:
			lda main_menu_cursor_option_id
			adi GLOBAL_REQ_GAME
			sta app_request
			ret

main_menu_cursor_init:
			A_TO_ZERO(GLOBAL_REQ_NONE)
@check_if_init:
			jmp @init
@init:
			lxi h, @no_init
			shld @check_if_init + 1

			; create a cursor actor
			lxi h, MAIN_MENU_CURSOR_POS_X
			shld hero_pos_x
			lxi h, MAIN_MENU_CURSOR_POS_Y_MAX
			shld hero_pos_y

			; reset selected option
			; a = 0
			sta main_menu_cursor_option_id

@no_init:
			; a = 0
			lxi h, main_menu_cursor_option_id
			mov b, m
			mvi a, >MAIN_MENU_CURSOR_POS_Y_MAX
			; b - main_menu_cursor_option_id
			; a - pos_y_max
			; calc the cursor pos_y

@loop:		dcr b
			jm @stop
			sui SETTING_LINE_SPACING
			jmp @loop
@stop:
			mov c, a
			mvi b, >MAIN_MENU_CURSOR_POS_X

			; spawn a cursor
			; bc - a cursor pos
			lxi h, hero_pos_y + 1
			mov m, c
			jmp cursor_init

main_menu_init:
			call screen_fade_out
			call screen_simple_init
			call main_menu_backgound_draw
			call main_menu_cursor_init

			; dialog_press_key (tiledata = 162)
			@pos_tiles_x = 9
			@pos_tiles_y = 4
			lxi b, TILEDATA_DIALOG_PRESS_KEY << 8 | @pos_tiles_x + @pos_tiles_y * TILE_HEIGHT
			; b - tiledata
			; c - tile_idx in the room_tiledata array.
			call backs_spawn

			call reset_game_updates_required_counter
			jmp screen_fade_in