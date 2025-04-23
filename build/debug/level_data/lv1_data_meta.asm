; fdd bin file metadata
; asm data file: build/debug/level_data/lv1_data_data.asm
; bin file: build/debug/bin/LV1_DATA.BIN

LV1_DATA_FILE_LEN = 10102
LV1_DATA_LAST_RECORD_LEN = 118

LV1_DATA_FILENAME_PTR:
			.byte "LV1_DATA" ; filename
			.byte "BIN" ; extension

lv1_data_rooms_ptrs:
			.word _lv1_room01, _lv1_room02, _lv1_room03, _lv1_room04, _lv1_room05, _lv1_room06, _lv1_room07, _lv1_room08, _lv1_room09, _lv1_room10, _lv1_room11, _lv1_room12, _lv1_room13, _lv1_room14, _lv1_room15, _lv1_room16, _lv1_room17, _lv1_room18, _lv1_room19, _lv1_room20, _lv1_room21, _lv1_room22, _lv1_room23, _lv1_room24, _lv1_room25, _lv1_room26, _lv1_room27, _lv1_room28, _lv1_room29, _lv1_room30, _lv1_room31, _lv1_room32, _lv1_room33, _lv1_room34, _lv1_room35, _lv1_room36, _lv1_room37, _lv1_room38, _lv1_room39, 
			.word EOD

lv1_data_init_tbl:
			.byte RAM_DISK_S_LV1_DATA
			.byte RAM_DISK_M_LV1_DATA
			.word lv1_data_rooms_ptrs
lv1_resources_inst_data_ptrs:
			.word _lv1_resources_inst_data_ptrs
			.word _lv1_containers_inst_data_ptrs
			.byte 160			; hero start pos_y
			.byte 48			; hero start pos_x
@data_end:
LV1_DATA_INIT_TBL_LEN = @data_end - lv1_data_init_tbl

LV1_RECOURCES_DATA_LEN = 209
LV1_CONTAINERS_DATA_LEN = 29

; in:
lv1_data_init:
			lxi b, LV1_DATA_ADDR
			lxi h, lv1_data_rooms_ptrs
			call update_labels_eod

			lxi d, LV1_DATA_ADDR
			lxi h, lv1_resources_inst_data_ptrs
			mvi c, 2 ; _lv0_resources_inst_data_ptrs and _lv0_containers_inst_data_ptrs
			call update_labels_len

			; copy a level init data
			lxi h, lv1_data_init_tbl
			lxi d, lv_data_init_tbl
			lxi b, LV1_DATA_INIT_TBL_LEN
			call mem_copy_len
			ret 

_lv1_resources_inst_data_ptrs = 0x0002
_lv1_containers_inst_data_ptrs = 0x00d5
_lv1_room01 = 0x00f4
_lv1_room02 = 0x01db
_lv1_room03 = 0x02e9
_lv1_room04 = 0x03f0
_lv1_room05 = 0x04f7
_lv1_room06 = 0x05de
_lv1_room07 = 0x06ec
_lv1_room08 = 0x07f3
_lv1_room09 = 0x08da
_lv1_room10 = 0x09e8
_lv1_room11 = 0x0aef
_lv1_room12 = 0x0bd6
_lv1_room13 = 0x0ce4
_lv1_room14 = 0x0deb
_lv1_room15 = 0x0ed2
_lv1_room16 = 0x0fe0
_lv1_room17 = 0x10e7
_lv1_room18 = 0x11ce
_lv1_room19 = 0x12dc
_lv1_room20 = 0x13e3
_lv1_room21 = 0x14c5
_lv1_room22 = 0x15d1
_lv1_room23 = 0x16d4
_lv1_room24 = 0x17b6
_lv1_room25 = 0x18c2
_lv1_room26 = 0x19c5
_lv1_room27 = 0x1aa7
_lv1_room28 = 0x1bb3
_lv1_room29 = 0x1cb6
_lv1_room30 = 0x1db9
_lv1_room31 = 0x1e9b
_lv1_room32 = 0x1f7d
_lv1_room33 = 0x2089
_lv1_room34 = 0x2195
_lv1_room35 = 0x2298
_lv1_room36 = 0x239b
_lv1_room37 = 0x247d
_lv1_room38 = 0x255f
_lv1_room39 = 0x266b

