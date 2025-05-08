; fdd bin file metadata
; asm data file: build/debug/sprite/goose_data.asm
; bin file: build/debug/bin/GOOSE.BIN

GOOSE_FILE_LEN = 4824
GOOSE_LAST_RECORD_LEN = 88

GOOSE_FILENAME_PTR:
			.byte "GOOSE" ; filename
			.byte "   " ; filename white chars
			.byte "BIN" ; extension

; relative frame labels
_goose_idle_0_0_relative = 2
_goose_idle_0_1_relative = 176
_goose_idle_0_2_relative = 350
_goose_idle_0_3_relative = 524
_goose_idle_1_0_relative = 782
_goose_idle_1_1_relative = 956
_goose_idle_1_2_relative = 1130
_goose_idle_1_3_relative = 1304
_goose_run_r0_0_relative = 1562
_goose_run_r0_1_relative = 1712
_goose_run_r0_2_relative = 1934
_goose_run_r0_3_relative = 2156
_goose_run_r1_0_relative = 2378
_goose_run_r1_1_relative = 2528
_goose_run_r1_2_relative = 2750
_goose_run_r1_3_relative = 2972
_goose_run_l0_0_relative = 3194
_goose_run_l0_1_relative = 3344
_goose_run_l0_2_relative = 3566
_goose_run_l0_3_relative = 3788
_goose_run_l1_0_relative = 4010
_goose_run_l1_1_relative = 4160
_goose_run_l1_2_relative = 4382
_goose_run_l1_3_relative = 4604

sprite_get_scr_addr_goose = sprite_get_scr_addr4

goose_preshifted_sprites:
			.byte 4
goose_anims:
			.word goose_idle_anim, goose_run_r_anim, goose_run_l_anim, EOD
goose_idle_anim:
			.byte 9, 0 ; offset to the next frame
			.word _goose_idle_0_0_relative, _goose_idle_0_1_relative, _goose_idle_0_2_relative, _goose_idle_0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _goose_idle_0_0_relative, _goose_idle_0_1_relative, _goose_idle_0_2_relative, _goose_idle_0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _goose_idle_1_0_relative, _goose_idle_1_1_relative, _goose_idle_1_2_relative, _goose_idle_1_3_relative, 
			.byte 225, $ff ; offset to the first frame
			.word _goose_idle_1_0_relative, _goose_idle_1_1_relative, _goose_idle_1_2_relative, _goose_idle_1_3_relative, 
goose_run_r_anim:
			.byte 9, 0 ; offset to the next frame
			.word _goose_run_r0_0_relative, _goose_run_r0_1_relative, _goose_run_r0_2_relative, _goose_run_r0_3_relative, 
			.byte 245, $ff ; offset to the first frame
			.word _goose_run_r1_0_relative, _goose_run_r1_1_relative, _goose_run_r1_2_relative, _goose_run_r1_3_relative, 
goose_run_l_anim:
			.byte 9, 0 ; offset to the next frame
			.word _goose_run_l0_0_relative, _goose_run_l0_1_relative, _goose_run_l0_2_relative, _goose_run_l0_3_relative, 
			.byte 245, $ff ; offset to the first frame
			.word _goose_run_l1_0_relative, _goose_run_l1_1_relative, _goose_run_l1_2_relative, _goose_run_l1_3_relative, 
goose_anims_end:
goose_anims_len: = goose_anims_end - goose_anims
