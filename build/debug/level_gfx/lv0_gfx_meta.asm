; fdd bin file metadata
; asm data file: build/debug/level_gfx/lv0_gfx_data.asm
; bin file: build/debug/bin/LV0_GFX.BIN

LV0_GFX_FILE_LEN = 5542
LV0_GFX_LAST_RECORD_LEN = 38

LV0_GFX_FILENAME_PTR:
			.byte "LV0_GFX" ; filename
			.byte " " ; filename white chars
			.byte "BIN" ; extension

_lv0_gfx_tiles_ptrs:
			.word _lv0_tile0, _lv0_tile1, _lv0_tile2, _lv0_tile3, _lv0_tile4, _lv0_tile5, _lv0_tile6, _lv0_tile7, _lv0_tile8, _lv0_tile9, _lv0_tile10, _lv0_tile11, _lv0_tile12, _lv0_tile13, _lv0_tile14, _lv0_tile15, _lv0_tile16, _lv0_tile17, _lv0_tile18, _lv0_tile19, _lv0_tile20, _lv0_tile21, _lv0_tile22, _lv0_tile23, _lv0_tile24, _lv0_tile25, _lv0_tile26, _lv0_tile27, _lv0_tile28, _lv0_tile29, _lv0_tile30, _lv0_tile31, _lv0_tile32, _lv0_tile33, _lv0_tile34, _lv0_tile35, _lv0_tile36, _lv0_tile37, _lv0_tile38, _lv0_tile39, _lv0_tile40, _lv0_tile41, _lv0_tile42, _lv0_tile43, _lv0_tile44, 
			.word EOD

lv0_gfx_init_tbl:
			.byte RAM_DISK_S_LV0_GFX
			.byte RAM_DISK_M_LV0_GFX
			.word _lv0_gfx_tiles_ptrs
lv0_palette_ptr:
			.word _lv0_palette
@data_end:
LV0_GFX_INIT_TBL_LEN = @data_end - lv0_gfx_init_tbl

; in:
lv0_gfx_load:
			lxi b, LV0_GFX_ADDR
			lxi h, _lv0_gfx_tiles_ptrs
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

_lv0_palette = 0x0002
_lv0_tile0 = 0x0014
_lv0_tile1 = 0x0098
_lv0_tile2 = 0x011c
_lv0_tile3 = 0x01a0
_lv0_tile4 = 0x0224
_lv0_tile5 = 0x02a8
_lv0_tile6 = 0x032c
_lv0_tile7 = 0x03b0
_lv0_tile8 = 0x0434
_lv0_tile9 = 0x04b8
_lv0_tile10 = 0x053c
_lv0_tile11 = 0x05a0
_lv0_tile12 = 0x0624
_lv0_tile13 = 0x06a8
_lv0_tile14 = 0x072c
_lv0_tile15 = 0x07b0
_lv0_tile16 = 0x0834
_lv0_tile17 = 0x0898
_lv0_tile18 = 0x091c
_lv0_tile19 = 0x09a0
_lv0_tile20 = 0x0a24
_lv0_tile21 = 0x0aa8
_lv0_tile22 = 0x0b2c
_lv0_tile23 = 0x0bb0
_lv0_tile24 = 0x0c34
_lv0_tile25 = 0x0cb8
_lv0_tile26 = 0x0cbc
_lv0_tile27 = 0x0d40
_lv0_tile28 = 0x0dc4
_lv0_tile29 = 0x0e48
_lv0_tile30 = 0x0e8c
_lv0_tile31 = 0x0ef0
_lv0_tile32 = 0x0f74
_lv0_tile33 = 0x0ff8
_lv0_tile34 = 0x105c
_lv0_tile35 = 0x10e0
_lv0_tile36 = 0x1104
_lv0_tile37 = 0x1188
_lv0_tile38 = 0x120c
_lv0_tile39 = 0x1290
_lv0_tile40 = 0x1314
_lv0_tile41 = 0x1398
_lv0_tile42 = 0x141c
_lv0_tile43 = 0x14a0
_lv0_tile44 = 0x1524

