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
_sword_sword_delay_0 = 2
_sword_sword_delay_1 = 38
_sword_sword_delay_2 = 74
_sword_sword_delay_3 = 110
_sword_sword_delay_4 = 146
_sword_sword_delay_5 = 182
_sword_sword_delay_6 = 218
_sword_sword_delay_7 = 254
_sword_sword_r0_0 = 290
_sword_sword_r0_1 = 488
_sword_sword_r0_2 = 686
_sword_sword_r0_3 = 980
_sword_sword_r0_4 = 1274
_sword_sword_r0_5 = 1568
_sword_sword_r0_6 = 1862
_sword_sword_r0_7 = 2156
_sword_sword_r1_0 = 2450
_sword_sword_r1_1 = 2648
_sword_sword_r1_2 = 2846
_sword_sword_r1_3 = 3140
_sword_sword_r1_4 = 3434
_sword_sword_r1_5 = 3728
_sword_sword_r1_6 = 4022
_sword_sword_r1_7 = 4316
_sword_sword_l0_0 = 4610
_sword_sword_l0_1 = 4808
_sword_sword_l0_2 = 5006
_sword_sword_l0_3 = 5300
_sword_sword_l0_4 = 5594
_sword_sword_l0_5 = 5888
_sword_sword_l0_6 = 6182
_sword_sword_l0_7 = 6476
_sword_sword_l1_0 = 6770
_sword_sword_l1_1 = 6968
_sword_sword_l1_2 = 7166
_sword_sword_l1_3 = 7460
_sword_sword_l1_4 = 7754
_sword_sword_l1_5 = 8048
_sword_sword_l1_6 = 8342
_sword_sword_l1_7 = 8636

sprite_get_scr_addr_sword = sprite_get_scr_addr8

_sword_preshifted_sprites:
			.byte 8
_sword_anims:
			.word _sword_delay, _sword_attk_r, _sword_attk_l, EOD
_sword_delay:
			.byte -1, $ff ; offset to the same last frame
			.word _sword_sword_delay_0, _sword_sword_delay_1, _sword_sword_delay_2, _sword_sword_delay_3, _sword_sword_delay_4, _sword_sword_delay_5, _sword_sword_delay_6, _sword_sword_delay_7, 
_sword_attk_r:
			.byte 17, 0 ; offset to the next frame
			.word _sword_sword_r0_0, _sword_sword_r0_1, _sword_sword_r0_2, _sword_sword_r0_3, _sword_sword_r0_4, _sword_sword_r0_5, _sword_sword_r0_6, _sword_sword_r0_7, 
			.byte -1, $ff ; offset to the same last frame
			.word _sword_sword_r1_0, _sword_sword_r1_1, _sword_sword_r1_2, _sword_sword_r1_3, _sword_sword_r1_4, _sword_sword_r1_5, _sword_sword_r1_6, _sword_sword_r1_7, 
_sword_attk_l:
			.byte 17, 0 ; offset to the next frame
			.word _sword_sword_l0_0, _sword_sword_l0_1, _sword_sword_l0_2, _sword_sword_l0_3, _sword_sword_l0_4, _sword_sword_l0_5, _sword_sword_l0_6, _sword_sword_l0_7, 
			.byte -1, $ff ; offset to the same last frame
			.word _sword_sword_l1_0, _sword_sword_l1_1, _sword_sword_l1_2, _sword_sword_l1_3, _sword_sword_l1_4, _sword_sword_l1_5, _sword_sword_l1_6, _sword_sword_l1_7, 
