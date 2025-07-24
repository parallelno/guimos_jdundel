; fdd bin file metadata
; asm data file: build/debug/tiled_img_gfx/ti0_gfx_data.asm
; bin file: build/debug/bin/TI0_GFX.BIN

TI0_GFX_FILE_LEN = 3332
TI0_GFX_LAST_RECORD_LEN = 4

TI0_GFX_FILENAME_PTR:
			.byte "TI0_GFX" ; filename
			.byte " " ; filename white chars
			.byte "BIN" ; extension

