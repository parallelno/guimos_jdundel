; fdd bin file metadata
; asm data file: build/debug/sprite/npc4_data.asm
; bin file: build/debug/bin/NPC4.BIN

NPC4_FILE_LEN = 11004
NPC4_LAST_RECORD_LEN = 124

NPC4_FILENAME_PTR:
			.byte "NPC4" ; filename
			.byte "    " ; filename white chars
			.byte "BIN" ; extension

; relative frame labels
_npc4_caterpillar_run0_0_relative = 2
_npc4_caterpillar_run0_1_relative = 50
_npc4_caterpillar_run0_2_relative = 98
_npc4_caterpillar_run0_3_relative = 146
_npc4_caterpillar_run1_0_relative = 194
_npc4_caterpillar_run1_1_relative = 230
_npc4_caterpillar_run1_2_relative = 266
_npc4_caterpillar_run1_3_relative = 302
_npc4_chiken_run_r0_0_relative = 338
_npc4_chiken_run_r0_1_relative = 512
_npc4_chiken_run_r0_2_relative = 686
_npc4_chiken_run_r0_3_relative = 944
_npc4_chiken_run_r1_0_relative = 1202
_npc4_chiken_run_r1_1_relative = 1376
_npc4_chiken_run_r1_2_relative = 1550
_npc4_chiken_run_r1_3_relative = 1808
_npc4_chiken_idle_r0_0_relative = 2066
_npc4_chiken_idle_r0_1_relative = 2228
_npc4_chiken_idle_r0_2_relative = 2390
_npc4_chiken_idle_r0_3_relative = 2630
_npc4_chiken_run_l0_0_relative = 2870
_npc4_chiken_run_l0_1_relative = 3044
_npc4_chiken_run_l0_2_relative = 3218
_npc4_chiken_run_l0_3_relative = 3476
_npc4_chiken_run_l1_0_relative = 3734
_npc4_chiken_run_l1_1_relative = 3908
_npc4_chiken_run_l1_2_relative = 4082
_npc4_chiken_run_l1_3_relative = 4340
_npc4_chiken_idle_l0_0_relative = 4598
_npc4_chiken_idle_l0_1_relative = 4760
_npc4_chiken_idle_l0_2_relative = 4922
_npc4_chiken_idle_l0_3_relative = 5162
_npc4_crow_idle0_0_relative = 5402
_npc4_crow_idle0_1_relative = 5540
_npc4_crow_idle0_2_relative = 5744
_npc4_crow_idle0_3_relative = 5948
_npc4_crow_idle1_0_relative = 6086
_npc4_crow_idle1_1_relative = 6224
_npc4_crow_idle1_2_relative = 6428
_npc4_crow_idle1_3_relative = 6632
_npc4_crow_run_r0_0_relative = 6770
_npc4_crow_run_r0_1_relative = 6932
_npc4_crow_run_r0_2_relative = 7172
_npc4_crow_run_r0_3_relative = 7412
_npc4_crow_run_r1_0_relative = 7652
_npc4_crow_run_r1_1_relative = 7766
_npc4_crow_run_r1_2_relative = 7934
_npc4_crow_run_r1_3_relative = 8102
_npc4_crow_run_r2_0_relative = 8270
_npc4_crow_run_r2_1_relative = 8384
_npc4_crow_run_r2_2_relative = 8552
_npc4_crow_run_r2_3_relative = 8720
_npc4_crow_run_l0_0_relative = 8888
_npc4_crow_run_l0_1_relative = 9050
_npc4_crow_run_l0_2_relative = 9290
_npc4_crow_run_l0_3_relative = 9530
_npc4_crow_run_l1_0_relative = 9770
_npc4_crow_run_l1_1_relative = 9884
_npc4_crow_run_l1_2_relative = 10052
_npc4_crow_run_l1_3_relative = 10220
_npc4_crow_run_l2_0_relative = 10388
_npc4_crow_run_l2_1_relative = 10502
_npc4_crow_run_l2_2_relative = 10670
_npc4_crow_run_l2_3_relative = 10838

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
