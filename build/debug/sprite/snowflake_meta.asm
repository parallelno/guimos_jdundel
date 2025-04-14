; fdd bin file metadata
; asm data file: build/debug/sprite/snowflake_data.asm
; bin file: build/debug/bin/SNOWFLAK.BIN

SNOWFLAK_FILE_LEN = 1212
SNOWFLAK_LAST_RECORD_LEN = 60

SNOWFLAK_FILENAME_PTR:
			.byte "SNOWFLAK" ; filename
			.byte "BIN" ; extension

; relative frame labels
_snowflake_run0_0_relative = 2
_snowflake_run0_1_relative = 68
_snowflake_run0_2_relative = 194
_snowflake_run0_3_relative = 320
_snowflake_run1_0_relative = 446
_snowflake_run1_1_relative = 512
_snowflake_run1_2_relative = 638
_snowflake_run1_3_relative = 764
_snowflake_run2_0_relative = 890
_snowflake_run2_1_relative = 956
_snowflake_run2_2_relative = 1022
_snowflake_run2_3_relative = 1148

sprite_get_scr_addr_snowflake = sprite_get_scr_addr4

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
