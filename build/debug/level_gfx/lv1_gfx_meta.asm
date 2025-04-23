; fdd bin file metadata
; asm data file: build/debug/level_gfx/lv1_gfx_data.asm
; bin file: build/debug/bin/LV1_GFX.BIN

LV1_GFX_FILE_LEN = 6470
LV1_GFX_LAST_RECORD_LEN = 70

LV1_GFX_FILENAME_PTR:
			.byte "LV1_GFX" ; filename
			.byte " " ; filename white chars
			.byte "BIN" ; extension

lv1_gfx_tiles_ptrs:
			.word _lv1_tile00_relative, _lv1_tile01_relative, _lv1_tile02_relative, _lv1_tile03_relative, _lv1_tile04_relative, _lv1_tile05_relative, _lv1_tile06_relative, _lv1_tile07_relative, _lv1_tile08_relative, _lv1_tile09_relative, _lv1_tile0a_relative, _lv1_tile0b_relative, _lv1_tile0c_relative, _lv1_tile0d_relative, _lv1_tile0e_relative, _lv1_tile0f_relative, _lv1_tile10_relative, _lv1_tile11_relative, _lv1_tile12_relative, _lv1_tile13_relative, _lv1_tile14_relative, _lv1_tile15_relative, _lv1_tile16_relative, _lv1_tile17_relative, _lv1_tile18_relative, _lv1_tile19_relative, _lv1_tile1a_relative, _lv1_tile1b_relative, _lv1_tile1c_relative, _lv1_tile1d_relative, _lv1_tile1e_relative, _lv1_tile1f_relative, _lv1_tile20_relative, _lv1_tile21_relative, _lv1_tile22_relative, _lv1_tile23_relative, _lv1_tile24_relative, _lv1_tile25_relative, _lv1_tile26_relative, _lv1_tile27_relative, _lv1_tile28_relative, _lv1_tile29_relative, _lv1_tile2a_relative, _lv1_tile2b_relative, _lv1_tile2c_relative, _lv1_tile2d_relative, _lv1_tile2e_relative, _lv1_tile2f_relative, _lv1_tile30_relative, _lv1_tile31_relative, _lv1_tile32_relative, _lv1_tile33_relative, _lv1_tile34_relative, _lv1_tile35_relative, _lv1_tile36_relative, _lv1_tile37_relative, _lv1_tile38_relative, _lv1_tile39_relative, _lv1_tile3a_relative, _lv1_tile3b_relative, _lv1_tile3c_relative, _lv1_tile3d_relative, _lv1_tile3e_relative, _lv1_tile3f_relative, _lv1_tile40_relative, _lv1_tile41_relative, _lv1_tile42_relative, _lv1_tile43_relative, _lv1_tile44_relative, _lv1_tile45_relative, _lv1_tile46_relative, _lv1_tile47_relative, _lv1_tile48_relative, _lv1_tile49_relative, _lv1_tile4a_relative, _lv1_tile4b_relative, _lv1_tile4c_relative, 
			.word EOD

lv1_gfx_init_tbl:
			.byte RAM_DISK_S_LV1_GFX
			.byte RAM_DISK_M_LV1_GFX
			.word lv1_gfx_tiles_ptrs
lv1_palette_ptr:
			.word _lv1_palette_relative
@data_end:
LV1_GFX_INIT_TBL_LEN = @data_end - lv1_gfx_init_tbl

; in:
lv1_gfx_init:
			lxi b, LV1_GFX_ADDR
			lxi h, lv1_gfx_tiles_ptrs
			call update_labels_eod

			lxi d, LV1_GFX_ADDR
			lxi h, lv1_palette_ptr
			mvi c, 1
			call update_labels_len

			; copy a level init data
			lxi h, lv1_gfx_init_tbl
			lxi d, lv_gfx_init_tbl
			lxi b, LV1_GFX_INIT_TBL_LEN
			call mem_copy_len
			ret

_lv1_palette_relative = 0x0002
_lv1_tile00_relative = 0x0014
_lv1_tile01_relative = 0x0038
_lv1_tile02_relative = 0x009c
_lv1_tile03_relative = 0x0100
_lv1_tile04_relative = 0x0164
_lv1_tile05_relative = 0x01c8
_lv1_tile06_relative = 0x022c
_lv1_tile07_relative = 0x0290
_lv1_tile08_relative = 0x02f4
_lv1_tile09_relative = 0x0358
_lv1_tile0a_relative = 0x03bc
_lv1_tile0b_relative = 0x0420
_lv1_tile0c_relative = 0x04a4
_lv1_tile0d_relative = 0x0508
_lv1_tile0e_relative = 0x058c
_lv1_tile0f_relative = 0x05d0
_lv1_tile10_relative = 0x0634
_lv1_tile11_relative = 0x0698
_lv1_tile12_relative = 0x06fc
_lv1_tile13_relative = 0x0720
_lv1_tile14_relative = 0x0724
_lv1_tile15_relative = 0x0748
_lv1_tile16_relative = 0x078c
_lv1_tile17_relative = 0x07d0
_lv1_tile18_relative = 0x0814
_lv1_tile19_relative = 0x0858
_lv1_tile1a_relative = 0x087c
_lv1_tile1b_relative = 0x08a0
_lv1_tile1c_relative = 0x08c4
_lv1_tile1d_relative = 0x08e8
_lv1_tile1e_relative = 0x094c
_lv1_tile1f_relative = 0x09b0
_lv1_tile20_relative = 0x09d4
_lv1_tile21_relative = 0x0a38
_lv1_tile22_relative = 0x0a3c
_lv1_tile23_relative = 0x0aa0
_lv1_tile24_relative = 0x0ac4
_lv1_tile25_relative = 0x0b28
_lv1_tile26_relative = 0x0b8c
_lv1_tile27_relative = 0x0bf0
_lv1_tile28_relative = 0x0c74
_lv1_tile29_relative = 0x0cf8
_lv1_tile2a_relative = 0x0d1c
_lv1_tile2b_relative = 0x0d60
_lv1_tile2c_relative = 0x0d84
_lv1_tile2d_relative = 0x0d88
_lv1_tile2e_relative = 0x0dec
_lv1_tile2f_relative = 0x0e10
_lv1_tile30_relative = 0x0e94
_lv1_tile31_relative = 0x0e98
_lv1_tile32_relative = 0x0e9c
_lv1_tile33_relative = 0x0f00
_lv1_tile34_relative = 0x0f44
_lv1_tile35_relative = 0x0f68
_lv1_tile36_relative = 0x0fcc
_lv1_tile37_relative = 0x1030
_lv1_tile38_relative = 0x1054
_lv1_tile39_relative = 0x10b8
_lv1_tile3a_relative = 0x111c
_lv1_tile3b_relative = 0x1180
_lv1_tile3c_relative = 0x11e4
_lv1_tile3d_relative = 0x1248
_lv1_tile3e_relative = 0x12ac
_lv1_tile3f_relative = 0x1310
_lv1_tile40_relative = 0x1374
_lv1_tile41_relative = 0x13d8
_lv1_tile42_relative = 0x145c
_lv1_tile43_relative = 0x14e0
_lv1_tile44_relative = 0x1544
_lv1_tile45_relative = 0x15a8
_lv1_tile46_relative = 0x162c
_lv1_tile47_relative = 0x16b0
_lv1_tile48_relative = 0x1714
_lv1_tile49_relative = 0x1778
_lv1_tile4a_relative = 0x17dc
_lv1_tile4b_relative = 0x1860
_lv1_tile4c_relative = 0x18e4

