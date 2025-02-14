.include "src/v6/v6_draw_text_ex_consts.asm"

LINE_SPACING_DEFAULT = -12
PARAG_SPACING_DEFAULT = -24

; set a default line and a paragraph spacing
.function text_ex_reset_spacing()
			mvi a, LINE_SPACING_DEFAULT
			sta text_ex_line_spacing + 1

			mvi a, PARAG_SPACING_DEFAULT
			sta text_ex_parag_spacing + 1
			;ret ; commented because of .endf
.endf

; set a line and a paragraph spacing
; in:
; c - line spacing
; b - paragraph spacing
.function text_ex_set_spacing()
			lxi h, text_ex_line_spacing + 1
			mov m, c
			lxi h, text_ex_parag_spacing + 1
			mov m, b
			;ret ; commented because of .endf
.endf

; draw a text with kerning. blend func - OR
; font gfx can be on the ram-disk. 
; the text data should be reachable by non-stack
; operations.
; char_id = 0 is EOD
; char_id = _LINE_BREAK_ is a new line
; in:
; de - text addr
; bc - pos_xy
; h - text gfx data ram-disk activation command
; l - SCR_BUFF3_ADDR or SCR_BUFF2_ADDR or SCR_BUFF1_ADDR

.function draw_text_ex()
.breakpoint			
			mov a, l
			sta @scr_buff_addr+1
			mov a, h
			RAM_DISK_ON_BANK()

			xchg
			; hl - text addr
			; store pos_x
			mov a, b
			sta text_ex_restore_pos_x + 1
@next_char:
			; get a char code
			mov e, m
			; return if it's 0
			A_TO_ZERO(NULL)
			ora e
			jz restore_sp_ret
			inx h
			; a - char_code
			; check if it is the end of the line
			cpi <_LINE_BREAK_
			jz text_ex_line_spacing
			; check if it is the end of the line
			cpi <_PARAG_BREAK_
			jz text_ex_parag_spacing

			mvi d, 0
			shld @restore_text_addr + 1  ; preserve the text data ptr
			; preserve pos_xy
			mov a, c
			sta @restore_pos_xy + 1
			mov a, b
			sta @restore_pos_xy + 2

			; get a char gfx pptr
			xchg
			dad h
			lxi d, font_gfx_ptrs - ADDR_LEN ; because there is no char_code = 0
			dad d
			; hl points to char gfx ptr
			; get a char gfx ptr
			mov e, m
			inx h
			mov d, m

			xchg
			; hl points to a char gfx
			sphl
			mov h, b
			mov l, c
			; hl - scr pos

			; add a pos_xy offset
			pop b
			dad b

			; calc a pxl shift
			mvi a, %111
			ana h
			; make a ptr to skip_dad dad h
			; de = a * 2 + @skip_dad_ptrs
			DE_TO_AX2_PLUS_INT16(@skip_dad_ptrs)

			; read skip_ptr
			xchg
			mov a, m
			inx h
			mov h, m
			mov l, a
			shld @skip_dad + 1

			; de - scr pos
			; pos_xy to scr addr
			mvi a, %11111000
			ana d
			RRC_(3)
@scr_buff_addr:
			adi TEMP_BYTE	; for ex. >SCR_BUFF1_ADDR
			mov d, a

			; draw a char
@loop:
			; de - scr addr
			; shift a pair of gfx bytes
			pop b
			; check if it is the end of the char gfx
			A_TO_ZERO(NULL)
			ora b
			jnz @advance_pos
			mov l, c
			mov h, b
@skip_dad:	jmp TEMP_ADDR

@shift1:	dad h
@shift2:	dad h
@shift3:	dad h
@shift4:	dad h
@shift5:	dad h
@shift6:	dad h
@shift7:	dad h

			ldax d
			ora h
			stax d
			inr d
			ldax d
			ora l
			stax d
			dcr d
			inr e
			jmp @loop

@shift0:
			ldax d
			ora c
			stax d
			inr e
			jmp @loop

@advance_pos:
			; bc - a pos offset
@restore_sp:
			lxi sp, 0x0002 ; safe SP addr
@restore_pos_xy:
			lxi h, TEMP_WORD ; restore pos_xy
			; advance a pos_xy to the next char
			dad b
			mov b, h
			mov c, l
@restore_text_addr:
			lxi h, TEMP_ADDR ; retore text addr

			jmp @next_char
@skip_dad_ptrs:
			.word @shift0, @shift1,	@shift2, @shift3, @shift4, @shift5, @shift6, @shift7

text_ex_next_char: = @next_char


; move a position to the next paragraph
text_ex_parag_spacing:
			mvi a, PARAG_SPACING_DEFAULT
			add c
			mov c, a
			jmp text_ex_restore_pos_x
; move a position to the next line
text_ex_line_spacing:
			mvi a, LINE_SPACING_DEFAULT
			add c
			mov c, a
text_ex_restore_pos_x:
			mvi b, TEMP_BYTE
			jmp text_ex_next_char
.endf