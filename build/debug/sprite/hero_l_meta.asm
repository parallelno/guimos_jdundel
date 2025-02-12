; fdd bin file metadata
; asm data file: build/debug/sprite/hero_l_data.asm
; bin file: build/debug/bin/HERO_L.BIN

HERO_L_FILE_LEN = 13176
HERO_L_LAST_RECORD_LEN = 120

HERO_L_FILENAME_PTR:
			.byte "HERO_L" ; filename
			.byte "  " ; filename white chars
			.byte "BIN" ; extension

; relative labels. to make it global call __text_ex_rd_init
_hero_l_idle0_0 = 2
_hero_l_idle0_1 = 188
_hero_l_idle0_2 = 374
_hero_l_idle0_3 = 560
_hero_l_idle0_4 = 836
_hero_l_idle0_5 = 1112
_hero_l_idle0_6 = 1388
_hero_l_idle0_7 = 1664
_hero_l_run0_0 = 1850
_hero_l_run0_1 = 2048
_hero_l_run0_2 = 2246
_hero_l_run0_3 = 2444
_hero_l_run0_4 = 2738
_hero_l_run0_5 = 3032
_hero_l_run0_6 = 3326
_hero_l_run0_7 = 3620
_hero_l_run1_0 = 3818
_hero_l_run1_1 = 4016
_hero_l_run1_2 = 4214
_hero_l_run1_3 = 4412
_hero_l_run1_4 = 4706
_hero_l_run1_5 = 5000
_hero_l_run1_6 = 5294
_hero_l_run1_7 = 5588
_hero_l_run2_0 = 5786
_hero_l_run2_1 = 5972
_hero_l_run2_2 = 6158
_hero_l_run2_3 = 6344
_hero_l_run2_4 = 6620
_hero_l_run2_5 = 6896
_hero_l_run2_6 = 7172
_hero_l_run2_7 = 7448
_hero_l_run3_0 = 7634
_hero_l_run3_1 = 7820
_hero_l_run3_2 = 8006
_hero_l_run3_3 = 8192
_hero_l_run3_4 = 8468
_hero_l_run3_5 = 8744
_hero_l_run3_6 = 9020
_hero_l_run3_7 = 9296
_hero_l_attk0_0 = 9482
_hero_l_attk0_1 = 9668
_hero_l_attk0_2 = 9854
_hero_l_attk0_3 = 10130
_hero_l_attk0_4 = 10406
_hero_l_attk0_5 = 10682
_hero_l_attk0_6 = 10958
_hero_l_attk0_7 = 11144
_hero_l_attk1_0 = 11330
_hero_l_attk1_1 = 11516
_hero_l_attk1_2 = 11702
_hero_l_attk1_3 = 11888
_hero_l_attk1_4 = 12164
_hero_l_attk1_5 = 12440
_hero_l_attk1_6 = 12716
_hero_l_attk1_7 = 12992

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
