; fdd bin file metadata
; asm data file: build/debug/sprite/scythe_data.asm
; bin file: build/debug/bin/SCYTHE.BIN

SCYTHE_FILE_LEN = 1068
SCYTHE_LAST_RECORD_LEN = 44

SCYTHE_FILENAME_PTR:
			.byte "SCYTHE" ; filename
			.byte "  " ; filename white chars
			.byte "BIN" ; extension

; relative frame labels
_scythe_run0_0_relative = 2
_scythe_run0_1_relative = 48
_scythe_run0_2_relative = 94
_scythe_run0_3_relative = 140
_scythe_run1_0_relative = 206
_scythe_run1_1_relative = 260
_scythe_run1_2_relative = 362
_scythe_run1_3_relative = 464
_scythe_run2_0_relative = 518
_scythe_run2_1_relative = 572
_scythe_run2_2_relative = 626
_scythe_run2_3_relative = 680
_scythe_run3_0_relative = 758
_scythe_run3_1_relative = 860
_scythe_run3_2_relative = 962
_scythe_run3_3_relative = 1016

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
