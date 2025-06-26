; fdd bin file metadata
; asm data file: build/debug/palette/pal_lv0_data.asm
; bin file: build/debug/bin/PAL_LV0.BIN

PAL_LV0_FILE_LEN = 148
PAL_LV0_LAST_RECORD_LEN = 20

PAL_LV0_FILENAME_PTR:
			.byte "PAL_LV0" ; filename
			.byte " " ; filename white chars
			.byte "BIN" ; extension

_pal_lv0_palette_relative = 0x0002
_pal_lv0_palette_fade_to_black_relative = 0x0014

