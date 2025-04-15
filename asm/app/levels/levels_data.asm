memusage_levels_data:
;=======================================================
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