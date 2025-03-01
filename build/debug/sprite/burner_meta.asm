; fdd bin file metadata
; asm data file: build/debug/sprite/burner_data.asm
; bin file: build/debug/bin/BURNER.BIN

BURNER_FILE_LEN = 9030
BURNER_LAST_RECORD_LEN = 70

BURNER_FILENAME_PTR:
			.byte "BURNER" ; filename
			.byte "  " ; filename white chars
			.byte "BIN" ; extension

; relative frame labels
_burner_dash_0_0 = 2
_burner_dash_0_1 = 176
_burner_dash_0_2 = 350
_burner_dash_0_3 = 608
_burner_dash_1_0 = 866
_burner_dash_1_1 = 1040
_burner_dash_1_2 = 1214
_burner_dash_1_3 = 1472
_burner_dash_2_0 = 1730
_burner_dash_2_1 = 1904
_burner_dash_2_2 = 2078
_burner_dash_2_3 = 2336
_burner_dash_3_0 = 2594
_burner_dash_3_1 = 2768
_burner_dash_3_2 = 2942
_burner_dash_3_3 = 3200
_burner_run_r0_0 = 3458
_burner_run_r0_1 = 3620
_burner_run_r0_2 = 3782
_burner_run_r0_3 = 4022
_burner_run_r1_0 = 4184
_burner_run_r1_1 = 4346
_burner_run_r1_2 = 4508
_burner_run_r1_3 = 4748
_burner_run_r2_0 = 4910
_burner_run_r2_1 = 5072
_burner_run_r2_2 = 5234
_burner_run_r2_3 = 5474
_burner_run_r3_0 = 5636
_burner_run_r3_1 = 5798
_burner_run_r3_2 = 5960
_burner_run_r3_3 = 6200
_burner_run_l0_0 = 6362
_burner_run_l0_1 = 6524
_burner_run_l0_2 = 6686
_burner_run_l0_3 = 6848
_burner_run_l1_0 = 7010
_burner_run_l1_1 = 7172
_burner_run_l1_2 = 7334
_burner_run_l1_3 = 7496
_burner_run_l2_0 = 7658
_burner_run_l2_1 = 7820
_burner_run_l2_2 = 7982
_burner_run_l2_3 = 8222
_burner_run_l3_0 = 8384
_burner_run_l3_1 = 8546
_burner_run_l3_2 = 8708
_burner_run_l3_3 = 8870

sprite_get_scr_addr_burner = sprite_get_scr_addr4

_burner_preshifted_sprites:
			.byte 4
_burner_anims:
			.word _burner_idle, _burner_run_r, _burner_run_l, _burner_dash, EOD
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
