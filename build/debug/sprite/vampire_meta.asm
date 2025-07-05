; fdd bin file metadata
; asm data file: build/debug/sprite/vampire_data.asm
; bin file: build/debug/bin/VAMPIRE.BIN

VAMPIRE_FILE_LEN = 5032
VAMPIRE_LAST_RECORD_LEN = 40

VAMPIRE_FILENAME_PTR:
			.byte "VAMPIRE" ; filename
			.byte " " ; filename white chars
			.byte "BIN" ; extension

; relative frame labels
_vampire_run_r0_0_relative = 2
_vampire_run_r0_1_relative = 120
_vampire_run_r0_2_relative = 238
_vampire_run_r0_3_relative = 356
_vampire_run_r1_0_relative = 530
_vampire_run_r1_1_relative = 648
_vampire_run_r1_2_relative = 766
_vampire_run_r1_3_relative = 884
_vampire_run_r2_0_relative = 1058
_vampire_run_r2_1_relative = 1184
_vampire_run_r2_2_relative = 1310
_vampire_run_r2_3_relative = 1436
_vampire_run_r3_0_relative = 1622
_vampire_run_r3_1_relative = 1748
_vampire_run_r3_2_relative = 1874
_vampire_run_r3_3_relative = 2000
_vampire_run_l0_0_relative = 2186
_vampire_run_l0_1_relative = 2304
_vampire_run_l0_2_relative = 2422
_vampire_run_l0_3_relative = 2596
_vampire_run_l1_0_relative = 2714
_vampire_run_l1_1_relative = 2832
_vampire_run_l1_2_relative = 2950
_vampire_run_l1_3_relative = 3124
_vampire_run_l2_0_relative = 3242
_vampire_run_l2_1_relative = 3368
_vampire_run_l2_2_relative = 3494
_vampire_run_l2_3_relative = 3680
_vampire_run_l3_0_relative = 3806
_vampire_run_l3_1_relative = 3932
_vampire_run_l3_2_relative = 4058
_vampire_run_l3_3_relative = 4244
_vampire_cast_0_0_relative = 4370
_vampire_cast_0_1_relative = 4504
_vampire_cast_0_2_relative = 4638
_vampire_cast_0_3_relative = 4836

vampire_get_scr_addr:
			.word sprite_get_scr_addr4
vampire_ram_disk_s_cmd:
			.byte TEMP_BYTE ; inited by sprite_init_meta_data
vampire_preshifted_sprites:
			.byte 4
vampire_anims:
			.word vampire_idle_anim, vampire_run_r_anim, vampire_run_l_anim, vampire_cast_anim, EOD
vampire_idle_anim:
			.byte 9, 0 ; offset to the next frame
			.word _vampire_run_r0_0_relative, _vampire_run_r0_1_relative, _vampire_run_r0_2_relative, _vampire_run_r0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _vampire_run_r1_0_relative, _vampire_run_r1_1_relative, _vampire_run_r1_2_relative, _vampire_run_r1_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _vampire_run_r2_0_relative, _vampire_run_r2_1_relative, _vampire_run_r2_2_relative, _vampire_run_r2_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _vampire_run_r3_0_relative, _vampire_run_r3_1_relative, _vampire_run_r3_2_relative, _vampire_run_r3_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _vampire_run_l0_0_relative, _vampire_run_l0_1_relative, _vampire_run_l0_2_relative, _vampire_run_l0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _vampire_run_l1_0_relative, _vampire_run_l1_1_relative, _vampire_run_l1_2_relative, _vampire_run_l1_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _vampire_run_l2_0_relative, _vampire_run_l2_1_relative, _vampire_run_l2_2_relative, _vampire_run_l2_3_relative, 
			.byte 185, $ff ; offset to the first frame
			.word _vampire_run_l3_0_relative, _vampire_run_l3_1_relative, _vampire_run_l3_2_relative, _vampire_run_l3_3_relative, 
vampire_run_r_anim:
			.byte 9, 0 ; offset to the next frame
			.word _vampire_run_r0_0_relative, _vampire_run_r0_1_relative, _vampire_run_r0_2_relative, _vampire_run_r0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _vampire_run_r1_0_relative, _vampire_run_r1_1_relative, _vampire_run_r1_2_relative, _vampire_run_r1_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _vampire_run_r2_0_relative, _vampire_run_r2_1_relative, _vampire_run_r2_2_relative, _vampire_run_r2_3_relative, 
			.byte 225, $ff ; offset to the first frame
			.word _vampire_run_r3_0_relative, _vampire_run_r3_1_relative, _vampire_run_r3_2_relative, _vampire_run_r3_3_relative, 
vampire_run_l_anim:
			.byte 9, 0 ; offset to the next frame
			.word _vampire_run_l0_0_relative, _vampire_run_l0_1_relative, _vampire_run_l0_2_relative, _vampire_run_l0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _vampire_run_l1_0_relative, _vampire_run_l1_1_relative, _vampire_run_l1_2_relative, _vampire_run_l1_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _vampire_run_l2_0_relative, _vampire_run_l2_1_relative, _vampire_run_l2_2_relative, _vampire_run_l2_3_relative, 
			.byte 225, $ff ; offset to the first frame
			.word _vampire_run_l3_0_relative, _vampire_run_l3_1_relative, _vampire_run_l3_2_relative, _vampire_run_l3_3_relative, 
vampire_cast_anim:
			.byte 255, $ff ; offset to the first frame
			.word _vampire_cast_0_0_relative, _vampire_cast_0_1_relative, _vampire_cast_0_2_relative, _vampire_cast_0_3_relative, 
vampire_anims_end:
vampire_anims_len: = vampire_anims_end - vampire_anims
