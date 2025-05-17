; fdd bin file metadata
; asm data file: build/debug/sprite/goose_data.asm
; bin file: build/debug/bin/GOOSE.BIN

GOOSE_FILE_LEN = 5520
GOOSE_LAST_RECORD_LEN = 16

GOOSE_FILENAME_PTR:
			.byte "GOOSE" ; filename
			.byte "   " ; filename white chars
			.byte "BIN" ; extension

; relative frame labels
_goose_idle0_0_relative = 2
_goose_idle0_1_relative = 176
_goose_idle0_2_relative = 350
_goose_idle0_3_relative = 524
_goose_idle1_0_relative = 782
_goose_idle1_1_relative = 956
_goose_idle1_2_relative = 1214
_goose_idle1_3_relative = 1472
_goose_run_r0_0_relative = 1730
_goose_run_r0_1_relative = 1904
_goose_run_r0_2_relative = 2162
_goose_run_r0_3_relative = 2420
_goose_run_r1_0_relative = 2678
_goose_run_r1_1_relative = 2852
_goose_run_r1_2_relative = 3110
_goose_run_r1_3_relative = 3368
_goose_run_l0_0_relative = 3626
_goose_run_l0_1_relative = 3800
_goose_run_l0_2_relative = 4058
_goose_run_l0_3_relative = 4316
_goose_run_l1_0_relative = 4574
_goose_run_l1_1_relative = 4748
_goose_run_l1_2_relative = 5006
_goose_run_l1_3_relative = 5264

sprite_get_scr_addr_goose = sprite_get_scr_addr4

goose_preshifted_sprites:
			.byte 4
goose_anims:
			.word goose_idle_anim, goose_run_r_anim, goose_run_l_anim, EOD
goose_idle_anim:
			.byte 9, 0 ; offset to the next frame
			.word _goose_idle0_0_relative, _goose_idle0_1_relative, _goose_idle0_2_relative, _goose_idle0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _goose_idle0_0_relative, _goose_idle0_1_relative, _goose_idle0_2_relative, _goose_idle0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _goose_idle1_0_relative, _goose_idle1_1_relative, _goose_idle1_2_relative, _goose_idle1_3_relative, 
			.byte 225, $ff ; offset to the first frame
			.word _goose_idle1_0_relative, _goose_idle1_1_relative, _goose_idle1_2_relative, _goose_idle1_3_relative, 
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
