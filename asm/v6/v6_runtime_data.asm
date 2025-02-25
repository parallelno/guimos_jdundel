	; this line for VSCode proper formating
.include "asm/v6/sound/v6_gc_runtime_data.asm"

; contains the current RAM-disk mode
; to restore by the interrupt routine after its execution
ram_disk_mode:
			.storage BYTE_LEN
;=============================================================================
;
; OS I/O vars
;
; the disk number to restore it before returning to the OS
; check RDS_DISK in os_consts.asm for more info
os_disk:
			.storage BYTE_LEN

; the last filename IO handled
os_filename:
			.storage BASENAME_LEN
			.storage BYTE_LEN ; "."
os_filename_ext:
			.storage EXT_LEN
			.storage 2 ; "\n$"

; the last file format IO handled
; TODO: make it useful or delete
;os_file_format:
;			.storage BYTE_LEN
; points to next byte after loaded file
os_file_data_ptr:
			.storage BYTE_LEN

;=============================================================================
;
; global states

; palette are a 16 byte buffer
; each color is a byte coded as BBGGGRRR
;	BB - 2 bit blue color
;	GGG - 3 bit green color
;	RRR - 3 bit red color
palette:			.storage PALETTE_LEN
border_color_idx:	.storage BYTE_LEN
scr_offset_y:		.storage BYTE_LEN
; it is used to check how many updates needs to happened to sync with interruptions
game_updates_required:
			.storage BYTE_LEN

;=============================================================================
; runtime data buffer size validation
;=============================================================================
runtime_data_end:
RAM_FREE_SPACE = LOADED_DATA_START_ADDR - runtime_data_end

.if runtime_data_end >= STACK_MIN_ADDR
	.error "Runtime data buffer overlaps the stack buffer at addr (" runtime_data_end ")." 
	.error "It must be within the range " BUFFERS_END_ADDR "."
.endif

.if runtime_data_end >= LOADED_DATA_START_ADDR
	.error "Runtime data buffer overlaps the loaded data at addr (" runtime_data_end ")." 
	.error "It must be within the range " LOADED_DATA_START_ADDR "."
.endif