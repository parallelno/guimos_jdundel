; fdd bin file metadata
; asm data file: build/debug/sprite/npc4_data.asm
; bin file: build/debug/bin/NPC4.BIN

NPC4_FILE_LEN = 11466
NPC4_LAST_RECORD_LEN = 74

NPC4_FILENAME_PTR:
			.byte "NPC4" ; filename
			.byte "    " ; filename white chars
			.byte "BIN" ; extension

; relative frame labels
_npc4_caterpillar_run0_0_relative = 2
_npc4_caterpillar_run0_1_relative = 92
_npc4_caterpillar_run0_2_relative = 182
_npc4_caterpillar_run0_3_relative = 314
_npc4_caterpillar_run1_0_relative = 446
_npc4_caterpillar_run1_1_relative = 512
_npc4_caterpillar_run1_2_relative = 608
_npc4_caterpillar_run1_3_relative = 704
_npc4_chiken_run_r0_0_relative = 800
_npc4_chiken_run_r0_1_relative = 974
_npc4_chiken_run_r0_2_relative = 1148
_npc4_chiken_run_r0_3_relative = 1406
_npc4_chiken_run_r1_0_relative = 1664
_npc4_chiken_run_r1_1_relative = 1838
_npc4_chiken_run_r1_2_relative = 2012
_npc4_chiken_run_r1_3_relative = 2270
_npc4_chiken_idle_r0_0_relative = 2528
_npc4_chiken_idle_r0_1_relative = 2690
_npc4_chiken_idle_r0_2_relative = 2852
_npc4_chiken_idle_r0_3_relative = 3092
_npc4_chiken_run_l0_0_relative = 3332
_npc4_chiken_run_l0_1_relative = 3506
_npc4_chiken_run_l0_2_relative = 3680
_npc4_chiken_run_l0_3_relative = 3938
_npc4_chiken_run_l1_0_relative = 4196
_npc4_chiken_run_l1_1_relative = 4370
_npc4_chiken_run_l1_2_relative = 4544
_npc4_chiken_run_l1_3_relative = 4802
_npc4_chiken_idle_l0_0_relative = 5060
_npc4_chiken_idle_l0_1_relative = 5222
_npc4_chiken_idle_l0_2_relative = 5384
_npc4_chiken_idle_l0_3_relative = 5624
_npc4_crow_idle0_0_relative = 5864
_npc4_crow_idle0_1_relative = 6002
_npc4_crow_idle0_2_relative = 6206
_npc4_crow_idle0_3_relative = 6410
_npc4_crow_idle1_0_relative = 6548
_npc4_crow_idle1_1_relative = 6686
_npc4_crow_idle1_2_relative = 6890
_npc4_crow_idle1_3_relative = 7094
_npc4_crow_run_r0_0_relative = 7232
_npc4_crow_run_r0_1_relative = 7394
_npc4_crow_run_r0_2_relative = 7634
_npc4_crow_run_r0_3_relative = 7874
_npc4_crow_run_r1_0_relative = 8114
_npc4_crow_run_r1_1_relative = 8228
_npc4_crow_run_r1_2_relative = 8396
_npc4_crow_run_r1_3_relative = 8564
_npc4_crow_run_r2_0_relative = 8732
_npc4_crow_run_r2_1_relative = 8846
_npc4_crow_run_r2_2_relative = 9014
_npc4_crow_run_r2_3_relative = 9182
_npc4_crow_run_l0_0_relative = 9350
_npc4_crow_run_l0_1_relative = 9512
_npc4_crow_run_l0_2_relative = 9752
_npc4_crow_run_l0_3_relative = 9992
_npc4_crow_run_l1_0_relative = 10232
_npc4_crow_run_l1_1_relative = 10346
_npc4_crow_run_l1_2_relative = 10514
_npc4_crow_run_l1_3_relative = 10682
_npc4_crow_run_l2_0_relative = 10850
_npc4_crow_run_l2_1_relative = 10964
_npc4_crow_run_l2_2_relative = 11132
_npc4_crow_run_l2_3_relative = 11300

sprite_get_scr_addr_npc4 = sprite_get_scr_addr4

npc4_preshifted_sprites:
			.byte 4
npc4_anims:
			.word npc4_caterpillar_run_anim, npc4_chiken_idle_r_anim, npc4_chiken_idle_l_anim, npc4_chiken_run_r_anim, npc4_chiken_run_l_anim, npc4_crow_idle_anim, npc4_crow_run_r_anim, npc4_crow_run_l_anim, EOD
npc4_caterpillar_run_anim:
			.byte 9, 0 ; offset to the next frame
			.word _npc4_caterpillar_run0_0_relative, _npc4_caterpillar_run0_1_relative, _npc4_caterpillar_run0_2_relative, _npc4_caterpillar_run0_3_relative, 
			.byte 245, $ff ; offset to the first frame
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
