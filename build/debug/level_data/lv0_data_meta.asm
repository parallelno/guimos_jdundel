; fdd bin file metadata
; asm data file: build/debug/level_data/lv0_data_data.asm
; bin file: build/debug/bin/LV0_DATA.BIN

LV0_DATA_FILE_LEN = 5920
LV0_DATA_LAST_RECORD_LEN = 32

LV0_DATA_FILENAME_PTR:
			.byte "LV0_DATA" ; filename
			.byte "BIN" ; extension

lv0_data_rooms_ptrs:
			.word _lv0_00_home, _lv0_01_farm_fence, _lv0_02_road_to_friends_home, _lv0_03_friends_home, _lv0_04_friends_home_backyard, _lv0_05_friends_secret_place, _lv0_06_crossroad, _lv0_07_farm_entrance, _lv0_08_farm_storage, _lv0_09_loop, _lv0_10_dungeon_entrance, _lv0_11_abandoned_home, _lv0_12_lost_coins, _lv0_13_forest, _lv0_14_farmer_bob, _lv0_15_backyard, _lv0_16_closed_gate, _lv0_17_dottys_home, _lv0_18_forest, _lv0_19_forest, 
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

LV0_RECOURCES_DATA_LEN = 135
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
_lv0_containers_inst_data_ptrs = 0x008b
_lv0_00_home = 0x0094
_lv0_01_farm_fence = 0x01b6
_lv0_02_road_to_friends_home = 0x02ca
_lv0_03_friends_home = 0x03e9
_lv0_04_friends_home_backyard = 0x04f6
_lv0_05_friends_secret_place = 0x060b
_lv0_06_crossroad = 0x0753
_lv0_07_farm_entrance = 0x087f
_lv0_08_farm_storage = 0x09a3
_lv0_09_loop = 0x0acd
_lv0_10_dungeon_entrance = 0x0bfc
_lv0_11_abandoned_home = 0x0d24
_lv0_12_lost_coins = 0x0e54
_lv0_13_forest = 0x0f80
_lv0_14_farmer_bob = 0x109f
_lv0_15_backyard = 0x11a0
_lv0_16_closed_gate = 0x12ca
_lv0_17_dottys_home = 0x13d3
_lv0_18_forest = 0x14e1
_lv0_19_forest = 0x1606

