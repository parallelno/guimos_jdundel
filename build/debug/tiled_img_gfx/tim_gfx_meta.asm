; fdd bin file metadata
; asm data file: build/debug/tiled_img_gfx/tim_gfx_data.asm
; bin file: build/debug/bin/TIM_GFX.BIN

TIM_GFX_FILE_LEN = 5832
TIM_GFX_LAST_RECORD_LEN = 72

TIM_GFX_FILENAME_PTR:
			.byte "TIM_GFX" ; filename
			.byte " " ; filename white chars
			.byte "BIN" ; extension

