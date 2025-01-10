.org	0x100
.include "common\\global_consts.asm"
.include "common\\macro.asm"

main_start:
			di
			RAM_DISK_OFF()

; File loading routine for CP/M using 8080 assembly
			; Input: Filename in FCB at memory location 005Ch
			; Output: File contents loaded to buffer

			; CP/M BDOS function numbers
			OPEN    =     15      ; Open file
			READ    =     20      ; Read next record
			PRINT   =     9       ; Print string

			; CP/M system addresses
			BDOS    =     5       ; BDOS entry point
			;FCB     =     fcb ;0x05C    ; Default File Control Block
			DMA     =     0x080    ; Default DMA address

start:  
			; Set up DMA address
			lxi     d,buffer        ; Load buffer address into DE
			mvi     c,26           ; BDOS function 26 (Set DMA Address)
			call    BDOS

			; Open the file
			lxi     d,FCB          ; Load FCB address into DE
			mvi     c,OPEN         ; BDOS function 15 (Open File)
			call    BDOS
			cpi     255           ; Check if open failed
			jz      error

			; Read loop
readloop:
			lxi     d,FCB          ; Load FCB address into DE
			mvi     c,READ         ; BDOS function 20 (Read Record)
			call    BDOS
			ora     a              ; Check for end of file
			jnz     done           ; If not zero, we're done
			
			; Process the record here
			; ... (add your processing code)
			
			jmp     readloop       ; Continue reading

error:  
			lxi     d,errmsg
			mvi     c,PRINT
			call    BDOS
			jmp program_exit

done:   
			lxi     d,donemsg
			mvi     c,PRINT
			call    BDOS
			jmp program_exit

program_exit:
			; Exit to CP/M
			mvi c, 0			; BDOS Terminate program function
			call 0x0005			

errmsg:		.byte "Error opening file$"
donemsg:	.byte "File read complete$"


FCB:		.byte 0			  ; Drive code (0 = default)
			.byte "DATA60K "   ; 8-character file name, space-padded
			.byte "BIN"			; 3-character extension, space-padded
			.byte 0			  ; Extent number
			.byte 0, 0			 ; S1, S2 (reserved)
			.byte 0			  ; Record count		

buffer:
			.storage 0x6000, 0 ; Disk allocation map
/*
fcb:		.byte 0			  ; Drive code (0 = default)
			.byte "DATA60K "   ; 8-character file name, space-padded
			.byte "BIN"			; 3-character extension, space-padded
			.byte 0			  ; Extent number
			.byte 0, 0			 ; S1, S2 (reserved)
			.byte 0			  ; Record count
buffer:			
			.storage 0x200, 0 ; Disk allocation map

start:
			; Open the file
			lxi d, fcb   ; DE points to the File Control Block (FCB)
			mvi c, 0x15			; BDOS Open File function
			call 0x0005			; Call BDOS
			cpi 0x0FF			; Check if file not found
			jz file_not_found

			; Read the file
read_loop:
			lxi d, fcb   ; DE points to the FCB
			mvi c, 0x20			; BDOS Read Sequential function
			call 0x0005			; Call BDOS
			cpi 1			   ; Check for EOF
			jz file_done
			cpi 2			   ; Check for disk error
			jz disk_error
			jmp read_loop     ; Continue reading

file_done:
			; Close the file
			lxi d, fcb   ; DE points to the FCB
			mvi c, 0x16			; BDOS Close File function
			call 0x0005			; Call BDOS
			jmp program_exit

file_not_found:
			; Handle file not found
			; (Add your error handling code here)
			jmp program_exit

disk_error:
			; Handle disk error
			; (Add your error handling code here)
			jmp program_exit

program_exit:
			; Exit to CP/M
			mvi c, 0			; BDOS Terminate program function
			call 0x0005
*/
.include "common\\global_vars.asm"
