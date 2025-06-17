; fdd bin file metadata
; asm data file: build/debug/tiled_img_data/tim_data_data.asm
; bin file: build/debug/bin/TIM_DATA.BIN

TIM_DATA_FILE_LEN = 666
TIM_DATA_LAST_RECORD_LEN = 26

TIM_DATA_FILENAME_PTR:
			.byte "TIM_DATA" ; filename
			.byte "BIN" ; extension

_tim_main_menu_back2 = 0x0002
_tim_main_menu_back1 = 0x00c5
_tim_title1 = 0x016f
_tim_frame_main_menu = 0x022d

