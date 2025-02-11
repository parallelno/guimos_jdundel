; fdd bin file metadata
; asm data file: build/debug/sprite/scythe_data.asm
; bin file: build/debug/bin/SCYTHE.BIN

SCYTHE_FILE_LEN = 1626
SCYTHE_LAST_RECORD_LEN = 90

SCYTHE_FILENAME_PTR:
			.byte "SCYTHE" ; filename
			.byte "  " ; filename white chars
			.byte "BIN" ; extension

; relative labels. to make it global call __text_ex_rd_init
_scythe_run0_0 = 2
_scythe_run0_1 = 62
_scythe_run0_2 = 122
_scythe_run0_3 = 182
_scythe_run1_0 = 272
_scythe_run1_1 = 416
_scythe_run1_2 = 560
_scythe_run1_3 = 704
_scythe_run2_0 = 776
_scythe_run2_1 = 848
_scythe_run2_2 = 920
_scythe_run2_3 = 992
_scythe_run3_0 = 1100
_scythe_run3_1 = 1244
_scythe_run3_2 = 1388
_scythe_run3_3 = 1460

sprite_get_scr_addr_scythe = sprite_get_scr_addr4

_scythe_preshifted_sprites:
			.byte 4
_scythe_anims:
			.word _scythe_run, 0, 
_scythe_run:
			.byte 9, 0 ; offset to the next frame
			.word _scythe_run0_0, _scythe_run0_1, _scythe_run0_2, _scythe_run0_3, 
			.byte 9, 0 ; offset to the next frame
			.word _scythe_run1_0, _scythe_run1_1, _scythe_run1_2, _scythe_run1_3, 
			.byte 9, 0 ; offset to the next frame
			.word _scythe_run2_0, _scythe_run2_1, _scythe_run2_2, _scythe_run2_3, 
			.byte 225, $ff ; offset to the first frame
			.word _scythe_run3_0, _scythe_run3_1, _scythe_run3_2, _scythe_run3_3, 
