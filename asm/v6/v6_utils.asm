.include "asm/v6/v6_rnd.asm"

; shared chunk of code to restore SP
; and dismount the ram-disk
restore_sp_ret:
			lxi sp, TEMP_ADDR
			RAM_DISK_OFF()
			ret


; erase a memory buffer (ram)
; 	hl - source
; 	bc - length
; out: 
;	hl - source + len
;	bc - source + len
; prep: 48cc
; loop: 32-64cc
; copy 4 bytes: 48 + 32*4 + 32 * 1 = 208
; copy 32 bytes: 48 + 32*32 + 32 * 1 = 1104
mem_erase:
			mvi e, 0
mem_fill:
			BC_TO_BC_PLUS_HL()
			; hl - source
			; bc - source + len
@loop2:
			mov a, c
@loop:
			mov m, e
			inx h

			cmp l
			jnz @loop
			mov a, b
			cmp h
			jnz @loop2
			ret


; clears a memory buffer using stack operations
; can be used to clear the ram-disk as well
;		IT CORRUPTS TWO BYTES BEFORE THE BUFFER if disable_int = false!
.macro MEM_ERASE_SP(buf_start, buff_len, command = RAM_DISK_OFF_CMD, disable_int = false)
		.if disable_int
			di
		.endif
			lxi h, >((buf_start + buff_len)<<8) | <(buf_start + buff_len)
			lxi d, buff_len / 32 - 1
			mvi a, command
			call mem_erase_sp
		.if disable_int
			ei
		.endif
.endmacro
; input:
; hl - the next addr after the erased buffer
; de - length // 32 - 1
; a - ram-disk activation command
; 		a = 0 to clear the main memory
; use:
; hl
mem_erase_sp:
			shld @buff_end+1

			RAM_DISK_ON_BANK()
			lxi h, 0x0000
			dad sp
			shld restore_sp_ret + 1
@buff_end:	
			lxi sp, TEMP_ADDR
@filler:
			lxi b, $0000
			mvi a, 0xFF
@loop:
			PUSH_B(16)

			dcx d
			cmp d
			jnz @loop
			jmp restore_sp_ret
mem_erase_sp_filler = @filler

; copy a memory buffer (ram to ram )
; 	hl - source
; 	de - destination
; 	bc - length
; out: 
;	hl - source + len
;	bc - source + len
;	de - destination + len
; prep: 40cc
; loop: 56-76cc
; copy 4 bytes: 40 + 56*4 + 20 * 1 = 284cc
; copy 32 bytes: 40 + 56*32 + 20 * 1 = 1852cc
; copy 128 bytes: 40 + 56*128 + 20 * 1 = 7228cc
.function mem_copy()
			BC_TO_BC_PLUS_HL()
			; hl - source
			; bc - source + len
			; de - destination
@loop:
			; copy a byte
			mov a, m
			stax d
			inx h
			inx d
			; check the end
			mov a, c
			sub l
			jnz @loop
			; a = 0
			add b
			cmp h
			jnz @loop
			;ret
.endf


;========================================
; copy a memory buffer (ram to ram-disk )
; disable INTERRUPTIONS before calling it!
; in:
; de - source
; hl - destination
; bc - length, must be divisible by 2
; a - ram-disk activation command

; prep: 140cc
; copy a word: 64-96cc
; TODO: optimization: unroll the loop 4 or more times, 
; then start it depending on the remined:
; start_here_if_len%4=0: COPY_WORD_MACRO()
; start_here_if_len%4=1: COPY_WORD_MACRO()
; start_here_if_len%4=2: COPY_WORD_MACRO()
; start_here_if_len%4=3: COPY_WORD_MACRO()
; dcx d
; jnz
; copy a word: (12*4*4 + 4*4)/4 = 52cc

.function mem_copy_to_ram_disk()
			dad b
			shld @dest+1

			; store sp
			RAM_DISK_ON_BANK_NO_RESTORE()
			lxi h, $0000
			dad sp
			shld @restore_sp+1			
@dest:
			lxi sp, TEMP_ADDR

			mov h, d
			mov l, e
			dad b
			; hl - source + len
			; de - source
@loop2:
			mov a, e
@loop:
			; copy a word to ram-disk
			dcx h
			mov b, m
			dcx h
			mov c, m
			push b
			; check the end
			cmp l
			jnz @loop
			mov a, d
			cmp h
			jnz @loop2

@restore_sp:
			lxi sp, TEMP_ADDR
			RAM_DISK_OFF_NO_RESTORE()
			;ret
.endf


;========================================
; copy a memory buffer (ram-disk to ram )
; works with enabled interruptions
; it corrupts a pair of bytes at source addr-2
; in:
; hl - source
; de - destination
; bc - length, must be divisible by 2
; a - ram-disk activation command

; prep: 152cc
; loop: 60-92cc
; TODO: optimization: unroll the loop 4 or more times, 
; then start it depending on the remined:

.function mem_copy_from_ram_disk()
			shld @source+1

			RAM_DISK_ON_BANK()
			lxi h, 0x0000
			dad sp
			shld restore_sp_ret + 1

@source:
			lxi sp, TEMP_ADDR
			mov h, d
			mov l, e
			dad b
			xchg

			; hl - destination
			; de - destination + len			
@loop2:
			mov a, e
@loop:
			; read a word
			pop b
			mov m, c
			inx h
			mov m, b
			inx h
			; check the end
			cmp l
			jnz @loop
			mov a, d
			cmp h
			jnz @loop2

			jmp restore_sp_ret
.endf


; Read a word from the ram-disk w/o blocking interruptions
; It requires two reserved bytes prior the read data
; input:
; de - data addr in the ram-disk
; a - ram-disk activation command
; use:
; de, a
; out:
; bc - data
; used: hl
; cc = 148
get_word_from_ram_disk:
			RAM_DISK_ON_BANK()
			; store sp
			lxi h, $0000
			dad sp
			shld restore_sp_ret+1

			; copy unpacked data into the ram_disk
			xchg
			sphl
			pop b ; bc has to be used when interruptions is on

			jmp restore_sp_ret

; a special version of a func above for accessing addr $8000 and higher
; cc = 100
.function get_word_from_scr_ram_disk()
			RAM_DISK_ON_BANK()
			xchg
			mov c, m
			inx h
			mov b, m
			RAM_DISK_OFF()
			;ret
.endf


; adds the offset to the pointers in the array
; in:
; hl - points to the array of ptrs to the data
; de - the data addr
; c - the len of the array
; out:
; hl - points to the next byte after the array
; c = 0
; de - same

.function update_labels()
@loop:
			mov a, m
			add e
			mov m, a
			inx h
			mov a, m
			adc d
			mov m, a
			inx h

			dcr c
			jnz @loop
			ret
.endf


; Set the palette
; input: hl - the addr of the last item in the palette
; use: hl, b, a

set_palette:
			hlt
set_palette_int:			; call it from an interruption routine
			mvi	a, PORT0_OUT_OUT
			out	0
			mvi	b, PALETTE_LEN - 1

@loop:		mov	a, b
			out	2
			mov a, m
			out 0x0C
			push psw
			pop psw
			push psw
			pop psw
			dcx h
			dcr b
			out 0x0C

			jp	@loop
			ret


; Copy the pallete, then request for using it
; in:
; hl - palette addr
; uses: bc, de, hl, a
.function copy_palette_request_update()
			lxi d, palette
			lxi b, PALETTE_LEN
			call mem_copy
			lxi h, palette_update_request
			mvi m, PALETTE_UPD_REQ_YES
			;ret
.endf


; empty func
; used as a placeholder for empty callbacks
.function empty_func()
			;ret ; commented because of .endf
.endf
