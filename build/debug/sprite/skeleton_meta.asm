; fdd bin file metadata
; asm data file: build/debug/sprite/skeleton_data.asm
; bin file: build/debug/bin/SKELETON.BIN

SKELETON_FILE_LEN = 9870
SKELETON_LAST_RECORD_LEN = 14

SKELETON_FILENAME_PTR:
			.byte "SKELETON" ; filename
			.byte "BIN" ; extension

; relative labels. to make it global call __text_ex_rd_init
_skeleton_idle_0_0 = 2
_skeleton_idle_0_1 = 188
_skeleton_idle_0_2 = 464
_skeleton_idle_0_3 = 740
_skeleton_idle_1_0 = 1016
_skeleton_idle_1_1 = 1202
_skeleton_idle_1_2 = 1478
_skeleton_idle_1_3 = 1754
_skeleton_run_r0_0 = 2030
_skeleton_run_r0_1 = 2216
_skeleton_run_r0_2 = 2492
_skeleton_run_r0_3 = 2768
_skeleton_run_r1_0 = 3044
_skeleton_run_r1_1 = 3230
_skeleton_run_r1_2 = 3506
_skeleton_run_r1_3 = 3782
_skeleton_run_r2_0 = 4058
_skeleton_run_r2_1 = 4244
_skeleton_run_r2_2 = 4520
_skeleton_run_r2_3 = 4796
_skeleton_run_r3_0 = 5072
_skeleton_run_r3_1 = 5258
_skeleton_run_r3_2 = 5534
_skeleton_run_r3_3 = 5810
_skeleton_run_l0_0 = 6086
_skeleton_run_l0_1 = 6272
_skeleton_run_l0_2 = 6458
_skeleton_run_l0_3 = 6734
_skeleton_run_l1_0 = 7010
_skeleton_run_l1_1 = 7196
_skeleton_run_l1_2 = 7382
_skeleton_run_l1_3 = 7658
_skeleton_run_l2_0 = 7934
_skeleton_run_l2_1 = 8120
_skeleton_run_l2_2 = 8396
_skeleton_run_l2_3 = 8672
_skeleton_run_l3_0 = 8948
_skeleton_run_l3_1 = 9134
_skeleton_run_l3_2 = 9320
_skeleton_run_l3_3 = 9596

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
