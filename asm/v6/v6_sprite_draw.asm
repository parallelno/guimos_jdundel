; sharetable chunk of code to restore SP and
; return a couple of parameters within HL, C
draw_sprite_ret:
draw_sprite_restore_sp:
			lxi sp, TEMP_ADDR
draw_sprite_scr_addr:
			lxi b, TEMP_ADDR
draw_sprite_width_height:
; d - width
;		00 - 8pxs,
;		01 - 16pxs,
;		10 - 24pxs,
;		11 - 32pxs,
; e - height
			lxi d, TEMP_WORD
			ret


; =============================================
; Draw a sprite with a mask in three consiquence screen buffs with offset_x and offset_y
; it can draw a sprite from the ram-disk if it's properly activated
; width is 1-3 bytes
; height is 0-255
; offset_x in bytes
; offset_y in pixels
; it uses sp to read the sprite data
; ex. CALL_RAM_DISK_FUNC(sprite_draw_vm, RAM_DISK_S_BURNER | RAM_DISK_M_BACKBUFF | RAM_DISK_M_8F )
; in:
; bc - sprite data
; de - screen addr
; out:
; d - width
;		00 - 8pxs,
;		01 - 16pxs,
;		10 - 24pxs,
;		11 - 32pxs,
; e - height
; bc - sprite screen addr + offset
; use: a, hl, sp

; data format:
; .word - two safety bytes to prevent a data corruption by the interruption  func
; .byte - offset_y
; .byte - offset_x
; .byte - height
; .byte - width
; 		0 - one byte width,
;		1 - two bytes width,
;		2 - three bytes width

; pixel format:
; 1st screen buff : 1 -> 2
; 2nd screen buff : 4 <- 3
; 3rd screen buff : 6 <- 5
; y++
; 3rd screen buff : 7 -> 8
; 2nd screen buff : 10 <- 9
; 1st screen buff : 12 <- 11
; y++
; repeat for the next lines of the art data

sprite_draw_vm:	; VM stands for: V - variable height, M - mask support
			; store SP
			lxi h, 0
			dad sp
			shld draw_sprite_restore_sp + 1
			; sp = BC
			mov	h, b
			mov	l, c
			sphl
			xchg
			pop b
			; b - offset_x
			; c - offset_y
			dad b
			; store a sprite screen addr to return it from this func
			shld draw_sprite_scr_addr+1

			; store sprite width and height
			pop b
			mov d, b
			mov e, c
			xchg
			; h, b - width
			; l, c - height
			shld draw_sprite_width_height+1
			xchg
			; d, b - width
			; e, c - height
			mov a, b
			rrc
			jc @width16
			rrc
			jc @width24
			jmp @width8


;------------------------------------------------
@width16:
			; save the high screen byte to restore X
			rlc
			add h
			sta @w16oddScr1+1
			adi $20
			mov d, a
			adi $20
			sta @w16evenScr3+1

@w16evenScr1:
			DRAW_SPRITE_V_M()
			inr h
			DRAW_SPRITE_V_M()
@w16evenScr2:
			mov h, d
			DRAW_SPRITE_V_M()
			dcr h
			DRAW_SPRITE_V_M()
@w16evenScr3:
			mvi h, TEMP_BYTE
			DRAW_SPRITE_V_M()
			dcr h
			DRAW_SPRITE_V_M()
			inr l
			dcr e
			jz draw_sprite_ret

@w16oddScr3:
			DRAW_SPRITE_V_M()
			inr h
			DRAW_SPRITE_V_M()
@w16oddScr2:
			mov h, d
			DRAW_SPRITE_V_M()
			dcr h
			DRAW_SPRITE_V_M()
@w16oddScr1:
			mvi h, TEMP_BYTE
			DRAW_SPRITE_V_M()
			dcr h
			DRAW_SPRITE_V_M()
			inr l
			dcr e
			jnz @w16evenScr1
			jmp draw_sprite_ret
;-------------------------------------------------
@width24:
			; save the high screen byte to restore X
			mvi a, 2
			add h
			sta @w24oddScr1+1
			adi $20
			mov d, a
			adi $20
			sta @w24evenScr3+1

@w24evenScr1:
			DRAW_SPRITE_V_M()
			inr h
			DRAW_SPRITE_V_M()
			inr h
			DRAW_SPRITE_V_M()

@w24evenScr2:
			mov h, d
			DRAW_SPRITE_V_M()
			dcr h
			DRAW_SPRITE_V_M()
			dcr h
			DRAW_SPRITE_V_M()

@w24evenScr3:
			mvi h, TEMP_BYTE
			DRAW_SPRITE_V_M()
			dcr h
			DRAW_SPRITE_V_M()
			dcr h
			DRAW_SPRITE_V_M()
			inr l
			dcr e
			jz draw_sprite_ret

@w24oddScr3:
			DRAW_SPRITE_V_M()
			inr h
			DRAW_SPRITE_V_M()
			inr h
			DRAW_SPRITE_V_M()
@w24oddScr2:
			mov h, d
			DRAW_SPRITE_V_M()
			dcr h
			DRAW_SPRITE_V_M()
			dcr h
			DRAW_SPRITE_V_M()
@w24oddScr1:
			mvi h, TEMP_BYTE
			DRAW_SPRITE_V_M()
			dcr h
			DRAW_SPRITE_V_M()
			dcr h
			DRAW_SPRITE_V_M()
			inr l
			dcr e
			jnz @w24evenScr1
			jmp draw_sprite_ret
;------------------------------------------------------
@width8:
			; save the high screen byte to restore X
			mov a, h
			sta @w8oddScr1+1
			adi $20
			mov d, a
			adi $20
			sta @w8evenScr3+1

@w8evenScr1:
			DRAW_SPRITE_V_M()
@w8evenScr2:
			mov h, d
			DRAW_SPRITE_V_M()
@w8evenScr3:
			mvi h, TEMP_BYTE
			DRAW_SPRITE_V_M()
			inr l
			dcr e
			jz draw_sprite_ret
@w8oddScr3:
			DRAW_SPRITE_V_M()
@w8oddScr2:
			mov h, d
			DRAW_SPRITE_V_M()
@w8oddScr1:
			mvi h, TEMP_BYTE
			DRAW_SPRITE_V_M()
			inr l
			dcr e
			jnz @w8evenScr1
			jmp draw_sprite_ret
sprite_draw_vm_end:

.macro DRAW_SPRITE_V_M()
			pop b
			mov a, m
			ana c
			ora b
			mov m, a
.endmacro