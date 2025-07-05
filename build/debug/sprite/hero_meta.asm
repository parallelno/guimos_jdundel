; fdd bin file metadata
; asm data file: build/debug/sprite/hero_data.asm
; bin file: build/debug/bin/HERO.BIN

HERO_FILE_LEN = 17792
HERO_LAST_RECORD_LEN = 0

HERO_FILENAME_PTR:
			.byte "HERO" ; filename
			.byte "    " ; filename white chars
			.byte "BIN" ; extension

; relative frame labels
_hero_idle0_l_0_relative = 2
_hero_idle0_l_1_relative = 128
_hero_idle0_l_2_relative = 254
_hero_idle0_l_3_relative = 380
_hero_idle0_l_4_relative = 566
_hero_idle0_l_5_relative = 752
_hero_idle0_l_6_relative = 938
_hero_idle0_l_7_relative = 1124
_hero_run0_l_0_relative = 1250
_hero_run0_l_1_relative = 1384
_hero_run0_l_2_relative = 1518
_hero_run0_l_3_relative = 1652
_hero_run0_l_4_relative = 1850
_hero_run0_l_5_relative = 2048
_hero_run0_l_6_relative = 2246
_hero_run0_l_7_relative = 2444
_hero_run1_l_0_relative = 2578
_hero_run1_l_1_relative = 2712
_hero_run1_l_2_relative = 2846
_hero_run1_l_3_relative = 2980
_hero_run1_l_4_relative = 3178
_hero_run1_l_5_relative = 3376
_hero_run1_l_6_relative = 3574
_hero_run1_l_7_relative = 3772
_hero_run2_l_0_relative = 3906
_hero_run2_l_1_relative = 4032
_hero_run2_l_2_relative = 4158
_hero_run2_l_3_relative = 4284
_hero_run2_l_4_relative = 4470
_hero_run2_l_5_relative = 4656
_hero_run2_l_6_relative = 4842
_hero_run2_l_7_relative = 5028
_hero_run3_l_0_relative = 5154
_hero_run3_l_1_relative = 5280
_hero_run3_l_2_relative = 5406
_hero_run3_l_3_relative = 5532
_hero_run3_l_4_relative = 5718
_hero_run3_l_5_relative = 5904
_hero_run3_l_6_relative = 6090
_hero_run3_l_7_relative = 6276
_hero_attk0_l_0_relative = 6402
_hero_attk0_l_1_relative = 6528
_hero_attk0_l_2_relative = 6654
_hero_attk0_l_3_relative = 6840
_hero_attk0_l_4_relative = 7026
_hero_attk0_l_5_relative = 7212
_hero_attk0_l_6_relative = 7398
_hero_attk0_l_7_relative = 7524
_hero_attk1_l_0_relative = 7650
_hero_attk1_l_1_relative = 7776
_hero_attk1_l_2_relative = 7902
_hero_attk1_l_3_relative = 8028
_hero_attk1_l_4_relative = 8214
_hero_attk1_l_5_relative = 8400
_hero_attk1_l_6_relative = 8586
_hero_attk1_l_7_relative = 8772
_hero_idle0_r_0_relative = 8898
_hero_idle0_r_1_relative = 9024
_hero_idle0_r_2_relative = 9150
_hero_idle0_r_3_relative = 9276
_hero_idle0_r_4_relative = 9462
_hero_idle0_r_5_relative = 9648
_hero_idle0_r_6_relative = 9834
_hero_idle0_r_7_relative = 10020
_hero_run0_r_0_relative = 10146
_hero_run0_r_1_relative = 10280
_hero_run0_r_2_relative = 10414
_hero_run0_r_3_relative = 10548
_hero_run0_r_4_relative = 10746
_hero_run0_r_5_relative = 10944
_hero_run0_r_6_relative = 11142
_hero_run0_r_7_relative = 11340
_hero_run1_r_0_relative = 11474
_hero_run1_r_1_relative = 11608
_hero_run1_r_2_relative = 11742
_hero_run1_r_3_relative = 11876
_hero_run1_r_4_relative = 12074
_hero_run1_r_5_relative = 12272
_hero_run1_r_6_relative = 12470
_hero_run1_r_7_relative = 12668
_hero_run2_r_0_relative = 12802
_hero_run2_r_1_relative = 12928
_hero_run2_r_2_relative = 13054
_hero_run2_r_3_relative = 13180
_hero_run2_r_4_relative = 13366
_hero_run2_r_5_relative = 13552
_hero_run2_r_6_relative = 13738
_hero_run2_r_7_relative = 13924
_hero_run3_r_0_relative = 14050
_hero_run3_r_1_relative = 14176
_hero_run3_r_2_relative = 14302
_hero_run3_r_3_relative = 14428
_hero_run3_r_4_relative = 14614
_hero_run3_r_5_relative = 14800
_hero_run3_r_6_relative = 14986
_hero_run3_r_7_relative = 15172
_hero_attk0_r_0_relative = 15298
_hero_attk0_r_1_relative = 15424
_hero_attk0_r_2_relative = 15550
_hero_attk0_r_3_relative = 15676
_hero_attk0_r_4_relative = 15802
_hero_attk0_r_5_relative = 15988
_hero_attk0_r_6_relative = 16174
_hero_attk0_r_7_relative = 16360
_hero_attk1_r_0_relative = 16546
_hero_attk1_r_1_relative = 16672
_hero_attk1_r_2_relative = 16798
_hero_attk1_r_3_relative = 16924
_hero_attk1_r_4_relative = 17110
_hero_attk1_r_5_relative = 17296
_hero_attk1_r_6_relative = 17482
_hero_attk1_r_7_relative = 17668

hero_get_scr_addr:
			.word sprite_get_scr_addr8
hero_ram_disk_s_cmd:
			.byte TEMP_BYTE ; inited by sprite_init_meta_data
hero_preshifted_sprites:
			.byte 8
hero_anims:
			.word hero_idle_l_anim, hero_run_l_anim, hero_attk_l_anim, hero_idle_r_anim, hero_run_r_anim, hero_attk_r_anim, EOD
hero_idle_l_anim:
			.byte 17, 0 ; offset to the next frame
			.word _hero_idle0_l_0_relative, _hero_idle0_l_1_relative, _hero_idle0_l_2_relative, _hero_idle0_l_3_relative, _hero_idle0_l_4_relative, _hero_idle0_l_5_relative, _hero_idle0_l_6_relative, _hero_idle0_l_7_relative, 
			.byte 17, 0 ; offset to the next frame
			.word _hero_idle0_l_0_relative, _hero_idle0_l_1_relative, _hero_idle0_l_2_relative, _hero_idle0_l_3_relative, _hero_idle0_l_4_relative, _hero_idle0_l_5_relative, _hero_idle0_l_6_relative, _hero_idle0_l_7_relative, 
			.byte 17, 0 ; offset to the next frame
			.word _hero_idle0_l_0_relative, _hero_idle0_l_1_relative, _hero_idle0_l_2_relative, _hero_idle0_l_3_relative, _hero_idle0_l_4_relative, _hero_idle0_l_5_relative, _hero_idle0_l_6_relative, _hero_idle0_l_7_relative, 
			.byte 201, $ff ; offset to the first frame
			.word _hero_run2_l_0_relative, _hero_run2_l_1_relative, _hero_run2_l_2_relative, _hero_run2_l_3_relative, _hero_run2_l_4_relative, _hero_run2_l_5_relative, _hero_run2_l_6_relative, _hero_run2_l_7_relative, 
hero_run_l_anim:
			.byte 17, 0 ; offset to the next frame
			.word _hero_run0_l_0_relative, _hero_run0_l_1_relative, _hero_run0_l_2_relative, _hero_run0_l_3_relative, _hero_run0_l_4_relative, _hero_run0_l_5_relative, _hero_run0_l_6_relative, _hero_run0_l_7_relative, 
			.byte 17, 0 ; offset to the next frame
			.word _hero_run1_l_0_relative, _hero_run1_l_1_relative, _hero_run1_l_2_relative, _hero_run1_l_3_relative, _hero_run1_l_4_relative, _hero_run1_l_5_relative, _hero_run1_l_6_relative, _hero_run1_l_7_relative, 
			.byte 17, 0 ; offset to the next frame
			.word _hero_run2_l_0_relative, _hero_run2_l_1_relative, _hero_run2_l_2_relative, _hero_run2_l_3_relative, _hero_run2_l_4_relative, _hero_run2_l_5_relative, _hero_run2_l_6_relative, _hero_run2_l_7_relative, 
			.byte 201, $ff ; offset to the first frame
			.word _hero_run3_l_0_relative, _hero_run3_l_1_relative, _hero_run3_l_2_relative, _hero_run3_l_3_relative, _hero_run3_l_4_relative, _hero_run3_l_5_relative, _hero_run3_l_6_relative, _hero_run3_l_7_relative, 
hero_attk_l_anim:
			.byte 17, 0 ; offset to the next frame
			.word _hero_attk0_l_0_relative, _hero_attk0_l_1_relative, _hero_attk0_l_2_relative, _hero_attk0_l_3_relative, _hero_attk0_l_4_relative, _hero_attk0_l_5_relative, _hero_attk0_l_6_relative, _hero_attk0_l_7_relative, 
			.byte -1, $ff ; offset to the same last frame
			.word _hero_attk1_l_0_relative, _hero_attk1_l_1_relative, _hero_attk1_l_2_relative, _hero_attk1_l_3_relative, _hero_attk1_l_4_relative, _hero_attk1_l_5_relative, _hero_attk1_l_6_relative, _hero_attk1_l_7_relative, 
hero_idle_r_anim:
			.byte 17, 0 ; offset to the next frame
			.word _hero_idle0_r_0_relative, _hero_idle0_r_1_relative, _hero_idle0_r_2_relative, _hero_idle0_r_3_relative, _hero_idle0_r_4_relative, _hero_idle0_r_5_relative, _hero_idle0_r_6_relative, _hero_idle0_r_7_relative, 
			.byte 17, 0 ; offset to the next frame
			.word _hero_idle0_r_0_relative, _hero_idle0_r_1_relative, _hero_idle0_r_2_relative, _hero_idle0_r_3_relative, _hero_idle0_r_4_relative, _hero_idle0_r_5_relative, _hero_idle0_r_6_relative, _hero_idle0_r_7_relative, 
			.byte 17, 0 ; offset to the next frame
			.word _hero_idle0_r_0_relative, _hero_idle0_r_1_relative, _hero_idle0_r_2_relative, _hero_idle0_r_3_relative, _hero_idle0_r_4_relative, _hero_idle0_r_5_relative, _hero_idle0_r_6_relative, _hero_idle0_r_7_relative, 
			.byte 201, $ff ; offset to the first frame
			.word _hero_run2_r_0_relative, _hero_run2_r_1_relative, _hero_run2_r_2_relative, _hero_run2_r_3_relative, _hero_run2_r_4_relative, _hero_run2_r_5_relative, _hero_run2_r_6_relative, _hero_run2_r_7_relative, 
hero_run_r_anim:
			.byte 17, 0 ; offset to the next frame
			.word _hero_run0_r_0_relative, _hero_run0_r_1_relative, _hero_run0_r_2_relative, _hero_run0_r_3_relative, _hero_run0_r_4_relative, _hero_run0_r_5_relative, _hero_run0_r_6_relative, _hero_run0_r_7_relative, 
			.byte 17, 0 ; offset to the next frame
			.word _hero_run1_r_0_relative, _hero_run1_r_1_relative, _hero_run1_r_2_relative, _hero_run1_r_3_relative, _hero_run1_r_4_relative, _hero_run1_r_5_relative, _hero_run1_r_6_relative, _hero_run1_r_7_relative, 
			.byte 17, 0 ; offset to the next frame
			.word _hero_run2_r_0_relative, _hero_run2_r_1_relative, _hero_run2_r_2_relative, _hero_run2_r_3_relative, _hero_run2_r_4_relative, _hero_run2_r_5_relative, _hero_run2_r_6_relative, _hero_run2_r_7_relative, 
			.byte 201, $ff ; offset to the first frame
			.word _hero_run3_r_0_relative, _hero_run3_r_1_relative, _hero_run3_r_2_relative, _hero_run3_r_3_relative, _hero_run3_r_4_relative, _hero_run3_r_5_relative, _hero_run3_r_6_relative, _hero_run3_r_7_relative, 
hero_attk_r_anim:
			.byte 17, 0 ; offset to the next frame
			.word _hero_attk0_r_0_relative, _hero_attk0_r_1_relative, _hero_attk0_r_2_relative, _hero_attk0_r_3_relative, _hero_attk0_r_4_relative, _hero_attk0_r_5_relative, _hero_attk0_r_6_relative, _hero_attk0_r_7_relative, 
			.byte -1, $ff ; offset to the same last frame
			.word _hero_attk1_r_0_relative, _hero_attk1_r_1_relative, _hero_attk1_r_2_relative, _hero_attk1_r_3_relative, _hero_attk1_r_4_relative, _hero_attk1_r_5_relative, _hero_attk1_r_6_relative, _hero_attk1_r_7_relative, 
hero_anims_end:
hero_anims_len: = hero_anims_end - hero_anims
