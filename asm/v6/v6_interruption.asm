
;----------------------------------------------------------------
; The interruption sub which supports stack manipulations in 
; the main program without di/ei.

; If the main program is doing "pop RP" operation to read some data, 
; and an interruption happens, then i8080 performs "push PC" 
; corrupting the data where sp was pointing to. The interruption sub 
; below restores the corrupted data using BC register pair. To make
; it works the main program has to use only pop B when it needs to
; use the stack to manipulate the data, also the data read by stack
; has to have two extra bytes 0,0 stored in front of the actual data
; to not let the "push PC" corrupts the data before BC pair gets it.
interruption:
			; get the return addr which this interruption call stored into the stack
			xthl
			shld interruption_return + 1
			pop h
			shld interruption_restoreHL + 1
			; store psw as the first element in the interruption stack
			; because the following dad psw corrupts it
			push psw
			pop h
			shld STACK_INTERRUPTION_ADDR-2
			
			lxi h, 0
			dad sp
			shld interruption_restoreSP + 1

			; restore two bytes that were corrupted by this interruption call
			push b

			; dismount ram disks to not damage the ram-disk data with the interruption stack
			RAM_DISK_OFF_NO_RESTORE()
			lxi sp, STACK_INTERRUPTION_ADDR-2
			push b
			push d

			CALL_RAM_DISK_FUNC_NO_RESTORE(v6_sound_update, RAM_DISK_M_SONG01 | RAM_DISK_M_8F)

;======================================================================================================================			
;
;			interruption main logic start
;
			call controls_check

			;check for a palette update
palette_update_request_:
			mvi a, PALETTE_UPD_REQ_NO ; this constant value is mutable, do not replace it with xra a
			CPI_ZERO(PALETTE_UPD_REQ_NO)
			jz @set_border_scrolling
			; set a palette
			; hl - the addr of the last item in the palette
			lxi h, palette + PALETTE_LEN - 1
			call set_palette_int
			; reset update
			A_TO_ZERO(PALETTE_UPD_REQ_NO)
			sta palette_update_request

@set_border_scrolling:
			; a border color, scrolling set up
			mvi a, PORT0_OUT_OUT
			out 0
			lda border_color_idx
			out 2
			lda scr_offset_y
			out 3

			; it's used in the main program to 
			; keep the update synced with interruption
			lxi h, game_updates_required
			inr m

			; fps update
			lxi h, ints_per_sec_counter
			dcr m

			jnz interruption_no_fps_update
			; a second is over
interruption_fps:
			lxi h, TEMP_WORD
			/*
			; commented out because FPS indication is drawn by 
			; the script in the Devector emulator
			; hl - fps
			mov a, l
			; draw fps
			; a - <fps
			draw_fps()
			*/
			lxi h, 0
			shld interruption_fps + 1
			lxi h, ints_per_sec_counter
			mvi m, INTS_PER_SEC
interruption_no_fps_update:				
;===========================================================================
;
;			; interruption main logic end

			pop d
			pop b
			pop psw
			mov l, a
			; restore the ram-disk mode
			RAM_DISK_RESTORE()
			; restore A
			mov a, l

interruption_restoreHL:	
			lxi		h, TEMP_WORD
interruption_restoreSP:	
			lxi		sp, TEMP_ADDR
			ei
interruption_return:	
			jmp TEMP_ADDR

ints_per_sec_counter:
			.byte INTS_PER_SEC

; a lopped counter increased every game draw call
game_draw_counter = interruption_fps + 1
palette_update_request = palette_update_request_ + 1