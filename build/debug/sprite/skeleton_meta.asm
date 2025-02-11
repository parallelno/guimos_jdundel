; fdd bin file metadata
; asm data file: build/debug/sprite/skeleton_data.asm
; bin file: build/debug/bin/SKELETON.BIN

SKELETON_FILE_LEN = 10140
SKELETON_LAST_RECORD_LEN = 28

SKELETON_FILENAME_PTR:
			.byte "SKELETON" ; filename
			.byte "BIN" ; extension

; relative labels. to make it global call __text_ex_rd_init
_skeleton_idle_0_0 = 2
_skeleton_idle_0_1 = 182
_skeleton_idle_0_2 = 452
_skeleton_idle_0_3 = 722
_skeleton_idle_1_0 = 992
_skeleton_idle_1_1 = 1172
_skeleton_idle_1_2 = 1442
_skeleton_idle_1_3 = 1712
_skeleton_run_r0_0 = 1982
_skeleton_run_r0_1 = 2162
_skeleton_run_r0_2 = 2432
_skeleton_run_r0_3 = 2702
_skeleton_run_r1_0 = 2972
_skeleton_run_r1_1 = 3152
_skeleton_run_r1_2 = 3422
_skeleton_run_r1_3 = 3692
_skeleton_run_r2_0 = 3962
_skeleton_run_r2_1 = 4142
_skeleton_run_r2_2 = 4412
_skeleton_run_r2_3 = 4682
_skeleton_run_r3_0 = 4952
_skeleton_run_r3_1 = 5132
_skeleton_run_r3_2 = 5402
_skeleton_run_r3_3 = 5672
_skeleton_run_l0_0 = 5942
_skeleton_run_l0_1 = 6122
_skeleton_run_l0_2 = 6392
_skeleton_run_l0_3 = 6662
_skeleton_run_l1_0 = 6932
_skeleton_run_l1_1 = 7112
_skeleton_run_l1_2 = 7382
_skeleton_run_l1_3 = 7652
_skeleton_run_l2_0 = 7922
_skeleton_run_l2_1 = 8102
_skeleton_run_l2_2 = 8372
_skeleton_run_l2_3 = 8642
_skeleton_run_l3_0 = 8912
_skeleton_run_l3_1 = 9092
_skeleton_run_l3_2 = 9362
_skeleton_run_l3_3 = 9632

sprite_get_scr_addr_skeleton = sprite_get_scr_addr4

_skeleton_preshifted_sprites:
			.byte 4
_skeleton_anims:
			.word _skeleton_idle, _skeleton_run_r, _skeleton_run_l, 0, 
_skeleton_idle:
			.byte 9, 0 ; offset to the next frame
			.word _skeleton_idle_0_0, _skeleton_idle_0_1, _skeleton_idle_0_2, _skeleton_idle_0_3, 
			.byte 245, $ff ; offset to the first frame
			.word _skeleton_idle_1_0, _skeleton_idle_1_1, _skeleton_idle_1_2, _skeleton_idle_1_3, 
_skeleton_run_r:
			.byte 9, 0 ; offset to the next frame
			.word _skeleton_run_r0_0, _skeleton_run_r0_1, _skeleton_run_r0_2, _skeleton_run_r0_3, 
			.byte 9, 0 ; offset to the next frame
			.word _skeleton_run_r1_0, _skeleton_run_r1_1, _skeleton_run_r1_2, _skeleton_run_r1_3, 
			.byte 9, 0 ; offset to the next frame
			.word _skeleton_run_r2_0, _skeleton_run_r2_1, _skeleton_run_r2_2, _skeleton_run_r2_3, 
			.byte 225, $ff ; offset to the first frame
			.word _skeleton_run_r3_0, _skeleton_run_r3_1, _skeleton_run_r3_2, _skeleton_run_r3_3, 
_skeleton_run_l:
			.byte 9, 0 ; offset to the next frame
			.word _skeleton_run_l0_0, _skeleton_run_l0_1, _skeleton_run_l0_2, _skeleton_run_l0_3, 
			.byte 9, 0 ; offset to the next frame
			.word _skeleton_run_l1_0, _skeleton_run_l1_1, _skeleton_run_l1_2, _skeleton_run_l1_3, 
			.byte 9, 0 ; offset to the next frame
			.word _skeleton_run_l2_0, _skeleton_run_l2_1, _skeleton_run_l2_2, _skeleton_run_l2_3, 
			.byte 225, $ff ; offset to the first frame
			.word _skeleton_run_l3_0, _skeleton_run_l3_1, _skeleton_run_l3_2, _skeleton_run_l3_3, 
