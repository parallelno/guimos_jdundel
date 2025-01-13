; contains the current RAM-disk mode
; to restore by the interrupt routine after its execution
ram_disk_mode:
			.byte 0

; temporally contains the disk number to restore it before returning to os
; RDS_DISK in os_consts.asm for more details
os_disk_tmp:
			.byte 0

; palette
palette:
			.storage PALETTE_COLORS

;=============================================================================
;
; global states 2
;
global_states_2:
			.byte 0
border_color_idx:
			.byte 0
scr_offset_y:
			.byte 0

; it is used to check how many updates needs to happened to sync with interruptions
game_updates_required:
			.byte 0

; a lopped counter increased every game update
game_update_counter:
			.byte 0

; used for the movement
char_temp_x:
			.word 0
char_temp_y:
			.word 0
global_states_2_end:
;=============================================================================

















;=============================================================================
; runtime data buffer size validation
;=============================================================================
runtime_data_end:
.if runtime_data_end >= BUFFERS_END_ADDR
	.error "Runtime data buffer overflow detected at addr (" runtime_data_end ")." 
	.error "It must be within the range " BUFFERS_END_ADDR "."
.endif