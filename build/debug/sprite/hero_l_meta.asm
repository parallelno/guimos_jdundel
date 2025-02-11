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
_hero_l_idle0_1 = 188
_hero_l_idle0_2 = 368
_hero_l_idle0_3 = 638
_hero_l_idle0_4 = 908
_hero_l_idle0_5 = 1178
_hero_l_idle0_6 = 1448
_hero_l_idle0_7 = 1718
_hero_l_run0_0 = 1898
_hero_l_run0_1 = 2096
_hero_l_run0_2 = 2288
_hero_l_run0_3 = 2576
_hero_l_run0_4 = 2864
_hero_l_run0_5 = 3152
_hero_l_run0_6 = 3440
_hero_l_run0_7 = 3728
_hero_l_run1_0 = 3920
_hero_l_run1_1 = 4118
_hero_l_run1_2 = 4310
_hero_l_run1_3 = 4598
_hero_l_run1_4 = 4886
_hero_l_run1_5 = 5174
_hero_l_run1_6 = 5462
_hero_l_run1_7 = 5750
_hero_l_run2_0 = 5942
_hero_l_run2_1 = 6128
_hero_l_run2_2 = 6308
_hero_l_run2_3 = 6578
_hero_l_run2_4 = 6848
_hero_l_run2_5 = 7118
_hero_l_run2_6 = 7388
_hero_l_run2_7 = 7658
_hero_l_run3_0 = 7838
_hero_l_run3_1 = 8024
_hero_l_run3_2 = 8204
_hero_l_run3_3 = 8474
_hero_l_run3_4 = 8744
_hero_l_run3_5 = 9014
_hero_l_run3_6 = 9284
_hero_l_run3_7 = 9554
_hero_l_attk0_0 = 9734
_hero_l_attk0_1 = 9920
_hero_l_attk0_2 = 10190
_hero_l_attk0_3 = 10460
_hero_l_attk0_4 = 10730
_hero_l_attk0_5 = 11000
_hero_l_attk0_6 = 11270
_hero_l_attk0_7 = 11450
_hero_l_attk1_0 = 11630
_hero_l_attk1_1 = 11816
_hero_l_attk1_2 = 11996
_hero_l_attk1_3 = 12266
_hero_l_attk1_4 = 12536
_hero_l_attk1_5 = 12806
_hero_l_attk1_6 = 13076
_hero_l_attk1_7 = 13346

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
