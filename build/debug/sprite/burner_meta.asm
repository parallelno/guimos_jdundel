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
_burner_dash_0_0_relative = 2
_burner_dash_0_1_relative = 176
_burner_dash_0_2_relative = 350
_burner_dash_0_3_relative = 608
_burner_dash_1_0_relative = 866
_burner_dash_1_1_relative = 1040
_burner_dash_1_2_relative = 1214
_burner_dash_1_3_relative = 1472
_burner_dash_2_0_relative = 1730
_burner_dash_2_1_relative = 1904
_burner_dash_2_2_relative = 2078
_burner_dash_2_3_relative = 2336
_burner_dash_3_0_relative = 2594
_burner_dash_3_1_relative = 2768
_burner_dash_3_2_relative = 2942
_burner_dash_3_3_relative = 3200
_burner_run_r0_0_relative = 3458
_burner_run_r0_1_relative = 3620
_burner_run_r0_2_relative = 3782
_burner_run_r0_3_relative = 4022
_burner_run_r1_0_relative = 4184
_burner_run_r1_1_relative = 4346
_burner_run_r1_2_relative = 4508
_burner_run_r1_3_relative = 4748
_burner_run_r2_0_relative = 4910
_burner_run_r2_1_relative = 5072
_burner_run_r2_2_relative = 5234
_burner_run_r2_3_relative = 5474
_burner_run_r3_0_relative = 5636
_burner_run_r3_1_relative = 5798
_burner_run_r3_2_relative = 5960
_burner_run_r3_3_relative = 6200
_burner_run_l0_0_relative = 6362
_burner_run_l0_1_relative = 6524
_burner_run_l0_2_relative = 6686
_burner_run_l0_3_relative = 6848
_burner_run_l1_0_relative = 7010
_burner_run_l1_1_relative = 7172
_burner_run_l1_2_relative = 7334
_burner_run_l1_3_relative = 7496
_burner_run_l2_0_relative = 7658
_burner_run_l2_1_relative = 7820
_burner_run_l2_2_relative = 7982
_burner_run_l2_3_relative = 8222
_burner_run_l3_0_relative = 8384
_burner_run_l3_1_relative = 8546
_burner_run_l3_2_relative = 8708
_burner_run_l3_3_relative = 8870

sprite_get_scr_addr_burner = sprite_get_scr_addr4

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
