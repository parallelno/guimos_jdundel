@memusage_app_utils
; functions that common accross this specific game
;


; it fills the main ram, backbuffer, backbuffer2
; set SCR_BUFF0 (only in the main mem), SCR_BUFF1, SCR_BUFF2 to zero
; set SCR_BUFF3 to $ff
fill_all_black:
			; set SCR_BUFF0, SCR_BUFF1, SCR_BUFF2 to zero
			; set SCR_BUFF3 to $ff
			; that represents the darkest possible color in the current palette
			A_TO_ZERO(RAM_DISK_OFF_CMD)
			lxi d, SCR_BUFF_LEN * 3 / 32 - 1
			call fill_buff_black

			; do the same for backbuffer and backbuffer2
			; set SCR_BUFF1, SCR_BUFF2 to zero
			; set SCR_BUFF3 to $ff
			; that represents the darkest possible color in the current palette
			mvi a, RAM_DISK_S_BACKBUFF
			lxi d, SCR_BUFF_LEN * 2 / 32 - 1
			call fill_buff_black

			mvi a, RAM_DISK_S_BACKBUFF2
			lxi d, SCR_BUFF_LEN * 2 / 32 - 1
			call fill_buff_black
			ret

; it fills SCR_BUFF3 with $ff
; it erases SCR_BUFF2, optionally <SCR_BUFF1, SCR_BUFF0>
; that represents the darkest possible color in the current palette
; in:
; a - RAM Disk activation command
;		a = 0 if you erase the main memory
; de - buff_len/32-1 that have to be erased
fill_buff_black:
			; set SCR_BUFF0, SCR_BUFF1, SCR_BUFF2 to zero
			lxi b, SCR_BUFF3_ADDR
			push psw
			call mem_erase_sp
			pop psw
			; set SCR_BUFF3 to $ff
			lxi h, $FFFF
			lxi b, 0
			lxi d, SCR_BUFF_LEN / 32 - 1
			jmp mem_fill_sp

reset_game_updates_required_counter:
			A_TO_ZERO(NULL)
			sta game_updates_required
			ret

; pause the main programm
; in:
; hl - delay. 1000 is roughly 1 sec
; uses:
; hl, a
pause:
@loop:
			mvi a, 138
@loop_small:
			dcr a
			jnz @loop_small
			; a = 0
			mov a, a ; 8cc delay
			dcx h
			mov a, l ; ora l replaced with mov a, l to get 4cc delay
			ora h
			jnz @loop
			ret