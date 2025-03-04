; to init each tiledata in a room during a room initialization. 
; check room.asm room_handle_room_tiledata func
room_tiledata_funcs:
			JMP_4(room_tiledata_decal_walkable_spawn)	; func_id = 0
			JMP_4(room_tiledata_monster_spawn)			; func_id = 1
			JMP_4(room_tiledata_copy)					; func_id = 2
			JMP_4(room_tiledata_copy)					; func_id = 3
			JMP_4(room_tiledata_copy)					; func_id = 4
			JMP_4(room_tiledata_copy)					; func_id = 5
			JMP_4(room_tiledata_item_spawn)				; func_id = 6
			JMP_4(room_tiledata_resource_spawn)			; func_id = 7
			JMP_4(room_tiledata_copy)					; func_id = 8
			JMP_4(room_tiledata_copy)					; func_id = 9
			JMP_4(room_tiledata_copy)					; func_id = 10
			JMP_4(room_tiledata_container_spawn)		; func_id = 11
			JMP_4(room_tiledata_door_spawn)				; func_id = 12
			JMP_4(room_tiledata_breakable_spawn)		; func_id = 13
			JMP_4(room_tiledata_decal_collidable_spawn)	; func_id = 14
			JMP_4(room_tiledata_back_spawn)				; func_id = 15

; level init data ptr and ram-disk access commands
levels_init_tbls_ptrs:
				.word level00_init_tbls, level01_init_tbls
; level00 init tbl
level00_init_tbls:
levels_ram_disk_s_data:				.byte RAM_DISK_S_LV0_DATA
levels_ram_disk_m_data: 			.byte RAM_DISK_M_LV0_DATA
levels_ram_disk_s_gfx:				.byte RAM_DISK_S_LV0_GFX
levels_ram_disk_m_gfx:				.byte RAM_DISK_M_LV0_GFX
levels_palette_ptr:					.word _lv0_palette
levels_resources_inst_data_pptr:	.word _lv0_resources_inst_data_ptrs
levels_containers_inst_data_pptr:	.word _lv0_containers_inst_data_ptrs
levels_start_pos_ptr:				.word _lv0_start_pos
levels_rooms_ptrs:					.word _lv0_data_rooms_ptrs
levels_tiles_ptrs:					.word _lv0_gfx_tiles_ptrs
level00_init_tbls_end:
; level01 init tbl
level01_init_tbls:
									.byte 0
									.byte 0
									.byte 0
									.byte 0
									.word 0
									.word 0
									.word 0
									.word 0
									.word 0
									.word 0