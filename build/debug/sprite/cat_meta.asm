; fdd bin file metadata
; asm data file: build/debug/sprite/cat_data.asm
; bin file: build/debug/bin/CAT.BIN

CAT_FILE_LEN = 6628
CAT_LAST_RECORD_LEN = 100

CAT_FILENAME_PTR:
			.byte "CAT" ; filename
			.byte "     " ; filename white chars
			.byte "BIN" ; extension

; relative frame labels
_cat_idle0_0_relative = 2
_cat_idle0_1_relative = 112
_cat_idle0_2_relative = 222
_cat_idle0_3_relative = 384
_cat_idle1_0_relative = 546
_cat_idle1_1_relative = 656
_cat_idle1_2_relative = 766
_cat_idle1_3_relative = 928
_cat_idle2_0_relative = 1090
_cat_idle2_1_relative = 1200
_cat_idle2_2_relative = 1362
_cat_idle2_3_relative = 1524
_cat_run_r0_0_relative = 1686
_cat_run_r0_1_relative = 1804
_cat_run_r0_2_relative = 1978
_cat_run_r0_3_relative = 2152
_cat_run_r1_0_relative = 2326
_cat_run_r1_1_relative = 2436
_cat_run_r1_2_relative = 2598
_cat_run_r1_3_relative = 2760
_cat_run_r2_0_relative = 2922
_cat_run_r2_1_relative = 3040
_cat_run_r2_2_relative = 3214
_cat_run_r2_3_relative = 3388
_cat_run_r3_0_relative = 3562
_cat_run_r3_1_relative = 3672
_cat_run_r3_2_relative = 3834
_cat_run_r3_3_relative = 3996
_cat_run_l0_0_relative = 4158
_cat_run_l0_1_relative = 4276
_cat_run_l0_2_relative = 4450
_cat_run_l0_3_relative = 4624
_cat_run_l1_0_relative = 4798
_cat_run_l1_1_relative = 4908
_cat_run_l1_2_relative = 5070
_cat_run_l1_3_relative = 5232
_cat_run_l2_0_relative = 5394
_cat_run_l2_1_relative = 5512
_cat_run_l2_2_relative = 5686
_cat_run_l2_3_relative = 5860
_cat_run_l3_0_relative = 6034
_cat_run_l3_1_relative = 6144
_cat_run_l3_2_relative = 6306
_cat_run_l3_3_relative = 6468

cat_get_scr_addr:
			.word sprite_get_scr_addr4
cat_ram_disk_s_cmd:
			.byte TEMP_BYTE ; inited by sprite_init_meta_data
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
