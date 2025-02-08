; fdd bin file metadata
; asm data file: build/debug/level_data/lv0_data_data.asm
; bin file: build/debug/bin/LV0_DATA.BIN

LV0_DATA_FILE_LEN = 3638
LV0_DATA_LAST_RECORD_LEN = 54

LV0_DATA_FILENAME_PTR:
			.byte "LV0_DATA" ; filename
			.byte "BIN" ; extension

_lv0_start_pos:					; a hero starting pos
			.byte 140			; pos_y
			.byte 120			; pos_x

_lv0_home = 2
_lv0_farm_fence = 278
_lv0_road_to_friends_home = 542
_lv0_friends_home = 826
_lv0_friends_home_backyard = 1088
_lv0_friends_secret_place = 1353
_lv0_crossroad = 1667
_lv0_farm_entrance = 1943
_lv0_farm_storage = 2212
_lv0_loop = 2476
_lv0_dungeon_entrance = 2765
_lv0_abandoned_home = 3051
_lv0_lost_coins = 3322

			.word 0 ; safety pair of bytes for reading by POP B
lv0_rooms_addr:
			.word _lv0_home, 0, _lv0_farm_fence, 0, _lv0_road_to_friends_home, 0, _lv0_friends_home, 0, _lv0_friends_home_backyard, 0, _lv0_friends_secret_place, 0, _lv0_crossroad, 0, _lv0_farm_entrance, 0, _lv0_farm_storage, 0, _lv0_loop, 0, _lv0_dungeon_entrance, 0, _lv0_abandoned_home, 0, _lv0_lost_coins, 

_lv0_resources_inst_data_ptrs:
			.byte 9, 109, 109, 109, 109, 109, 109, 111, 121, 
_lv0_resources_inst_data:
			.byte 98, 0, 99, 0, 82, 0, 215, 2, 216, 2, 217, 2, 198, 2, 199, 2, 201, 2, 202, 2, 184, 5, 167, 5, 169, 5, 36, 5, 37, 5, 19, 5, 20, 5, 104, 6, 87, 6, 73, 6, 27, 6, 196, 9, 197, 9, 205, 9, 180, 9, 181, 9, 73, 10, 56, 10, 57, 10, 59, 10, 179, 11, 180, 11, 181, 11, 182, 11, 179, 12, 180, 12, 162, 12, 163, 12, 138, 12, 139, 12, 122, 12, 123, 12, 88, 12, 73, 12, 52, 12, 53, 12, 36, 12, 37, 12, 38, 12, 39, 12, 
			.byte 200, 2, 
			.byte 125, 0, 94, 0, 134, 4, 135, 4, 101, 4, 

_lv0_containers_inst_data_ptrs:
			.byte 3, 5, 7, 
_lv0_containers_inst_data:
			.byte 168, 5, 
			.byte 178, 11, 
