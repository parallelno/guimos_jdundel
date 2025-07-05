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
; .word - two safety bytes prevent data corruption caused by interruptions
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
; sprite 24x15:
; prep: 18*4=72cc
; loop: (11*9 + 5)*15 * 4 = 6240cc
; total: 6312 cc
; total + init: 6312 + 53*4 = 6524 cc

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

; 9*4=36cc
.macro DRAW_SPRITE_V_M()
			pop b
			mov a, m
			ana c
			ora b
			mov m, a
.endmacro


/*
; draws a sprite by rows. each row is variable pxls height and have an offset
; in:
; bc - sprite data
; de - screen addr

; data format:
; .word - two safety bytes prevent data corruption caused by interruptions
; new row:
; .word - row_scr_addr_offset_xy - row offset relative to
; 														the previous row or the
; 														sprite bottom-left corner 
; 														if it's the first row
; .byte - height, row_id+1
; first byte:
; .byte mask, color_scr1, color_scr2, color_scr3
; next byte above:
; .byte mask, color_scr3, color_scr2, color_scr1
; ...
; new row:
; ...
; last bytes:
; .word scr_offset - offset to the bootom-left corner of the sprite visible area.
;						Used for sprite_copy_to_scr and sprite_erase funcs
; .byte - NULL, row_id+1
; .byte - height, width

draw_spite_rvm: ; r - draw by rows, v - variable pxls height, m - mask support
			; store SP
			lxi h, 0
			dad sp
			shld draw_sprite_restore_sp + 1
			; sp = BC
			mov	h, b
			mov	l, c
			sphl

			xchg
			hl - scr addr

@next_row:
			pop b ; bc - row_scr_addr_offset_xy
			dad b
			pop b ; c - height, b - row_id+1
			dcr b
			jz @end

			mov a, h
			sta @init_x + 1
			adi $20
			sta @init_x_plus_20_01 + 1
			sta @init_x_plus_20_02 + 1
			adi $20
			sta @init_x_plus_40 + 1			

@loop:	
// odd byte from Scr1 to Scr3
    		// Scr1
			pop b ; b - color_scr1, c - mask
			mov a, m
			ana c
			ora b
			mov m, a

@init_x_plus_20_01:
			mvi h, TEMP_BYTE ; init_x + 0x20
			mov d, c

			// Scr2
			mov a, m
			ana c
			pop b ; c - color_scr2, b - color_scr3
			ora c
			mov m, a

@init_x_plus_40:
			mvi h, TEMP_BYTE ; init_x + 0x40

			// Scr3
			mov a, m
			ana d
			ora b
			mov m, a
			
			inr l ; X + 1

			dcr e
			jz @check_end
			
// even byte. from Scr3 to Scr1
			
			// Scr3
			pop b ; b - color_scr3, c - mask
			mov a, m
			ana c
			ora b
			mov m, a

@init_x_plus_20_02:
			mvi h, TEMP_BYTE ; init_x + 0x20
			mov d, c

			// Scr2
			mov a, m
			ana c
			pop b ; c - color_scr2, b - color_scr1
			ora c
			mov m, a
@init_x:
			mvi h, TEMP_BYTE ; init_x + 0x00

			// Scr1
			mov a, m
			ana d
			ora b
			mov m, a
			
			inr l ; X + 1

			dcr e
			jnz @loop
			
			jmp @next_row

@end:
			; read scr offset to 
			pop b ; b - width, c - height
			mov d, b
			mov e, c
draw_sprite_restore_sp:
			lxi sp, TEMP_ADDR
			mov b, h
			mov c, l
			ret
*/


/*
; draws a sprite 24xN pxls, line by line
; in:
; SP - sprite addr
; HL - scr addr
; D - width in bytes
; E - height

; sprite format:
; mask, color_scr1, color_scr2, color_scr3
; mask, color_scr3, color_scr2, color_scr1
; mask, color_scr1, color_scr2, color_scr3
; next line data
; mask, color_scr3, color_scr2, color_scr1
; mask, color_scr1, color_scr2, color_scr3
; mask, color_scr3, color_scr2, color_scr1
; next line data
; ...

draw_spite_w24:
; prep
			mvi $dx
			add h
			sta @init_x_plus_dx
			adi $dx
			sta @init_x_plus_dx
			adi $dx
			sta @init_x_plus_dx
			adi $dx
			sta @init_x_plus_dx
			adi $dx
			sta @init_x_plus_dx
			adi $dx
			sta @init_x_plus_dx
			adi $dx
			sta @init_x_plus_dx
			adi $dx
			sta @init_x_plus_dx
			adi $dx
			sta @init_x_plus_dx
			adi $dx
			sta @init_x_plus_dx
			adi $dx
			sta @init_x_plus_dx
			adi $dx
			sta @init_x_plus_dx

loop:
// first byte from Scr1 to Scr3
    		// Scr1
			pop b ; b - color_scr1, c - mask
			mov a, m
			ana c
			ora b
			mov m, a

			mvi h, TEMP_BYTE ; init_x + 0x20
			mov d, c

			// Scr2
			mov a, m
			ana c
			pop b ; c - color_scr2, b - color_scr3
			ora c
			mov m, a

			mvi h, TEMP_BYTE ; init_x + 0x40

			// Scr3
			mov a, m
			ana d
			ora b
			mov m, a
			
			inr h ; X + 1
			; 32*4=
			
// second byte from Scr3 to Scr1
			
			// Scr3
			pop b ; b - color_scr3, c - mask
			mov a, m
			ana c
			ora b
			mov m, a

			mvi h, TEMP_BYTE ; init_x + 0x21
			mov d, c

			// Scr2
			mov a, m
			ana c
			pop b ; c - color_scr2, b - color_scr1
			ora c
			mov m, a

			mvi h, TEMP_BYTE ; init_x + 0x01

			// Scr1
			mov a, m
			ana d
			ora b
			mov m, a
			
			inr h ; X + 1

// last byte from Scr1 to Scr3
			
			// Scr1
			pop b ; b - color_scr1, c - mask
			mov a, m
			ana c
			ora b
			mov m, a

			mvi h, TEMP_BYTE ; init_x + 0x22
			mov d, c

			// Scr2
			mov a, m
			ana c
			pop b ; c - color_scr2, b - color_scr3
			ora c
			mov m, a

			mvi h, TEMP_BYTE ; init_x + 0x42

			// Scr3
			mov a, m
			ana d
			ora b
			mov m, a
			
			inr l ; Y + 1

			dcr e
			jz @end
            
// repeat the loop code above in reverse
            dcr e
            jnz @loop

			; sprite 24 x 15 perf:
            ; prep: (6*12 + 1)*4=292 cc
			; loop: (96 + 5) * 15 * 4 = 6060 cc
			; total: 6352 cc
            ; 47.05 cc per byte
            ; 44.83 cc per byte w/o a loop counter
*/
