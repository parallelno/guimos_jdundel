; fdd bin file metadata
; asm data file: build/debug/sprite/skeleton_data.asm
; bin file: build/debug/bin/SKELETON.BIN

SKELETON_FILE_LEN = 6660
SKELETON_LAST_RECORD_LEN = 4

SKELETON_FILENAME_PTR:
			.byte "SKELETON" ; filename
			.byte "BIN" ; extension

; relative frame labels
_skeleton_idle_0_0_relative = 2
_skeleton_idle_0_1_relative = 128
_skeleton_idle_0_2_relative = 314
_skeleton_idle_0_3_relative = 500
_skeleton_idle_1_0_relative = 686
_skeleton_idle_1_1_relative = 812
_skeleton_idle_1_2_relative = 998
_skeleton_idle_1_3_relative = 1184
_skeleton_run_r0_0_relative = 1370
_skeleton_run_r0_1_relative = 1496
_skeleton_run_r0_2_relative = 1682
_skeleton_run_r0_3_relative = 1868
_skeleton_run_r1_0_relative = 2054
_skeleton_run_r1_1_relative = 2180
_skeleton_run_r1_2_relative = 2366
_skeleton_run_r1_3_relative = 2552
_skeleton_run_r2_0_relative = 2738
_skeleton_run_r2_1_relative = 2864
_skeleton_run_r2_2_relative = 3050
_skeleton_run_r2_3_relative = 3236
_skeleton_run_r3_0_relative = 3422
_skeleton_run_r3_1_relative = 3548
_skeleton_run_r3_2_relative = 3734
_skeleton_run_r3_3_relative = 3920
_skeleton_run_l0_0_relative = 4106
_skeleton_run_l0_1_relative = 4232
_skeleton_run_l0_2_relative = 4358
_skeleton_run_l0_3_relative = 4544
_skeleton_run_l1_0_relative = 4730
_skeleton_run_l1_1_relative = 4856
_skeleton_run_l1_2_relative = 4982
_skeleton_run_l1_3_relative = 5168
_skeleton_run_l2_0_relative = 5354
_skeleton_run_l2_1_relative = 5480
_skeleton_run_l2_2_relative = 5666
_skeleton_run_l2_3_relative = 5852
_skeleton_run_l3_0_relative = 6038
_skeleton_run_l3_1_relative = 6164
_skeleton_run_l3_2_relative = 6290
_skeleton_run_l3_3_relative = 6476

skeleton_get_scr_addr:
			.word sprite_get_scr_addr4
skeleton_ram_disk_s_cmd:
			.byte TEMP_BYTE ; inited by sprite_init_meta_data
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
skeleton_anims_end:
skeleton_anims_len: = skeleton_anims_end - skeleton_anims
