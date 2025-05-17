; fdd bin file metadata
; asm data file: build/debug/sprite/cat_data.asm
; bin file: build/debug/bin/CAT.BIN

CAT_FILE_LEN = 9810
CAT_LAST_RECORD_LEN = 82

CAT_FILENAME_PTR:
			.byte "CAT" ; filename
			.byte "     " ; filename white chars
			.byte "BIN" ; extension

; relative frame labels
_cat_idle0_0_relative = 2
_cat_idle0_1_relative = 164
_cat_idle0_2_relative = 326
_cat_idle0_3_relative = 566
_cat_idle1_0_relative = 806
_cat_idle1_1_relative = 968
_cat_idle1_2_relative = 1130
_cat_idle1_3_relative = 1370
_cat_idle2_0_relative = 1610
_cat_idle2_1_relative = 1772
_cat_idle2_2_relative = 2012
_cat_idle2_3_relative = 2252
_cat_run_r0_0_relative = 2492
_cat_run_r0_1_relative = 2666
_cat_run_r0_2_relative = 2924
_cat_run_r0_3_relative = 3182
_cat_run_r1_0_relative = 3440
_cat_run_r1_1_relative = 3602
_cat_run_r1_2_relative = 3842
_cat_run_r1_3_relative = 4082
_cat_run_r2_0_relative = 4322
_cat_run_r2_1_relative = 4496
_cat_run_r2_2_relative = 4754
_cat_run_r2_3_relative = 5012
_cat_run_r3_0_relative = 5270
_cat_run_r3_1_relative = 5432
_cat_run_r3_2_relative = 5672
_cat_run_r3_3_relative = 5912
_cat_run_l0_0_relative = 6152
_cat_run_l0_1_relative = 6326
_cat_run_l0_2_relative = 6584
_cat_run_l0_3_relative = 6842
_cat_run_l1_0_relative = 7100
_cat_run_l1_1_relative = 7262
_cat_run_l1_2_relative = 7502
_cat_run_l1_3_relative = 7742
_cat_run_l2_0_relative = 7982
_cat_run_l2_1_relative = 8156
_cat_run_l2_2_relative = 8414
_cat_run_l2_3_relative = 8672
_cat_run_l3_0_relative = 8930
_cat_run_l3_1_relative = 9092
_cat_run_l3_2_relative = 9332
_cat_run_l3_3_relative = 9572

sprite_get_scr_addr_cat = sprite_get_scr_addr4

cat_preshifted_sprites:
			.byte 4
cat_anims:
			.word cat_idle_anim, cat_run_r_anim, cat_run_l_anim, EOD
cat_idle_anim:
			.byte 9, 0 ; offset to the next frame
			.word _cat_idle0_0_relative, _cat_idle0_1_relative, _cat_idle0_2_relative, _cat_idle0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _cat_idle1_0_relative, _cat_idle1_1_relative, _cat_idle1_2_relative, _cat_idle1_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _cat_idle0_0_relative, _cat_idle0_1_relative, _cat_idle0_2_relative, _cat_idle0_3_relative, 
			.byte 225, $ff ; offset to the first frame
			.word _cat_idle2_0_relative, _cat_idle2_1_relative, _cat_idle2_2_relative, _cat_idle2_3_relative, 
cat_run_r_anim:
			.byte 9, 0 ; offset to the next frame
			.word _cat_run_r0_0_relative, _cat_run_r0_1_relative, _cat_run_r0_2_relative, _cat_run_r0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _cat_run_r1_0_relative, _cat_run_r1_1_relative, _cat_run_r1_2_relative, _cat_run_r1_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _cat_run_r2_0_relative, _cat_run_r2_1_relative, _cat_run_r2_2_relative, _cat_run_r2_3_relative, 
			.byte 225, $ff ; offset to the first frame
			.word _cat_run_r3_0_relative, _cat_run_r3_1_relative, _cat_run_r3_2_relative, _cat_run_r3_3_relative, 
cat_run_l_anim:
			.byte 9, 0 ; offset to the next frame
			.word _cat_run_l0_0_relative, _cat_run_l0_1_relative, _cat_run_l0_2_relative, _cat_run_l0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _cat_run_l1_0_relative, _cat_run_l1_1_relative, _cat_run_l1_2_relative, _cat_run_l1_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _cat_run_l2_0_relative, _cat_run_l2_1_relative, _cat_run_l2_2_relative, _cat_run_l2_3_relative, 
			.byte 225, $ff ; offset to the first frame
			.word _cat_run_l3_0_relative, _cat_run_l3_1_relative, _cat_run_l3_2_relative, _cat_run_l3_3_relative, 
cat_anims_end:
cat_anims_len: = cat_anims_end - cat_anims
