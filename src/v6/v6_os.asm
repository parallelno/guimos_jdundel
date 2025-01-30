.include "src/v6/v6_os_consts.asm"
.include "src/v6/v6_os_macro.asm"
;=======================================================
; RDS (based on CP/M 2.2 and MicroDos 3) library
; Refs:
; https://github.com/ImproverX/RDS/blob/master/manuals/rds-rpro.txt
; https://www.seasip.info/Cpm/bdos.html
; https://www.seasip.info/Cpm/fcb.html
; https://www.seasip.info/Cpm/format22.html
; http://www.cpm.z80.de/manuals/cpm22-m.pdf
; https://zxpress.ru/book_articles.php?id=2318
;=======================================================


v6_os_err_file_open:		.byte "Error opening file: $"						
v6_os_err_hardware:			.byte "Hardware error\n$"
v6_os_err_invalid_fcb:		.byte "Invalid FCB\n$"
v6_os_msg_exit:				.byte "Exit the game.\n$"
/*
errmsg_invalid_read_data:	.byte "Invalid read data\n$"

errmsg_file_make:			.byte "NO DIRECTORY SPACE\n$"
errmsg_invalid_save_data:	.byte "Invalid save data\n$"

errmsg_delete_file:			.byte "Error deleting file\n$"
errmsg_search_file:			.byte "Error searching for file\n$"
errmsg_open_del_file:		.byte "Error open DEL file\n$"

errmsg_file_open_to_save:	.byte "Error opening file for saving\n$"
errmsg_file_save:	.byte "Error saving file\n$"

errmsg:				.byte "Error\n$"
msg_file_saved:		.byte "File saved\n$"

donemsg:			.byte "Done\n$"
*/
;=======================================================
; OS init. Should be called first in the application
; in:
;	hl - reboot_addr
;	de - interruption_addr
;=======================================================
v6_os_init:
			shld @set_reboot+1
			xchg
			shld @set_int+1

			; take from the stack the return addr
            pop h
			shld @return+1
.if DEBUG
			jmp @print
@text:
			.byte "Debug mode is on\n$"
@print:
			SYS_CALL_D(CPM_SUB_PRINT, @text)
.endif
			di
			lxi sp, 0 ; TODO: check if it's required for call 5
			; map 0x0A000-0xDFFF range to the Screen buffer
			A_TO_ZERO(RDS_SCR_MODE_ON)
			sta RDS_SCR_MODE
			; enable the RDS mode 1
			mvi a, RDS_MODE_1
			sta RDS_MODE
			SYS_CALL(RDS_SUB_SCR_MODE)
			; temporaly store the system fdd disk num
			lda RDS_DISK
			sta os_disk

			RAM_DISK_OFF(RAM_DISK0_PORT)	; disable the ram-disk 0 because the OS uses it
			RAM_DISK_OFF()					; disable the ram-disk 1 because the game uses it
			mvi a, OPCODE_JMP
			sta RESTART_ADDR
			sta INT_ADDR

			; set the reboot & interrupt routine vectors
@set_reboot:			
			lxi h, TEMP_ADDR
			shld RESTART_ADDR + 1
@set_int:
			lxi h, TEMP_ADDR
			shld INT_ADDR + 1
			lxi sp, STACK_MAIN_PROGRAM_ADDR
			ei
@return:
			lxi h, TEMP_ADDR
			pchl

;=======================================================
; Read file
;=======================================================

; in:
; os_file_data_ptr - it must contain the load destination addr
; filenamePtr - filename ptr
; file_len - the len of the last record (<128)
; out:
; os_file_data_ptr - points to next byte after loaded file
.macro LOAD_FILE_NEXT(filenamePtr, file_len)
			mvi a, file_len & (CMP_DMA_BUFFER_LEN - 1)
			mvi c, file_len >> 7
			lxi h, filenamePtr
			call load_file
.endmacro

; in:
; dest - load destination addr
; filenamePtr - filename ptr
; file_len - the len of the last record (<128)
; out:
; os_file_data_ptr - points to next byte after loaded file
.macro LOAD_FILE(dest, filenamePtr, file_len)
			lxi h, dest
			shld os_file_data_ptr
			mvi a, file_len & (CMP_DMA_BUFFER_LEN - 1)
			mvi c, file_len >> 7
			lxi h, filenamePtr
			call load_file
.endmacro
; in:
; os_file_data_ptr - load destination addr
; hl - filename ptr
; a - the len of the last record (<128)
; c - the num of full records (128 byte long)
; out:
; os_file_data_ptr - points to next byte after loaded file
load_file:
			sta @copy_last_record+1
			mov a, c
			sta @check_rec_num+1
			call set_file_name

			; Open the file
			SYS_CALL_D(CPM_SUB_F_OPEN, CPM_FCB)
			cpi CPM_MSG_ERROR
			jz v6_os_error_file_open

@loop:
			; Read the record from the file
			SYS_CALL_D(CPM_SUB_F_READ, CPM_FCB)
			cpi CPM_MSG_ERROR
			jz v6_os_error_hardware
			cpi CPM_MSG_INVALID_FCB
			jz v6_os_error_invalid_fcb
			cpi CPM_MSG_EOF
			jz @close_file

@check_rec_num:
			mvi a, TEMP_BYTE
			ora a
			jz @copy_last_record
			dcr a
			sta @check_rec_num+1

			; copy CMP_DMA_BUFFER_LEN bytes, then continue loading
			lhld os_file_data_ptr
			lxi d, CMP_DMA_BUFFER_LEN
			xchg
			dad d
			shld os_file_data_ptr
			lxi h, CMP_DMA_BUFFER
			lxi b, CMP_DMA_BUFFER_LEN
			mem_copy()
			jmp @loop

@copy_last_record:
			lxi d, TEMP_WORD ; the length of the last record (<128) 
			; check if the len is 0
			A_TO_ZERO(0)
			ora e
			jz @close_file
			push d
			; advance os_file_data_ptr to += the length of the last record
			lhld os_file_data_ptr
			xchg
			dad d
			shld os_file_data_ptr
			
			lxi h, CMP_DMA_BUFFER
			pop b
			; hl - CMP_DMA_BUFFER
			; de - os_file_data_ptr before advance
			; bc - the length of the last record
			mem_copy()
@close_file:
			; Close the file
			SYS_CALL_D(CPM_SUB_F_CLOSE, CPM_FCB)
			ret
/*
;=======================================================
; Delete file
;=======================================================
del_file:
			lxi h, file_name
			call set_file_name

			SYS_CALL_D(CPM_SUB_F_SFIRST, CPM_FCB)
			cpi CPM_ERROR
			lxi d, errmsg_search_file
			jz exit_w_error

			; delete the file
			SYS_CALL_D(CPM_SUB_F_DELETE, CPM_FCB)
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

			lxi h, file_name
			call set_file_name

			; Create the file
			SYS_CALL_D(CPM_SUB_F_MAKE, CPM_FCB)
			cpi CPM_ERROR		; Check if file was created successfully
			jz error_file_make	; Handle file creation error

			; Open file for writing
			SYS_CALL_D(CPM_SUB_F_OPEN, CPM_FCB)
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
			SYS_CALL_D(CPM_SUB_F_WRITE, CPM_FCB)
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
			SYS_CALL_D(CPM_SUB_F_CLOSE, CPM_FCB)

			; Exit program
			SYS_CALL_D(CPM_SUB_PRINT, msg_file_saved)
			ret
*/

; in:
;	hl - ptr to a filename (8 bytes name, 3 bytes extention)
set_file_name:
			; Set the filename
			lxi d, CPM_FCB+1 ; file name addr
			lxi b, FILENAME_LEN
			push h
			mem_copy()
			pop h

			push h

			; Store the filename as a CPM string
			lxi d, os_filename
			lxi b, BASENAME_LEN
			call copy_filebase
			; print the '.' symbol
			mvi a, '.'
			stax d
			inx d

			pop h
			; hl - filename ptr
			lxi b, BASENAME_LEN
			dad b
			; hl - file ext ptr
			; de - points to v6_os_errmsg_file_open_ext
			lxi b, EXT_LEN
			mem_copy()
			mvi a, '\n'
			stax d
			inx d
			mvi a, '$'
			stax d

			; Set the disk drive number
			mvi a, DISK_CURRENT
			sta CPM_FCB

			; Erase the rest of the FCB
			lxi h, CPM_FCB + FILENAME_LEN + 1
			mvi c, <(CMP_DMA_BUFFER - (CPM_FCB + FILENAME_LEN + 1))
			call mem_erase_short
			ret

;=======================================================
; Error handling
;=======================================================

v6_os_error_file_open:
			call v6_os_exit_prep
			SYS_CALL_D(CPM_SUB_PRINT, v6_os_err_file_open)
			SYS_CALL_D(CPM_SUB_PRINT, os_filename)
			jmp CPM_EXIT

v6_os_error_hardware:
			call v6_os_exit_prep
			SYS_CALL_D(CPM_SUB_PRINT, v6_os_err_hardware)
			jmp CPM_EXIT

v6_os_error_invalid_fcb:
			call v6_os_exit_prep
			SYS_CALL_D(CPM_SUB_PRINT, v6_os_err_invalid_fcb)
			jmp CPM_EXIT			

;=======================================================
; Return to OS. Should be called last in the application
;=======================================================

v6_os_exit:
			call v6_os_exit_prep
			SYS_CALL_D(CPM_SUB_PRINT, v6_os_msg_exit)
			jmp CPM_EXIT

v6_os_exit_prep:
			pop h
			shld @return+1
			di
			mvi a, RDS_MODE_0
			sta RDS_MODE
			SYS_CALL(RDS_SUB_SCR_MODE)

			ei
			; restore the system fdd disk num
			lda os_disk
			sta RDS_DISK
@return:
			lxi h, TEMP_ADDR
			pchl

; copy a memory buffer that ends with a whitespace (' ') or takes the full length stored in bc
; in:
; 	hl - source
; 	de - destination
; 	bc - length
; out:
; 	hl - points to the next byte after copied source buffer
;	de - points to the next byte after copied destination buffer
; use:
; a
copy_filebase:
@loop:		mov a, m
			; check if it's the end
			cpi ' '
			rz

			stax d
			inx h
			inx d
			dcx b

			mov a, c
			ora b
			jnz @loop
			ret