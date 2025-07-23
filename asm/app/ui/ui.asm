@memusage_ui
;=======================================================

HEALTH_SCR_ADDR = 0xA3FB
HERO_SCORE_SCR_ADDR = 0xB9FB


RES_TEXT_SCR_ADDR_0 = $a8fb
RES_SELECTION_FRAME_SCR_ADDR = $a000 + (6<<8) | 30*8
RES_DISPLAYED_MAX = 3

GAME_UI_ITEM_UPDATE_DELAY = 80

game_ui_init:
			A_TO_ZERO(NULL)
			sta game_ui_res_selected_ptr
			mvi a, <global_items
			sta game_ui_item_visible_addr
			ret

game_ui_draw:
			call game_ui_draw_panel
			call game_ui_draw_health_text
			call game_ui_draw_score_text
			jmp game_ui_draw_res

game_ui_update:
			call game_ui_draw_items
			jmp dialog_update


game_ui_draw_health_text:
			lxi h, hero_res_health
			lxi b, HEALTH_SCR_ADDR
			jmp text_mono_draw_int8_ptr


game_ui_draw_score_text:
			lhld hero_res_score

			lxi d, game_ui_score_txt
			push d
			call int16_to_ascii_dec
			pop h
			; hl = game_ui_score_txt
			lxi b, HERO_SCORE_SCR_ADDR
			jmp text_mono_draw
game_ui_score_txt:
			.byte $30, $30, $30, $30, $30, $30, 0


game_ui_draw_panel:
			lxi d, _ti0_frame_ingame_top
			jmp tiled_img_draw
game_ui_draw_icon_mana:
			lxi d, _ti0_res_mana
			jmp tiled_img_draw

;==================================================================================================
;
;	resource related routines
;
;==================================================================================================

; when a player hits action_2
; it selects the next non-empty resource
game_ui_res_select_next:
			lxi h, game_ui_res_selected_ptr
			mov l, m
			mvi c, RES_SELECTABLE_MAX
			A_TO_ZERO(0)
			cmp l
			rz ; return if no available

			; find the next available
@next_res:
			; check if the res ptr is not out of range
			inr l
			mvi a, <hero_res_end
			cmp l
			jnz @in_range
			mvi l, <RES_SELECTABLE_FIRST
@in_range:
			A_TO_ZERO(0)
			cmp m
			jnz game_ui_res_select
			dcr c
			jnz @next_res
			; selected the same resource, no need to redraw
			ret

; select the resource and draw resources
; if a resource is empty, select the first available
; in:
; hl - ptr to a resource ( ex. lxi h, hero_res_snowflake )
game_ui_res_select_and_draw:
			; check if a resource is not empty
			mov a, m
			CPI_ZERO()
			jnz @select_res
			call game_ui_res_get_first_available
@select_res:
			; hl - ptr to a resource
			; store res ptr
			mov a, l
			sta game_ui_res_selected_ptr
			jmp game_ui_draw_res
game_ui_res_select: = @select_res

; out:
; l - res ptr of the first non-empty resource
; l = 0 if all resources are empty
game_ui_res_get_first_available:
			lxi h, RES_SELECTABLE_FIRST
			mvi c, RES_SELECTABLE_MAX
			A_TO_ZERO(0)
@next_res:
			cmp m
			rnz
			inx h
			dcr c
			jnz @next_res
			; all res are empty
			mvi l, 0
			ret

; TODO: refactor this function
; draws available resource icons and a selection frame
; health and the score resources have their own dedicated draw functions
game_ui_draw_res:
			; check if no available res
			lxi h, game_ui_res_selected_ptr
			mov l, m
			A_TO_ZERO(0)
			cmp l
			jz @erase_all

			; find the first displayed res
			mvi c, RES_DISPLAYED_MAX
			; hl - selected res ptr
@loop:
			mov a, m
			CPI_ZERO()
			jz @next

			; store the first available res ptr
			mov b, l
			dcr c
			jz @found_first_displayed

@next:
			dcr l
			mov a, l
			cpi <RES_SELECTABLE_FIRST
			jnc @loop

@found_first_displayed:
			; b - the first displayed res ptr
			; store the displayed res counter
			mov a, c
			sta @draw_selection + 1
			mvi c, RES_DISPLAYED_MAX

@draw_loop:
			; hl - selected res ptr
			; b - resource low ptr
			; c - displayed res counter
			mov l, b
			mvi h, >hero_resources

			; check if a res is available
			mov a, m
			CPI_ZERO()
			jz @draw_loop_next

			push b
			call @draw_res_icon
			pop b
			dcr c
			jz @draw_selection

@draw_loop_next:
			inr b
			; check if the res ptr is not out of range
			mov a, b
			cpi <hero_res_end
			jnz @draw_loop
			call @draw_empty_res_loop
			jmp @draw_selection

@draw_res_icon:
			; b - res low ptr
			; c - displayed res counter
			mov a, b
			; res low ptr to tile_id
			sbi <hero_res_sword
			; tile_id to tiled graphics data ptr
			HL_TO_AX2_PLUS_INT16(@tiled_img_ptrs)
			mov e, m
			inx h
			mov d, m
			; de - tiled image data ptr
			; make the scr addr offset
			mvi a, RES_DISPLAYED_MAX
			sub c
			ADD_A(2) ; a * 4 because resources displayed every 4*8 pixels
			mov h, a
			mvi l, 0
			push b
			call @draw_icon
			pop b
@draw_res_text:
			; b - resource low ptr
			; c - displayed res counter
			mov l, b
			mvi h, >hero_resources

			; make the scr addr offset
			mvi a, RES_DISPLAYED_MAX
			sub c
			ADD_A(2)
			adi >RES_TEXT_SCR_ADDR_0
			mov b, a
			mvi c, <RES_TEXT_SCR_ADDR_0
			jmp text_mono_draw_int8_ptr

@erase_all:
			mvi c, RES_DISPLAYED_MAX
@draw_empty_res_loop:
			push b
			call @draw_empty_res_icon
			pop b
			dcr c
			jnz @draw_empty_res_loop
			ret

@draw_empty_res_icon:
			; c - displayed res counter
			lxi d, _ti0_res_empty
			; de - tiled image data ptr
			; make the scr addr offset
			mvi a, RES_DISPLAYED_MAX
			sub c
			ADD_A(2) ; a * 4 because resources displayed every 4*8 pixels
			mov h, a
			mvi l, 0
			; hl - scr adr offset
@draw_icon:
			; de - ptr to a tiled img
			jmp tiled_img_draw_pos_offset_set

@draw_selection:
			mvi c, TEMP_BYTE
			; c - selected res counter
			; selected res counter to the scr addr
			mvi a, RES_DISPLAYED_MAX - 1 ; because selected res counter was decreased at least once
			sub c
			ADD_A(2) ; a * 4 because resources displayed every 4*8 pixels
			adi >RES_SELECTION_FRAME_SCR_ADDR
			mov d, a
			mvi e, <RES_SELECTION_FRAME_SCR_ADDR
			; de - scr addr
			; draw the selection frame on top of the selected resorce
			lhld vfx_selection_anim + 2 ; the first frame absolute addr
			mov c, l
			mov b, h
			; bc - sprite data ptr
			; de - scr addr
			; render it to the main scr buff
			lda vfx_ram_disk_s_cmd
			; dissable the RAM disk M modes
			; to render on the screen, not the back buffer
			ani ~(RAM_DISK_M_8F | RAM_DISK_M_BACKBUFF)
			CALL_RAM_DISK_FUNC_BANK(sprite_draw_vm)
			ret

@tiled_img_ptrs:
			.word _ti0_res_sword
			.word _ti0_res_mana
			.word _ti0_res_tnt
			.word _ti0_res_potion_health
			.word _ti0_res_potion_mana
			.word _ti0_res_laundry
			.word _ti0_res_cabbage
			.word _ti0_res_spoon
			.word _ti0_res_scarecrow

;=============================================================================
; Game UI – Item Display Renderer & Selector
;=============================================================================
; Draws the currently available item in the UI.
; Automatically cycles to the next available item every
; GAME_UI_ITEM_UPDATE_DELAY game updates.
game_ui_draw_items:
			lxi h, @delay
			dcr m
			rnz
			mvi m, GAME_UI_ITEM_UPDATE_DELAY

			lxi h, game_ui_item_visible_addr
			mov e, m
			mvi d, >global_items
			mvi c, <global_items + ITEM_ID_UI_MAX
			mvi b, ITEM_ID_UI_MAX
			; de - addr to the currently shown item on the ui panel
@loop:
			inx d
			; check if addr in the range
			mov a, e
			cmp c
			jc @check_amount
			; clamp the ptr to the ITEM_ID_UI_MAX range
			mvi e, <global_items
@check_amount:
			; check if available
			ldax d
			cpi ITEM_STATUS_ACQUIRED
			jz @draw
			dcr b
			jnz @loop
			; no available items
			lxi d, _ti0_item_empty
			jmp @draw_icon
@draw:
			mov m, e
			; de - ptr to the item amount
			; make item_id
			mov a, e
			sui <global_items

			; a - item_id
			HL_TO_AX2_PLUS_INT16(@tiled_img_ptrs)
			mov e, m
			inx h
			mov d, m
@draw_icon:
			; de - ptr to a tiled img
			jmp tiled_img_draw

@delay:		.byte TEMP_WORD

@tiled_img_ptrs:
			.word _ti0_item_key_0	; item_id = 1
			.word _ti0_item_key_1	; item_id = 2
			.word _ti0_item_key_2	; item_id = 3
			.word _ti0_item_key_3	; item_id = 4
			.word _ti0_item_key_4	; item_id = 5
			.word _ti0_item_key_4 	; item_id = 6