; sharetable chunk of code to restore SP and 
; return a couple of parameters within HL, C
sprite_draw_ret_ram_disk:
			RAM_DISK_OFF()
sprite_draw_scr_addr_ram_disk:
			lxi b, TEMP_ADDR
sprite_draw_width_height_ram_disk:
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
; width is 1-3 bytes
; height is 0-255
; offset_x in bytes
; offset_y in pixels
; it uses sp to read the sprite data
; in:
; bc - sprite data
; de - screen addr
; a - ram-disk activation command
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
			RAM_DISK_ON_BANK()
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
			shld sprite_draw_scr_addr_ram_disk+1

			; store sprite width and height
			pop b			
			mov d, b
			mov e, c
			xchg
			; h, b - width, 
			; l, c - height			
			shld sprite_draw_width_height_ram_disk+1
			xchg		
			; d, b - width, 
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
			SPRITE_VM_DRAW()
			inr h
			SPRITE_VM_DRAW()
@w16evenScr2:
			mov h, d
			SPRITE_VM_DRAW()
			dcr h
			SPRITE_VM_DRAW()
@w16evenScr3:
			mvi h, TEMP_BYTE
			SPRITE_VM_DRAW()
			dcr h
			SPRITE_VM_DRAW()
			inr l
			dcr e
			jz sprite_draw_ret_ram_disk

@w16oddScr3:
			SPRITE_VM_DRAW()
			inr h
			SPRITE_VM_DRAW()
@w16oddScr2:
			mov h, d
			SPRITE_VM_DRAW()
			dcr h
			SPRITE_VM_DRAW()
@w16oddScr1:
			mvi h, TEMP_BYTE
			SPRITE_VM_DRAW()
			dcr h
			SPRITE_VM_DRAW()
			inr l
			dcr e
			jnz @w16evenScr1
			jmp sprite_draw_ret_ram_disk
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
			SPRITE_VM_DRAW()
			inr h
			SPRITE_VM_DRAW()
			inr h
			SPRITE_VM_DRAW()

@w24evenScr2:
			mov h, d
			SPRITE_VM_DRAW()
			dcr h
			SPRITE_VM_DRAW()
			dcr h
			SPRITE_VM_DRAW()

@w24evenScr3:
			mvi h, TEMP_BYTE
			SPRITE_VM_DRAW()
			dcr h
			SPRITE_VM_DRAW()
			dcr h
			SPRITE_VM_DRAW()
			inr l
			dcr e
			jz sprite_draw_ret_ram_disk

@w24oddScr3:
			SPRITE_VM_DRAW()
			inr h
			SPRITE_VM_DRAW()
			inr h
			SPRITE_VM_DRAW()
@w24oddScr2:
			mov h, d
			SPRITE_VM_DRAW()
			dcr h
			SPRITE_VM_DRAW()
			dcr h
			SPRITE_VM_DRAW()
@w24oddScr1:
			mvi h, TEMP_BYTE
			SPRITE_VM_DRAW()
			dcr h
			SPRITE_VM_DRAW()
			dcr h
			SPRITE_VM_DRAW()
			inr l
			dcr e
			jnz @w24evenScr1
			jmp sprite_draw_ret_ram_disk
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
			SPRITE_VM_DRAW()
@w8evenScr2:
			mov h, d
			SPRITE_VM_DRAW()
@w8evenScr3:
			mvi h, TEMP_BYTE
			SPRITE_VM_DRAW()
			inr l
			dcr e
			jz sprite_draw_ret_ram_disk
@w8oddScr3:
			SPRITE_VM_DRAW()
@w8oddScr2:
			mov h, d
			SPRITE_VM_DRAW()
@w8oddScr1:
			mvi h, TEMP_BYTE
			SPRITE_VM_DRAW()
			inr l
			dcr e
			jnz @w8evenScr1
			jmp sprite_draw_ret_ram_disk
_sprite_vm_draw_end:
			
.macro SPRITE_VM_DRAW()
			pop b
			mov a, m
			ana c
			ora b
			mov m, a
.endmacro
