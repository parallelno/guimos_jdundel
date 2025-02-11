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
_skeleton_idle_0_1 = 188
_skeleton_idle_0_2 = 458
_skeleton_idle_0_3 = 728
_skeleton_idle_1_0 = 998
_skeleton_idle_1_1 = 1184
_skeleton_idle_1_2 = 1454
_skeleton_idle_1_3 = 1724
_skeleton_run_r0_0 = 1994
_skeleton_run_r0_1 = 2180
_skeleton_run_r0_2 = 2450
_skeleton_run_r0_3 = 2720
_skeleton_run_r1_0 = 2990
_skeleton_run_r1_1 = 3176
_skeleton_run_r1_2 = 3446
_skeleton_run_r1_3 = 3716
_skeleton_run_r2_0 = 3986
_skeleton_run_r2_1 = 4172
_skeleton_run_r2_2 = 4442
_skeleton_run_r2_3 = 4712
_skeleton_run_r3_0 = 4982
_skeleton_run_r3_1 = 5168
_skeleton_run_r3_2 = 5438
_skeleton_run_r3_3 = 5708
_skeleton_run_l0_0 = 5978
_skeleton_run_l0_1 = 6164
_skeleton_run_l0_2 = 6434
_skeleton_run_l0_3 = 6704
_skeleton_run_l1_0 = 6974
_skeleton_run_l1_1 = 7160
_skeleton_run_l1_2 = 7430
_skeleton_run_l1_3 = 7700
_skeleton_run_l2_0 = 7970
_skeleton_run_l2_1 = 8156
_skeleton_run_l2_2 = 8426
_skeleton_run_l2_3 = 8696
_skeleton_run_l3_0 = 8966
_skeleton_run_l3_1 = 9152
_skeleton_run_l3_2 = 9422
_skeleton_run_l3_3 = 9692

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
