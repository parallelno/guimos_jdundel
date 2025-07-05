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
_vampire_run_r0_0_relative = 2
_vampire_run_r0_1_relative = 176
_vampire_run_r0_2_relative = 350
_vampire_run_r0_3_relative = 524
_vampire_run_r1_0_relative = 782
_vampire_run_r1_1_relative = 956
_vampire_run_r1_2_relative = 1130
_vampire_run_r1_3_relative = 1304
_vampire_run_r2_0_relative = 1562
_vampire_run_r2_1_relative = 1748
_vampire_run_r2_2_relative = 1934
_vampire_run_r2_3_relative = 2120
_vampire_run_r3_0_relative = 2396
_vampire_run_r3_1_relative = 2582
_vampire_run_r3_2_relative = 2768
_vampire_run_r3_3_relative = 2954
_vampire_run_l0_0_relative = 3230
_vampire_run_l0_1_relative = 3404
_vampire_run_l0_2_relative = 3578
_vampire_run_l0_3_relative = 3836
_vampire_run_l1_0_relative = 4010
_vampire_run_l1_1_relative = 4184
_vampire_run_l1_2_relative = 4358
_vampire_run_l1_3_relative = 4616
_vampire_run_l2_0_relative = 4790
_vampire_run_l2_1_relative = 4976
_vampire_run_l2_2_relative = 5162
_vampire_run_l2_3_relative = 5438
_vampire_run_l3_0_relative = 5624
_vampire_run_l3_1_relative = 5810
_vampire_run_l3_2_relative = 5996
_vampire_run_l3_3_relative = 6272
_vampire_cast_0_0_relative = 6458
_vampire_cast_0_1_relative = 6656
_vampire_cast_0_2_relative = 6854
_vampire_cast_0_3_relative = 7148

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
