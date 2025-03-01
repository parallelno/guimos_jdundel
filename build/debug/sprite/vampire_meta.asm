; fdd bin file metadata
; asm data file: build/debug/sprite/vampire_data.asm
; bin file: build/debug/bin/VAMPIRE.BIN

VAMPIRE_FILE_LEN = 7440
VAMPIRE_LAST_RECORD_LEN = 16

VAMPIRE_FILENAME_PTR:
			.byte "VAMPIRE" ; filename
			.byte " " ; filename white chars
			.byte "BIN" ; extension

; relative frame labels
_vampire_run_r0_0 = 2
_vampire_run_r0_1 = 176
_vampire_run_r0_2 = 350
_vampire_run_r0_3 = 524
_vampire_run_r1_0 = 782
_vampire_run_r1_1 = 956
_vampire_run_r1_2 = 1130
_vampire_run_r1_3 = 1304
_vampire_run_r2_0 = 1562
_vampire_run_r2_1 = 1748
_vampire_run_r2_2 = 1934
_vampire_run_r2_3 = 2120
_vampire_run_r3_0 = 2396
_vampire_run_r3_1 = 2582
_vampire_run_r3_2 = 2768
_vampire_run_r3_3 = 2954
_vampire_run_l0_0 = 3230
_vampire_run_l0_1 = 3404
_vampire_run_l0_2 = 3578
_vampire_run_l0_3 = 3836
_vampire_run_l1_0 = 4010
_vampire_run_l1_1 = 4184
_vampire_run_l1_2 = 4358
_vampire_run_l1_3 = 4616
_vampire_run_l2_0 = 4790
_vampire_run_l2_1 = 4976
_vampire_run_l2_2 = 5162
_vampire_run_l2_3 = 5438
_vampire_run_l3_0 = 5624
_vampire_run_l3_1 = 5810
_vampire_run_l3_2 = 5996
_vampire_run_l3_3 = 6272
_vampire_cast_0_0 = 6458
_vampire_cast_0_1 = 6656
_vampire_cast_0_2 = 6854
_vampire_cast_0_3 = 7148

sprite_get_scr_addr_vampire = sprite_get_scr_addr4

_vampire_preshifted_sprites:
			.byte 4
_vampire_anims:
			.word _vampire_idle, _vampire_run_r, _vampire_run_l, _vampire_cast, EOD
_vampire_idle:
			.byte 9, 0 ; offset to the next frame
			.word _vampire_run_r0_0, _vampire_run_r0_1, _vampire_run_r0_2, _vampire_run_r0_3, 
			.byte 9, 0 ; offset to the next frame
			.word _vampire_run_r1_0, _vampire_run_r1_1, _vampire_run_r1_2, _vampire_run_r1_3, 
			.byte 9, 0 ; offset to the next frame
			.word _vampire_run_r2_0, _vampire_run_r2_1, _vampire_run_r2_2, _vampire_run_r2_3, 
			.byte 9, 0 ; offset to the next frame
			.word _vampire_run_r3_0, _vampire_run_r3_1, _vampire_run_r3_2, _vampire_run_r3_3, 
			.byte 9, 0 ; offset to the next frame
			.word _vampire_run_l0_0, _vampire_run_l0_1, _vampire_run_l0_2, _vampire_run_l0_3, 
			.byte 9, 0 ; offset to the next frame
			.word _vampire_run_l1_0, _vampire_run_l1_1, _vampire_run_l1_2, _vampire_run_l1_3, 
			.byte 9, 0 ; offset to the next frame
			.word _vampire_run_l2_0, _vampire_run_l2_1, _vampire_run_l2_2, _vampire_run_l2_3, 
			.byte 185, $ff ; offset to the first frame
			.word _vampire_run_l3_0, _vampire_run_l3_1, _vampire_run_l3_2, _vampire_run_l3_3, 
_vampire_run_r:
			.byte 9, 0 ; offset to the next frame
			.word _vampire_run_r0_0, _vampire_run_r0_1, _vampire_run_r0_2, _vampire_run_r0_3, 
			.byte 9, 0 ; offset to the next frame
			.word _vampire_run_r1_0, _vampire_run_r1_1, _vampire_run_r1_2, _vampire_run_r1_3, 
			.byte 9, 0 ; offset to the next frame
			.word _vampire_run_r2_0, _vampire_run_r2_1, _vampire_run_r2_2, _vampire_run_r2_3, 
			.byte 225, $ff ; offset to the first frame
			.word _vampire_run_r3_0, _vampire_run_r3_1, _vampire_run_r3_2, _vampire_run_r3_3, 
_vampire_run_l:
			.byte 9, 0 ; offset to the next frame
			.word _vampire_run_l0_0, _vampire_run_l0_1, _vampire_run_l0_2, _vampire_run_l0_3, 
			.byte 9, 0 ; offset to the next frame
			.word _vampire_run_l1_0, _vampire_run_l1_1, _vampire_run_l1_2, _vampire_run_l1_3, 
			.byte 9, 0 ; offset to the next frame
			.word _vampire_run_l2_0, _vampire_run_l2_1, _vampire_run_l2_2, _vampire_run_l2_3, 
			.byte 225, $ff ; offset to the first frame
			.word _vampire_run_l3_0, _vampire_run_l3_1, _vampire_run_l3_2, _vampire_run_l3_3, 
_vampire_cast:
			.byte 255, $ff ; offset to the first frame
			.word _vampire_cast_0_0, _vampire_cast_0_1, _vampire_cast_0_2, _vampire_cast_0_3, 
