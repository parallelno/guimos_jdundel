	; this line for VSCode proper formating
; contains game-related runtime data

;=============================================================================
; level init data ptr and ram-disk access commands
level_init_tbl:
level_resources_inst_data_pptr:		.storage 2
level_containers_inst_data_pptr:	.storage 2
level_start_pos_ptr:				.storage 2
level_rooms_pptr:					.storage 2 ; pptr to the level tile_gfx_idxs + tiledata
level_tiles_pptr:					.storage 2 ; pptr to the level tile gfx data
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
room_tiles_gfx_ptrs_end:

;=============================================================================
; tiledata buffer has to follow room_tiles_gfx_ptrs because they 
; are unpacked altogether. see level_data.asm for tiledata format

; data format:
; .loop ROOM_HEIGHT
;	.loop ROOM_WIDTH
;		.byte - tiledata
;	.endloop
; .endloop

room_tiledata:			.storage ROOM_TILEDATA_LEN
room_tiledata_end:

;=============================================================================
;	it's a copy of the room tiledata stored by room_draw
;	it's used in room_redraw for storing states of breakable objects, and restoring states of doors and containers
ROOM_TILEDATA_BACKUP_LEN			= ROOM_WIDTH * ROOM_HEIGHT
room_tiledata_backup:				.storage ROOM_TILEDATA_BACKUP_LEN
room_tiledata_backup_end:

;=============================================================================
; tiled image idxs buffer
; a temporal buffer to unpack data

; TODO: consider increasing this buffer and combine 
; title1, title2, main_menu_back1, and main_menu_back2 into one image
TEMP_BUFF_LEN = $200
temp_buff:				.storage TEMP_BUFF_LEN

;=============================================================================
; global states
;

; stores a request to manage the game and main_menu states
global_request:			.storage BYTE_LEN


; the current room idx of the current level
room_id:				.storage BYTE_LEN ; in the range [0, ROOMS_MAX-1]
; the current level idx
level_id:   			.storage BYTE_LEN

; currently shown item on the panel. range [0, ITEMS_MAX-1]
game_ui_item_visible_addr:	.storage BYTE_LEN

;=============================================================================
; hero runtime data
hero_runtime_data:
hero_update_ptr:			.storage ADDR_LEN ; .word hero_update
hero_draw_ptr:				.storage ADDR_LEN ; .word hero_draw
hero_impacted_ptr:			.storage ADDR_LEN ; .word hero_impacted ; called by a monster's bullet, a monster, etc. to affect a hero
hero_type:					.storage BYTE_LEN ; .byte MONSTER_TYPE_ALLY
hero_status:				.storage BYTE_LEN ; .byte HERO_STATUS_IDLE ; a status describes what set of animations and behavior is active
hero_status_timer:			.storage BYTE_LEN ; .byte 0	; a duration of the status. ticks every update
hero_anim_timer:			.storage BYTE_LEN ; .byte TEMP_BYTE ; it triggers an anim frame switching when it overflows
hero_anim_addr:				.storage ADDR_LEN ; .word TEMP_ADDR ; holds the current frame ptr
hero_dir:					.storage BYTE_LEN ; .byte 1			; VDHD, V: vertical dir, H: horiz dir, D: 0 - neg dir, 1 - positive dir
hero_erase_scr_addr:		.storage ADDR_LEN ; .word TEMP_ADDR	; screen addr for erasing
hero_erase_scr_addr_old:	.storage ADDR_LEN ; .word TEMP_ADDR	; screen addr for erasing last frame 
hero_erase_wh:				.storage WORD_LEN ; .word TEMP_WORD	; width, height
hero_erase_wh_old:			.storage WORD_LEN ; .word TEMP_WORD	; width, height last frame
hero_pos_x:					.storage WORD_LEN ; .word TEMP_WORD ; first byte is a sub-pixel coord
hero_pos_y:					.storage WORD_LEN ; .word TEMP_WORD ; first byte is a sub-pixel coord
hero_speed_x:				.storage WORD_LEN ; .word TEMP_WORD ; first byte is a sub-pixel coord speed
hero_speed_y:				.storage WORD_LEN ; .word TEMP_WORD ; first byte is a sub-pixel coord speed
hero_data_prev_pptr:		.storage ADDR_LEN ; .word TEMP_ADDR
hero_data_next_pptr:		.storage ADDR_LEN ; .word TEMP_ADDR
hero_runtime_data_end:

;=============================================================================
; monsters runtime data
;
MONSTERS_MAX = 15 ; max monsters in the room
; ptr to the first monster data in the sorted list
monsters_runtime_data_sorted:	.storage ADDR_LEN ; .word monster_update_ptr

; a list of monster runtime data structs.
monsters_runtime_data:
monster_update_ptr:			.storage ADDR_LEN ; .word TEMP_ADDR
monster_draw_ptr:			.storage ADDR_LEN ; .word TEMP_ADDR
monster_status:				.storage BYTE_LEN ; .byte TEMP_BYTE
monster_status_timer:		.storage BYTE_LEN ; .byte TEMP_BYTE
monster_anim_timer:			.storage BYTE_LEN ; .byte TEMP_BYTE
monster_anim_ptr:			.storage ADDR_LEN ; .word TEMP_ADDR
monster_erase_scr_addr:		.storage ADDR_LEN ; .word TEMP_WORD
monster_erase_scr_addr_old:	.storage ADDR_LEN ; .word TEMP_ADDR
monster_erase_wh:			.storage WORD_LEN ; .word TEMP_WORD
monster_erase_wh_old:		.storage WORD_LEN ; .word TEMP_WORD
monster_pos_x:				.storage WORD_LEN ; .word TEMP_WORD
monster_pos_y:				.storage WORD_LEN ; .word TEMP_WORD
monster_speed_x:			.storage WORD_LEN ; .word TEMP_WORD
monster_speed_y:			.storage WORD_LEN ; .word TEMP_WORD
monster_impacted_ptr:		.storage ADDR_LEN ; .word TEMP_WORD ; called by a hero's bullet, another monster, etc. to affect this monster
monster_id:					.storage BYTE_LEN ; .byte TEMP_BYTE
monster_type:				.storage BYTE_LEN ; .byte TEMP_BYTE
monster_health:				.storage BYTE_LEN ; .byte TEMP_BYTE
monster_data_prev_pptr:		.storage ADDR_LEN ; .word TEMP_WORD
monster_data_next_pptr:		.storage ADDR_LEN ; .word TEMP_WORD
@data_end:
MONSTER_RUNTIME_DATA_LEN = @data_end - monsters_runtime_data

.storage MONSTER_RUNTIME_DATA_LEN * (MONSTERS_MAX - 1) ; remaining monster runtime data

; the same structs for the rest of the monsters
monsters_runtime_data_end_marker:	.storage WORD_LEN ; .word ACTOR_RUNTIME_DATA_END << 8
monsters_runtime_data_end:
MONSTERS_RUNTIME_DATA_LEN			= monsters_runtime_data_end - monsters_runtime_data_sorted

;=============================================================================
; bullets runtime data
.align 0x100 ; must fit inside $100 block
; a list of bullet runtime data structs.
bullets_runtime_data:
bullet_update_ptr:			.storage ADDR_LEN
bullet_draw_ptr:			.storage ADDR_LEN
bullet_status:				.storage BYTE_LEN
bullet_status_timer:		.storage BYTE_LEN
bullet_anim_timer:			.storage BYTE_LEN
bullet_anim_ptr:			.storage ADDR_LEN
bullet_erase_scr_addr:		.storage ADDR_LEN
bullet_erase_scr_addr_old:	.storage ADDR_LEN
bullet_erase_wh:			.storage WORD_LEN
bullet_erase_wh_old:		.storage WORD_LEN
bullet_pos_x:				.storage WORD_LEN
bullet_pos_y:				.storage WORD_LEN
bullet_speed_x:				.storage WORD_LEN
bullet_speed_y:				.storage WORD_LEN
@data_end:
BULLET_RUNTIME_DATA_LEN = @data_end - bullets_runtime_data

.storage BULLET_RUNTIME_DATA_LEN * (BULLETS_MAX - 1) ; remaining bullet runtime data

; the same structs for the rest of the bullets
bullets_runtime_data_end_marker:	.storage WORD_LEN ; .word ACTOR_RUNTIME_DATA_END << 8
bullets_runtime_data_end:
BULLETS_RUNTIME_DATA_LEN			= bullets_runtime_data_end - bullets_runtime_data

;=============================================================================
; statuses of container instances.
; this data is aligned to $100, the length is <= $100

; data format:
; containers_inst_data_ptrs:
; .loop CONTAINERS_UNIQUE__USED_IN_LEVELS 
; if only one type if chests is used, CONTAINERS_UNIQUE__USED_IN_LEVELS = 1. this data is generated by level exporter
;	.byte - a low byte ptr to container_inst_data for particular container
; .endloop
; .byte - a low byte ptr to the next addr after the last container_NN_inst_data_ptr
; container_inst_data:
; .loop CONTAINERS_UNIQUE_MAX
;	container_inst_data:
;		.byte - tile_idx where this container is placed
;		.byte - room_id where this container is placed. 
;				if room_id == CONTAINERS_STATUS_ACQUIRED, a container is acquired
; .endloop
CONTAINERS_UNIQUE_MAX		= 16
CONTAINERS_LEN				= $100
CONTAINERS_STATUS_ACQUIRED	= $ff

containers_inst_data_ptrs:	.storage CONTAINERS_LEN
;containers_inst_data:		= containers_inst_data_ptrs + used_unique_containers (can vary) + 1

;=============================================================================
; statuses of resource instances placed in rooms. 
; this data is aligned to $100, the length is <= $100

; data format:
; resources_inst_data_ptrs:
; .loop RESOURCES_UNIQUE_USED_IN_LEVELS 
; if only boxes is used, RESOURCES_UNIQUE_USED_IN_LEVELS = 1. this data is generated by level exporter
;	.byte - a low byte ptr to resources_inst_data for particular resource
; .endloop
; .byte - a low byte ptr to the next addr after the last element in resources_inst_data
; resources_inst_data:
; .loop RESOURCES_UNIQUE_MAX
;	resource_inst_data:
;		.byte - tile_idx where this resource is placed
;		.byte - room_id where this resource is placed. 
;				if room_id == RESOURCES_STATUS_ACQUIRED, a resource is acquired
; .endloop
RESOURCES_UNIQUE_MAX		= 16
RESOURCES_LEN				= $100
RESOURCES_STATUS_ACQUIRED	= $ff

resources_inst_data_ptrs:	.storage RESOURCES_LEN
;resources_inst_data:		= resources_inst_data_ptrs + used_unique_resources (can vary) + 1
