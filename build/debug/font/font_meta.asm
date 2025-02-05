; fdd bin file metadata
; asm data file: build/debug/font/font_data.asm
; bin file: build/debug/bin/FONT.BIN

FONT_META_FILE_LEN = 1624
FONT_META_LAST_RECORD_LEN = 88
FONT_META_filename:
			.byte "FONT" ; filename
			.byte "    " ; filename white chars
			.byte "BIN" ; extension

; relative labels. to make it global call __text_ex_rd_init
; font_0 = 2
; font_1 = 26
; font_2 = 50
; font_3 = 74
; font_4 = 98
; font_5 = 122
; font_6 = 146
; font_7 = 170
; font_8 = 194
; font_9 = 218
; font_space = 242
; font_exclamation = 250
; font_d_quote = 276
; font_ampersand = 284
; font_hash = 308
; font_dollar = 316
; font_percent = 324
; font_ampercent = 332
; font_quote = 340
; font_parent_l = 350
; font_parent_r = 372
; font_comma = 394
; font_dash = 404
; font_period = 412
; font_colon = 420
; font_equal = 434
; font_question = 442
; font_A = 468
; font_B = 492
; font_C = 516
; font_D = 540
; font_E = 564
; font_F = 588
; font_G = 612
; font_H = 640
; font_I = 664
; font_J = 688
; font_K = 712
; font_L = 736
; font_M = 760
; font_N = 786
; font_O = 810
; font_P = 834
; font_Q = 858
; font_R = 884
; font_S = 912
; font_T = 936
; font_U = 960
; font_V = 984
; font_W = 1008
; font_X = 1032
; font_Y = 1056
; font_Z = 1080
; font_a = 1104
; font_b = 1122
; font_c = 1144
; font_d = 1162
; font_e = 1184
; font_f = 1202
; font_g = 1226
; font_h = 1248
; font_i = 1266
; font_j = 1288
; font_k = 1316
; font_l = 1334
; font_m = 1352
; font_n = 1370
; font_o = 1388
; font_p = 1406
; font_q = 1432
; font_r = 1452
; font_s = 1474
; font_t = 1492
; font_u = 1518
; font_v = 1536
; font_w = 1554
; font_x = 1572
; font_y = 1590
; font_z = 1608
font_gfx_ptrs:
GFX_PTRS_LEN = 90
			.word 1104, 1122, 1144, 1162, 1184, 1202, 1226, 1248, 1266, 1288, 1316, 1334, 1352, 1370, 1388, 1406, 
			.word 1432, 1452, 1474, 1492, 1518, 1536, 1554, 1572, 1590, 1608, 242, 242, 242, 242, 242, 242, 
			.word 250, 340, 242, 242, 242, 284, 340, 350, 372, 242, 242, 394, 404, 412, 242, 2, 
			.word 26, 50, 74, 98, 122, 146, 170, 194, 218, 420, 242, 242, 242, 242, 442, 242, 
			.word 468, 492, 516, 540, 564, 588, 612, 640, 664, 688, 712, 736, 760, 786, 810, 834, 
			.word 858, 884, 912, 936, 960, 984, 1008, 1032, 1056, 1080, 
