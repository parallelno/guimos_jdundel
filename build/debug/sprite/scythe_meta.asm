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
_scythe_run0_0_relative = 2
_scythe_run0_1_relative = 68
_scythe_run0_2_relative = 134
_scythe_run0_3_relative = 200
_scythe_run1_0_relative = 296
_scythe_run1_1_relative = 374
_scythe_run1_2_relative = 524
_scythe_run1_3_relative = 674
_scythe_run2_0_relative = 752
_scythe_run2_1_relative = 830
_scythe_run2_2_relative = 908
_scythe_run2_3_relative = 986
_scythe_run3_0_relative = 1100
_scythe_run3_1_relative = 1250
_scythe_run3_2_relative = 1400
_scythe_run3_3_relative = 1478

scythe_get_scr_addr:
			.word sprite_get_scr_addr4
scythe_ram_disk_s_cmd:
			.byte TEMP_BYTE ; inited by sprite_init_meta_data
scythe_preshifted_sprites:
			.byte 4
scythe_anims:
			.word scythe_run_anim, EOD
scythe_run_anim:
			.byte 9, 0 ; offset to the next frame
			.word _scythe_run0_0_relative, _scythe_run0_1_relative, _scythe_run0_2_relative, _scythe_run0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _scythe_run1_0_relative, _scythe_run1_1_relative, _scythe_run1_2_relative, _scythe_run1_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _scythe_run2_0_relative, _scythe_run2_1_relative, _scythe_run2_2_relative, _scythe_run2_3_relative, 
			.byte 225, $ff ; offset to the first frame
			.word _scythe_run3_0_relative, _scythe_run3_1_relative, _scythe_run3_2_relative, _scythe_run3_3_relative, 
scythe_anims_end:
scythe_anims_len: = scythe_anims_end - scythe_anims
