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
_knight_idle_0_1 = 182
_knight_idle_0_2 = 362
_knight_idle_0_3 = 632
_knight_idle_1_0 = 902
_knight_idle_1_1 = 1082
_knight_idle_1_2 = 1262
_knight_idle_1_3 = 1532
_knight_run_r0_0 = 1802
_knight_run_r0_1 = 1970
_knight_run_r0_2 = 2138
_knight_run_r0_3 = 2390
_knight_run_r1_0 = 2642
_knight_run_r1_1 = 2822
_knight_run_r1_2 = 3002
_knight_run_r1_3 = 3272
_knight_run_r2_0 = 3452
_knight_run_r2_1 = 3632
_knight_run_r2_2 = 3812
_knight_run_r2_3 = 4082
_knight_run_r3_0 = 4352
_knight_run_r3_1 = 4520
_knight_run_r3_2 = 4688
_knight_run_r3_3 = 4940
_knight_run_l0_0 = 5192
_knight_run_l0_1 = 5360
_knight_run_l0_2 = 5528
_knight_run_l0_3 = 5780
_knight_run_l1_0 = 6032
_knight_run_l1_1 = 6212
_knight_run_l1_2 = 6392
_knight_run_l1_3 = 6662
_knight_run_l2_0 = 6842
_knight_run_l2_1 = 7022
_knight_run_l2_2 = 7202
_knight_run_l2_3 = 7472
_knight_run_l3_0 = 7652
_knight_run_l3_1 = 7820
_knight_run_l3_2 = 7988
_knight_run_l3_3 = 8240
_knight_defence_r0_0 = 8492
_knight_defence_r0_1 = 8660
_knight_defence_r0_2 = 8912
_knight_defence_r0_3 = 9164
_knight_defence_r1_0 = 9416
_knight_defence_r1_1 = 9596
_knight_defence_r1_2 = 9866
_knight_defence_r1_3 = 10136
_knight_defence_r2_0 = 10316
_knight_defence_r2_1 = 10496
_knight_defence_r2_2 = 10766
_knight_defence_r2_3 = 11036
_knight_defence_r3_0 = 11306
_knight_defence_r3_1 = 11474
_knight_defence_r3_2 = 11726
_knight_defence_r3_3 = 11978
_knight_defence_l0_0 = 12230
_knight_defence_l0_1 = 12398
_knight_defence_l0_2 = 12650
_knight_defence_l0_3 = 12902
_knight_defence_l1_0 = 13154
_knight_defence_l1_1 = 13334
_knight_defence_l1_2 = 13514
_knight_defence_l1_3 = 13784
_knight_defence_l2_0 = 14054
_knight_defence_l2_1 = 14234
_knight_defence_l2_2 = 14504
_knight_defence_l2_3 = 14774
_knight_defence_l3_0 = 15044
_knight_defence_l3_1 = 15212
_knight_defence_l3_2 = 15464
_knight_defence_l3_3 = 15716

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
