; fdd bin file metadata
; asm data file: build/debug/font/font_data.asm
; bin file: build/debug/bin/FONT.BIN

FONT_FILE_LEN = 1624
FONT_LAST_RECORD_LEN = 88

FONT_FILENAME_PTR:
			.byte "FONT" ; filename
			.byte "    " ; filename white chars
			.byte "BIN" ; extension

; relative labels. to make it global call __text_ex_rd_init
_font_0 = 2
_font_1 = 26
_font_2 = 50
_font_3 = 74
_font_4 = 98
_font_5 = 122
_font_6 = 146
_font_7 = 170
_font_8 = 194
_font_9 = 218
_font_space = 242
_font_exclamation = 250
_font_d_quote = 276
_font_ampersand = 284
_font_hash = 308
_font_dollar = 316
_font_percent = 324
_font_ampercent = 332
_font_quote = 340
_font_parent_l = 350
_font_parent_r = 372
_font_comma = 394
_font_dash = 404
_font_period = 412
_font_colon = 420
_font_equal = 434
_font_question = 442
_font_A = 468
_font_B = 492
_font_C = 516
_font_D = 540
_font_E = 564
_font_F = 588
_font_G = 612
_font_H = 640
_font_I = 664
_font_J = 688
_font_K = 712
_font_L = 736
_font_M = 760
_font_N = 786
_font_O = 810
_font_P = 834
_font_Q = 858
_font_R = 884
_font_S = 912
_font_T = 936
_font_U = 960
_font_V = 984
_font_W = 1008
_font_X = 1032
_font_Y = 1056
_font_Z = 1080
_font_a = 1104
_font_b = 1122
_font_c = 1144
_font_d = 1162
_font_e = 1184
_font_f = 1202
_font_g = 1226
_font_h = 1248
_font_i = 1266
_font_j = 1288
_font_k = 1316
_font_l = 1334
_font_m = 1352
_font_n = 1370
_font_o = 1388
_font_p = 1406
_font_q = 1432
_font_r = 1452
_font_s = 1474
_font_t = 1492
_font_u = 1518
_font_v = 1536
_font_w = 1554
_font_x = 1572
_font_y = 1590
_font_z = 1608
font_gfx_ptrs:
GFX_PTRS_LEN = 90
			.word _font_a, _font_b, _font_c, _font_d, _font_e, _font_f, _font_g, _font_h, _font_i, _font_j, _font_k, _font_l, _font_m, _font_n, _font_o, _font_p, 
			.word _font_q, _font_r, _font_s, _font_t, _font_u, _font_v, _font_w, _font_x, _font_y, _font_z, _font_space, _font_space, _font_space, _font_space, _font_space, _font_space, 
			.word _font_exclamation, _font_quote, _font_space, _font_space, _font_space, _font_ampersand, _font_quote, _font_parent_l, _font_parent_r, _font_space, _font_space, _font_comma, _font_dash, _font_period, _font_space, _font_0, 
			.word _font_1, _font_2, _font_3, _font_4, _font_5, _font_6, _font_7, _font_8, _font_9, _font_colon, _font_space, _font_space, _font_space, _font_space, _font_question, _font_space, 
			.word _font_A, _font_B, _font_C, _font_D, _font_E, _font_F, _font_G, _font_H, _font_I, _font_J, _font_K, _font_L, _font_M, _font_N, _font_O, _font_P, 
			.word _font_Q, _font_R, _font_S, _font_T, _font_U, _font_V, _font_W, _font_X, _font_Y, _font_Z, 
