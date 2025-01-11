.org	0x100
.include "common\\global_consts.asm"
.include "common\\macro.asm"

; CP/M CPM_BDOS function numbers
CPM_SUB_PRINT			= 09 ; 0x09 Print string terminated by '$'
CPM_SUB_F_DMAOFF		= 26 ; 0x1A Set the address of	a custom I/O file buffer 128 byte long
CPM_SUB_F_OPEN			= 15 ; 0x0F Open file
CPM_SUB_F_READ			= 20 ; 0x14 Read file sequentially
CPM_SUB_F_WRITE			= 21 ; 0x15 Save file sequentially
CPM_SUB_F_CLOSE			= 16 ; 0x10 Close file
CPM_SUB_F_MAKE			= 22 ; 0x16 Make File
CPM_SUB_F_DELETE		= 19 ; 0x13 Delete file
;CPM_SUB_DRV_ALLRESET	= 13 ; 0x0D Reset all drives
CPM_SUB_F_SFIRST		= 17 ; 0x11 Search for first file
CPM_SUB_DRV_GET			= 25 ; 0x19 Get current drive
CPM_SUB_DRV_SET			= 14 ; 0x0E Set current drive

; CP/M system addresses
CPM_BDOS    	= 0x0005       ; CPM_BDOS entry point

; CP/M system constants
CPM_FCB				= 0x005C
FILE_NAME_ADDR		= CPM_FCB+1
CMP_DMA_BUFFER		= 0x0080
CMP_DMA_BUFFER_LEN	= 128
CPM_FCB_LEN			= CMP_DMA_BUFFER - CPM_FCB
FILE_NAME_LEN		= 8+3
CPM_ERROR			= 0xFF
CPM_SUCCESS			= 0x00


; program consts
DISK_CURRENT	= 0 ; 0=currently used, 1=A:, 2=B:, etc.
DISK_A			= 1
DISK_B			= 2

main_start:
			di
			RAM_DISK_OFF()
			;lxi h, 0
			;dad sp
			;shld os_stack_addr
			;lxi sp, STACK_MAIN_PROGRAM_ADDR
;
; Main program

START:

			call del_file
			call save_file

;=======================================================
; Read file
;=======================================================

load_file:
			lxi h, bin_data
			shld bin_data_ptr

			lxi h, file_name2
			call set_file_name
		/*
			; commented because it uses the system DMA buffer

			; Set DMA buffer address
			mvi c, CPM_SUB_F_DMAOFF     ; CPM_BDOS function 0x1A: Set DMA Address			
			lxi d, CMP_DMA_BUFFER
			call CPM_BDOS     ; Call CPM_BDOS
		*/
			; Open the file
			mvi c, CPM_SUB_F_OPEN     ; CPM_BDOS function 0x0F: Open File
			lxi d, CPM_FCB			
			call CPM_BDOS     ; Call CPM_BDOS
			cpi CPM_ERROR        ; Check if file was opened successfully (0xFF = error)
			jz error_file_open   ; Handle file open error

@loop:
			; Read a record from the file
			mvi c, CPM_SUB_F_READ     ; CPM_BDOS function 0x14: Sequential Read
			lxi d, CPM_FCB			
			call CPM_BDOS     ; Call CPM_BDOS
			cpi CPM_SUCCESS        ; Check if read was successful (0x00 = success)
			jnz @done   ; If not, end of file or error

			; Process the data in CMP_DMA_BUFFER (128 bytes)
			; (Add your code here to handle the data)
			call check_file_128
			jnz error_invalid_read_data

			jmp @loop   ; Read the next record

@done:
			; Close the file
			mvi c, CPM_SUB_F_CLOSE     ; CPM_BDOS function 0x10: Close File			
			lxi d, CPM_FCB
			call CPM_BDOS     ; Call CPM_BDOS
	
			mvi c, CPM_SUB_PRINT
			lxi d, donemsg
			call CPM_BDOS
			jmp program_exit


;=======================================================
; Delete file
;=======================================================
del_file:
			lxi h, file_name3
			call set_file_name

			; init
			// mvi c, CPM_SUB_DRV_ALLRESET
			// call CPM_BDOS

			mvi c, CPM_SUB_F_SFIRST
			lxi d, CPM_FCB
			call CPM_BDOS
			cpi CPM_ERROR
			lxi d, errmsg_search_file
			jz exit_w_error

			; delete the file
			mvi c, CPM_SUB_F_DELETE
			lxi d, CPM_FCB
			call CPM_BDOS
			cpi CPM_ERROR
			lxi d, errmsg_delete_file
			jz exit_w_error
			ret

;=======================================================
; Save file
;=======================================================

save_file:
			lxi h, bin_data
			shld bin_data_ptr

			lxi h, SAVE_FILE_LEN
			shld save_file_len_ptr

			lxi h, file_name2
			call set_file_name

			// ; init
			// mvi c, CPM_SUB_DRV_ALLRESET
			// call CPM_BDOS

			
			; Create the file
			mvi c, CPM_SUB_F_MAKE
			lxi d, CPM_FCB			
			call CPM_BDOS
			cpi CPM_ERROR		; Check if file was created successfully
			jz error_file_make	; Handle file creation error

			; Open file for writing
			mvi c, CPM_SUB_F_OPEN
			lxi d, CPM_FCB			
			call CPM_BDOS
			cpi CPM_ERROR
			lxi d, errmsg_file_open_to_save
			jz exit_w_error

			; Write data to the file
@loop:
			; Fill up the DMA buffer with data to write
			lhld bin_data_ptr
			lxi d, CMP_DMA_BUFFER
			mvi c, 128
			call copy_data
			shld bin_data_ptr

			; Write a record to the file
			mvi c, CPM_SUB_F_WRITE
			lxi d, CPM_FCB			
			call CPM_BDOS
			cpi CPM_SUCCESS
			lxi d, errmsg_file_save
			jnz exit_w_error

			; check if all data is written
			lhld save_file_len_ptr
			dcx h
			shld save_file_len_ptr
			mov a, l
			ora h
			jnz @loop

@done:
			; Close the file
			mvi c, CPM_SUB_F_CLOSE     ; CPM_BDOS function 0x10: Close File
			lxi d, CPM_FCB			
			call CPM_BDOS

			; Exit program
			mvi c, CPM_SUB_PRINT
			lxi d, msg_file_saved
			call CPM_BDOS
			ret

;=======================================================
; Subroutines
;=======================================================

check_file_128:
			mvi c, 128
			lhld bin_data_ptr
			lxi d, CMP_DMA_BUFFER
@loop:		mov b, m
			ldax d
			cmp b
			rnz
			inx h
			inx d
			dcr c
			jnz @loop
			shld bin_data_ptr
			ret			

; in:
;	hl - ptr tp the file name (8+3 bytes)
set_file_name:
			; Set the file name
			lxi d, CPM_FCB+1 ; file name addr
			mvi c, FILE_NAME_LEN
			call copy_data

			; Set the disk drive number
			mvi a, DISK_CURRENT
			sta CPM_FCB

			; Erase the rest of the FCB
			lxi h, CPM_FCB + FILE_NAME_LEN + 1
			lxi b, CMP_DMA_BUFFER - (CPM_FCB + FILE_NAME_LEN + 1)
			call erase_data
			ret

; in:
;	hl - source data ptr
;	de - destination data ptr
;	c - number of bytes to copy
copy_data:
			mov a, m
			stax d
			inx h
			inx d
			dcr c
			jnz copy_data
			ret

; erase_data:
; in:
;	hl - ptr to the memory to erase
;	bc - number of bytes to erase
; out:
;	hl - ptr to the end of erased memory
erase_data:
			mvi e, 0
@loop:
			mov m, e
			inx h
			dcx b
			mov a, b
			ora c
			jnz @loop
			ret

			dad d
			rnc
			stax d
			inx d
			jmp @loop
			




program_exit:
			; Exit to CP/M
			;mvi c, 0			; CPM_BDOS Terminate program function
			;call CPM_BDOS			
			;lhld os_stack_addr
			;sphl
			
			;ret
			jmp 0

;=======================================================
; Error handling
;=======================================================

error_file_open:
			lxi d, errmsg_file_open
			jmp exit_w_error

error_invalid_read_data:
			lxi d, errmsg_invalid_read_data
			jmp exit_w_error

error_file_make:  
			lxi d, errmsg_file_make
			jmp exit_w_error

exit_w_error:
			mvi c, CPM_SUB_PRINT
			call CPM_BDOS
			jmp program_exit

errmsg_file_open:			.byte "Error opening file\n$"
donemsg:					.byte "File read complete\n$"
errmsg_invalid_read_data:	.byte "Invalid read data\n$"

errmsg_file_make:			.byte "NO DIRECTORY SPACE\n$"
errmsg_invalid_save_data:	.byte "Invalid save data\n$"

errmsg_delete_file:			.byte "Error deleting file\n$"
errmsg_search_file:			.byte "Error searching for file\n$"

errmsg_file_open_to_save:	.byte "Error opening file for saving\n$"
errmsg_file_save:	.byte "Error saving file\n$"

errmsg:				.byte "Error\n$"
msg_file_saved:		.byte "File saved\n$"



file_name3:
			.byte "DEL     "	; 8-character file name, space-padded
			.byte "   "			; 3-character extension, space-padded

file_name2:
			.byte "DATA    "	; 8-character file name, space-padded
			.byte "BIN"			; 3-character extension, space-padded			

os_stack_addr:
			.word 0x0000
bin_data_ptr:
			.word bin_data



/*
.align 1024

; Define the File Control Block (CPM_FCB)
CPM_FCB:
			.byte 0				; Drive (0 = default, 1 = A:, 2 = B:, etc.)
			.byte "DATA60K "	; 8-character file name, space-padded
			.byte "BIN"			; 3-character extension, space-padded
@EX:		.byte 0				; Current extent. Set this to 0 when opening a file and then leave it to CP/M. 
								; You can rewind a file by setting EX, RC, S2 and CR to 0.
@S1:		.byte 0				; Reserved.
@S2:		.byte 0				; Reserved. Extent high byte. RDS increments it by 1 after loading following 16k bytes or RECORD_COUNT*DMA_BUFFER_LEN or 128*128=16384).
								; I assume RECORD_COUNT*DMA_BUFFER_LEN is an extent size.
@RC:		.byte 0				; FILE'S RECORD COUNT (0 TO 128). Set this to 0 when opening a file and then leave it to CP/M.
								; when file's opened, CP/M will set it to the number of records (128*RC) in the file.
@AL:		.storage 0x10		; Image of the second half of the directory entry, which
								; containing the file's allocation (which disc blocks it owns).
@CR:		.byte 0				; Current record within extent. It is usually best to set 
								; this to 0 immediately after a file has been opened and 
								; then ignore it.
@Rn:		.byte 0, 0, 0		; Not used in CP/M 1.4. Reserved for future use.

.align 16
CMP_DMA_BUFFER:
	.storage 128          ; DMA buffer for reading data (128 bytes)
*/
bin_data:
.include "data_.asm"
bin_data_end:
.align 128 ; allighed to the DMA buffer length for writing a file

SAVE_FILE_LEN = (bin_data_end - bin_data) / 128

save_file_len_ptr: // length of the data to save in records (128 bytes)
			.word SAVE_FILE_LEN

.include "common\\global_vars.asm"
