; fdd bin file metadata
; asm data file: build/debug/level_gfx/lv1_gfx_data.asm
; bin file: build/debug/bin/LV1_GFX.BIN

LV1_GFX_FILE_LEN = 6466
LV1_GFX_LAST_RECORD_LEN = 66

LV1_GFX_FILENAME_PTR:
			.byte "LV1_GFX" ; filename
			.byte " " ; filename white chars
			.byte "BIN" ; extension

lv1_gfx_tiles_ptrs:
			.word _lv1_tile00_relative, _lv1_tile01_relative, _lv1_tile02_relative, _lv1_tile03_relative, _lv1_tile04_relative, _lv1_tile05_relative, _lv1_tile06_relative, _lv1_tile07_relative, _lv1_tile08_relative, _lv1_tile09_relative, _lv1_tile0a_relative, _lv1_tile0b_relative, _lv1_tile0c_relative, _lv1_tile0d_relative, _lv1_tile0e_relative, _lv1_tile0f_relative, _lv1_tile10_relative, _lv1_tile11_relative, _lv1_tile12_relative, _lv1_tile13_relative, _lv1_tile14_relative, _lv1_tile15_relative, _lv1_tile16_relative, _lv1_tile17_relative, _lv1_tile18_relative, _lv1_tile19_relative, _lv1_tile1a_relative, _lv1_tile1b_relative, _lv1_tile1c_relative, _lv1_tile1d_relative, _lv1_tile1e_relative, _lv1_tile1f_relative, _lv1_tile20_relative, _lv1_tile21_relative, _lv1_tile22_relative, _lv1_tile23_relative, _lv1_tile24_relative, _lv1_tile25_relative, _lv1_tile26_relative, _lv1_tile27_relative, _lv1_tile28_relative, _lv1_tile29_relative, _lv1_tile2a_relative, _lv1_tile2b_relative, _lv1_tile2c_relative, _lv1_tile2d_relative, _lv1_tile2e_relative, _lv1_tile2f_relative, _lv1_tile30_relative, _lv1_tile31_relative, _lv1_tile32_relative, _lv1_tile33_relative, _lv1_tile34_relative, _lv1_tile35_relative, _lv1_tile36_relative, _lv1_tile37_relative, _lv1_tile38_relative, _lv1_tile39_relative, _lv1_tile3a_relative, _lv1_tile3b_relative, _lv1_tile3c_relative, _lv1_tile3d_relative, _lv1_tile3e_relative, _lv1_tile3f_relative, _lv1_tile40_relative, _lv1_tile41_relative, _lv1_tile42_relative, _lv1_tile43_relative, _lv1_tile44_relative, _lv1_tile45_relative, _lv1_tile46_relative, _lv1_tile47_relative, _lv1_tile48_relative, _lv1_tile49_relative, _lv1_tile4a_relative, _lv1_tile4b_relative, 
			.word EOD

lv1_gfx_init_tbl:
			.byte TEMP_BYTE ; RAM_DISK_S_LV1_DATA ; defined in loads.asm and inited by _gfx_init
			.byte TEMP_BYTE ; RAM_DISK_M_LV1_DATA ; defined in loads.asm and inited by _gfx_init
			.word lv1_gfx_tiles_ptrs
@data_end:
LV1_GFX_INIT_TBL_LEN = @data_end - lv1_gfx_init_tbl

; in:
; bc - LV1_DATA_ADDR
; l - RAM_DISK_S
; h - RAM_DISK_M
; ex. hl = RAM_DISK_M_LV0_GFX<<8 | RAM_DISK_S_LV0_GFX
lv1_gfx_init:
			shld lv1_gfx_init_tbl

			push b

			lxi h, lv1_gfx_tiles_ptrs
			call add_offset_to_labels_eod

			pop d
			; d = LV1_DATA_ADDR

			; copy a level init data
			lxi h, lv1_gfx_init_tbl
			lxi d, lv_gfx_init_tbl
			lxi b, LV1_GFX_INIT_TBL_LEN
			call mem_copy_len
			ret

_lv1_palette_relative = 0x0002
_lv1_tile00_relative = 0x0014
_lv1_tile01_relative = 0x0038
_lv1_tile02_relative = 0x005c
_lv1_tile03_relative = 0x00c0
_lv1_tile04_relative = 0x0124
_lv1_tile05_relative = 0x0148
_lv1_tile06_relative = 0x01ac
_lv1_tile07_relative = 0x0210
_lv1_tile08_relative = 0x0274
_lv1_tile09_relative = 0x02d8
_lv1_tile0a_relative = 0x033c
_lv1_tile0b_relative = 0x03a0
_lv1_tile0c_relative = 0x0404
_lv1_tile0d_relative = 0x0468
_lv1_tile0e_relative = 0x04cc
_lv1_tile0f_relative = 0x0530
_lv1_tile10_relative = 0x0594
_lv1_tile11_relative = 0x05f8
_lv1_tile12_relative = 0x067c
_lv1_tile13_relative = 0x0700
_lv1_tile14_relative = 0x0764
_lv1_tile15_relative = 0x07c8
_lv1_tile16_relative = 0x084c
_lv1_tile17_relative = 0x08b0
_lv1_tile18_relative = 0x0914
_lv1_tile19_relative = 0x0978
_lv1_tile1a_relative = 0x09fc
_lv1_tile1b_relative = 0x0a80
_lv1_tile1c_relative = 0x0ae4
_lv1_tile1d_relative = 0x0b48
_lv1_tile1e_relative = 0x0bac
_lv1_tile1f_relative = 0x0bf0
_lv1_tile20_relative = 0x0c34
_lv1_tile21_relative = 0x0c98
_lv1_tile22_relative = 0x0cfc
_lv1_tile23_relative = 0x0d60
_lv1_tile24_relative = 0x0dc4
_lv1_tile25_relative = 0x0e48
_lv1_tile26_relative = 0x0ecc
_lv1_tile27_relative = 0x0f30
_lv1_tile28_relative = 0x0f94
_lv1_tile29_relative = 0x0f98
_lv1_tile2a_relative = 0x0fbc
_lv1_tile2b_relative = 0x1020
_lv1_tile2c_relative = 0x1064
_lv1_tile2d_relative = 0x1088
_lv1_tile2e_relative = 0x10ec
_lv1_tile2f_relative = 0x1150
_lv1_tile30_relative = 0x1174
_lv1_tile31_relative = 0x1198
_lv1_tile32_relative = 0x11bc
_lv1_tile33_relative = 0x11e0
_lv1_tile34_relative = 0x1244
_lv1_tile35_relative = 0x1288
_lv1_tile36_relative = 0x12ec
_lv1_tile37_relative = 0x1370
_lv1_tile38_relative = 0x1374
_lv1_tile39_relative = 0x1398
_lv1_tile3a_relative = 0x13bc
_lv1_tile3b_relative = 0x1420
_lv1_tile3c_relative = 0x1444
_lv1_tile3d_relative = 0x1488
_lv1_tile3e_relative = 0x14ec
_lv1_tile3f_relative = 0x1570
_lv1_tile40_relative = 0x15f4
_lv1_tile41_relative = 0x1658
_lv1_tile42_relative = 0x167c
_lv1_tile43_relative = 0x16e0
_lv1_tile44_relative = 0x1724
_lv1_tile45_relative = 0x1768
_lv1_tile46_relative = 0x17cc
_lv1_tile47_relative = 0x1850
_lv1_tile48_relative = 0x1874
_lv1_tile49_relative = 0x1878
_lv1_tile4a_relative = 0x18dc
_lv1_tile4b_relative = 0x18e0

