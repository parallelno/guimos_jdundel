; fdd bin file metadata
; asm data file: build/debug/sprite/tnt_data.asm
; bin file: build/debug/bin/TNT.BIN

TNT_FILE_LEN = 1056
TNT_LAST_RECORD_LEN = 32

TNT_FILENAME_PTR:
			.byte "TNT" ; filename
			.byte "     " ; filename white chars
			.byte "BIN" ; extension

; relative frame labels
_tnt_idle0_0_relative = 2
_tnt_idle0_1_relative = 74
_tnt_idle0_2_relative = 212
_tnt_idle0_3_relative = 350
_tnt_idle1_0_relative = 488
_tnt_idle1_1_relative = 572
_tnt_idle1_2_relative = 734
_tnt_idle1_3_relative = 896

sprite_get_scr_addr_tnt = sprite_get_scr_addr4

tnt_preshifted_sprites:
			.byte 4
tnt_anims:
			.word tnt_run_anim, EOD
tnt_run_anim:
			.byte 9, 0 ; offset to the next frame
			.word _tnt_idle0_0_relative, _tnt_idle0_1_relative, _tnt_idle0_2_relative, _tnt_idle0_3_relative, 
			.byte 245, $ff ; offset to the first frame
			.word _tnt_idle1_0_relative, _tnt_idle1_1_relative, _tnt_idle1_2_relative, _tnt_idle1_3_relative, 
