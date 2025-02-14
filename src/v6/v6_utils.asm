.include "src/v6/v6_rnd.asm"

; shared chunk of code to restore SP
; and dismount the ram-disk
restore_sp_:
			RAM_DISK_OFF()
			ret


; clears a memory buffer
; input:
; hl - addr to clear
; bc - length
; use:
; a
/*
.function mem_erase()
@loop:
			A_TO_ZERO(NULL)
			mov m, a
			inx h
			dcx b
			ora c
			ora b
			jnz @loop
			;ret
.endif
*/
; Fills a short, aligned memory buffer.
; The buffer length is <= 256 bytes.
; The buffer is aligned to a $100 (256-byte) memory block.
; input:
; hl - addr to clear
; a - the next addr (a low byte of address) after a buffer
; c - filler, if mem_fill_short is called
; use:
; a

mem_erase_short:
			mvi c, 0
mem_fill_short:
@loop:		mov m, c
			inr l
			cmp l
			jnz @loop
			ret



; clears a memory buffer using stack operations
; can be used to clear the ram-disk as well
; input:
; hl - the next addr after the erased buffer
; de - length // 32 - 1
; a - ram-disk activation command
; 		a = 0 to clear the main memory
; use:
; hl
;		IT CORRUPTS TWO BYTES BEFORE THE BUFFER!

.macro MEM_ERASE_SP(disable_int = false)
		.if disable_int
			di
		.endif
			call mem_erase_sp
		.if disable_int
			ei
		.endif
.endmacro

mem_erase_sp:
			shld @buff_end+1

			RAM_DISK_ON_BANK()
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
			jmp restore_sp_
mem_erase_sp_filler = @filler

; fill a memory buffer with a word using stack operations
; can be used to clear ram-disk memory as well
; input:
; hl - a filler word
; bc - the last addr of a erased buffer + 1
; de - length/32 - 1
; a - ram-disk activation command
; 		a = 0 to clear the main memory
/*
.function mem_fill_sp()
			shld mem_erase_sp_filler + 1
			call mem_erase_sp
			lxi h, 0
			shld mem_erase_sp_filler + 1
			;ret
.endf
*/
; clear the ram-disk using sp operations
; disables interruptions
; input:
/*
.function clear_ram_disk()
			di
			lxi b, $0000
			lxi d, $10000/32 - 1
			mvi a, RAM_DISK_S0
			push b
			push d
			MEM_ERASE_SP(true)
			pop d
			pop b

			mvi a, RAM_DISK_S1
			push b
			push d
			MEM_ERASE_SP(true)
			pop d
			pop b

			mvi a, RAM_DISK_S2
			push b
			push d
			MEM_ERASE_SP(true)
			pop d
			pop b

			mvi a, RAM_DISK_S3
			MEM_ERASE_SP(true)
			//ret ; commented out because .endf is replaced with ret
.endf
*/

; erase a block in the screen buff
; in:
; hl - scr_addr
; b - width/8
; c - height
/*
screen_erase_block:
			mov a, c
			add l
			mov c, l
@loop:
			mvi m, 0
			inr l
			cmp l
			jnz @loop

			inr h
			mov l, c

			dcr b
			jnz @loop
			ret
*/

; copy a memory buffer
; in:
; 	hl - source
; 	de - destination
; 	bc - length
; out:
; 	hl - points to the next byte after source buffer
;	de - points to the next byte after destination buffer
; use:
; a
; 12cc - preparation
; 64cc - loop iteration

.function mem_copy()
@loop:		mov a, m
			stax d
			inx h
			inx d
			dcx b

			mov a, c
			ora b
			jnz @loop
			;ret
.endf


;========================================
; copy a buffer into the ram-disk
; disable INTERRUPTIONS before calling it!
; in:
; de - source
; hl - destination
; bc - length, must be divisible by 2
; a - ram-disk activation command

; 140 - prep
; copy a word: 64-96cc
; TODO: optimization: unroll the loop 4 or more times, 
; then start it depending on the remined
; start_here_if_len%4=0: COPY_WORD_MACRO()
; start_here_if_len%4=1: COPY_WORD_MACRO()
; start_here_if_len%4=2: COPY_WORD_MACRO()
; start_here_if_len%4=3: COPY_WORD_MACRO()
; dcx d
; jnz
; copy a word: (12*4*4 + 4*4)/4 = 52cc

.function mem_copy_sp()

			dad b
			shld @dest+1

			RAM_DISK_ON_BANK(false)
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
			COPY_W_SP()

			cmp l
			jnz @loop
			mov a, d
			cmp h
			jnz @loop2

			RAM_DISK_OFF(false)
			;ret
.endf

.macro COPY_W_SP()
			dcx h
			mov b, m
			dcx h
			mov c, m
			push b
.endmacro


;========================================
; fast copy a buffer into the ram-disk.
; if interruptions are ON, it corrupts a pair of bytes at target addr-2 !!!
; input:
; de - source addr + data length
; hl - target addr + data length
; bc - buffer length / 32
; a - ram-disk activation command
; use:
; all
//		IT IS NOT RECOMMENDED TO USE THESE MACROS
//		BECAUSE OF THE RISK OF DATA CORRUPTION
//		RAM_DISK_ON_BANK macro must not be used before calling a function!
/*
.macro COPY_TO_RAM_DISK(count)
		.loop count
			dcx h
			mov d, m
			dcx h
			mov e, m
			push d
		.endloop
.endmacro

.function mem_copy_sp32()
			shld @restoreTargetAddr+1
			; store sp
			lxi h, NULL
			dad sp
			shld @restore__sp + 1
			RAM_DISK_ON_BANK()
@restoreTargetAddr:
			lxi sp, TEMP_ADDR
			xchg
@loop:
			COPY_TO_RAM_DISK(16)
			dcx b
			mov a, b
			ora c
			jnz @loop

@restore_sp:
			lxi sp, TEMP_ADDR
			RAM_DISK_OFF()
			;ret
.endf
*/

; Copy data (max 510) from the ram-disk to ram w/o blocking interruptions
; this macro is for checking if the length fits the range 1-510
/*
.macro COPY_FROM_RAM_DISK(length)
		.if length > 510
			.error "The length (" length ") is bigger than required (510)"
		.endif
		mvi l, length/2
		copy_from_ram_disk()
.endmacro
*/
; Copy data (max 510) from the ram-disk to ram w/o blocking interruptions
; input:
; h - ram-disk activation command
; l - data length / 2
; de - data addr in the ram-disk
; bc - destination addr

; performance related details:
; using stack ops to copy data adds 128 cc overhead
; replacing pop with mov_(2), inx_(2), adds 8 cc per byte overhead
; that said, copying with pop becomes efficient if a copy len > 16
//		IT IS NOT RECOMMENDED TO USE THESE MACROS
//		BECAUSE OF THE RISK OF DATA CORRUPTION
//		RAM_DISK_ON_BANK macro must not be used before calling a function!
/*
.function copy_from_ram_disk()
			; store sp
			push h
			lxi h, $0002
			dad sp
			shld restore__sp + 1
			; copy unpacked data into the ram_disk
			xchg
			pop d
			mov a, d
			RAM_DISK_ON_BANK()
			sphl
			mov l, c
			mov h, b
@loop:
			pop b
			mov m, c
			inx h
			mov m, b
			inx h
			dcr e
			jnz @loop
			jmp restore_sp
.endf
*/

; adds the offset to the pointers in the array
; in:
; hl - points to the array of ptrs to the data
; de - the data addr
; c - the len of the array
; out:
; hl - points to the next byte after the array

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


; Read a word from the ram-disk w/o blocking interruptions
; keep two two reserved bytes prior the addr stores in de reg pair
; because this func can corrupt it
; input:
; de - data addr in the ram-disk
; a - ram-disk activation command
; use:
; de, a
; out:
; bc - data
; hl - data addr in the ram-disk
; cc = 148
//		IT IS NOT RECOMMENDED TO USE THESE MACROS
//		BECAUSE OF THE RISK OF DATA CORRUPTION
//		RAM_DISK_ON_BANK macro must not be used before calling a function!
/*
get_word_from_ram_disk:
			RAM_DISK_ON_BANK()
			; store sp
			lxi h, $0000
			dad sp
			shld @restore__sp + 1
			; copy unpacked data into the ram_disk
			xchg
			sphl
			pop b ; bc has to be used when interruptions is on
@restore_sp:
			lxi sp, TEMP_ADDR
			RAM_DISK_OFF()
			ret
*/
/*
; a special version of a func above for accessing addr $8000 and higher
; cc = 100
get_word_from_scr_ram_disk:
			RAM_DISK_ON_BANK()
			xchg
			mov c, m
			inx h
			mov b, m
			RAM_DISK_OFF()
			ret
*/


; Set the palette
; input: hl - the addr of the last item in the palette
; use: hl, b, a

set_palette:
			hlt
set_palette_int:			; call it from an interruption routine
			mvi	a, PORT0_OUT_OUT
			out	0
			mvi	b, PALETTE_COLORS - 1

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


; Set palette copied from the ram-disk w/o blocking interruptions
; input:
; de - the addr of the first item in the palette
; a - ram-disk activation command
; use:
; hl, bc, a
//		IT IS NOT RECOMMENDED TO USE THESE MACROS
//		BECAUSE OF THE RISK OF DATA CORRUPTION
//		RAM_DISK_ON_BANK macro must not be used before calling a function!
/*
set_palette_from_ram_disk:
			hlt
			; store sp
			lxi h, $0000
			dad sp
			shld restore__sp + 1
			; copy unpacked data into the ram_disk
			xchg
			RAM_DISK_ON_BANK()
			sphl

			mvi	a, PORT0_OUT_OUT
			out	0
			mvi e, $00
@loop:
			pop b
			; even color
			mov	a, e
			out	2
			mov a, c
			out $0c
			xthl ; delay 24
			xthl ; delay 24
			inr e ; counter plus delay 8
			inr h ; delay 8
			dcr h ; delay 8
			out $0c
			; odd color
			mov	a, e
			out	2
			mov a, b
			out $0c
			xthl ; delay 24
			xthl ; delay 24
			inr e ; counter plus delay 8
			inr h ; delay 8
			dcr h ; delay 8
			out $0c
			mov a, e
			cpi PALETTE_COLORS
			jnz	@loop
			jmp restore_sp
*/

; Copy the pallete, then request for using it
; in:
; hl - palette addr
; uses: bc, de, hl, a
.function copy_palette_request_update()
			lxi d, palette
			lxi b, PALETTE_COLORS
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

/*
			// div range [0,29951] by 96*2
			//int s = n>>8;
    		//int res = (( (s + (s>>2) + (s>>4) + (s>>6))+2)<<1); // -2, 3
			mvi b, 0b00111111
			mov d, a
			rrc \ rrc \ ana b
			mov e, a
			rrc \ rrc \ ana b
			mov c, a
			rrc \ rrc \ ana b
			add d
			add e
			add c
			adi 2
			; 22*4=88

			// div range [0,29951] by 96*2
			// int s = n>>8;
    		// int res = (((s + ((s<<2) + (s<<4) + (s<<6))>>4)+4)>>1); // -1, 2
			mov e, a
			add a \ add a
			mov c, a
			add a \ add a
			add c
			mov l, a
			adc e
			sub l
			mov h, a

			mvi a, 0x111100
			ani e
			rrc \ rrc
			mov d, a
			rrc \ rrc \ 
			ani 0x00001111

			add d
			add h
			; 28*4=112
*/