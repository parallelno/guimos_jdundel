; fdd bin file metadata
; asm data file: build/debug/sprite/npc4_data.asm
; bin file: build/debug/bin/NPC4.BIN

NPC4_FILE_LEN = 6054
NPC4_LAST_RECORD_LEN = 38

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
_npc4_goose_run_r0_1_relative = 1892
_npc4_goose_run_r0_2_relative = 2132
_npc4_goose_run_r0_3_relative = 2372
_npc4_goose_run_r1_0_relative = 2612
_npc4_goose_run_r1_1_relative = 2774
_npc4_goose_run_r1_2_relative = 3014
_npc4_goose_run_r1_3_relative = 3254
_npc4_goose_run_l0_0_relative = 3494
_npc4_goose_run_l0_1_relative = 3656
_npc4_goose_run_l0_2_relative = 3896
_npc4_goose_run_l0_3_relative = 4136
_npc4_goose_run_l1_0_relative = 4376
_npc4_goose_run_l1_1_relative = 4538
_npc4_goose_run_l1_2_relative = 4778
_npc4_goose_run_l1_3_relative = 5018
_npc4_caterpillar_run_0_0_relative = 5258
_npc4_caterpillar_run_0_1_relative = 5348
_npc4_caterpillar_run_0_2_relative = 5438
_npc4_caterpillar_run_0_3_relative = 5570
_npc4_caterpillar_run_1_0_relative = 5702
_npc4_caterpillar_run_1_1_relative = 5768
_npc4_caterpillar_run_1_2_relative = 5864
_npc4_caterpillar_run_1_3_relative = 5960

sprite_get_scr_addr_npc4 = sprite_get_scr_addr4

npc4_preshifted_sprites:
			.byte 4
npc4_anims:
			.word npc4_goose_idle_anim, npc4_goose_run_r_anim, npc4_goose_run_l_anim, npc4_caterpillar_idle_anim, npc4_caterpillar_run_anim, EOD
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
npc4_caterpillar_idle_anim:
			.byte 255, $ff ; offset to the first frame
			.word _npc4_caterpillar_run_1_0_relative, _npc4_caterpillar_run_1_1_relative, _npc4_caterpillar_run_1_2_relative, _npc4_caterpillar_run_1_3_relative, 
npc4_caterpillar_run_anim:
			.byte 9, 0 ; offset to the next frame
			.word _npc4_caterpillar_run_0_0_relative, _npc4_caterpillar_run_0_1_relative, _npc4_caterpillar_run_0_2_relative, _npc4_caterpillar_run_0_3_relative, 
			.byte 245, $ff ; offset to the first frame
			.word _npc4_caterpillar_run_1_0_relative, _npc4_caterpillar_run_1_1_relative, _npc4_caterpillar_run_1_2_relative, _npc4_caterpillar_run_1_3_relative, 
npc4_anims_end:
npc4_anims_len: = npc4_anims_end - npc4_anims
