	; this line for VSCode proper formating
; TODO: write a script that generates this file

;=============================================================================
;
; for validation
; TODO: keep updated
BUFFERS_START_ADDR	= $7300

;=============================================================================
; contains statuses of breakables. should be reseted every game start and after hero respawn
; this structure can contain statuses for 1016 breakables across all levels
; each room can contain variable amount of breakables
; TODO: check if it supports the level 2
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
;			Where bit=0 means breakable is not broken, 1 - broken
;			Example: if the room contains nine breakables with tile_id=A, tile_id=B, tile_id=C, tile_id=J, tile_id=K, tile_id=O, tile_id=P, tile_id=X, tile_id=Z
;			their statuses will be packed into two bytes:
;			.byte XPOKJCBA
;			.byte 0000000Z
;	.endloop
BREAKABLES_MAX							= 1016 ; (256-1-128)*8
breakables_status_buffer_available_ptr:	= $7300 ; contains the pointer
breakables_status_buffer_ptrs:			= $7301
breakables_status_buffers:				= breakables_status_buffer_ptrs + ROOMS_MAX * LEVELS_MAX
breakables_statuses_end:				= breakables_status_buffer_available_ptr + $100

;=============================================================================
;	it's a copy of the room tiledata stored by room_draw
;	it's used in room_redraw for storing states of breakable objects, and restoring states of doors and containers
ROOM_TILEDATA_BACKUP_LEN			= ROOM_WIDTH * ROOM_HEIGHT
room_tiledata_backup:				= $7400
room_tiledata_backup_end:			= $7400 + ROOM_TILEDATA_BACKUP_LEN

;=============================================================================
; hero runtime data
hero_runtime_data:			= $74f0
hero_update_ptr:			= hero_runtime_data + 0		; .word hero_update
hero_draw_ptr:				= hero_runtime_data + 2		; .word hero_draw
hero_impacted_ptr:			= hero_runtime_data + 4		; .word hero_impacted ; called by a monster's bullet, a monster, etc. to affect a hero
hero_type:					= hero_runtime_data + 6		; .byte MONSTER_TYPE_ALLY
hero_status:				= hero_runtime_data + 7		; .byte ACTOR_STATUS_HERO_IDLE ; a status describes what set of animations and behavior is active
hero_status_timer:			= hero_runtime_data + 8		; .byte 0	; a duration of the status. ticks every update
hero_anim_timer:			= hero_runtime_data + 9		; .byte TEMP_BYTE ; it triggers an anim frame switching when it overflows
hero_anim_addr:				= hero_runtime_data + 10	; .word TEMP_ADDR ; holds the current frame ptr
hero_dir:					= hero_runtime_data + 12	; .byte 1			; VDHD, V: vertical dir, H: horiz dir, D: 0 - neg dir, 1 - positive dir
hero_erase_scr_addr:		= hero_runtime_data + 13	; .word TEMP_ADDR	; screen addr for erasing
hero_erase_scr_addr_old:	= hero_runtime_data + 15	; .word TEMP_ADDR	; screen addr for erasing last frame 
hero_erase_wh:				= hero_runtime_data + 17	; .word TEMP_WORD	; width, height
hero_erase_wh_old:			= hero_runtime_data + 19	; .word TEMP_WORD	; width, height last frame
hero_pos_x:					= hero_runtime_data + 21	; .word TEMP_WORD ; first byte is a sub-pixel coord
hero_pos_y:					= hero_runtime_data + 23	; .word TEMP_WORD ; first byte is a sub-pixel coord
hero_speed_x:				= hero_runtime_data + 25	; .word TEMP_WORD ; first byte is a sub-pixel coord speed
hero_speed_y:				= hero_runtime_data + 27	; .word TEMP_WORD ; first byte is a sub-pixel coord speed
hero_data_prev_pptr:		= hero_runtime_data + 29	; .word TEMP_ADDR
hero_data_next_pptr:		= hero_runtime_data + 31	; .word TEMP_ADDR
hero_runtime_data_end:		= hero_runtime_data + 33

;=============================================================================
;
; contains the current RAM-disk mode
; to restore by the interrupt routine after its execution
ram_disk_mode:				= $7511
			;.storage BYTE_LEN

;=============================================================================
; monsters runtime data
; requirements:
; * MONSTER_RUNTIME_DATA_LEN < 256
; * (bullet_status - bullet_erase_scr_addr) == (monster_status - monster_erase_scr_addr)
; * (bullet_erase_scr_addr+1 - bullet_erase_wh) == (monster_erase_scr_addr+1 - monster_erase_wh)
;
MONSTERS_MAX = 15 ; max monsters in the room
; ptr to the first monster data in the sorted list
monsters_runtime_data_sorted:	= $7512 ; .word monster_update_ptr

; a list of monster runtime data structs.
monsters_runtime_data:		= $7514	; $7712 - $1fe (512)(MONSTER_RUNTIME_DATA_LEN * MONSTERS_MAX)
monster_update_ptr:			= monsters_runtime_data + 0		; .word TEMP_ADDR
monster_draw_ptr:			= monsters_runtime_data + 2		; .word TEMP_ADDR
monster_status:				= monsters_runtime_data + 4		; .byte TEMP_BYTE
monster_status_timer:		= monsters_runtime_data + 5		; .byte TEMP_BYTE
monster_anim_timer:			= monsters_runtime_data + 6		; .byte TEMP_BYTE
monster_anim_ptr:			= monsters_runtime_data + 7		; .word TEMP_ADDR
monster_erase_scr_addr:		= monsters_runtime_data + 9		; .word TEMP_WORD
monster_erase_scr_addr_old:	= monsters_runtime_data + 11	; .word TEMP_ADDR
monster_erase_wh:			= monsters_runtime_data + 13	; .word TEMP_WORD
monster_erase_wh_old:		= monsters_runtime_data + 15	; .word TEMP_WORD
monster_pos_x:				= monsters_runtime_data + 17	; .word TEMP_WORD
monster_pos_y:				= monsters_runtime_data + 19	; .word TEMP_WORD
monster_speed_x:			= monsters_runtime_data + 21	; .word TEMP_WORD
monster_speed_y:			= monsters_runtime_data + 23	; .word TEMP_WORD
monster_impacted_ptr:		= monsters_runtime_data + 25	; .word TEMP_WORD ; called by a hero's bullet, another monster, etc. to affect this monster
monster_id:					= monsters_runtime_data + 27	; .byte TEMP_BYTE
monster_type:				= monsters_runtime_data + 28	; .byte TEMP_BYTE
monster_health:				= monsters_runtime_data + 29	; .byte TEMP_BYTE
monster_data_prev_pptr:		= monsters_runtime_data + 30	; .word TEMP_WORD
monster_data_next_pptr:		= monsters_runtime_data + 32	; .word TEMP_WORD
@data_end:					= monsters_runtime_data + 34

MONSTER_RUNTIME_DATA_LEN = @data_end - monsters_runtime_data

; the same structs for the rest of the monsters
monsters_runtime_data_end_marker:	= monsters_runtime_data + MONSTER_RUNTIME_DATA_LEN * MONSTERS_MAX	; .word ACTOR_RUNTIME_DATA_END << 8
monsters_runtime_data_end:			= monsters_runtime_data_end_marker + ADDR_LEN
MONSTERS_RUNTIME_DATA_LEN			= monsters_runtime_data_end - monsters_runtime_data_sorted

;=============================================================================
/*
; tiled image indices buffer
; a temporal buffer to unpack data
tiled_img_idxs:	= $7714

; TODO: consider increasing this buffer and combine title1, title2, main_menu_back1, and main_menu_back2 into one image
TILED_IMG_IDXS_LEN = $100
*/
; tiled image idxs buffer
; a temporal buffer to unpack data

; TODO: consider increasing this buffer and combine
; title1, title2, main_menu_back1, and main_menu_back2 into one image
TEMP_BUFF_LEN = $100
temp_buff:				.storage TEMP_BUFF_LEN

;=============================================================================
; bullets runtime data
; requirements:
; * must fit inside $100 block
; * (bullet_status - bullet_erase_scr_addr) == (monster_status - monster_erase_scr_addr)
; * (bullet_erase_scr_addr+1 - bullet_erase_wh) == (monster_erase_scr_addr+1 - monster_erase_wh)

; a list of bullet runtime data structs.
bullets_runtime_data:		= $7815
bullet_update_ptr:			= bullets_runtime_data + 0		;.word TEMP_ADDR
bullet_draw_ptr:			= bullets_runtime_data + 2		;.word TEMP_ADDR
bullet_status:				= bullets_runtime_data + 4		;.byte TEMP_BYTE
bullet_status_timer:		= bullets_runtime_data + 5		;.byte TEMP_BYTE
bullet_anim_timer:			= bullets_runtime_data + 6		;.byte TEMP_BYTE
bullet_anim_ptr:			= bullets_runtime_data + 7		;.word TEMP_ADDR
bullet_erase_scr_addr:		= bullets_runtime_data + 9		;.word TEMP_WORD
bullet_erase_scr_addr_old:	= bullets_runtime_data + 11		;.word TEMP_ADDR
bullet_erase_wh:			= bullets_runtime_data + 13		;.word TEMP_WORD
bullet_erase_wh_old:		= bullets_runtime_data + 15		;.word TEMP_WORD
bullet_pos_x:				= bullets_runtime_data + 17		;.word TEMP_WORD
bullet_pos_y:				= bullets_runtime_data + 19		;.word TEMP_WORD
bullet_speed_x:				= bullets_runtime_data + 21		;.word TEMP_WORD
bullet_speed_y:				= bullets_runtime_data + 23		;.word TEMP_WORD
@data_end:					= bullets_runtime_data + 25

BULLET_RUNTIME_DATA_LEN = @data_end - bullets_runtime_data ; $1a; bullet_runtime_data_end_addr-bullets_runtime_data

; the same structs for the rest of the bullets
bullets_runtime_data_end_marker:	= bullets_runtime_data + BULLET_RUNTIME_DATA_LEN * BULLETS_MAX ; $78ff ; :		.word ACTOR_RUNTIME_DATA_END << 8
bullets_runtime_data_end:			= bullets_runtime_data_end_marker + ADDR_LEN
BULLETS_RUNTIME_DATA_LEN			= bullets_runtime_data_end - bullets_runtime_data
;=============================================================================
;
; FREE SPACE $78F8 - $7900
;
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

containers_inst_data_ptrs:	= $7900
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

resources_inst_data_ptrs:	= $7a00
;resources_inst_data:		= resources_inst_data_ptrs + used_unique_resources (can vary) + 1

;=============================================================================
; rooms spawn rates. each byte represents a spawn rate in a particular room.
; this data is aligned to $100, the length is <= $100
; data format:
; .loop ROOMS_MAX
;	.byte - a monster spawn rate in the room_id = N
; .endloop
; .loop ROOMS_MAX
;	.byte - a breakables spawn rate in the room_id = N
; .endloop
; ...

rooms_spawn_rates:				= $7b00
rooms_spawn_rate_monsters:		= rooms_spawn_rates 					; 0 means 100% chance to spawn a monster. 255 means no spawn
rooms_spawn_rates_end:			= rooms_spawn_rate_monsters + ROOMS_MAX ; $7b80

;=============================================================================
;
;	free space [$7b80]
;
;=============================================================================
;
; global states
;

; a current command that is handled by the level update func
;global_request:	= $7b81			; .byte

; the current room idx of the current level
room_id:		= $7b82			; .byte ; in the range [0, ROOMS_MAX-1]
; the current level idx
level_id:   	= room_id + 1	; .byte

game_ui_item_visible_addr:	= $7b84		; .byte TEMP_BYTE ; currently shown item on the panel. range [0, ITEMS_MAX-1]

;=============================================================================
; back runtime data
; must fit inside one $100 block
backs_runtime_data:		= $7b85
back_anim_ptr:			= backs_runtime_data + 0	;.word TEMP_ADDR ; also (back_anim_ptr+1) stores a marker of end of the data like ACTOR_RUNTIME_DATA_LAST
back_scr_addr:			= backs_runtime_data + 2	;.word TEMP_WORD
back_anim_timer:		= backs_runtime_data + 4	;.byte TEMP_BYTE
back_anim_timer_speed:	= backs_runtime_data + 5	;.byte TEMP_BYTE
@data_end:				= backs_runtime_data + 6

BACK_RUNTIME_DATA_LEN = @data_end - backs_runtime_data

; the same structs for the rest of the backs
backs_runtime_data_end_marker:	= backs_runtime_data + BACK_RUNTIME_DATA_LEN * BACKS_MAX ;.word ACTOR_RUNTIME_DATA_END << 8
backs_runtime_data_end:			= backs_runtime_data_end_marker + WORD_LEN
BACKS_RUNTIME_DATA_LEN = backs_runtime_data_end - backs_runtime_data

;=============================================================================
; level init data ptr and ram-disk access commands
level_init_tbl:						= $7bc3
level_ram_disk_s_data:				= level_init_tbl		; .byte __RAM_DISK_S_LEVEL00_DATA
level_ram_disk_m_data: 				= level_init_tbl + 1	; .byte __RAM_DISK_M_LEVEL00_DATA
level_ram_disk_s_gfx:				= level_init_tbl + 2	; .byte __RAM_DISK_S_LEVEL00_GFX
level_ram_disk_m_gfx:				= level_init_tbl + 3	; .byte __RAM_DISK_M_LEVEL00_GFX
level_palette_ptr:					= level_init_tbl + 4	; .word __level00_palette
level_resources_inst_data_pptr:		= level_init_tbl + 6	; .word __level00_resources_inst_data_ptrs
level_containers_inst_data_pptr:	= level_init_tbl + 8	; .word __level00_containers_inst_data_ptrs
level_start_pos_ptr:				= level_init_tbl + 10	; .word _lv0_data_start_pos
level_rooms_pptr:					= level_init_tbl + 12	; .word _lv0_data_rooms_ptrs
level_tiles_pptr:					= level_init_tbl + 14	; .word _lv0_gfx_tiles_ptrs
@data_end:							= level_init_tbl + 16	
LEVEL_INIT_TBL_LEN = @data_end - level_init_tbl

;=============================================================================
;
; palette
palette: = $7bd3 ; 16 bytes

;=============================================================================
;
; game statuses
GAME_STATUS_NOT_ACQUIRED	= 0
GAME_STATUS_ACQUIRED		= 1
GAME_STATUS_USED			= 2

game_status:				= $7be3
game_status_cabbage_eaten:		= game_status		; contains how many cabbage were eaten
game_status_fire_extinguished:	= game_status + 1	; contains how many fire walls were extinguished
game_status_cabbage_healing:	= game_status + 2	; show dialog when the hero used cabbage the first time
game_status_use_pie:			= game_status + 3	; show dialog when the hero used a pie the first time
game_status_use_clothes:		= game_status + 4	; show dialog when the hero used a clothes the first time
game_status_use_spoon:			= game_status + 5	; show dialog when the hero used a spoon the first time
game_status_first_freeze:		= game_status + 6	; show dialog when the hero freeze the monster the first time
game_status_fart:				= game_status + 7	; a status acquired for eating cabbage
game_status_burner_quest_room:	= game_status + 8	; a status contains an index for burner_quest_room_ids array
game_status_end:				= game_status + 9

;=============================================================================
;
;	free space [$7bec - $7bf6]
;=============================================================================
;
; global states 2
;
global_states_2:		= $7bf7
border_color_idx:		= global_states_2 + 0 ; .byte
scr_offset_y:			= global_states_2 + 1 ; .byte

; it is used to check how many updates needs to happened
; to sync with interruptions
game_updates_required:= global_states_2 + 2 ; .byte
			;.storage BYTE_LEN

; a lopped counter increased every game update
game_update_counter:	= global_states_2 + 3 ; .byte

; used for the movement
char_temp_x:			= global_states_2 + 4 ; .word ; temporal X
char_temp_y:			= global_states_2 + 6 ; .word ; temporal Y
global_states_2_end:	= global_states_2 + 8
;=============================================================================
;
; hero resources
; 15 resources max

hero_resources:			= $7c00
hero_res_score:			= hero_resources + 0 ; WORD_LEN
hero_res_health:		= hero_resources + 2 ; +2 because hero_res_score = WORD_LEN
hero_res_sword:			= hero_resources + 3 ; the first selectable resource
hero_res_snowflake:		= hero_resources + 4
hero_res_tnt:			= hero_resources + 5
hero_res_potion_health:	= hero_resources + 6
hero_res_popsicle_pie:	= hero_resources + 7
hero_res_clothes:		= hero_resources + 8 ; it is a quest resource
hero_res_cabbage:		= hero_resources + 9 ; it is a quest resource
hero_res_spoon:			= hero_resources + 10
hero_res_not_used_01:	= hero_resources + 11 ; it is a quest resource
hero_res_not_used_02:	= hero_resources + 12
hero_res_not_used_03:	= hero_resources + 13
hero_res_not_used_04:	= hero_resources + 14
hero_res_not_used_06:	= hero_resources + 15

; selected ui resource
; 0000_RRRR
;	RRRR - res_id, it is not equal to the tiledata because hero_res_score takes two bytes
;	0 - no resources
game_ui_res_selected_id:	= hero_resources + 16	; .byte
hero_resources_end:			= hero_resources + 17

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

global_items:		= $7c11
global_items_end:	= global_items + ITEMS_MAX

;=============================================================================
; tile graphics pointer table.

; data format:
; .loop ROOM_HEIGHT
;	.loop ROOM_WIDTH
;		.word - tile_gfx_addr
;	.endloop
; .endloop

ROOM_TILES_GFX_PTRS_LEN	= ROOM_WIDTH * ROOM_HEIGHT * ADDR_LEN
room_tiles_gfx_ptrs:		= $7c20
room_tiles_gfx_ptrs_end:	= room_tiles_gfx_ptrs + ROOM_TILES_GFX_PTRS_LEN

;=============================================================================
; tiledata buffer has to follow room_tiles_gfx_ptrs because they are unpacked altogether. see level_data.asm for tiledata format

; data format:
; .loop ROOM_HEIGHT
;	.loop ROOM_WIDTH
;		.byte - tiledata
;	.endloop
; .endloop

room_tiledata:		= $7e00
room_tiledata_end:	= room_tiledata + ROOM_TILEDATA_LEN

;=============================================================================
;
;	free space [$7ef0 - $7eff]
;
;=============================================================================
;
; OS I/O vars
;
os_io_data:				= $7ef0
; the disk number to restore it before returning to the OS
; check RDS_DISK in os_consts.asm for more info
os_disk:				= os_io_data

; the last filename IO handled
os_filename:			= os_disk + BYTE_LEN
			;.storage BASENAME_LEN
			;.storage BYTE_LEN ; "."
os_filename_ext:		= os_filename + BASENAME_LEN + BYTE_LEN
			;.storage EXT_LEN
			;.storage 2 ; "\n$"

/*
; the last file format IO handled
; TODO: make it useful or delete
;os_file_format:
;			.storage BYTE_LEN
*/
; points to next byte after loaded file
os_file_data_ptr:		= os_filename_ext + EXT_LEN + WORD_LEN
			;.storage BYTE_LEN
os_io_data_end:			= os_file_data_ptr + BYTE_LEN
OS_IO_DATA_END = os_io_data_end - os_io_data

;=============================================================================
;
;	free space [$7F00 - $7FBE]
;
;=============================================================================

;=============================================================================
;
; STACK_MIN_ADDR = $7FBE

