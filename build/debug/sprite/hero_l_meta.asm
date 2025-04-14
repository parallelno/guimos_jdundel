; fdd bin file metadata
; asm data file: build/debug/sprite/hero_l_data.asm
; bin file: build/debug/bin/HERO_L.BIN

HERO_L_FILE_LEN = 13176
HERO_L_LAST_RECORD_LEN = 120

HERO_L_FILENAME_PTR:
			.byte "HERO_L" ; filename
			.byte "  " ; filename white chars
			.byte "BIN" ; extension

; relative frame labels
_hero_l_idle0_0_relative = 2
_hero_l_idle0_1_relative = 188
_hero_l_idle0_2_relative = 374
_hero_l_idle0_3_relative = 560
_hero_l_idle0_4_relative = 836
_hero_l_idle0_5_relative = 1112
_hero_l_idle0_6_relative = 1388
_hero_l_idle0_7_relative = 1664
_hero_l_run0_0_relative = 1850
_hero_l_run0_1_relative = 2048
_hero_l_run0_2_relative = 2246
_hero_l_run0_3_relative = 2444
_hero_l_run0_4_relative = 2738
_hero_l_run0_5_relative = 3032
_hero_l_run0_6_relative = 3326
_hero_l_run0_7_relative = 3620
_hero_l_run1_0_relative = 3818
_hero_l_run1_1_relative = 4016
_hero_l_run1_2_relative = 4214
_hero_l_run1_3_relative = 4412
_hero_l_run1_4_relative = 4706
_hero_l_run1_5_relative = 5000
_hero_l_run1_6_relative = 5294
_hero_l_run1_7_relative = 5588
_hero_l_run2_0_relative = 5786
_hero_l_run2_1_relative = 5972
_hero_l_run2_2_relative = 6158
_hero_l_run2_3_relative = 6344
_hero_l_run2_4_relative = 6620
_hero_l_run2_5_relative = 6896
_hero_l_run2_6_relative = 7172
_hero_l_run2_7_relative = 7448
_hero_l_run3_0_relative = 7634
_hero_l_run3_1_relative = 7820
_hero_l_run3_2_relative = 8006
_hero_l_run3_3_relative = 8192
_hero_l_run3_4_relative = 8468
_hero_l_run3_5_relative = 8744
_hero_l_run3_6_relative = 9020
_hero_l_run3_7_relative = 9296
_hero_l_attk0_0_relative = 9482
_hero_l_attk0_1_relative = 9668
_hero_l_attk0_2_relative = 9854
_hero_l_attk0_3_relative = 10130
_hero_l_attk0_4_relative = 10406
_hero_l_attk0_5_relative = 10682
_hero_l_attk0_6_relative = 10958
_hero_l_attk0_7_relative = 11144
_hero_l_attk1_0_relative = 11330
_hero_l_attk1_1_relative = 11516
_hero_l_attk1_2_relative = 11702
_hero_l_attk1_3_relative = 11888
_hero_l_attk1_4_relative = 12164
_hero_l_attk1_5_relative = 12440
_hero_l_attk1_6_relative = 12716
_hero_l_attk1_7_relative = 12992

sprite_get_scr_addr_hero_l = sprite_get_scr_addr8

hero_l_preshifted_sprites:
			.byte 8
hero_l_anims:
			.word hero_l_idle_anim, hero_l_run_anim, hero_l_attk_anim, EOD
hero_l_idle_anim:
			.byte 17, 0 ; offset to the next frame
			.word _hero_l_idle0_0_relative, _hero_l_idle0_1_relative, _hero_l_idle0_2_relative, _hero_l_idle0_3_relative, _hero_l_idle0_4_relative, _hero_l_idle0_5_relative, _hero_l_idle0_6_relative, _hero_l_idle0_7_relative, 
			.byte 17, 0 ; offset to the next frame
			.word _hero_l_idle0_0_relative, _hero_l_idle0_1_relative, _hero_l_idle0_2_relative, _hero_l_idle0_3_relative, _hero_l_idle0_4_relative, _hero_l_idle0_5_relative, _hero_l_idle0_6_relative, _hero_l_idle0_7_relative, 
			.byte 17, 0 ; offset to the next frame
			.word _hero_l_idle0_0_relative, _hero_l_idle0_1_relative, _hero_l_idle0_2_relative, _hero_l_idle0_3_relative, _hero_l_idle0_4_relative, _hero_l_idle0_5_relative, _hero_l_idle0_6_relative, _hero_l_idle0_7_relative, 
			.byte 201, $ff ; offset to the first frame
			.word _hero_l_run2_0_relative, _hero_l_run2_1_relative, _hero_l_run2_2_relative, _hero_l_run2_3_relative, _hero_l_run2_4_relative, _hero_l_run2_5_relative, _hero_l_run2_6_relative, _hero_l_run2_7_relative, 
hero_l_run_anim:
			.byte 17, 0 ; offset to the next frame
			.word _hero_l_run0_0_relative, _hero_l_run0_1_relative, _hero_l_run0_2_relative, _hero_l_run0_3_relative, _hero_l_run0_4_relative, _hero_l_run0_5_relative, _hero_l_run0_6_relative, _hero_l_run0_7_relative, 
			.byte 17, 0 ; offset to the next frame
			.word _hero_l_run1_0_relative, _hero_l_run1_1_relative, _hero_l_run1_2_relative, _hero_l_run1_3_relative, _hero_l_run1_4_relative, _hero_l_run1_5_relative, _hero_l_run1_6_relative, _hero_l_run1_7_relative, 
			.byte 17, 0 ; offset to the next frame
			.word _hero_l_run2_0_relative, _hero_l_run2_1_relative, _hero_l_run2_2_relative, _hero_l_run2_3_relative, _hero_l_run2_4_relative, _hero_l_run2_5_relative, _hero_l_run2_6_relative, _hero_l_run2_7_relative, 
			.byte 201, $ff ; offset to the first frame
			.word _hero_l_run3_0_relative, _hero_l_run3_1_relative, _hero_l_run3_2_relative, _hero_l_run3_3_relative, _hero_l_run3_4_relative, _hero_l_run3_5_relative, _hero_l_run3_6_relative, _hero_l_run3_7_relative, 
hero_l_attk_anim:
			.byte 17, 0 ; offset to the next frame
			.word _hero_l_attk0_0_relative, _hero_l_attk0_1_relative, _hero_l_attk0_2_relative, _hero_l_attk0_3_relative, _hero_l_attk0_4_relative, _hero_l_attk0_5_relative, _hero_l_attk0_6_relative, _hero_l_attk0_7_relative, 
			.byte -1, $ff ; offset to the same last frame
			.word _hero_l_attk1_0_relative, _hero_l_attk1_1_relative, _hero_l_attk1_2_relative, _hero_l_attk1_3_relative, _hero_l_attk1_4_relative, _hero_l_attk1_5_relative, _hero_l_attk1_6_relative, _hero_l_attk1_7_relative, 
