; fdd bin file metadata
; asm data file: build/debug/sprite/snowflake_data.asm
; bin file: build/debug/bin/SNOWFLAK.BIN

SNOWFLAK_FILE_LEN = 832
SNOWFLAK_LAST_RECORD_LEN = 64

SNOWFLAK_FILENAME_PTR:
			.byte "SNOWFLAK" ; filename
			.byte "BIN" ; extension

; relative frame labels
_snowflake_run0_0_relative = 2
_snowflake_run0_1_relative = 48
_snowflake_run0_2_relative = 134
_snowflake_run0_3_relative = 220
_snowflake_run1_0_relative = 306
_snowflake_run1_1_relative = 352
_snowflake_run1_2_relative = 438
_snowflake_run1_3_relative = 524
_snowflake_run2_0_relative = 610
_snowflake_run2_1_relative = 656
_snowflake_run2_2_relative = 702
_snowflake_run2_3_relative = 788

snowflake_get_scr_addr:
			.word sprite_get_scr_addr4
snowflake_ram_disk_s_cmd:
			.byte TEMP_BYTE ; inited by sprite_init_meta_data
snowflake_preshifted_sprites:
			.byte 4
snowflake_anims:
			.word snowflake_run_anim, EOD
snowflake_run_anim:
			.byte 9, 0 ; offset to the next frame
			.word _snowflake_run0_0_relative, _snowflake_run0_1_relative, _snowflake_run0_2_relative, _snowflake_run0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _snowflake_run1_0_relative, _snowflake_run1_1_relative, _snowflake_run1_2_relative, _snowflake_run1_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _snowflake_run2_0_relative, _snowflake_run2_1_relative, _snowflake_run2_2_relative, _snowflake_run2_3_relative, 
			.byte 225, $ff ; offset to the first frame
			.word _snowflake_run1_0_relative, _snowflake_run1_1_relative, _snowflake_run1_2_relative, _snowflake_run1_3_relative, 
snowflake_anims_end:
snowflake_anims_len: = snowflake_anims_end - snowflake_anims
