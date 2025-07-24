; fdd bin file metadata
; asm data file: build/debug/level_gfx/lv0_gfx_data.asm
; bin file: build/debug/bin/LV0_GFX.BIN

LV0_GFX_FILE_LEN = 6302
LV0_GFX_LAST_RECORD_LEN = 30

LV0_GFX_FILENAME_PTR:
			.byte "LV0_GFX" ; filename
			.byte " " ; filename white chars
			.byte "BIN" ; extension

lv0_gfx_tiles_ptrs:
			.word _lv0_tile00_relative, _lv0_tile01_relative, _lv0_tile02_relative, _lv0_tile03_relative, _lv0_tile04_relative, _lv0_tile05_relative, _lv0_tile06_relative, _lv0_tile07_relative, _lv0_tile08_relative, _lv0_tile09_relative, _lv0_tile0a_relative, _lv0_tile0b_relative, _lv0_tile0c_relative, _lv0_tile0d_relative, _lv0_tile0e_relative, _lv0_tile0f_relative, _lv0_tile10_relative, _lv0_tile11_relative, _lv0_tile12_relative, _lv0_tile13_relative, _lv0_tile14_relative, _lv0_tile15_relative, _lv0_tile16_relative, _lv0_tile17_relative, _lv0_tile18_relative, _lv0_tile19_relative, _lv0_tile1a_relative, _lv0_tile1b_relative, _lv0_tile1c_relative, _lv0_tile1d_relative, _lv0_tile1e_relative, _lv0_tile1f_relative, _lv0_tile20_relative, _lv0_tile21_relative, _lv0_tile22_relative, _lv0_tile23_relative, _lv0_tile24_relative, _lv0_tile25_relative, _lv0_tile26_relative, _lv0_tile27_relative, _lv0_tile28_relative, _lv0_tile29_relative, _lv0_tile2a_relative, _lv0_tile2b_relative, _lv0_tile2c_relative, _lv0_tile2d_relative, _lv0_tile2e_relative, _lv0_tile2f_relative, _lv0_tile30_relative, _lv0_tile31_relative, _lv0_tile32_relative, 
			.word EOD

lv0_gfx_init_tbl:
			.byte TEMP_BYTE ; RAM_DISK_S_LV0_DATA ; defined in loads.asm and inited by _gfx_init
			.byte TEMP_BYTE ; RAM_DISK_M_LV0_DATA ; defined in loads.asm and inited by _gfx_init
			.word lv0_gfx_tiles_ptrs
@data_end:
LV0_GFX_INIT_TBL_LEN = @data_end - lv0_gfx_init_tbl

; in:
; bc - LV0_DATA_ADDR
; l - RAM_DISK_S
; h - RAM_DISK_M
; ex. hl = RAM_DISK_M_LV0_GFX<<8 | RAM_DISK_S_LV0_GFX
lv0_gfx_init:
			shld lv0_gfx_init_tbl

			push b

			lxi h, lv0_gfx_tiles_ptrs
			call add_offset_to_labels_eod

			pop d
			; d = LV0_DATA_ADDR

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
_lv0_tile07_relative = 0x0390
_lv0_tile08_relative = 0x0414
_lv0_tile09_relative = 0x0498
_lv0_tile0a_relative = 0x051c
_lv0_tile0b_relative = 0x05a0
_lv0_tile0c_relative = 0x0624
_lv0_tile0d_relative = 0x06a8
_lv0_tile0e_relative = 0x070c
_lv0_tile0f_relative = 0x0790
_lv0_tile10_relative = 0x0814
_lv0_tile11_relative = 0x0898
_lv0_tile12_relative = 0x091c
_lv0_tile13_relative = 0x09a0
_lv0_tile14_relative = 0x0a24
_lv0_tile15_relative = 0x0aa8
_lv0_tile16_relative = 0x0b2c
_lv0_tile17_relative = 0x0b30
_lv0_tile18_relative = 0x0bb4
_lv0_tile19_relative = 0x0c38
_lv0_tile1a_relative = 0x0cbc
_lv0_tile1b_relative = 0x0d00
_lv0_tile1c_relative = 0x0d84
_lv0_tile1d_relative = 0x0e08
_lv0_tile1e_relative = 0x0e6c
_lv0_tile1f_relative = 0x0ef0
_lv0_tile20_relative = 0x0f54
_lv0_tile21_relative = 0x0fd8
_lv0_tile22_relative = 0x105c
_lv0_tile23_relative = 0x10e0
_lv0_tile24_relative = 0x1164
_lv0_tile25_relative = 0x11e8
_lv0_tile26_relative = 0x120c
_lv0_tile27_relative = 0x1290
_lv0_tile28_relative = 0x1314
_lv0_tile29_relative = 0x1398
_lv0_tile2a_relative = 0x141c
_lv0_tile2b_relative = 0x14a0
_lv0_tile2c_relative = 0x1524
_lv0_tile2d_relative = 0x15a8
_lv0_tile2e_relative = 0x162c
_lv0_tile2f_relative = 0x16b0
_lv0_tile30_relative = 0x1714
_lv0_tile31_relative = 0x1798
_lv0_tile32_relative = 0x181c

