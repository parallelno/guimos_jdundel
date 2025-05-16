; fdd bin file metadata
; asm data file: build/debug/sprite/npc4_data.asm
; bin file: build/debug/bin/NPC4.BIN

NPC4_FILE_LEN = 8808
NPC4_LAST_RECORD_LEN = 104

NPC4_FILENAME_PTR:
			.byte "NPC4" ; filename
			.byte "    " ; filename white chars
			.byte "BIN" ; extension

; relative frame labels
_npc4_goose_idle_0_0_relative = 2
_npc4_goose_idle_0_1_relative = 176
_npc4_goose_idle_0_2_relative = 350
_npc4_goose_idle_0_3_relative = 524
_npc4_goose_idle_1_0_relative = 782
_npc4_goose_idle_1_1_relative = 956
_npc4_goose_idle_1_2_relative = 1214
_npc4_goose_idle_1_3_relative = 1472
_npc4_goose_run_r0_0_relative = 1730
_npc4_goose_run_r0_1_relative = 1904
_npc4_goose_run_r0_2_relative = 2162
_npc4_goose_run_r0_3_relative = 2420
_npc4_goose_run_r1_0_relative = 2678
_npc4_goose_run_r1_1_relative = 2852
_npc4_goose_run_r1_2_relative = 3110
_npc4_goose_run_r1_3_relative = 3368
_npc4_goose_run_l0_0_relative = 3626
_npc4_goose_run_l0_1_relative = 3800
_npc4_goose_run_l0_2_relative = 4058
_npc4_goose_run_l0_3_relative = 4316
_npc4_goose_run_l1_0_relative = 4574
_npc4_goose_run_l1_1_relative = 4748
_npc4_goose_run_l1_2_relative = 5006
_npc4_goose_run_l1_3_relative = 5264
_npc4_caterpillar_run_0_0_relative = 5522
_npc4_caterpillar_run_0_1_relative = 5612
_npc4_caterpillar_run_0_2_relative = 5702
_npc4_caterpillar_run_0_3_relative = 5834
_npc4_caterpillar_run_1_0_relative = 5966
_npc4_caterpillar_run_1_1_relative = 6032
_npc4_caterpillar_run_1_2_relative = 6128
_npc4_caterpillar_run_1_3_relative = 6224
_npc4_cat_idle_0_0_relative = 6320
_npc4_cat_idle_0_1_relative = 6482
_npc4_cat_idle_0_2_relative = 6644
_npc4_cat_idle_0_3_relative = 6884
_npc4_cat_idle_1_0_relative = 7124
_npc4_cat_idle_1_1_relative = 7286
_npc4_cat_idle_1_2_relative = 7448
_npc4_cat_idle_1_3_relative = 7688
_npc4_cat_idle_2_0_relative = 7928
_npc4_cat_idle_2_1_relative = 8090
_npc4_cat_idle_2_2_relative = 8330
_npc4_cat_idle_2_3_relative = 8570

sprite_get_scr_addr_npc4 = sprite_get_scr_addr4

npc4_preshifted_sprites:
			.byte 4
npc4_anims:
			.word npc4_goose_idle_anim, npc4_goose_run_r_anim, npc4_goose_run_l_anim, npc4_caterpillar_run_anim, npc4_cat_idle_anim, npc4_cat_run_r_anim, npc4_cat_run_l_anim, EOD
npc4_goose_idle_anim:
			.byte 9, 0 ; offset to the next frame
			.word _npc4_goose_idle_0_0_relative, _npc4_goose_idle_0_1_relative, _npc4_goose_idle_0_2_relative, _npc4_goose_idle_0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _npc4_goose_idle_0_0_relative, _npc4_goose_idle_0_1_relative, _npc4_goose_idle_0_2_relative, _npc4_goose_idle_0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _npc4_goose_idle_1_0_relative, _npc4_goose_idle_1_1_relative, _npc4_goose_idle_1_2_relative, _npc4_goose_idle_1_3_relative, 
			.byte 225, $ff ; offset to the first frame
			.word _npc4_goose_idle_1_0_relative, _npc4_goose_idle_1_1_relative, _npc4_goose_idle_1_2_relative, _npc4_goose_idle_1_3_relative, 
npc4_goose_run_r_anim:
			.byte 9, 0 ; offset to the next frame
			.word _npc4_goose_run_r0_0_relative, _npc4_goose_run_r0_1_relative, _npc4_goose_run_r0_2_relative, _npc4_goose_run_r0_3_relative, 
			.byte 245, $ff ; offset to the first frame
			.word _npc4_goose_run_r1_0_relative, _npc4_goose_run_r1_1_relative, _npc4_goose_run_r1_2_relative, _npc4_goose_run_r1_3_relative, 
npc4_goose_run_l_anim:
			.byte 9, 0 ; offset to the next frame
			.word _npc4_goose_run_l0_0_relative, _npc4_goose_run_l0_1_relative, _npc4_goose_run_l0_2_relative, _npc4_goose_run_l0_3_relative, 
			.byte 245, $ff ; offset to the first frame
			.word _npc4_goose_run_l1_0_relative, _npc4_goose_run_l1_1_relative, _npc4_goose_run_l1_2_relative, _npc4_goose_run_l1_3_relative, 
npc4_caterpillar_run_anim:
			.byte 9, 0 ; offset to the next frame
			.word _npc4_caterpillar_run_0_0_relative, _npc4_caterpillar_run_0_1_relative, _npc4_caterpillar_run_0_2_relative, _npc4_caterpillar_run_0_3_relative, 
			.byte 245, $ff ; offset to the first frame
			.word _npc4_caterpillar_run_1_0_relative, _npc4_caterpillar_run_1_1_relative, _npc4_caterpillar_run_1_2_relative, _npc4_caterpillar_run_1_3_relative, 
npc4_cat_idle_anim:
			.byte 9, 0 ; offset to the next frame
			.word _npc4_cat_idle_0_0_relative, _npc4_cat_idle_0_1_relative, _npc4_cat_idle_0_2_relative, _npc4_cat_idle_0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _npc4_cat_idle_1_0_relative, _npc4_cat_idle_1_1_relative, _npc4_cat_idle_1_2_relative, _npc4_cat_idle_1_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _npc4_cat_idle_0_0_relative, _npc4_cat_idle_0_1_relative, _npc4_cat_idle_0_2_relative, _npc4_cat_idle_0_3_relative, 
			.byte 225, $ff ; offset to the first frame
			.word _npc4_cat_idle_2_0_relative, _npc4_cat_idle_2_1_relative, _npc4_cat_idle_2_2_relative, _npc4_cat_idle_2_3_relative, 
npc4_cat_run_r_anim:
			.byte 9, 0 ; offset to the next frame
			.word _npc4_cat_idle_0_0_relative, _npc4_cat_idle_0_1_relative, _npc4_cat_idle_0_2_relative, _npc4_cat_idle_0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _npc4_cat_idle_1_0_relative, _npc4_cat_idle_1_1_relative, _npc4_cat_idle_1_2_relative, _npc4_cat_idle_1_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _npc4_cat_idle_0_0_relative, _npc4_cat_idle_0_1_relative, _npc4_cat_idle_0_2_relative, _npc4_cat_idle_0_3_relative, 
			.byte 225, $ff ; offset to the first frame
			.word _npc4_cat_idle_2_0_relative, _npc4_cat_idle_2_1_relative, _npc4_cat_idle_2_2_relative, _npc4_cat_idle_2_3_relative, 
npc4_cat_run_l_anim:
			.byte 9, 0 ; offset to the next frame
			.word _npc4_cat_idle_0_0_relative, _npc4_cat_idle_0_1_relative, _npc4_cat_idle_0_2_relative, _npc4_cat_idle_0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _npc4_cat_idle_1_0_relative, _npc4_cat_idle_1_1_relative, _npc4_cat_idle_1_2_relative, _npc4_cat_idle_1_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _npc4_cat_idle_0_0_relative, _npc4_cat_idle_0_1_relative, _npc4_cat_idle_0_2_relative, _npc4_cat_idle_0_3_relative, 
			.byte 225, $ff ; offset to the first frame
			.word _npc4_cat_idle_2_0_relative, _npc4_cat_idle_2_1_relative, _npc4_cat_idle_2_2_relative, _npc4_cat_idle_2_3_relative, 
npc4_anims_end:
npc4_anims_len: = npc4_anims_end - npc4_anims
