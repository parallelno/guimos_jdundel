; fdd bin file metadata
; asm data file: build/debug/level_data/lv0_data_data.asm
; bin file: build/debug/bin/LV0_DATA.BIN

LV0_DATA_FILE_LEN = 3770
LV0_DATA_LAST_RECORD_LEN = 58

LV0_DATA_FILENAME_PTR:
			.byte "LV0_DATA" ; filename
			.byte "BIN" ; extension

lv0_data_rooms_ptrs:
			.word _lv0_home, _lv0_farm_fence, _lv0_road_to_friends_home, _lv0_friends_home, _lv0_friends_home_backyard, _lv0_friends_secret_place, _lv0_crossroad, _lv0_farm_entrance, _lv0_farm_storage, _lv0_loop, _lv0_dungeon_entrance, _lv0_abandoned_home, _lv0_lost_coins, 
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

LV0_RECOURCES_DATA_LEN = 121
LV0_CONTAINERS_DATA_LEN = 7

; in:
lv0_data_load:
			lxi b, LV0_DATA_ADDR
			lxi h, lv0_data_rooms_ptrs
			call update_labels_eod

			lxi d, LV0_DATA_ADDR
			lxi h, lv0_resources_inst_data_ptrs
			mvi c, 2 ; _lv0_resources_inst_data_ptrs abd _lv0_containers_inst_data_ptrs
			call update_labels_len

			; copy a level init data
			lxi h, lv0_data_init_tbl
			lxi d, lv_data_init_tbl
			lxi b, LV0_DATA_INIT_TBL_LEN
			call mem_copy_len
			ret 

_lv0_resources_inst_data_ptrs = 0x0002
_lv0_containers_inst_data_ptrs = 0x007d
_lv0_home = 0x0086
_lv0_farm_fence = 0x019d
_lv0_road_to_friends_home = 0x02a7
_lv0_friends_home = 0x03c5
_lv0_friends_home_backyard = 0x04cd
_lv0_friends_secret_place = 0x05d8
_lv0_crossroad = 0x0714
_lv0_farm_entrance = 0x082a
_lv0_farm_storage = 0x0939
_lv0_loop = 0x0a43
_lv0_dungeon_entrance = 0x0b66
_lv0_abandoned_home = 0x0c86
_lv0_lost_coins = 0x0d97

