; fdd bin file metadata
; asm data file: build/debug/level_gfx/lv0_gfx_data.asm
; bin file: build/debug/bin/LV0_GFX.BIN

LV0_GFX_FILE_LEN = 6170
LV0_GFX_LAST_RECORD_LEN = 26

LV0_GFX_FILENAME_PTR:
			.byte "LV0_GFX" ; filename
			.byte " " ; filename white chars
			.byte "BIN" ; extension

lv0_gfx_tiles_ptrs:
			.word _lv0_tile00_relative, _lv0_tile01_relative, _lv0_tile02_relative, _lv0_tile03_relative, _lv0_tile04_relative, _lv0_tile05_relative, _lv0_tile06_relative, _lv0_tile07_relative, _lv0_tile08_relative, _lv0_tile09_relative, _lv0_tile0a_relative, _lv0_tile0b_relative, _lv0_tile0c_relative, _lv0_tile0d_relative, _lv0_tile0e_relative, _lv0_tile0f_relative, _lv0_tile10_relative, _lv0_tile11_relative, _lv0_tile12_relative, _lv0_tile13_relative, _lv0_tile14_relative, _lv0_tile15_relative, _lv0_tile16_relative, _lv0_tile17_relative, _lv0_tile18_relative, _lv0_tile19_relative, _lv0_tile1a_relative, _lv0_tile1b_relative, _lv0_tile1c_relative, _lv0_tile1d_relative, _lv0_tile1e_relative, _lv0_tile1f_relative, _lv0_tile20_relative, _lv0_tile21_relative, _lv0_tile22_relative, _lv0_tile23_relative, _lv0_tile24_relative, _lv0_tile25_relative, _lv0_tile26_relative, _lv0_tile27_relative, _lv0_tile28_relative, _lv0_tile29_relative, _lv0_tile2a_relative, _lv0_tile2b_relative, _lv0_tile2c_relative, _lv0_tile2d_relative, _lv0_tile2e_relative, _lv0_tile2f_relative, _lv0_tile30_relative, _lv0_tile31_relative, 
			.word EOD

lv0_gfx_init_tbl:
			.byte RAM_DISK_S_LV0_GFX
			.byte RAM_DISK_M_LV0_GFX
			.word lv0_gfx_tiles_ptrs
lv0_palette_ptr:
			.word _lv0_palette_relative
@data_end:
LV0_GFX_INIT_TBL_LEN = @data_end - lv0_gfx_init_tbl

; in:
lv0_gfx_init:
			lxi b, LV0_GFX_ADDR
			lxi h, lv0_gfx_tiles_ptrs
			call update_labels_eod

			lxi d, LV0_GFX_ADDR
			lxi h, lv0_palette_ptr
			mvi c, 1
			call update_labels_len

			; copy a level init data
			lxi h, lv0_gfx_init_tbl
			lxi d, lv_gfx_init_tbl
			lxi b, LV0_GFX_INIT_TBL_LEN
			call mem_copy_len
			ret

_lv0_palette_relative = 0x0002
_lv0_tile00_relative = 0x0014
_lv0_tile01_relative = 0x0098
_lv0_tile02_relative = 0x011c
_lv0_tile03_relative = 0x01a0
_lv0_tile04_relative = 0x0224
_lv0_tile05_relative = 0x0288
_lv0_tile06_relative = 0x030c
_lv0_tile07_relative = 0x0310
_lv0_tile08_relative = 0x0394
_lv0_tile09_relative = 0x0418
_lv0_tile0a_relative = 0x047c
_lv0_tile0b_relative = 0x0500
_lv0_tile0c_relative = 0x0584
_lv0_tile0d_relative = 0x0608
_lv0_tile0e_relative = 0x068c
_lv0_tile0f_relative = 0x0710
_lv0_tile10_relative = 0x0794
_lv0_tile11_relative = 0x07f8
_lv0_tile12_relative = 0x087c
_lv0_tile13_relative = 0x0900
_lv0_tile14_relative = 0x0984
_lv0_tile15_relative = 0x0a08
_lv0_tile16_relative = 0x0a8c
_lv0_tile17_relative = 0x0b10
_lv0_tile18_relative = 0x0b94
_lv0_tile19_relative = 0x0c18
_lv0_tile1a_relative = 0x0c9c
_lv0_tile1b_relative = 0x0d20
_lv0_tile1c_relative = 0x0d64
_lv0_tile1d_relative = 0x0de8
_lv0_tile1e_relative = 0x0e6c
_lv0_tile1f_relative = 0x0ed0
_lv0_tile20_relative = 0x0f54
_lv0_tile21_relative = 0x0f78
_lv0_tile22_relative = 0x0ffc
_lv0_tile23_relative = 0x1080
_lv0_tile24_relative = 0x1104
_lv0_tile25_relative = 0x1188
_lv0_tile26_relative = 0x120c
_lv0_tile27_relative = 0x1290
_lv0_tile28_relative = 0x1314
_lv0_tile29_relative = 0x1398
_lv0_tile2a_relative = 0x141c
_lv0_tile2b_relative = 0x14a0
_lv0_tile2c_relative = 0x1524
_lv0_tile2d_relative = 0x15a8
_lv0_tile2e_relative = 0x162c
_lv0_tile2f_relative = 0x1690
_lv0_tile30_relative = 0x1714
_lv0_tile31_relative = 0x1798

