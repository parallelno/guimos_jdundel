; contains the current RAM-disk mode
; to restore by the interrupt routine after its execution
ram_disk_mode:
			.byte TEMP_BYTE

;=============================================================================
;
; OS I/O vars
;
; the disk number to restore it before returning to the OS
; check RDS_DISK in os_consts.asm for more info
os_disk:
			.byte TEMP_BYTE
; loaded file format
os_file_format:
            .byte TEMP_BYTE
; points to next byte after loaded file
os_file_data_ptr:
			.byte TEMP_ADDR

;=============================================================================
;
; global states

; palette are a 16 byte buffer
; each color is a byte coded as BBGGGRRR
;	BB - 2 bit blue color
;	GGG - 3 bit green color
;	RRR - 3 bit red color
palette:
			.storage PALETTE_COLORS
border_color_idx:
			.byte 0
scr_offset_y:
			.byte 0
; it is used to check how many updates needs to happened to sync with interruptions
game_updates_required:
			.byte 0











;=============================================================================
; runtime data buffer size validation
;=============================================================================
runtime_data_end:
.if runtime_data_end >= BUFFERS_END_ADDR
	.error "Runtime data buffer overflow detected at addr (" runtime_data_end ")." 
	.error "It must be within the range " BUFFERS_END_ADDR "."
.endif