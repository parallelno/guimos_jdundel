; fdd bin file metadata
; asm data file: build/debug/tiled_img_data/tim_data_data.asm
; bin file: build/debug/bin/TIM_DATA.BIN

TIM_DATA_FILE_LEN = 728
TIM_DATA_LAST_RECORD_LEN = 88

TIM_DATA_FILENAME_PTR:
			.byte "TIM_DATA" ; filename
			.byte "BIN" ; extension

_tim_main_menu_back = 0x0002
_tim_main_menu_front = 0x0167

