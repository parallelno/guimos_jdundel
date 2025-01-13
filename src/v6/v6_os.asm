.include "v6/v6_os_consts.asm"
.include "v6/v6_os_macro.asm"
;=======================================================
; RDS (based on CP/M 2.2 and MicroDos 3) library
; Docs:
; https://github.com/ImproverX/RDS/blob/master/manuals/rds-rpro.txt
; https://www.seasip.info/Cpm/bdos.html
; https://www.seasip.info/Cpm/fcb.html
; https://www.seasip.info/Cpm/format22.html
; http://www.cpm.z80.de/manuals/cpm22-m.pdf
; https://zxpress.ru/book_articles.php?id=2318
;=======================================================

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

.if v6_debug_mode == DEBUG_ON
			jmp @print
@text:
			.byte "v6_os_init is executing$"
@print:
			SYS_CALL(CPM_SUB_PRINT, @text)
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
			sta os_disk_tmp

			RAM_DISK_OFF()

			; set the reboot & interrupt routine vectors
@set_reboot:			
			lxi h, TEMP_ADDR
			shld RESTART_ADDR + 1
@set_int:
			lxi h, TEMP_ADDR
			shld INT_ADDR + 1
			lxi sp, STACK_MAIN_PROGRAM_ADDR
			ei
			ret

;=======================================================
; Return to OS. Should be called last in the application
;=======================================================
v6_os_exit:
			di
			mvi a, RDS_MODE_0
			sta RDS_MODE
			SYS_CALL(RDS_SUB_SCR_MODE)

			ei
			; restore the system fdd disk num
			lda os_disk_tmp
			sta RDS_DISK
			jmp CPM_EXIT

;=======================================================
; Read file
;=======================================================
bin_data:  // temporally added.
bin_data_ptr: // temporally added.
file_name:  // temporally added.
			.byte "FILENAME"
			.byte "EXT"

SAVE_FILE_LEN = 0x100 // temporally added.
save_file_len_ptr: // temporally added.
			.word 0


load_file:
			lxi h, bin_data
			shld bin_data_ptr

			lxi h, file_name
			call set_file_name
		/*
			; commented because it uses the system DMA buffer

			; Set DMA buffer address
			mvi c, CPM_SUB_F_DMAOFF     ; CPM_BDOS function 0x1A: Set DMA Address
			lxi d, CMP_DMA_BUFFER
			call CPM_BDOS     ; Call CPM_BDOS
		*/
			; Open the file
			SYS_CALL(CPM_SUB_F_OPEN, CPM_FCB)
			cpi CPM_ERROR        ; Check if file was opened successfully (0xFF = error)
			jz error_file_open   ; Handle file open error

@loop:
			; Read a record from the file
			SYS_CALL(CPM_SUB_F_READ, CPM_FCB)
			cpi CPM_SUCCESS        ; Check if read was successful (0x00 = success)
			jnz @done   ; If not, end of file or error

			; Process the data in CMP_DMA_BUFFER (128 bytes)
			; (Add your code here to handle the data)
			call check_file_128
			jnz error_invalid_read_data

			jmp @loop   ; Read the next record

@done:
			; Close the file
			SYS_CALL(CPM_SUB_F_CLOSE, CPM_FCB)

			mvi c, CPM_SUB_PRINT
			lxi d, donemsg
			call CPM_BDOS
			jmp v6_os_exit


;=======================================================
; Delete file
;=======================================================
del_file:
			lxi h, file_name
			call set_file_name

			SYS_CALL(CPM_SUB_F_SFIRST, CPM_FCB)
			cpi CPM_ERROR
			lxi d, errmsg_search_file
			jz exit_w_error

			; delete the file
			SYS_CALL(CPM_SUB_F_DELETE, CPM_FCB)
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
			SYS_CALL(CPM_SUB_F_MAKE, CPM_FCB)
			cpi CPM_ERROR		; Check if file was created successfully
			jz error_file_make	; Handle file creation error

			; Open file for writing
			SYS_CALL(CPM_SUB_F_OPEN, CPM_FCB)
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
			SYS_CALL(CPM_SUB_F_WRITE, CPM_FCB)
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
			SYS_CALL(CPM_SUB_F_CLOSE, CPM_FCB)

			; Exit program
			SYS_CALL(CPM_SUB_PRINT, msg_file_saved)
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
			mov m, e	; 8
			inx h		; 8
			dcx b		; 8
			mov a, b	; 8
			ora c		; 4
			jnz @loop	; 12
			ret			; total: 48 cc
						; bytes: 11

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
			SYS_CALL(CPM_SUB_PRINT)
			jmp 0

errmsg_file_open:			.byte "Error opening file\n$"
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