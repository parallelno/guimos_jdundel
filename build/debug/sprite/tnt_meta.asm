; fdd bin file metadata
; asm data file: build/debug/sprite/tnt_data.asm
; bin file: build/debug/bin/TNT.BIN

TNT_FILE_LEN = 1056
TNT_LAST_RECORD_LEN = 32

TNT_FILENAME_PTR:
			.byte "TNT" ; filename
			.byte "     " ; filename white chars
			.byte "BIN" ; extension

; relative labels. to make it global call __text_ex_rd_init
_tnt_idle0_0 = 2
_tnt_idle0_1 = 74
_tnt_idle0_2 = 212
_tnt_idle0_3 = 350
_tnt_idle1_0 = 488
_tnt_idle1_1 = 572
_tnt_idle1_2 = 734
_tnt_idle1_3 = 896

sprite_get_scr_addr_tnt = sprite_get_scr_addr4

_tnt_preshifted_sprites:
			.byte 4
_tnt_anims:
			.word _tnt_run, 0, 
_tnt_run:
			.byte 9, 0 ; offset to the next frame
			.word _tnt_idle0_0, _tnt_idle0_1, _tnt_idle0_2, _tnt_idle0_3, 
			.byte 245, $ff ; offset to the first frame
			.word _tnt_idle1_0, _tnt_idle1_1, _tnt_idle1_2, _tnt_idle1_3, 
