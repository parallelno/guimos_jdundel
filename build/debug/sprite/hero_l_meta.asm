; fdd bin file metadata
; asm data file: build/debug/sprite/hero_l_data.asm
; bin file: build/debug/bin/HERO_L.BIN

HERO_L_FILE_LEN = 8896
HERO_L_LAST_RECORD_LEN = 64

HERO_L_FILENAME_PTR:
			.byte "HERO_L" ; filename
			.byte "  " ; filename white chars
			.byte "BIN" ; extension

; relative frame labels
_hero_l_idle0_0_relative = 2
_hero_l_idle0_1_relative = 128
_hero_l_idle0_2_relative = 254
_hero_l_idle0_3_relative = 380
_hero_l_idle0_4_relative = 566
_hero_l_idle0_5_relative = 752
_hero_l_idle0_6_relative = 938
_hero_l_idle0_7_relative = 1124
_hero_l_run0_0_relative = 1250
_hero_l_run0_1_relative = 1384
_hero_l_run0_2_relative = 1518
_hero_l_run0_3_relative = 1652
_hero_l_run0_4_relative = 1850
_hero_l_run0_5_relative = 2048
_hero_l_run0_6_relative = 2246
_hero_l_run0_7_relative = 2444
_hero_l_run1_0_relative = 2578
_hero_l_run1_1_relative = 2712
_hero_l_run1_2_relative = 2846
_hero_l_run1_3_relative = 2980
_hero_l_run1_4_relative = 3178
_hero_l_run1_5_relative = 3376
_hero_l_run1_6_relative = 3574
_hero_l_run1_7_relative = 3772
_hero_l_run2_0_relative = 3906
_hero_l_run2_1_relative = 4032
_hero_l_run2_2_relative = 4158
_hero_l_run2_3_relative = 4284
_hero_l_run2_4_relative = 4470
_hero_l_run2_5_relative = 4656
_hero_l_run2_6_relative = 4842
_hero_l_run2_7_relative = 5028
_hero_l_run3_0_relative = 5154
_hero_l_run3_1_relative = 5280
_hero_l_run3_2_relative = 5406
_hero_l_run3_3_relative = 5532
_hero_l_run3_4_relative = 5718
_hero_l_run3_5_relative = 5904
_hero_l_run3_6_relative = 6090
_hero_l_run3_7_relative = 6276
_hero_l_attk0_0_relative = 6402
_hero_l_attk0_1_relative = 6528
_hero_l_attk0_2_relative = 6654
_hero_l_attk0_3_relative = 6840
_hero_l_attk0_4_relative = 7026
_hero_l_attk0_5_relative = 7212
_hero_l_attk0_6_relative = 7398
_hero_l_attk0_7_relative = 7524
_hero_l_attk1_0_relative = 7650
_hero_l_attk1_1_relative = 7776
_hero_l_attk1_2_relative = 7902
_hero_l_attk1_3_relative = 8028
_hero_l_attk1_4_relative = 8214
_hero_l_attk1_5_relative = 8400
_hero_l_attk1_6_relative = 8586
_hero_l_attk1_7_relative = 8772

hero_l_get_scr_addr:
			.word sprite_get_scr_addr8
hero_l_ram_disk_s_cmd:
			.byte TEMP_BYTE ; inited by sprite_init_meta_data
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
hero_l_anims_end:
hero_l_anims_len: = hero_l_anims_end - hero_l_anims
