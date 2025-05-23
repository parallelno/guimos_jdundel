; fdd bin file metadata
; asm data file: build/debug/level_data/lv0_data_data.asm
; bin file: build/debug/bin/LV0_DATA.BIN

LV0_DATA_FILE_LEN = 3874
LV0_DATA_LAST_RECORD_LEN = 34

LV0_DATA_FILENAME_PTR:
			.byte "LV0_DATA" ; filename
			.byte "BIN" ; extension

lv0_data_rooms_ptrs:
			.word _lv0_00_home, _lv0_01_farm_fence, _lv0_02_road_to_friends_home, _lv0_03_friends_home, _lv0_04_friends_home_backyard, _lv0_05_friends_secret_place, _lv0_06_crossroad, _lv0_07_farm_entrance, _lv0_08_farm_storage, _lv0_09_loop, _lv0_10_dungeon_entrance, _lv0_11_abandoned_home, _lv0_12_lost_coins, 
			.word EOD

lv0_data_init_tbl:
			.byte RAM_DISK_S_LV0_DATA
			.byte RAM_DISK_M_LV0_DATA
			.word lv0_data_rooms_ptrs
lv0_resources_inst_data_ptrs:
			.word _lv0_resources_inst_data_ptrs
			.word _lv0_containers_inst_data_ptrs
			.byte 140			; hero start pos_y
			.byte 120			; hero start pos_x
@data_end:
LV0_DATA_INIT_TBL_LEN = @data_end - lv0_data_init_tbl

LV0_RECOURCES_DATA_LEN = 117
LV0_CONTAINERS_DATA_LEN = 7

; in:
lv0_data_init:
			lxi b, LV0_DATA_ADDR
			lxi h, lv0_data_rooms_ptrs
			call update_labels_eod

			lxi d, LV0_DATA_ADDR
			lxi h, lv0_resources_inst_data_ptrs
			mvi c, 2 ; _lv0_resources_inst_data_ptrs and _lv0_containers_inst_data_ptrs
			call update_labels_len

			; copy a level init data
			lxi h, lv0_data_init_tbl
			lxi d, lv_data_init_tbl
			lxi b, LV0_DATA_INIT_TBL_LEN
			call mem_copy_len
			ret 

_lv0_resources_inst_data_ptrs = 0x0002
_lv0_containers_inst_data_ptrs = 0x0079
_lv0_00_home = 0x0082
_lv0_01_farm_fence = 0x01a3
_lv0_02_road_to_friends_home = 0x02b8
_lv0_03_friends_home = 0x03df
_lv0_04_friends_home_backyard = 0x04ec
_lv0_05_friends_secret_place = 0x0600
_lv0_06_crossroad = 0x0745
_lv0_07_farm_entrance = 0x0865
_lv0_08_farm_storage = 0x097a
_lv0_09_loop = 0x0a8b
_lv0_10_dungeon_entrance = 0x0bb7
_lv0_11_abandoned_home = 0x0cdf
_lv0_12_lost_coins = 0x0df7

