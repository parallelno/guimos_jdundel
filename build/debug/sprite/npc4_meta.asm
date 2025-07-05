; fdd bin file metadata
; asm data file: build/debug/sprite/npc4_data.asm
; bin file: build/debug/bin/NPC4.BIN

NPC4_FILE_LEN = 7464
NPC4_LAST_RECORD_LEN = 40

NPC4_FILENAME_PTR:
			.byte "NPC4" ; filename
			.byte "    " ; filename white chars
			.byte "BIN" ; extension

; relative frame labels
_npc4_caterpillar_run0_0_relative = 2
_npc4_caterpillar_run0_1_relative = 36
_npc4_caterpillar_run0_2_relative = 70
_npc4_caterpillar_run0_3_relative = 104
_npc4_caterpillar_run1_0_relative = 138
_npc4_caterpillar_run1_1_relative = 164
_npc4_caterpillar_run1_2_relative = 190
_npc4_caterpillar_run1_3_relative = 216
_npc4_chiken_run_r0_0_relative = 242
_npc4_chiken_run_r0_1_relative = 360
_npc4_chiken_run_r0_2_relative = 478
_npc4_chiken_run_r0_3_relative = 652
_npc4_chiken_run_r1_0_relative = 826
_npc4_chiken_run_r1_1_relative = 944
_npc4_chiken_run_r1_2_relative = 1062
_npc4_chiken_run_r1_3_relative = 1236
_npc4_chiken_idle_r0_0_relative = 1410
_npc4_chiken_idle_r0_1_relative = 1520
_npc4_chiken_idle_r0_2_relative = 1630
_npc4_chiken_idle_r0_3_relative = 1792
_npc4_chiken_run_l0_0_relative = 1954
_npc4_chiken_run_l0_1_relative = 2072
_npc4_chiken_run_l0_2_relative = 2190
_npc4_chiken_run_l0_3_relative = 2364
_npc4_chiken_run_l1_0_relative = 2538
_npc4_chiken_run_l1_1_relative = 2656
_npc4_chiken_run_l1_2_relative = 2774
_npc4_chiken_run_l1_3_relative = 2948
_npc4_chiken_idle_l0_0_relative = 3122
_npc4_chiken_idle_l0_1_relative = 3232
_npc4_chiken_idle_l0_2_relative = 3342
_npc4_chiken_idle_l0_3_relative = 3504
_npc4_crow_idle0_0_relative = 3666
_npc4_crow_idle0_1_relative = 3760
_npc4_crow_idle0_2_relative = 3898
_npc4_crow_idle0_3_relative = 4036
_npc4_crow_idle1_0_relative = 4130
_npc4_crow_idle1_1_relative = 4224
_npc4_crow_idle1_2_relative = 4362
_npc4_crow_idle1_3_relative = 4500
_npc4_crow_run_r0_0_relative = 4594
_npc4_crow_run_r0_1_relative = 4704
_npc4_crow_run_r0_2_relative = 4866
_npc4_crow_run_r0_3_relative = 5028
_npc4_crow_run_r1_0_relative = 5190
_npc4_crow_run_r1_1_relative = 5268
_npc4_crow_run_r1_2_relative = 5382
_npc4_crow_run_r1_3_relative = 5496
_npc4_crow_run_r2_0_relative = 5610
_npc4_crow_run_r2_1_relative = 5688
_npc4_crow_run_r2_2_relative = 5802
_npc4_crow_run_r2_3_relative = 5916
_npc4_crow_run_l0_0_relative = 6030
_npc4_crow_run_l0_1_relative = 6140
_npc4_crow_run_l0_2_relative = 6302
_npc4_crow_run_l0_3_relative = 6464
_npc4_crow_run_l1_0_relative = 6626
_npc4_crow_run_l1_1_relative = 6704
_npc4_crow_run_l1_2_relative = 6818
_npc4_crow_run_l1_3_relative = 6932
_npc4_crow_run_l2_0_relative = 7046
_npc4_crow_run_l2_1_relative = 7124
_npc4_crow_run_l2_2_relative = 7238
_npc4_crow_run_l2_3_relative = 7352

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
