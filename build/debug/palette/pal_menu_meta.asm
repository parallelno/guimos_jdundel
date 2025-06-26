; fdd bin file metadata
; asm data file: build/debug/palette/pal_menu_data.asm
; bin file: build/debug/bin/PAL_MENU.BIN

PAL_MENU_FILE_LEN = 168
PAL_MENU_LAST_RECORD_LEN = 40

PAL_MENU_FILENAME_PTR:
			.byte "PAL_MENU" ; filename
			.byte "BIN" ; extension

_pal_menu_palette_relative = 0x0002
_pal_menu_palette_fade_to_load_relative = 0x0014
_pal_menu_palette_fade_to_menu_relative = 0x005f

