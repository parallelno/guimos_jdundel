; fdd bin file metadata
; asm data file: build/debug/sprite/npc4_data.asm
; bin file: build/debug/bin/NPC4.BIN

NPC4_FILE_LEN = 7916
NPC4_LAST_RECORD_LEN = 108

NPC4_FILENAME_PTR:
			.byte "NPC4" ; filename
			.byte "    " ; filename white chars
			.byte "BIN" ; extension

; relative frame labels
_npc4_caterpillar_run0_0_relative = 2
_npc4_caterpillar_run0_1_relative = 48
_npc4_caterpillar_run0_2_relative = 94
_npc4_caterpillar_run0_3_relative = 160
_npc4_caterpillar_run1_0_relative = 206
_npc4_caterpillar_run1_1_relative = 260
_npc4_caterpillar_run1_2_relative = 314
_npc4_caterpillar_run1_3_relative = 392
_npc4_caterpillar_run2_0_relative = 446
_npc4_caterpillar_run2_1_relative = 508
_npc4_caterpillar_run2_2_relative = 570
_npc4_caterpillar_run2_3_relative = 632
_npc4_chiken_run_r0_0_relative = 694
_npc4_chiken_run_r0_1_relative = 812
_npc4_chiken_run_r0_2_relative = 930
_npc4_chiken_run_r0_3_relative = 1104
_npc4_chiken_run_r1_0_relative = 1278
_npc4_chiken_run_r1_1_relative = 1396
_npc4_chiken_run_r1_2_relative = 1514
_npc4_chiken_run_r1_3_relative = 1688
_npc4_chiken_idle_r0_0_relative = 1862
_npc4_chiken_idle_r0_1_relative = 1972
_npc4_chiken_idle_r0_2_relative = 2082
_npc4_chiken_idle_r0_3_relative = 2244
_npc4_chiken_run_l0_0_relative = 2406
_npc4_chiken_run_l0_1_relative = 2524
_npc4_chiken_run_l0_2_relative = 2642
_npc4_chiken_run_l0_3_relative = 2816
_npc4_chiken_run_l1_0_relative = 2990
_npc4_chiken_run_l1_1_relative = 3108
_npc4_chiken_run_l1_2_relative = 3226
_npc4_chiken_run_l1_3_relative = 3400
_npc4_chiken_idle_l0_0_relative = 3574
_npc4_chiken_idle_l0_1_relative = 3684
_npc4_chiken_idle_l0_2_relative = 3794
_npc4_chiken_idle_l0_3_relative = 3956
_npc4_crow_idle0_0_relative = 4118
_npc4_crow_idle0_1_relative = 4212
_npc4_crow_idle0_2_relative = 4350
_npc4_crow_idle0_3_relative = 4488
_npc4_crow_idle1_0_relative = 4582
_npc4_crow_idle1_1_relative = 4676
_npc4_crow_idle1_2_relative = 4814
_npc4_crow_idle1_3_relative = 4952
_npc4_crow_run_r0_0_relative = 5046
_npc4_crow_run_r0_1_relative = 5156
_npc4_crow_run_r0_2_relative = 5318
_npc4_crow_run_r0_3_relative = 5480
_npc4_crow_run_r1_0_relative = 5642
_npc4_crow_run_r1_1_relative = 5720
_npc4_crow_run_r1_2_relative = 5834
_npc4_crow_run_r1_3_relative = 5948
_npc4_crow_run_r2_0_relative = 6062
_npc4_crow_run_r2_1_relative = 6140
_npc4_crow_run_r2_2_relative = 6254
_npc4_crow_run_r2_3_relative = 6368
_npc4_crow_run_l0_0_relative = 6482
_npc4_crow_run_l0_1_relative = 6592
_npc4_crow_run_l0_2_relative = 6754
_npc4_crow_run_l0_3_relative = 6916
_npc4_crow_run_l1_0_relative = 7078
_npc4_crow_run_l1_1_relative = 7156
_npc4_crow_run_l1_2_relative = 7270
_npc4_crow_run_l1_3_relative = 7384
_npc4_crow_run_l2_0_relative = 7498
_npc4_crow_run_l2_1_relative = 7576
_npc4_crow_run_l2_2_relative = 7690
_npc4_crow_run_l2_3_relative = 7804

npc4_get_scr_addr:
			.word sprite_get_scr_addr4
npc4_ram_disk_s_cmd:
			.byte TEMP_BYTE ; inited by sprite_init_meta_data
npc4_preshifted_sprites:
			.byte 4
npc4_anims:
			.word npc4_caterpillar_run_anim, npc4_chiken_idle_r_anim, npc4_chiken_idle_l_anim, npc4_chiken_run_r_anim, npc4_chiken_run_l_anim, npc4_crow_idle_anim, npc4_crow_run_r_anim, npc4_crow_run_l_anim, EOD
npc4_caterpillar_run_anim:
			.byte 9, 0 ; offset to the next frame
			.word _npc4_caterpillar_run0_0_relative, _npc4_caterpillar_run0_1_relative, _npc4_caterpillar_run0_2_relative, _npc4_caterpillar_run0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _npc4_caterpillar_run1_0_relative, _npc4_caterpillar_run1_1_relative, _npc4_caterpillar_run1_2_relative, _npc4_caterpillar_run1_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _npc4_caterpillar_run2_0_relative, _npc4_caterpillar_run2_1_relative, _npc4_caterpillar_run2_2_relative, _npc4_caterpillar_run2_3_relative, 
			.byte 225, $ff ; offset to the first frame
			.word _npc4_caterpillar_run1_0_relative, _npc4_caterpillar_run1_1_relative, _npc4_caterpillar_run1_2_relative, _npc4_caterpillar_run1_3_relative, 
npc4_chiken_idle_r_anim:
			.byte 9, 0 ; offset to the next frame
			.word _npc4_chiken_idle_r0_0_relative, _npc4_chiken_idle_r0_1_relative, _npc4_chiken_idle_r0_2_relative, _npc4_chiken_idle_r0_3_relative, 
			.byte 245, $ff ; offset to the first frame
			.word _npc4_chiken_run_r0_0_relative, _npc4_chiken_run_r0_1_relative, _npc4_chiken_run_r0_2_relative, _npc4_chiken_run_r0_3_relative, 
npc4_chiken_idle_l_anim:
			.byte 9, 0 ; offset to the next frame
			.word _npc4_chiken_idle_l0_0_relative, _npc4_chiken_idle_l0_1_relative, _npc4_chiken_idle_l0_2_relative, _npc4_chiken_idle_l0_3_relative, 
			.byte 245, $ff ; offset to the first frame
			.word _npc4_chiken_run_l0_0_relative, _npc4_chiken_run_l0_1_relative, _npc4_chiken_run_l0_2_relative, _npc4_chiken_run_l0_3_relative, 
npc4_chiken_run_r_anim:
			.byte 9, 0 ; offset to the next frame
			.word _npc4_chiken_run_r0_0_relative, _npc4_chiken_run_r0_1_relative, _npc4_chiken_run_r0_2_relative, _npc4_chiken_run_r0_3_relative, 
			.byte 245, $ff ; offset to the first frame
			.word _npc4_chiken_run_r1_0_relative, _npc4_chiken_run_r1_1_relative, _npc4_chiken_run_r1_2_relative, _npc4_chiken_run_r1_3_relative, 
npc4_chiken_run_l_anim:
			.byte 9, 0 ; offset to the next frame
			.word _npc4_chiken_run_l0_0_relative, _npc4_chiken_run_l0_1_relative, _npc4_chiken_run_l0_2_relative, _npc4_chiken_run_l0_3_relative, 
			.byte 245, $ff ; offset to the first frame
			.word _npc4_chiken_run_l1_0_relative, _npc4_chiken_run_l1_1_relative, _npc4_chiken_run_l1_2_relative, _npc4_chiken_run_l1_3_relative, 
npc4_crow_idle_anim:
			.byte 9, 0 ; offset to the next frame
			.word _npc4_crow_idle0_0_relative, _npc4_crow_idle0_1_relative, _npc4_crow_idle0_2_relative, _npc4_crow_idle0_3_relative, 
			.byte 245, $ff ; offset to the first frame
			.word _npc4_crow_idle1_0_relative, _npc4_crow_idle1_1_relative, _npc4_crow_idle1_2_relative, _npc4_crow_idle1_3_relative, 
npc4_crow_run_r_anim:
			.byte 9, 0 ; offset to the next frame
			.word _npc4_crow_run_r0_0_relative, _npc4_crow_run_r0_1_relative, _npc4_crow_run_r0_2_relative, _npc4_crow_run_r0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _npc4_crow_run_r1_0_relative, _npc4_crow_run_r1_1_relative, _npc4_crow_run_r1_2_relative, _npc4_crow_run_r1_3_relative, 
			.byte 235, $ff ; offset to the first frame
			.word _npc4_crow_run_r2_0_relative, _npc4_crow_run_r2_1_relative, _npc4_crow_run_r2_2_relative, _npc4_crow_run_r2_3_relative, 
npc4_crow_run_l_anim:
			.byte 9, 0 ; offset to the next frame
			.word _npc4_crow_run_l0_0_relative, _npc4_crow_run_l0_1_relative, _npc4_crow_run_l0_2_relative, _npc4_crow_run_l0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _npc4_crow_run_l1_0_relative, _npc4_crow_run_l1_1_relative, _npc4_crow_run_l1_2_relative, _npc4_crow_run_l1_3_relative, 
			.byte 235, $ff ; offset to the first frame
			.word _npc4_crow_run_l2_0_relative, _npc4_crow_run_l2_1_relative, _npc4_crow_run_l2_2_relative, _npc4_crow_run_l2_3_relative, 
npc4_anims_end:
npc4_anims_len: = npc4_anims_end - npc4_anims
