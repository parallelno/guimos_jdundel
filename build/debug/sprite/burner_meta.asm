; fdd bin file metadata
; asm data file: build/debug/sprite/burner_data.asm
; bin file: build/debug/bin/BURNER.BIN

BURNER_FILE_LEN = 9600
BURNER_LAST_RECORD_LEN = 0

BURNER_FILENAME_PTR:
			.byte "BURNER" ; filename
			.byte "  " ; filename white chars
			.byte "BIN" ; extension

; relative labels. to make it global call __text_ex_rd_init
_burner_dash_0_0 = 2
_burner_dash_0_1 = 176
_burner_dash_0_2 = 428
_burner_dash_0_3 = 680
_burner_dash_1_0 = 932
_burner_dash_1_1 = 1106
_burner_dash_1_2 = 1358
_burner_dash_1_3 = 1610
_burner_dash_2_0 = 1862
_burner_dash_2_1 = 2036
_burner_dash_2_2 = 2288
_burner_dash_2_3 = 2540
_burner_dash_3_0 = 2792
_burner_dash_3_1 = 2966
_burner_dash_3_2 = 3218
_burner_dash_3_3 = 3470
_burner_run_r0_0 = 3722
_burner_run_r0_1 = 3884
_burner_run_r0_2 = 4040
_burner_run_r0_3 = 4274
_burner_run_r1_0 = 4430
_burner_run_r1_1 = 4592
_burner_run_r1_2 = 4748
_burner_run_r1_3 = 4982
_burner_run_r2_0 = 5138
_burner_run_r2_1 = 5300
_burner_run_r2_2 = 5456
_burner_run_r2_3 = 5690
_burner_run_r3_0 = 5846
_burner_run_r3_1 = 6008
_burner_run_r3_2 = 6164
_burner_run_r3_3 = 6398
_burner_run_l0_0 = 6554
_burner_run_l0_1 = 6716
_burner_run_l0_2 = 6872
_burner_run_l0_3 = 7106
_burner_run_l1_0 = 7262
_burner_run_l1_1 = 7424
_burner_run_l1_2 = 7580
_burner_run_l1_3 = 7814
_burner_run_l2_0 = 7970
_burner_run_l2_1 = 8132
_burner_run_l2_2 = 8288
_burner_run_l2_3 = 8522
_burner_run_l3_0 = 8678
_burner_run_l3_1 = 8840
_burner_run_l3_2 = 8996
_burner_run_l3_3 = 9230

sprite_get_scr_addr_burner = sprite_get_scr_addr4

_burner_preshifted_sprites:
			.byte 4
_burner_anims:
			.word _burner_idle, _burner_run_r, _burner_run_l, _burner_dash, 0, 
_burner_idle:
			.byte 9, 0 ; offset to the next frame
			.word _burner_run_r0_0, _burner_run_r0_1, _burner_run_r0_2, _burner_run_r0_3, 
			.byte 9, 0 ; offset to the next frame
			.word _burner_run_r1_0, _burner_run_r1_1, _burner_run_r1_2, _burner_run_r1_3, 
			.byte 9, 0 ; offset to the next frame
			.word _burner_run_r2_0, _burner_run_r2_1, _burner_run_r2_2, _burner_run_r2_3, 
			.byte 9, 0 ; offset to the next frame
			.word _burner_run_r3_0, _burner_run_r3_1, _burner_run_r3_2, _burner_run_r3_3, 
			.byte 9, 0 ; offset to the next frame
			.word _burner_run_l0_0, _burner_run_l0_1, _burner_run_l0_2, _burner_run_l0_3, 
			.byte 9, 0 ; offset to the next frame
			.word _burner_run_l1_0, _burner_run_l1_1, _burner_run_l1_2, _burner_run_l1_3, 
			.byte 9, 0 ; offset to the next frame
			.word _burner_run_l2_0, _burner_run_l2_1, _burner_run_l2_2, _burner_run_l2_3, 
			.byte 185, $ff ; offset to the first frame
			.word _burner_run_l3_0, _burner_run_l3_1, _burner_run_l3_2, _burner_run_l3_3, 
_burner_run_r:
			.byte 9, 0 ; offset to the next frame
			.word _burner_run_r0_0, _burner_run_r0_1, _burner_run_r0_2, _burner_run_r0_3, 
			.byte 9, 0 ; offset to the next frame
			.word _burner_run_r1_0, _burner_run_r1_1, _burner_run_r1_2, _burner_run_r1_3, 
			.byte 9, 0 ; offset to the next frame
			.word _burner_run_r2_0, _burner_run_r2_1, _burner_run_r2_2, _burner_run_r2_3, 
			.byte 225, $ff ; offset to the first frame
			.word _burner_run_r3_0, _burner_run_r3_1, _burner_run_r3_2, _burner_run_r3_3, 
_burner_run_l:
			.byte 9, 0 ; offset to the next frame
			.word _burner_run_l0_0, _burner_run_l0_1, _burner_run_l0_2, _burner_run_l0_3, 
			.byte 9, 0 ; offset to the next frame
			.word _burner_run_l1_0, _burner_run_l1_1, _burner_run_l1_2, _burner_run_l1_3, 
			.byte 9, 0 ; offset to the next frame
			.word _burner_run_l2_0, _burner_run_l2_1, _burner_run_l2_2, _burner_run_l2_3, 
			.byte 225, $ff ; offset to the first frame
			.word _burner_run_l3_0, _burner_run_l3_1, _burner_run_l3_2, _burner_run_l3_3, 
_burner_dash:
			.byte 9, 0 ; offset to the next frame
			.word _burner_dash_0_0, _burner_dash_0_1, _burner_dash_0_2, _burner_dash_0_3, 
			.byte 9, 0 ; offset to the next frame
			.word _burner_dash_1_0, _burner_dash_1_1, _burner_dash_1_2, _burner_dash_1_3, 
			.byte 9, 0 ; offset to the next frame
			.word _burner_dash_2_0, _burner_dash_2_1, _burner_dash_2_2, _burner_dash_2_3, 
			.byte 225, $ff ; offset to the first frame
			.word _burner_dash_3_0, _burner_dash_3_1, _burner_dash_3_2, _burner_dash_3_3, 
