; fdd bin file metadata
; asm data file: build/debug/sprite/snowflake_data.asm
; bin file: build/debug/bin/SNOWFLAK.BIN

SNOWFLAK_FILE_LEN = 1332
SNOWFLAK_LAST_RECORD_LEN = 52

SNOWFLAK_FILENAME_PTR:
			.byte "SNOWFLAK" ; filename
			.byte "BIN" ; extension

; relative labels. to make it global call __text_ex_rd_init

sprite_get_scr_addr_snowflake = sprite_get_scr_addr4

_snowflake_preshifted_sprites:
			.byte 4
_snowflake_anims:
			.word _snowflake_run, 0, 
_snowflake_run:
			.byte 9, 0 ; offset to the next frame
			.word _snowflake_run0_0, _snowflake_run0_1, _snowflake_run0_2, _snowflake_run0_3, 
			.byte 9, 0 ; offset to the next frame
			.word _snowflake_run1_0, _snowflake_run1_1, _snowflake_run1_2, _snowflake_run1_3, 
			.byte 9, 0 ; offset to the next frame
			.word _snowflake_run2_0, _snowflake_run2_1, _snowflake_run2_2, _snowflake_run2_3, 
			.byte 225, $ff ; offset to the first frame
			.word _snowflake_run1_0, _snowflake_run1_1, _snowflake_run1_2, _snowflake_run1_3, 
_snowflake_run0_0 = 1
_snowflake_run0_1 = 1
_snowflake_run0_2 = 1
_snowflake_run0_3 = 1
_snowflake_run1_0 = 1
_snowflake_run1_1 = 1
_snowflake_run1_2 = 1
_snowflake_run1_3 = 1
_snowflake_run2_0 = 1
_snowflake_run2_1 = 1
_snowflake_run2_2 = 1
_snowflake_run2_3 = 1
