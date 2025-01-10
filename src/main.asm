.org	0x100
.include "common\\global_consts.asm"
.include "common\\macro.asm"

main_start:
			di
			RAM_DISK_OFF()

; CP/M BDOS function numbers
PRINT   =     0x09       ; Print string
SET_DMA_ADDR = 0x1A       ; Set DMA address
OPEN_FILE = 0x0F       ; Open file
READ_FILE_SEQ = 0x14       ; Read file sequentially
CLOSE_FILE = 0x10       ; Close file

; CP/M system addresses
BDOS    =     0x0005       ; BDOS entry point

START:
	lxi h, bin_data
	shld bin_data_addr


	; Set DMA buffer address
	lxi d, DMA_BUFFER
	mvi c, SET_DMA_ADDR     ; BDOS function 0x1A: Set DMA Address
	call BDOS     ; Call BDOS

	; Open the file
	lxi d, FCB
	mvi c, OPEN_FILE     ; BDOS function 0x0F: Open File
	call BDOS     ; Call BDOS
	cpi 0xFF        ; Check if file was opened successfully (0xFF = error)
	jz error   ; Handle file open error

READ_LOOP:
	; Read a record from the file
	lxi d, FCB
	mvi c, READ_FILE_SEQ     ; BDOS function 0x14: Sequential Read
	call BDOS     ; Call BDOS
	cpi 0x00        ; Check if read was successful (0x00 = success)
	jnz READ_DONE   ; If not, end of file or error

	; Process the data in DMA_BUFFER (128 bytes)
	; (Add your code here to handle the data)
	call check_file_128

	jmp READ_LOOP   ; Read the next record

READ_DONE:
	; Close the file
	lxi d, FCB
	mvi c, CLOSE_FILE     ; BDOS function 0x10: Close File
	call BDOS     ; Call BDOS
	jmp done

error:  
			lxi     d,errmsg
			mvi     c,PRINT
			call    BDOS
			jmp program_exit

error_invalid_read_data:
			lxi     d,errmsg_invalid_read_data
			mvi     c,PRINT
			call    BDOS
			jmp program_exit

done:   
			lxi     d,donemsg
			mvi     c,PRINT
			call    BDOS
			jmp program_exit


check_file_128:
			mvi c, 128
			lhld bin_data_addr
			lxi d, DMA_BUFFER
@loop:		mov b, m
			ldax d
			cmp b
			jnz error_invalid_read_data
			inx h
			inx d
			dcr c
			jnz @loop
			shld bin_data_addr
			ret			
bin_data_addr:
			.word bin_data

program_exit:
			; Exit to CP/M
			mvi c, 0			; BDOS Terminate program function
			call 0x0005			

errmsg:		.byte "Error opening file$"
donemsg:	.byte "File read complete$"
errmsg_invalid_read_data:	.byte "Invalid read data$"


; Define the File Control Block (FCB)
FCB:
			.byte 0				; Drive (0 = default, 1 = A:, 2 = B:, etc.)
			.byte "DATA60K "	; 8-character file name, space-padded
			.byte "BIN"			; 3-character extension, space-padded
@EX:		.byte 0				; Current extent. Set this to 0 when opening a file and then leave it to CP/M. 
								; You can rewind a file by setting EX, RC, S2 and CR to 0.
@S1:		.byte 0				; Reserved.   
@S2:		.byte 0				; Reserved. Extent high byte. The CP/M Plus source code refers to this use of the S2 byte as 'module number'.
@RC:		.byte 0				; Set this to 0 when opening a file and then leave it to CP/M.
@AL:		.storage 0x10		; Image of the second half of the directory entry,
            					; containing the file's allocation (which disc blocks it owns).
@CR:		.byte 0				; Current record within extent. It is usually best to set 
            					; this to 0 immediately after a file has been opened and 
            					; then ignore it.
@Rn:		.byte 0, 0			; Random access record number (not CP/M 1). A 16-bit 
            					; value in CP/M 2 (with R2 used for overflow); an 18-bit
            					; value in CP/M 3.

DMA_BUFFER:
	.storage 128          ; DMA buffer for reading data (128 bytes)

bin_data:
.generate "bouncewave", $00, $ff, $400, 1




/*
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
*/



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
