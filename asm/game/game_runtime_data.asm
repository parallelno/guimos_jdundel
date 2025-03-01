	; this line for VSCode proper formating
; contains game-related runtime data

;=============================================================================
; level init data ptr and ram-disk access commands
level_init_tbl:
level_ram_disk_s_data:				.storage BYTE_LEN	; .byte RAM_DISK_S_LEVEL00_DATA
level_ram_disk_m_data: 				.storage BYTE_LEN		; .byte RAM_DISK_M_LEVEL00_DATA
level_ram_disk_s_gfx:				.storage BYTE_LEN		; .byte RAM_DISK_S_LEVEL00_GFX
level_ram_disk_m_gfx:				.storage BYTE_LEN		; .byte RAM_DISK_M_LEVEL00_GFX
level_palette_ptr:					.storage ADDR_LEN	; .word _level00_palette
level_resources_inst_data_pptr:		.storage ADDR_LEN		; .word _level00_resources_inst_data_ptrs
level_containers_inst_data_pptr:	.storage ADDR_LEN		; .word _level00_containers_inst_data_ptrs
level_start_pos_ptr:				.storage ADDR_LEN		; .word _level00_start_pos
level_rooms_pptr:					.storage ADDR_LEN		; .word _level00_rooms_addr
level_tiles_pptr:					.storage ADDR_LEN		; .word _level00_tiles_addr
level_init_tbl_end:

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
ROOM_TILEDATA_BACKUP_LEN			= ROOM_TILEDATA_LEN
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
global_states:
; stores a request to manage the game and main_menu states
global_request:			.storage BYTE_LEN


; the current room idx of the current level
room_id:				.storage BYTE_LEN ; in the range [0, ROOMS_MAX-1]
; the current level idx
level_id:   			.storage BYTE_LEN

; currently shown item on the panel. range [0, ITEMS_MAX-1]
game_ui_item_visible_addr:	.storage BYTE_LEN

; a lopped counter increased every game update
game_update_counter:	.storage BYTE_LEN

; used for the movement
char_temp_x:			.storage WORD_LEN ; temporal X
char_temp_y:			.storage WORD_LEN ; temporal Y
global_states_end:
;=============================================================================
;
; game statuses
GAME_STATUS_NOT_ACQUIRED	= 0
GAME_STATUS_ACQUIRED		= 1
GAME_STATUS_USED			= 2

game_status:
game_status_cabbage_eaten:		.storage BYTE_LEN ; contains how many cabbage were eaten
game_status_fire_extinguished:	.storage BYTE_LEN ; contains how many fire walls were extinguished
game_status_cabbage_healing:	.storage BYTE_LEN ; show dialog when the hero used cabbage the first time
game_status_use_pie:			.storage BYTE_LEN ; show dialog when the hero used a pie the first time
game_status_use_clothes:		.storage BYTE_LEN ; show dialog when the hero used a clothes the first time
game_status_use_spoon:			.storage BYTE_LEN ; show dialog when the hero used a spoon the first time
game_status_first_freeze:		.storage BYTE_LEN ; show dialog when the hero freeze the monster the first time
game_status_fart:				.storage BYTE_LEN ; a status acquired for eating cabbage
game_status_burner_quest_room:	.storage BYTE_LEN ; a status contains an index for burner_quest_room_ids array
game_status_end:


;=============================================================================
; hero resources
; 15 resources max

hero_resources:
hero_res_score:			.storage WORD_LEN
hero_res_health:		.storage BYTE_LEN
hero_res_sword:			.storage BYTE_LEN ; the first selectable resource
hero_res_snowflake:		.storage BYTE_LEN
hero_res_tnt:			.storage BYTE_LEN
hero_res_potion_health:	.storage BYTE_LEN
hero_res_popsicle_pie:	.storage BYTE_LEN
hero_res_clothes:		.storage BYTE_LEN ; it is a quest resource
hero_res_cabbage:		.storage BYTE_LEN ; it is a quest resource
hero_res_spoon:			.storage BYTE_LEN
hero_res_not_used_01:	.storage BYTE_LEN ; it is a quest resource
hero_res_not_used_02:	.storage BYTE_LEN
hero_res_not_used_03:	.storage BYTE_LEN
hero_res_not_used_04:	.storage BYTE_LEN
hero_res_not_used_06:	.storage BYTE_LEN

; selected ui resource
; 0000_RRRR
;	RRRR - res_id, it is not equal to the tiledata 
;			because hero_res_score takes two bytes
;	0 - no resource selected
game_ui_res_selected_id:	.storage BYTE_LEN
hero_resources_end:

RES_SELECTABLE_AVAILABLE_NONE	= 0
RES_SELECTABLE_ID_CLOTHES		= 4
RES_SELECTABLE_FIRST	= hero_res_sword
RES_SELECTABLE_LAST		= hero_res_spoon
RES_SELECTABLE_MAX		= RES_SELECTABLE_LAST - RES_SELECTABLE_FIRST + 1


;=============================================================================
; contains global item statuses.
ITEM_STATUS_NOT_ACQUIRED	= 0
ITEM_STATUS_ACQUIRED		= 1
ITEM_STATUS_USED			= 2
ITEMS_MAX					= 15 ; item_id = 0 is reserved for dialog tiledata

; data format:
; .loop ITEMS_MAX
;	.byte - status of item_id = N
; .endloop

global_items:		.storage ITEMS_MAX
global_items_end:

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
; back runtime data
.align 0x100 ; must fit inside $100 block
backs_runtime_data:
back_anim_ptr:			.storage ADDR_LEN ; also (back_anim_ptr+1) stores a marker of end of the data like ACTOR_RUNTIME_DATA_LAST
back_scr_addr:			.storage ADDR_LEN
back_anim_timer:		.storage BYTE_LEN
back_anim_timer_speed:	.storage BYTE_LEN
@data_end:
BACK_RUNTIME_DATA_LEN = @data_end - backs_runtime_data

.storage BACK_RUNTIME_DATA_LEN * (BACKS_MAX - 1)

; the same structs for the rest of the backs
backs_runtime_data_end_marker:	.storage WORD_LEN ;.word ACTOR_RUNTIME_DATA_END << 8
backs_runtime_data_end:
BACKS_RUNTIME_DATA_LEN = backs_runtime_data_end - backs_runtime_data

;=============================================================================
; statuses of container instances.
.align 0x100 ; must be aligned to $100, the length is <= $100

; data format:
; containers_inst_data_ptrs:
; .loop CONTAINERS_UNIQUE_USED_IN_LEVELS 
; if only one type if chests is used, CONTAINERS_UNIQUE_USED_IN_LEVELS = 1. this data is generated by level exporter
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
.align 0x100 ; must be aligned to $100, the length is <= $100

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

;=============================================================================
; rooms spawn rates. each byte represents a spawn rate in a particular room.
.align 0x100 ; must be aligned to $100, the length is <= $100
; data format:
; .loop ROOMS_MAX
;	.byte - a monster spawn rate in the room_id = N
; .endloop
; .loop ROOMS_MAX
;	.byte - a breakables spawn rate in the room_id = N
; .endloop
; ...
; 0 means 100% chance to spawn a monster. 255 means no spawn

rooms_spawn_rates:
rooms_spawn_rate_monsters:		.storage ROOMS_MAX * 2
rooms_spawn_rates_end:

;=============================================================================
; contains statuss of breakables. 
.align 0x100 ; TODO: check if it must be aligned to $100
; should be reseted every game start and after hero respawns
; this structure can contain statuses for 1016 breakables across off levels
; each room can contain variable amount of breakables
; TODO: supports only level 0 and level 1 now
; data format:
; breakables_status_buffer_ptrs:
;	 .byte a low byte pointer to a breakables statuses in breakables_status_buffers for a room_id_0 in level_id_0
;	 .byte a low byte pointer to a breakables statuses in breakables_status_buffers for a room_id_1 in level_id_0
;	... similar for the rest rooms, ROOMS_MAX total
;	 .byte a low byte pointer to a breakables statuses in breakables_status_buffers for a room_id_0 in level_id_1
;	 .byte a low byte pointer to a breakables statuses in breakables_status_buffers for a room_id_1 in level_id_1
;	... similar for the rest rooms, ROOMS_MAX total
;
; breakables_status_buffers:
;	.loop as many, as many rooms contain breakables and visited by player
;		Set of bytes where every byte contains statuses of 8 breakables in the room starting from the tile_id=0
;			Bit = 0 means a breakable is not broken, and vise versa
;			Example: if the room contains nine breakables with tile_id=A, tile_id=B, tile_id=C, tile_id=J, tile_id=K, tile_id=O, tile_id=P, tile_id=X, tile_id=Z
;			their statuses will be packed into two bytes:
;			.byte XPOKJCBA
;			.byte 0000000Z
;	.endloop
BREAKABLES_MAX							= 1016 ; (256-1-128)*8
breakables_status_buffer_available_ptr:	.storage BYTE_LEN ; contains the pointer
breakables_status_buffer_ptrs:			.storage ROOMS_MAX * LEVELS_MAX
breakables_status_buffers:				.storage 0x100 - ROOMS_MAX * LEVELS_MAX ;  TODO: check if this LEN is correct
breakables_statuses_end:
