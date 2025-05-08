; fdd bin file metadata
; asm data file: build/debug/sprite/sword_data.asm
; bin file: build/debug/bin/SWORD.BIN

SWORD_FILE_LEN = 8928
SWORD_LAST_RECORD_LEN = 96

SWORD_FILENAME_PTR:
			.byte "SWORD" ; filename
			.byte "   " ; filename white chars
			.byte "BIN" ; extension

; relative frame labels
_sword_sword_delay_0_relative = 2
_sword_sword_delay_1_relative = 38
_sword_sword_delay_2_relative = 74
_sword_sword_delay_3_relative = 110
_sword_sword_delay_4_relative = 146
_sword_sword_delay_5_relative = 182
_sword_sword_delay_6_relative = 218
_sword_sword_delay_7_relative = 254
_sword_sword_r0_0_relative = 290
_sword_sword_r0_1_relative = 488
_sword_sword_r0_2_relative = 686
_sword_sword_r0_3_relative = 980
_sword_sword_r0_4_relative = 1274
_sword_sword_r0_5_relative = 1568
_sword_sword_r0_6_relative = 1862
_sword_sword_r0_7_relative = 2156
_sword_sword_r1_0_relative = 2450
_sword_sword_r1_1_relative = 2648
_sword_sword_r1_2_relative = 2846
_sword_sword_r1_3_relative = 3140
_sword_sword_r1_4_relative = 3434
_sword_sword_r1_5_relative = 3728
_sword_sword_r1_6_relative = 4022
_sword_sword_r1_7_relative = 4316
_sword_sword_l0_0_relative = 4610
_sword_sword_l0_1_relative = 4808
_sword_sword_l0_2_relative = 5006
_sword_sword_l0_3_relative = 5300
_sword_sword_l0_4_relative = 5594
_sword_sword_l0_5_relative = 5888
_sword_sword_l0_6_relative = 6182
_sword_sword_l0_7_relative = 6476
_sword_sword_l1_0_relative = 6770
_sword_sword_l1_1_relative = 6968
_sword_sword_l1_2_relative = 7166
_sword_sword_l1_3_relative = 7460
_sword_sword_l1_4_relative = 7754
_sword_sword_l1_5_relative = 8048
_sword_sword_l1_6_relative = 8342
_sword_sword_l1_7_relative = 8636

sprite_get_scr_addr_sword = sprite_get_scr_addr8

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
