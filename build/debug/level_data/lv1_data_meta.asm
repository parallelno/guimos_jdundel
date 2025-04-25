; fdd bin file metadata
; asm data file: build/debug/level_data/lv1_data_data.asm
; bin file: build/debug/bin/LV1_DATA.BIN

LV1_DATA_FILE_LEN = 816
LV1_DATA_LAST_RECORD_LEN = 48

LV1_DATA_FILENAME_PTR:
			.byte "LV1_DATA" ; filename
			.byte "BIN" ; extension

lv1_data_rooms_ptrs:
			.word _lv1_room00, _lv1_room01, _lv1_room02, 
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

LV1_RECOURCES_DATA_LEN = 35
LV1_CONTAINERS_DATA_LEN = 5

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
_lv1_containers_inst_data_ptrs = 0x0027
_lv1_room00 = 0x002e
_lv1_room01 = 0x0136
_lv1_room02 = 0x0249

