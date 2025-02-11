; fdd bin file metadata
; asm data file: build/debug/sprite/hero_l_data.asm
; bin file: build/debug/bin/HERO_L.BIN

HERO_L_FILE_LEN = 13818
HERO_L_LAST_RECORD_LEN = 122

HERO_L_FILENAME_PTR:
			.byte "HERO_L" ; filename
			.byte "  " ; filename white chars
			.byte "BIN" ; extension

; relative labels. to make it global call __text_ex_rd_init
_hero_l_idle0_0 = 2
_hero_l_idle0_1 = 182
_hero_l_idle0_2 = 362
_hero_l_idle0_3 = 632
_hero_l_idle0_4 = 902
_hero_l_idle0_5 = 1172
_hero_l_idle0_6 = 1442
_hero_l_idle0_7 = 1712
_hero_l_run0_0 = 1892
_hero_l_run0_1 = 2084
_hero_l_run0_2 = 2276
_hero_l_run0_3 = 2564
_hero_l_run0_4 = 2852
_hero_l_run0_5 = 3140
_hero_l_run0_6 = 3428
_hero_l_run0_7 = 3716
_hero_l_run1_0 = 3908
_hero_l_run1_1 = 4100
_hero_l_run1_2 = 4292
_hero_l_run1_3 = 4580
_hero_l_run1_4 = 4868
_hero_l_run1_5 = 5156
_hero_l_run1_6 = 5444
_hero_l_run1_7 = 5732
_hero_l_run2_0 = 5924
_hero_l_run2_1 = 6104
_hero_l_run2_2 = 6284
_hero_l_run2_3 = 6554
_hero_l_run2_4 = 6824
_hero_l_run2_5 = 7094
_hero_l_run2_6 = 7364
_hero_l_run2_7 = 7634
_hero_l_run3_0 = 7814
_hero_l_run3_1 = 7994
_hero_l_run3_2 = 8174
_hero_l_run3_3 = 8444
_hero_l_run3_4 = 8714
_hero_l_run3_5 = 8984
_hero_l_run3_6 = 9254
_hero_l_run3_7 = 9524
_hero_l_attk0_0 = 9704
_hero_l_attk0_1 = 9884
_hero_l_attk0_2 = 10154
_hero_l_attk0_3 = 10424
_hero_l_attk0_4 = 10694
_hero_l_attk0_5 = 10964
_hero_l_attk0_6 = 11234
_hero_l_attk0_7 = 11414
_hero_l_attk1_0 = 11594
_hero_l_attk1_1 = 11774
_hero_l_attk1_2 = 11954
_hero_l_attk1_3 = 12224
_hero_l_attk1_4 = 12494
_hero_l_attk1_5 = 12764
_hero_l_attk1_6 = 13034
_hero_l_attk1_7 = 13304

sprite_get_scr_addr_hero_l = sprite_get_scr_addr8

_hero_l_preshifted_sprites:
			.byte 8
_hero_l_anims:
			.word _hero_l_idle, _hero_l_run, _hero_l_attk, 0, 
_hero_l_idle:
			.byte 17, 0 ; offset to the next frame
			.word _hero_l_idle0_0, _hero_l_idle0_1, _hero_l_idle0_2, _hero_l_idle0_3, _hero_l_idle0_4, _hero_l_idle0_5, _hero_l_idle0_6, _hero_l_idle0_7, 
			.byte 17, 0 ; offset to the next frame
			.word _hero_l_idle0_0, _hero_l_idle0_1, _hero_l_idle0_2, _hero_l_idle0_3, _hero_l_idle0_4, _hero_l_idle0_5, _hero_l_idle0_6, _hero_l_idle0_7, 
			.byte 17, 0 ; offset to the next frame
			.word _hero_l_idle0_0, _hero_l_idle0_1, _hero_l_idle0_2, _hero_l_idle0_3, _hero_l_idle0_4, _hero_l_idle0_5, _hero_l_idle0_6, _hero_l_idle0_7, 
			.byte 201, $ff ; offset to the first frame
			.word _hero_l_run2_0, _hero_l_run2_1, _hero_l_run2_2, _hero_l_run2_3, _hero_l_run2_4, _hero_l_run2_5, _hero_l_run2_6, _hero_l_run2_7, 
_hero_l_run:
			.byte 17, 0 ; offset to the next frame
			.word _hero_l_run0_0, _hero_l_run0_1, _hero_l_run0_2, _hero_l_run0_3, _hero_l_run0_4, _hero_l_run0_5, _hero_l_run0_6, _hero_l_run0_7, 
			.byte 17, 0 ; offset to the next frame
			.word _hero_l_run1_0, _hero_l_run1_1, _hero_l_run1_2, _hero_l_run1_3, _hero_l_run1_4, _hero_l_run1_5, _hero_l_run1_6, _hero_l_run1_7, 
			.byte 17, 0 ; offset to the next frame
			.word _hero_l_run2_0, _hero_l_run2_1, _hero_l_run2_2, _hero_l_run2_3, _hero_l_run2_4, _hero_l_run2_5, _hero_l_run2_6, _hero_l_run2_7, 
			.byte 201, $ff ; offset to the first frame
			.word _hero_l_run3_0, _hero_l_run3_1, _hero_l_run3_2, _hero_l_run3_3, _hero_l_run3_4, _hero_l_run3_5, _hero_l_run3_6, _hero_l_run3_7, 
_hero_l_attk:
			.byte 17, 0 ; offset to the next frame
			.word _hero_l_attk0_0, _hero_l_attk0_1, _hero_l_attk0_2, _hero_l_attk0_3, _hero_l_attk0_4, _hero_l_attk0_5, _hero_l_attk0_6, _hero_l_attk0_7, 
			.byte -1, $ff ; offset to the same last frame
			.word _hero_l_attk1_0, _hero_l_attk1_1, _hero_l_attk1_2, _hero_l_attk1_3, _hero_l_attk1_4, _hero_l_attk1_5, _hero_l_attk1_6, _hero_l_attk1_7, 
