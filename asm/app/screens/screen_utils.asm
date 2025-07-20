@memusage_screen_utils
;=======================================================

screen_space_checking:
			; return if non-space key was pressed
			lda action_code
			ani CONTROL_CODE_KEY_SPACE | CONTROL_CODE_FIRE1
			rz
			; set the global req to return to the main nemu
			mvi a, GLOBAL_REQ_MENU_MAIN
			sta app_request
			ret


screen_simple_init:
			; clear the screen
			MEM_ERASE_SP(SCR_ADDR, SCR_BUFFS_LEN)
			; clear the backbuffer2
			MEM_ERASE_SP(BACK_BUFF_ADDR, BACK_BUFF_LEN, RAM_DISK_S_BACKBUFF)

			mvi a, BORDER_COLOR_IDX
			sta border_color_idx

			; erase backs buffs
			lxi h, backs_runtime_data
			lxi b, backs_runtime_data_end
			call mem_erase
			; setup backs runtime data
			call backs_init

			; erase bullets buffs
			lxi h, bullets_runtime_data
			lxi b, bullets_runtime_data_end
			call mem_erase
			; setup bullets runtime data
			call bullets_init

			; fill up the tile_data_buff with tiledata = 0
			; (walkable tile, no back restore , no decal)
			mvi c, 0
			call room_fill_tiledata

			; reset key data
			mvi a, CONTROL_CODE_NO
			sta action_code
			ret

screen_fade_out:
			lxi d, PERMANENT_PAL_MENU_ADDR + _pal_menu_palette_fade_to_load_relative
			mvi a, PERMANENT_PAL_MENU_RAM_DISK_S
			jmp pallete_fade_out

screen_fade_in:
			lxi d, PERMANENT_PAL_MENU_ADDR + _pal_menu_palette_fade_to_load_relative
			mvi a, PERMANENT_PAL_MENU_RAM_DISK_S
			jmp pallete_fade_in

screen_draw_frame:
			; back
			lxi d, _tim_main_menu_back
			jmp tiled_img_draw

; in:
; hl - a specific update func ptr
screen_simple_update:
			shld @spec_update_func + 1
@loop:
			CHECK_GAME_UPDATE_COUNTER(game_updates_required)

@spec_update_func:
			call TEMP_ADDR
			call backs_update
			call bullets_update

			; to check repeated key-pressing
			lda action_code
			sta action_code_old

			jmp @loop

screen_simple_draw:
			; update counter to calc fps
			lhld game_draw_counter
			inx h
			shld game_draw_counter

			; draw funcs
			call backs_draw
			call bullets_draw
			call bullets_copy_to_scr
			call bullets_erase
			ret

; draw a space button as a back object
; draw a text referenced by _options_screen_return label
screen_draw_return_text_button:
			; draw a text
			lxi d, _options_screen_return

; draw a space button as a back object
; and a custom text at the custom pos
; in:
; hl - screen_pos
; de - text_addr

screen_draw_return_button_custom_text:
			call text_ex_draw

			; braw a button
			@pos_tiles_y = 1
			@pos_tiles_x = 13
			mvi c, @pos_tiles_x + @pos_tiles_y * TILE_HEIGHT
			; dialog_press_key (tiledata = 162)
			mvi b, 162
			; b - tiledata
			; c - tile_idx in the room_tiledata array.
			jmp backs_spawn