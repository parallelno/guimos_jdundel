; fdd bin file metadata
; asm data file: build/debug/sprite/knight_data.asm
; bin file: build/debug/bin/KNIGHT.BIN

KNIGHT_FILE_LEN = 15780
KNIGHT_LAST_RECORD_LEN = 36

KNIGHT_FILENAME_PTR:
			.byte "KNIGHT" ; filename
			.byte "  " ; filename white chars
			.byte "BIN" ; extension

; relative frame labels
_knight_idle_0_0 = 2
_knight_idle_0_1 = 188
_knight_idle_0_2 = 374
_knight_idle_0_3 = 650
_knight_idle_1_0 = 926
_knight_idle_1_1 = 1112
_knight_idle_1_2 = 1298
_knight_idle_1_3 = 1484
_knight_run_r0_0 = 1760
_knight_run_r0_1 = 1934
_knight_run_r0_2 = 2108
_knight_run_r0_3 = 2366
_knight_run_r1_0 = 2624
_knight_run_r1_1 = 2810
_knight_run_r1_2 = 2996
_knight_run_r1_3 = 3182
_knight_run_r2_0 = 3368
_knight_run_r2_1 = 3554
_knight_run_r2_2 = 3740
_knight_run_r2_3 = 3926
_knight_run_r3_0 = 4202
_knight_run_r3_1 = 4376
_knight_run_r3_2 = 4550
_knight_run_r3_3 = 4808
_knight_run_l0_0 = 5066
_knight_run_l0_1 = 5240
_knight_run_l0_2 = 5414
_knight_run_l0_3 = 5672
_knight_run_l1_0 = 5930
_knight_run_l1_1 = 6116
_knight_run_l1_2 = 6302
_knight_run_l1_3 = 6488
_knight_run_l2_0 = 6674
_knight_run_l2_1 = 6860
_knight_run_l2_2 = 7046
_knight_run_l2_3 = 7322
_knight_run_l3_0 = 7508
_knight_run_l3_1 = 7682
_knight_run_l3_2 = 7856
_knight_run_l3_3 = 8114
_knight_defence_r0_0 = 8372
_knight_defence_r0_1 = 8546
_knight_defence_r0_2 = 8804
_knight_defence_r0_3 = 9062
_knight_defence_r1_0 = 9320
_knight_defence_r1_1 = 9506
_knight_defence_r1_2 = 9782
_knight_defence_r1_3 = 10058
_knight_defence_r2_0 = 10244
_knight_defence_r2_1 = 10430
_knight_defence_r2_2 = 10706
_knight_defence_r2_3 = 10982
_knight_defence_r3_0 = 11258
_knight_defence_r3_1 = 11432
_knight_defence_r3_2 = 11690
_knight_defence_r3_3 = 11948
_knight_defence_l0_0 = 12206
_knight_defence_l0_1 = 12380
_knight_defence_l0_2 = 12554
_knight_defence_l0_3 = 12812
_knight_defence_l1_0 = 13070
_knight_defence_l1_1 = 13256
_knight_defence_l1_2 = 13442
_knight_defence_l1_3 = 13718
_knight_defence_l2_0 = 13994
_knight_defence_l2_1 = 14180
_knight_defence_l2_2 = 14366
_knight_defence_l2_3 = 14642
_knight_defence_l3_0 = 14918
_knight_defence_l3_1 = 15092
_knight_defence_l3_2 = 15266
_knight_defence_l3_3 = 15524

sprite_get_scr_addr_knight = sprite_get_scr_addr4

_knight_preshifted_sprites:
			.byte 4
_knight_anims:
			.word _knight_idle, _knight_run_r, _knight_run_l, _knight_defence_r, _knight_defence_l, EOD
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
