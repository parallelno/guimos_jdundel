; fdd bin file metadata
; asm data file: build/debug/sprite/skeleton_data.asm
; bin file: build/debug/bin/SKELETON.BIN

SKELETON_FILE_LEN = 9870
SKELETON_LAST_RECORD_LEN = 14

SKELETON_FILENAME_PTR:
			.byte "SKELETON" ; filename
			.byte "BIN" ; extension

; relative frame labels
_skeleton_idle_0_0_relative = 2
_skeleton_idle_0_1_relative = 188
_skeleton_idle_0_2_relative = 464
_skeleton_idle_0_3_relative = 740
_skeleton_idle_1_0_relative = 1016
_skeleton_idle_1_1_relative = 1202
_skeleton_idle_1_2_relative = 1478
_skeleton_idle_1_3_relative = 1754
_skeleton_run_r0_0_relative = 2030
_skeleton_run_r0_1_relative = 2216
_skeleton_run_r0_2_relative = 2492
_skeleton_run_r0_3_relative = 2768
_skeleton_run_r1_0_relative = 3044
_skeleton_run_r1_1_relative = 3230
_skeleton_run_r1_2_relative = 3506
_skeleton_run_r1_3_relative = 3782
_skeleton_run_r2_0_relative = 4058
_skeleton_run_r2_1_relative = 4244
_skeleton_run_r2_2_relative = 4520
_skeleton_run_r2_3_relative = 4796
_skeleton_run_r3_0_relative = 5072
_skeleton_run_r3_1_relative = 5258
_skeleton_run_r3_2_relative = 5534
_skeleton_run_r3_3_relative = 5810
_skeleton_run_l0_0_relative = 6086
_skeleton_run_l0_1_relative = 6272
_skeleton_run_l0_2_relative = 6458
_skeleton_run_l0_3_relative = 6734
_skeleton_run_l1_0_relative = 7010
_skeleton_run_l1_1_relative = 7196
_skeleton_run_l1_2_relative = 7382
_skeleton_run_l1_3_relative = 7658
_skeleton_run_l2_0_relative = 7934
_skeleton_run_l2_1_relative = 8120
_skeleton_run_l2_2_relative = 8396
_skeleton_run_l2_3_relative = 8672
_skeleton_run_l3_0_relative = 8948
_skeleton_run_l3_1_relative = 9134
_skeleton_run_l3_2_relative = 9320
_skeleton_run_l3_3_relative = 9596

sprite_get_scr_addr_skeleton = sprite_get_scr_addr4

skeleton_preshifted_sprites:
			.byte 4
skeleton_anims:
			.word skeleton_idle_anim, skeleton_run_r_anim, skeleton_run_l_anim, EOD
skeleton_idle_anim:
			.byte 9, 0 ; offset to the next frame
			.word _skeleton_idle_0_0_relative, _skeleton_idle_0_1_relative, _skeleton_idle_0_2_relative, _skeleton_idle_0_3_relative, 
			.byte 245, $ff ; offset to the first frame
			.word _skeleton_idle_1_0_relative, _skeleton_idle_1_1_relative, _skeleton_idle_1_2_relative, _skeleton_idle_1_3_relative, 
skeleton_run_r_anim:
			.byte 9, 0 ; offset to the next frame
			.word _skeleton_run_r0_0_relative, _skeleton_run_r0_1_relative, _skeleton_run_r0_2_relative, _skeleton_run_r0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _skeleton_run_r1_0_relative, _skeleton_run_r1_1_relative, _skeleton_run_r1_2_relative, _skeleton_run_r1_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _skeleton_run_r2_0_relative, _skeleton_run_r2_1_relative, _skeleton_run_r2_2_relative, _skeleton_run_r2_3_relative, 
			.byte 225, $ff ; offset to the first frame
			.word _skeleton_run_r3_0_relative, _skeleton_run_r3_1_relative, _skeleton_run_r3_2_relative, _skeleton_run_r3_3_relative, 
skeleton_run_l_anim:
			.byte 9, 0 ; offset to the next frame
			.word _skeleton_run_l0_0_relative, _skeleton_run_l0_1_relative, _skeleton_run_l0_2_relative, _skeleton_run_l0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _skeleton_run_l1_0_relative, _skeleton_run_l1_1_relative, _skeleton_run_l1_2_relative, _skeleton_run_l1_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _skeleton_run_l2_0_relative, _skeleton_run_l2_1_relative, _skeleton_run_l2_2_relative, _skeleton_run_l2_3_relative, 
			.byte 225, $ff ; offset to the first frame
			.word _skeleton_run_l3_0_relative, _skeleton_run_l3_1_relative, _skeleton_run_l3_2_relative, _skeleton_run_l3_3_relative, 
