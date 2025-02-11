; fdd bin file metadata
; asm data file: build/debug/sprite/knight_data.asm
; bin file: build/debug/bin/KNIGHT.BIN

KNIGHT_FILE_LEN = 16398
KNIGHT_LAST_RECORD_LEN = 14

KNIGHT_FILENAME_PTR:
			.byte "KNIGHT" ; filename
			.byte "  " ; filename white chars
			.byte "BIN" ; extension

; relative labels. to make it global call __text_ex_rd_init
_knight_idle_0_0 = 2
_knight_idle_0_1 = 188
_knight_idle_0_2 = 368
_knight_idle_0_3 = 638
_knight_idle_1_0 = 908
_knight_idle_1_1 = 1094
_knight_idle_1_2 = 1274
_knight_idle_1_3 = 1544
_knight_run_r0_0 = 1814
_knight_run_r0_1 = 1988
_knight_run_r0_2 = 2156
_knight_run_r0_3 = 2408
_knight_run_r1_0 = 2660
_knight_run_r1_1 = 2846
_knight_run_r1_2 = 3026
_knight_run_r1_3 = 3296
_knight_run_r2_0 = 3476
_knight_run_r2_1 = 3662
_knight_run_r2_2 = 3842
_knight_run_r2_3 = 4112
_knight_run_r3_0 = 4382
_knight_run_r3_1 = 4556
_knight_run_r3_2 = 4724
_knight_run_r3_3 = 4976
_knight_run_l0_0 = 5228
_knight_run_l0_1 = 5402
_knight_run_l0_2 = 5570
_knight_run_l0_3 = 5822
_knight_run_l1_0 = 6074
_knight_run_l1_1 = 6260
_knight_run_l1_2 = 6440
_knight_run_l1_3 = 6710
_knight_run_l2_0 = 6890
_knight_run_l2_1 = 7076
_knight_run_l2_2 = 7256
_knight_run_l2_3 = 7526
_knight_run_l3_0 = 7706
_knight_run_l3_1 = 7880
_knight_run_l3_2 = 8048
_knight_run_l3_3 = 8300
_knight_defence_r0_0 = 8552
_knight_defence_r0_1 = 8726
_knight_defence_r0_2 = 8978
_knight_defence_r0_3 = 9230
_knight_defence_r1_0 = 9482
_knight_defence_r1_1 = 9668
_knight_defence_r1_2 = 9938
_knight_defence_r1_3 = 10208
_knight_defence_r2_0 = 10388
_knight_defence_r2_1 = 10574
_knight_defence_r2_2 = 10844
_knight_defence_r2_3 = 11114
_knight_defence_r3_0 = 11384
_knight_defence_r3_1 = 11558
_knight_defence_r3_2 = 11810
_knight_defence_r3_3 = 12062
_knight_defence_l0_0 = 12314
_knight_defence_l0_1 = 12488
_knight_defence_l0_2 = 12740
_knight_defence_l0_3 = 12992
_knight_defence_l1_0 = 13244
_knight_defence_l1_1 = 13430
_knight_defence_l1_2 = 13610
_knight_defence_l1_3 = 13880
_knight_defence_l2_0 = 14150
_knight_defence_l2_1 = 14336
_knight_defence_l2_2 = 14606
_knight_defence_l2_3 = 14876
_knight_defence_l3_0 = 15146
_knight_defence_l3_1 = 15320
_knight_defence_l3_2 = 15572
_knight_defence_l3_3 = 15824

sprite_get_scr_addr_knight = sprite_get_scr_addr4

_knight_preshifted_sprites:
			.byte 4
_knight_anims:
			.word _knight_idle, _knight_run_r, _knight_run_l, _knight_defence_r, _knight_defence_l, 0, 
_knight_idle:
			.byte 9, 0 ; offset to the next frame
			.word _knight_idle_0_0, _knight_idle_0_1, _knight_idle_0_2, _knight_idle_0_3, 
			.byte 245, $ff ; offset to the first frame
			.word _knight_idle_1_0, _knight_idle_1_1, _knight_idle_1_2, _knight_idle_1_3, 
_knight_run_r:
			.byte 9, 0 ; offset to the next frame
			.word _knight_run_r0_0, _knight_run_r0_1, _knight_run_r0_2, _knight_run_r0_3, 
			.byte 9, 0 ; offset to the next frame
			.word _knight_run_r1_0, _knight_run_r1_1, _knight_run_r1_2, _knight_run_r1_3, 
			.byte 9, 0 ; offset to the next frame
			.word _knight_run_r2_0, _knight_run_r2_1, _knight_run_r2_2, _knight_run_r2_3, 
			.byte 225, $ff ; offset to the first frame
			.word _knight_run_r3_0, _knight_run_r3_1, _knight_run_r3_2, _knight_run_r3_3, 
_knight_run_l:
			.byte 9, 0 ; offset to the next frame
			.word _knight_run_l0_0, _knight_run_l0_1, _knight_run_l0_2, _knight_run_l0_3, 
			.byte 9, 0 ; offset to the next frame
			.word _knight_run_l1_0, _knight_run_l1_1, _knight_run_l1_2, _knight_run_l1_3, 
			.byte 9, 0 ; offset to the next frame
			.word _knight_run_l2_0, _knight_run_l2_1, _knight_run_l2_2, _knight_run_l2_3, 
			.byte 225, $ff ; offset to the first frame
			.word _knight_run_l3_0, _knight_run_l3_1, _knight_run_l3_2, _knight_run_l3_3, 
_knight_defence_r:
			.byte 9, 0 ; offset to the next frame
			.word _knight_defence_r0_0, _knight_defence_r0_1, _knight_defence_r0_2, _knight_defence_r0_3, 
			.byte 9, 0 ; offset to the next frame
			.word _knight_defence_r1_0, _knight_defence_r1_1, _knight_defence_r1_2, _knight_defence_r1_3, 
			.byte 9, 0 ; offset to the next frame
			.word _knight_defence_r2_0, _knight_defence_r2_1, _knight_defence_r2_2, _knight_defence_r2_3, 
			.byte 225, $ff ; offset to the first frame
			.word _knight_defence_r3_0, _knight_defence_r3_1, _knight_defence_r3_2, _knight_defence_r3_3, 
_knight_defence_l:
			.byte 9, 0 ; offset to the next frame
			.word _knight_defence_l0_0, _knight_defence_l0_1, _knight_defence_l0_2, _knight_defence_l0_3, 
			.byte 9, 0 ; offset to the next frame
			.word _knight_defence_l1_0, _knight_defence_l1_1, _knight_defence_l1_2, _knight_defence_l1_3, 
			.byte 9, 0 ; offset to the next frame
			.word _knight_defence_l2_0, _knight_defence_l2_1, _knight_defence_l2_2, _knight_defence_l2_3, 
			.byte 225, $ff ; offset to the first frame
			.word _knight_defence_l3_0, _knight_defence_l3_1, _knight_defence_l3_2, _knight_defence_l3_3, 
