; fdd bin file metadata
; asm data file: build/debug/sprite/tnt_data.asm
; bin file: build/debug/bin/TNT.BIN

TNT_FILE_LEN = 720
TNT_LAST_RECORD_LEN = 80

TNT_FILENAME_PTR:
			.byte "TNT" ; filename
			.byte "     " ; filename white chars
			.byte "BIN" ; extension

; relative frame labels
_tnt_idle0_0_relative = 2
_tnt_idle0_1_relative = 52
_tnt_idle0_2_relative = 146
_tnt_idle0_3_relative = 240
_tnt_idle1_0_relative = 334
_tnt_idle1_1_relative = 392
_tnt_idle1_2_relative = 502
_tnt_idle1_3_relative = 612

tnt_get_scr_addr:
			.word sprite_get_scr_addr4
tnt_ram_disk_s_cmd:
			.byte TEMP_BYTE ; inited by sprite_init_meta_data
tnt_preshifted_sprites:
			.byte 4
tnt_anims:
			.word tnt_run_anim, EOD
tnt_run_anim:
			.byte 9, 0 ; offset to the next frame
			.word _tnt_idle0_0_relative, _tnt_idle0_1_relative, _tnt_idle0_2_relative, _tnt_idle0_3_relative, 
			.byte 245, $ff ; offset to the first frame
			.word _tnt_idle1_0_relative, _tnt_idle1_1_relative, _tnt_idle1_2_relative, _tnt_idle1_3_relative, 
tnt_anims_end:
tnt_anims_len: = tnt_anims_end - tnt_anims
