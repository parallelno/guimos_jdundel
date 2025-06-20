; fdd bin file metadata
; asm data file: build/debug/palette/pal_lv1_data.asm
; bin file: build/debug/bin/PAL_LV1.BIN

PAL_LV1_FILE_LEN = 18
PAL_LV1_LAST_RECORD_LEN = 18

PAL_LV1_FILENAME_PTR:
			.byte "PAL_LV1" ; filename
			.byte " " ; filename white chars
			.byte "BIN" ; extension

_pal_lv1_palette_relative = 0x0002

