; fdd bin file metadata
; asm data file: build/debug/level_gfx/lv0_gfx_data.asm
; bin file: build/debug/bin/LV0_GFX.BIN

LV0_GFX_FILE_LEN = 5524
LV0_GFX_LAST_RECORD_LEN = 20

LV0_GFX_FILENAME_PTR:
			.byte "LV0_GFX" ; filename
			.byte " " ; filename white chars
			.byte "BIN" ; extension

; assets\levels/tiled/art/lv0.png
_lv0_palette:
			.byte %01100101, %01010010, %01011100, %01101011, 
			.byte %10100100, %01101100, %10110111, %01101111, 
			.byte %10011011, %11111101, %10101111, %01011111, 
			.byte %11111111, %11100010, %01100010, %00011111, 

_lv0_tile0 = 2
_lv0_tile1 = 134
_lv0_tile2 = 266
_lv0_tile3 = 398
_lv0_tile4 = 530
_lv0_tile5 = 662
_lv0_tile6 = 794
_lv0_tile7 = 926
_lv0_tile8 = 1058
_lv0_tile9 = 1190
_lv0_tile10 = 1322
_lv0_tile11 = 1422
_lv0_tile12 = 1554
_lv0_tile13 = 1686
_lv0_tile14 = 1818
_lv0_tile15 = 1950
_lv0_tile16 = 2082
_lv0_tile17 = 2182
_lv0_tile18 = 2314
_lv0_tile19 = 2446
_lv0_tile20 = 2578
_lv0_tile21 = 2710
_lv0_tile22 = 2842
_lv0_tile23 = 2974
_lv0_tile24 = 3106
_lv0_tile25 = 3238
_lv0_tile26 = 3370
_lv0_tile27 = 3502
_lv0_tile28 = 3634
_lv0_tile29 = 3702
_lv0_tile30 = 3802
_lv0_tile31 = 3934
_lv0_tile32 = 4066
_lv0_tile33 = 4166
_lv0_tile34 = 4298
_lv0_tile35 = 4334
_lv0_tile36 = 4466
_lv0_tile37 = 4470
_lv0_tile38 = 4602
_lv0_tile39 = 4734
_lv0_tile40 = 4866
_lv0_tile41 = 4998
_lv0_tile42 = 5130
_lv0_tile43 = 5262
_lv0_tile44 = 5394

_lv0_tiles_ptrs:
			.word _lv0_tile0, _lv0_tile1, _lv0_tile2, _lv0_tile3, _lv0_tile4, _lv0_tile5, _lv0_tile6, _lv0_tile7, _lv0_tile8, _lv0_tile9, _lv0_tile10, _lv0_tile11, _lv0_tile12, _lv0_tile13, _lv0_tile14, _lv0_tile15, _lv0_tile16, _lv0_tile17, _lv0_tile18, _lv0_tile19, _lv0_tile20, _lv0_tile21, _lv0_tile22, _lv0_tile23, _lv0_tile24, _lv0_tile25, _lv0_tile26, _lv0_tile27, _lv0_tile28, _lv0_tile29, _lv0_tile30, _lv0_tile31, _lv0_tile32, _lv0_tile33, _lv0_tile34, _lv0_tile35, _lv0_tile36, _lv0_tile37, _lv0_tile38, _lv0_tile39, _lv0_tile40, _lv0_tile41, _lv0_tile42, _lv0_tile43, _lv0_tile44, 

			.word EOD
