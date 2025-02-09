	; this line for VSCode proper formating
; contains game-related runtime data

;=============================================================================
; level init data ptr and ram-disk access commands
level_init_tbl:
level_ram_disk_s_data:				.byte 0;RAM_DISK_S_LEVEL00_DATA
level_ram_disk_m_data: 				.byte 0;RAM_DISK_M_LEVEL00_DATA
level_ram_disk_s_gfx:				.byte 0;RAM_DISK_S_LEVEL00_GFX
level_palette_ptr:					.word 0;_lv0_palette
level_resources_inst_data_pptr:		.word 0;level00_resources_inst_data_ptrs
level_containers_inst_data_pptr:	.word 0;level00_containers_inst_data_ptrs
level_start_pos_ptr:				.word 0;level00_start_pos
level_rooms_pptr:					.word 0;level00_rooms_addr
level_tiles_pptr:					.word 0;level00_tiles_addr
@data_end:	
LEVEL_INIT_TBL_LEN = @data_end - level_init_tbl

;=============================================================================
; tile graphics pointer table.

; data format:
; .loop ROOM_HEIGHT
;	.loop ROOM_WIDTH
;		.word - tile_gfx_addr
;	.endloop
; .endloop

ROOM_TILES_GFX_PTRS_LEN	= ROOM_WIDTH * ROOM_HEIGHT * ADDR_LEN
room_tiles_gfx_ptrs:		.storage ROOM_TILES_GFX_PTRS_LEN
room_tiles_gfx_ptrs_end:	= room_tiles_gfx_ptrs + ROOM_TILES_GFX_PTRS_LEN