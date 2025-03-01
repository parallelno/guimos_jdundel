; fdd bin file metadata
; asm data file: build/debug/sprite/scythe_data.asm
; bin file: build/debug/bin/SCYTHE.BIN

SCYTHE_FILE_LEN = 1554
SCYTHE_LAST_RECORD_LEN = 18

SCYTHE_FILENAME_PTR:
			.byte "SCYTHE" ; filename
			.byte "  " ; filename white chars
			.byte "BIN" ; extension

; relative frame labels
_scythe_run0_0 = 2
_scythe_run0_1 = 68
_scythe_run0_2 = 134
_scythe_run0_3 = 200
_scythe_run1_0 = 296
_scythe_run1_1 = 374
_scythe_run1_2 = 524
_scythe_run1_3 = 674
_scythe_run2_0 = 752
_scythe_run2_1 = 830
_scythe_run2_2 = 908
_scythe_run2_3 = 986
_scythe_run3_0 = 1100
_scythe_run3_1 = 1250
_scythe_run3_2 = 1400
_scythe_run3_3 = 1478

sprite_get_scr_addr_scythe = sprite_get_scr_addr4

_scythe_preshifted_sprites:
			.byte 4
_scythe_anims:
			.word _scythe_run, EOD
_scythe_run:
			.byte 9, 0 ; offset to the next frame
			.word _scythe_run0_0, _scythe_run0_1, _scythe_run0_2, _scythe_run0_3, 
			.byte 9, 0 ; offset to the next frame
			.word _scythe_run1_0, _scythe_run1_1, _scythe_run1_2, _scythe_run1_3, 
			.byte 9, 0 ; offset to the next frame
			.word _scythe_run2_0, _scythe_run2_1, _scythe_run2_2, _scythe_run2_3, 
			.byte 225, $ff ; offset to the first frame
			.word _scythe_run3_0, _scythe_run3_1, _scythe_run3_2, _scythe_run3_3, 
