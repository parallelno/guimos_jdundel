@memusage_v6_decal_draw
;----------------------------------------------------------------
; draw a decal sprite with an alpha channel (16xN pixels)
; TODO: support width = 8
; input:
; bc - decal sprite data addr
; de - screen addr, d=[$80, $9f]
; use: a, hl, sp

; Data Layout:
; .word - two safety bytes prevent data corruption caused by interruptions
; .byte offset_y, offset_x
; .byte height, width
; 		0 - one byte width,
;		1 - two bytes width,
; pixel format:
; odd_line:
; 1st screen buff : 1 -> 2
; 2nd screen buff : 4 <- 3
; 3rd screen buff : 6 <- 5
; 4rd screen buff : 8 <- 7
; y++
; even_line:
; 4rd screen buff : 9 -> 10
; 3nd screen buff : 12 <- 11
; 2st screen buff : 14 <- 13
; 1st screen buff : 16 <- 15
; y++
; repeat for the next lines of the art data

.macro DRAW_DECAL_V_M()
			pop b
			mov a, m
			ana e
			ora c
			mov m, a
			inr h
			mov a, m
			ana d
			ora b
			mov m, a
.endmacro

.macro DRAW_DECAL_V_M_BACK()
			pop b
			mov a, m
			ana d
			ora c
			mov m, a
			dcr h
			mov a, m
			ana e
			ora b
			mov m, a
.endmacro

; the description is above!
draw_decal_v:
			; store sp
			lxi h, $0000
			dad sp
			shld @restore_sp + 1
			; bc - decal sprite data addr
			mov h, b
			mov l, c
			sphl
			xchg
			pop b
			; b - offset_x
			; c - offset_y
			; hl - scr addr
			dad b
			pop b

			A_TO_ZERO(0)	; this is a fix of line: dcr b
			cmp b			; we SHOULD NOT modify BC to prevent stack corruption!

			mov a, c
			jnz @drawWidth16
@drawWidth8:
; TODO: support width = 8
			jmp @restore_sp

; hl - scr addr
; sp - pixel data
; a - height

@width16 = 2
@drawWidth16:
			; store a max Y to check the end end the loop
			add l
			sta @maxY1+1
			sta @maxY2+1
			; store X addr to be able to restore it
			mov a, h
			adi @width16-1
			sta @scr82 + 1
			adi $20
			sta @scrA + 1
			sta @scrA2 + 1
			adi $20
			sta @scrC + 1
			sta @scrC2 + 1
			adi $20
			sta @scrE + 1

@odd_line:
			pop b ; an alpha
			mov e, c
			mov d, b
@scr8:
			DRAW_DECAL_V_M()
@scrA:		mvi h, TEMP_BYTE

			DRAW_DECAL_V_M_BACK()
@scrC:		mvi h, TEMP_ADDR

			DRAW_DECAL_V_M_BACK()
@scrE:		mvi h, TEMP_BYTE

			DRAW_DECAL_V_M_BACK()

			inr l
@maxY1:		mvi a, TEMP_BYTE
			cmp l
			jz @restore_sp

@even_line:
			pop b ; an alpha
			mov e, c
			mov d, b
@scrE2:
			DRAW_DECAL_V_M()
@scrC2:		mvi h, TEMP_ADDR

			DRAW_DECAL_V_M_BACK()
@scrA2:		mvi h, TEMP_BYTE

			DRAW_DECAL_V_M_BACK()
@scr82:		mvi h, TEMP_BYTE

			DRAW_DECAL_V_M_BACK()

			inr l
@maxY2:		mvi a, TEMP_BYTE
			cmp l
			jnz @odd_line

@restore_sp:
			lxi sp, TEMP_ADDR
			ret
draw_decal_v_end: