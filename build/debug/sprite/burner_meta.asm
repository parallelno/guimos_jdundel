; fdd bin file metadata
; asm data file: build/debug/sprite/burner_data.asm
; bin file: build/debug/bin/BURNER.BIN

BURNER_FILE_LEN = 6116
BURNER_LAST_RECORD_LEN = 100

BURNER_FILENAME_PTR:
			.byte "BURNER" ; filename
			.byte "  " ; filename white chars
			.byte "BIN" ; extension

; relative frame labels
_burner_dash_0_0_relative = 2
_burner_dash_0_1_relative = 120
_burner_dash_0_2_relative = 238
_burner_dash_0_3_relative = 412
_burner_dash_1_0_relative = 586
_burner_dash_1_1_relative = 704
_burner_dash_1_2_relative = 822
_burner_dash_1_3_relative = 996
_burner_dash_2_0_relative = 1170
_burner_dash_2_1_relative = 1288
_burner_dash_2_2_relative = 1406
_burner_dash_2_3_relative = 1580
_burner_dash_3_0_relative = 1754
_burner_dash_3_1_relative = 1872
_burner_dash_3_2_relative = 1990
_burner_dash_3_3_relative = 2164
_burner_run_r0_0_relative = 2338
_burner_run_r0_1_relative = 2448
_burner_run_r0_2_relative = 2558
_burner_run_r0_3_relative = 2720
_burner_run_r1_0_relative = 2830
_burner_run_r1_1_relative = 2940
_burner_run_r1_2_relative = 3050
_burner_run_r1_3_relative = 3212
_burner_run_r2_0_relative = 3322
_burner_run_r2_1_relative = 3432
_burner_run_r2_2_relative = 3542
_burner_run_r2_3_relative = 3704
_burner_run_r3_0_relative = 3814
_burner_run_r3_1_relative = 3924
_burner_run_r3_2_relative = 4034
_burner_run_r3_3_relative = 4196
_burner_run_l0_0_relative = 4306
_burner_run_l0_1_relative = 4416
_burner_run_l0_2_relative = 4526
_burner_run_l0_3_relative = 4636
_burner_run_l1_0_relative = 4746
_burner_run_l1_1_relative = 4856
_burner_run_l1_2_relative = 4966
_burner_run_l1_3_relative = 5076
_burner_run_l2_0_relative = 5186
_burner_run_l2_1_relative = 5296
_burner_run_l2_2_relative = 5406
_burner_run_l2_3_relative = 5568
_burner_run_l3_0_relative = 5678
_burner_run_l3_1_relative = 5788
_burner_run_l3_2_relative = 5898
_burner_run_l3_3_relative = 6008

burner_get_scr_addr:
			.word sprite_get_scr_addr4
burner_ram_disk_s_cmd:
			.byte TEMP_BYTE ; inited by sprite_init_meta_data
burner_preshifted_sprites:
			.byte 4
burner_anims:
			.word burner_idle_anim, burner_run_r_anim, burner_run_l_anim, burner_dash_anim, EOD
burner_idle_anim:
			.byte 9, 0 ; offset to the next frame
			.word _burner_run_r0_0_relative, _burner_run_r0_1_relative, _burner_run_r0_2_relative, _burner_run_r0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _burner_run_r1_0_relative, _burner_run_r1_1_relative, _burner_run_r1_2_relative, _burner_run_r1_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _burner_run_r2_0_relative, _burner_run_r2_1_relative, _burner_run_r2_2_relative, _burner_run_r2_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _burner_run_r3_0_relative, _burner_run_r3_1_relative, _burner_run_r3_2_relative, _burner_run_r3_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _burner_run_l0_0_relative, _burner_run_l0_1_relative, _burner_run_l0_2_relative, _burner_run_l0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _burner_run_l1_0_relative, _burner_run_l1_1_relative, _burner_run_l1_2_relative, _burner_run_l1_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _burner_run_l2_0_relative, _burner_run_l2_1_relative, _burner_run_l2_2_relative, _burner_run_l2_3_relative, 
			.byte 185, $ff ; offset to the first frame
			.word _burner_run_l3_0_relative, _burner_run_l3_1_relative, _burner_run_l3_2_relative, _burner_run_l3_3_relative, 
burner_run_r_anim:
			.byte 9, 0 ; offset to the next frame
			.word _burner_run_r0_0_relative, _burner_run_r0_1_relative, _burner_run_r0_2_relative, _burner_run_r0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _burner_run_r1_0_relative, _burner_run_r1_1_relative, _burner_run_r1_2_relative, _burner_run_r1_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _burner_run_r2_0_relative, _burner_run_r2_1_relative, _burner_run_r2_2_relative, _burner_run_r2_3_relative, 
			.byte 225, $ff ; offset to the first frame
			.word _burner_run_r3_0_relative, _burner_run_r3_1_relative, _burner_run_r3_2_relative, _burner_run_r3_3_relative, 
burner_run_l_anim:
			.byte 9, 0 ; offset to the next frame
			.word _burner_run_l0_0_relative, _burner_run_l0_1_relative, _burner_run_l0_2_relative, _burner_run_l0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _burner_run_l1_0_relative, _burner_run_l1_1_relative, _burner_run_l1_2_relative, _burner_run_l1_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _burner_run_l2_0_relative, _burner_run_l2_1_relative, _burner_run_l2_2_relative, _burner_run_l2_3_relative, 
			.byte 225, $ff ; offset to the first frame
			.word _burner_run_l3_0_relative, _burner_run_l3_1_relative, _burner_run_l3_2_relative, _burner_run_l3_3_relative, 
burner_dash_anim:
			.byte 9, 0 ; offset to the next frame
			.word _burner_dash_0_0_relative, _burner_dash_0_1_relative, _burner_dash_0_2_relative, _burner_dash_0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _burner_dash_1_0_relative, _burner_dash_1_1_relative, _burner_dash_1_2_relative, _burner_dash_1_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _burner_dash_2_0_relative, _burner_dash_2_1_relative, _burner_dash_2_2_relative, _burner_dash_2_3_relative, 
			.byte 225, $ff ; offset to the first frame
			.word _burner_dash_3_0_relative, _burner_dash_3_1_relative, _burner_dash_3_2_relative, _burner_dash_3_3_relative, 
burner_anims_end:
burner_anims_len: = burner_anims_end - burner_anims
