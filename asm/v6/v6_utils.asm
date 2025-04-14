.include "asm/v6/v6_rnd.asm"
.include "asm/v6/v6_dzx0.asm"

; shared chunk of code to restore SP
; and dismount the ram-disk
restore_sp:
			lxi sp, TEMP_ADDR
			RAM_DISK_OFF()
			ret


; erase a memory buffer (ram)
; 	hl - source
;	bc - source + len
; out: 
;	hl - source + len
;	bc - source + len
; prep: 8cc
; loop: 32-64cc
; copy 4 bytes: 48 + 32*4 + 32 * 1 = 208
; copy 32 bytes: 48 + 32*32 + 32 * 1 = 1104
mem_erase:
			mvi e, 0
; e - filler
mem_fill:
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
			lxi b, >((buf_start + buff_len)<<8) | <(buf_start + buff_len)
			lxi d, buff_len / 32 - 1
			mvi a, command
			call mem_erase_sp
		.if disable_int
			ei
		.endif
.endmacro
; input:
; bc - source + len
; de - length // 32 - 1
; a - ram-disk activation command
; 		a = 0 to clear the main memory
; use:
; hl
mem_erase_sp:
			RAM_DISK_ON_BANK()
			lxi h, 0x0000
			dad sp
			shld restore_sp + 1
			mov h, b
			mov l, c
mem_erase_sp_filler:
			lxi b, $0000
			sphl
			mvi a, 0xFF
@loop:
			PUSH_B(16)

			dcx d
			cmp d
			jnz @loop
			jmp restore_sp

; fill a memory buffer with a word using stack operations
; can be used to clear ram-disk memory as well
; input:
; hl - a filler word
; bc - the last addr of a erased buffer + 1
; de - length/32 - 1
; a - ram disk activation command
; 		a = 0 to clear the main memory
mem_fill_sp:
			shld mem_erase_sp_filler + 1
			call mem_erase_sp
			lxi h, 0
			shld mem_erase_sp_filler + 1
			ret

; copy a memory buffer (ram to ram )
; in:
; 	hl - source
; 	de - destination
;	bc - len
; prep: 40cc
mem_copy_len:
			BC_TO_BC_PLUS_HL()
; in:
; 	hl - source
; 	de - destination			
;	bc - source + len
; prep: 0cc
; loop: 56-76cc
mem_copy:
			; hl - source
			; de - destination
			; bc - source + len			
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
			ret

;========================================
; copy a memory buffer (ram to ram-disk)
; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
; !!! IT CORRUPTS TWO BYTES BEFORE THE BUFFER !!!
; !!!        IF INTERRUPTIONS ARE ENABLED     !!!
; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
MEM_COPY_WORD_LEN = 5
; in:
; de - source
; hl - destination + len
; bc - len. len must be non-zero and divisible by 2
; a - ram-disk activation command
; out:
; de - source
; hl - source

; prep: (53+10+7)*4=280cc
; loop 32 bytes: 784cc - 784+32= 816cc
; copy 128 bytes: 280 + 784*4 + 32 = 3448cc
; copy 256 bytes: 280 + 784*8 + 32 = 6584cc
; copy 1024*24 bytes: 280 + 784*768 + 32*96 = 608,536cc
mem_copy_to_ram_disk:
			shld @dest + 1
			sta @mapping + 1

			; store sp
			lxi h, 0x0000
			dad sp
			shld restore_sp + 1

			; bc - len
			; get the jump addr to start the loop
			mvi a, 0b00011110 ; get the reminder of 32
			ana c
			HL_TO_A_PLUS_INT16(jmp_tbl)
			mov a, m
			inx h
			mov h, m
			mov l, a

			shld @start_loop + 1

			mov h, b
			mov l, c
			dad d
@mapping:
			mvi a, TEMP_BYTE			
			RAM_DISK_ON_BANK()
			
			; TODO: think of how to optimize these two movs
			mov b, d
			mov c, e

			mov a, c
@dest:
			lxi sp, TEMP_ADDR
@start_loop:
			jmp TEMP_ADDR

			; hl - source + len
			; bc - source
			; sp - destination + len
mem_copy_to_ram_disk_loop2:
			mov a, c
mem_copy_to_ram_disk_loop:
		.loop 16
			MEM_COPY_WORD()
		.endloop
			; check the end
			cmp l
			jnz mem_copy_to_ram_disk_loop
			mov a, b
			cmp h
			jnz mem_copy_to_ram_disk_loop2
			jmp restore_sp
jmp_tbl:
			.word mem_copy_to_ram_disk_loop + MEM_COPY_WORD_LEN * 0
			.word mem_copy_to_ram_disk_loop + MEM_COPY_WORD_LEN * 15
			.word mem_copy_to_ram_disk_loop + MEM_COPY_WORD_LEN * 14
			.word mem_copy_to_ram_disk_loop + MEM_COPY_WORD_LEN * 13
			.word mem_copy_to_ram_disk_loop + MEM_COPY_WORD_LEN * 12
			.word mem_copy_to_ram_disk_loop + MEM_COPY_WORD_LEN * 11
			.word mem_copy_to_ram_disk_loop + MEM_COPY_WORD_LEN * 10
			.word mem_copy_to_ram_disk_loop + MEM_COPY_WORD_LEN * 9
			.word mem_copy_to_ram_disk_loop + MEM_COPY_WORD_LEN * 8
			.word mem_copy_to_ram_disk_loop + MEM_COPY_WORD_LEN * 7
			.word mem_copy_to_ram_disk_loop + MEM_COPY_WORD_LEN * 6
			.word mem_copy_to_ram_disk_loop + MEM_COPY_WORD_LEN * 5
			.word mem_copy_to_ram_disk_loop + MEM_COPY_WORD_LEN * 4
			.word mem_copy_to_ram_disk_loop + MEM_COPY_WORD_LEN * 3
			.word mem_copy_to_ram_disk_loop + MEM_COPY_WORD_LEN * 2
			.word mem_copy_to_ram_disk_loop + MEM_COPY_WORD_LEN * 1

; 12*4=48cc
; len = 5 bytes
.macro MEM_COPY_WORD()
			dcx h
			mov d, m
			dcx h
			mov e, m
			push d
.endmacro

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
			shld restore_sp + 1

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

			jmp restore_sp
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
			shld restore_sp+1

			; copy unpacked data into the ram_disk
			xchg
			sphl
			pop b ; bc has to be used when interruptions is on

			jmp restore_sp

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


; Converts local labels to absolute by adding the absolute address
; The the array data must ends with EOD word
; in:
; hl - points to the array of local ptrs to the data
; bc - the abslute offset

; out:
; hl - points to the last byte of EOD
; bc - same
update_labels_eod:
@loop:
			; read the local ptr
			mov e, m
			inx h
			mov d, m
			; ret if EOD
			mov a, e
			ora d
			rz
			xchg
			dad b
			xchg
			; store the offseted addr
			dcx h
			mov m, e
			inx h
			mov m, d
			inx h
			jmp @loop

; Converts local labels to absolute by adding the absolute address 
; in:
; hl - points to the array of ptrs to the data
; de - the abslute data addr
; c - the len of the array. if the array contains two word ptrs, then c = 2
; out:
; hl - points to the next byte after the array
; c = 0
; de - same
update_labels_len:
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


; Copy the pallete, 
; then request for using it
; in:
; hl - ram-disk palette addr
; a - ram-disk activation command
; uses: bc, de, hl, a
copy_palette_request_update:
			lxi d, palette
			lxi b, PALETTE_LEN
			mem_copy_from_ram_disk()

			lxi h, palette_update_request
			mvi m, PALETTE_UPD_REQ_YES
			ret

; TODO: think of storing all palettes in one place, ram or ram-disk
; that will unify copy_palette_request_update and copy_palette_request_update_rd
; Copy the pallete from the ram-disk,
; then request for using it
; in:
; a - ram-disk activation command
; hl - palette addr
; uses: bc, de, hl, a
copy_palette_request_update_rd:
			lxi d, palette
			lxi b, PALETTE_LEN
			call mem_copy_from_ram_disk
			lxi h, palette_update_request
			mvi m, PALETTE_UPD_REQ_YES
			ret


; empty func
; used as a placeholder for empty callbacks
empty_func:
			ret
