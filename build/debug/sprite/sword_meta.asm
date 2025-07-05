; fdd bin file metadata
; asm data file: build/debug/sprite/sword_data.asm
; bin file: build/debug/bin/SWORD.BIN

SWORD_FILE_LEN = 6032
SWORD_LAST_RECORD_LEN = 16

SWORD_FILENAME_PTR:
			.byte "SWORD" ; filename
			.byte "   " ; filename white chars
			.byte "BIN" ; extension

; relative frame labels
_sword_sword_delay_0_relative = 2
_sword_sword_delay_1_relative = 28
_sword_sword_delay_2_relative = 54
_sword_sword_delay_3_relative = 80
_sword_sword_delay_4_relative = 106
_sword_sword_delay_5_relative = 132
_sword_sword_delay_6_relative = 158
_sword_sword_delay_7_relative = 184
_sword_sword_r0_0_relative = 210
_sword_sword_r0_1_relative = 344
_sword_sword_r0_2_relative = 478
_sword_sword_r0_3_relative = 676
_sword_sword_r0_4_relative = 874
_sword_sword_r0_5_relative = 1072
_sword_sword_r0_6_relative = 1270
_sword_sword_r0_7_relative = 1468
_sword_sword_r1_0_relative = 1666
_sword_sword_r1_1_relative = 1800
_sword_sword_r1_2_relative = 1934
_sword_sword_r1_3_relative = 2132
_sword_sword_r1_4_relative = 2330
_sword_sword_r1_5_relative = 2528
_sword_sword_r1_6_relative = 2726
_sword_sword_r1_7_relative = 2924
_sword_sword_l0_0_relative = 3122
_sword_sword_l0_1_relative = 3256
_sword_sword_l0_2_relative = 3390
_sword_sword_l0_3_relative = 3588
_sword_sword_l0_4_relative = 3786
_sword_sword_l0_5_relative = 3984
_sword_sword_l0_6_relative = 4182
_sword_sword_l0_7_relative = 4380
_sword_sword_l1_0_relative = 4578
_sword_sword_l1_1_relative = 4712
_sword_sword_l1_2_relative = 4846
_sword_sword_l1_3_relative = 5044
_sword_sword_l1_4_relative = 5242
_sword_sword_l1_5_relative = 5440
_sword_sword_l1_6_relative = 5638
_sword_sword_l1_7_relative = 5836

sword_get_scr_addr:
			.word sprite_get_scr_addr8
sword_ram_disk_s_cmd:
			.byte TEMP_BYTE ; inited by sprite_init_meta_data
sword_preshifted_sprites:
			.byte 8
sword_anims:
			.word sword_delay_anim, sword_attk_r_anim, sword_attk_l_anim, EOD
sword_delay_anim:
			.byte -1, $ff ; offset to the same last frame
			.word _sword_sword_delay_0_relative, _sword_sword_delay_1_relative, _sword_sword_delay_2_relative, _sword_sword_delay_3_relative, _sword_sword_delay_4_relative, _sword_sword_delay_5_relative, _sword_sword_delay_6_relative, _sword_sword_delay_7_relative, 
sword_attk_r_anim:
			.byte 17, 0 ; offset to the next frame
			.word _sword_sword_r0_0_relative, _sword_sword_r0_1_relative, _sword_sword_r0_2_relative, _sword_sword_r0_3_relative, _sword_sword_r0_4_relative, _sword_sword_r0_5_relative, _sword_sword_r0_6_relative, _sword_sword_r0_7_relative, 
			.byte -1, $ff ; offset to the same last frame
			.word _sword_sword_r1_0_relative, _sword_sword_r1_1_relative, _sword_sword_r1_2_relative, _sword_sword_r1_3_relative, _sword_sword_r1_4_relative, _sword_sword_r1_5_relative, _sword_sword_r1_6_relative, _sword_sword_r1_7_relative, 
sword_attk_l_anim:
			.byte 17, 0 ; offset to the next frame
			.word _sword_sword_l0_0_relative, _sword_sword_l0_1_relative, _sword_sword_l0_2_relative, _sword_sword_l0_3_relative, _sword_sword_l0_4_relative, _sword_sword_l0_5_relative, _sword_sword_l0_6_relative, _sword_sword_l0_7_relative, 
			.byte -1, $ff ; offset to the same last frame
			.word _sword_sword_l1_0_relative, _sword_sword_l1_1_relative, _sword_sword_l1_2_relative, _sword_sword_l1_3_relative, _sword_sword_l1_4_relative, _sword_sword_l1_5_relative, _sword_sword_l1_6_relative, _sword_sword_l1_7_relative, 
sword_anims_end:
sword_anims_len: = sword_anims_end - sword_anims
