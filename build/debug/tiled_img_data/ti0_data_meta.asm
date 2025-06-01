; fdd bin file metadata
; asm data file: build/debug/tiled_img_data/ti0_data_data.asm
; bin file: build/debug/bin/TI0_DATA.BIN

TI0_DATA_FILE_LEN = 1008
TI0_DATA_LAST_RECORD_LEN = 112

TI0_DATA_FILENAME_PTR:
			.byte "TI0_DATA" ; filename
			.byte "BIN" ; extension

_ti0_frame_ingame_dialog = 0x0002
_ti0_main_menu_back2 = 0x0032
_ti0_main_menu_back1 = 0x00f5
_ti0_title1 = 0x019f
_ti0_frame_main_menu = 0x025d
_ti0_frame_ingame_top = 0x02cc
_ti0_res_mana = 0x02fc
_ti0_res_sword = 0x030c
_ti0_res_potion_health = 0x031c
_ti0_res_potion_mana = 0x032c
_ti0_res_tnt = 0x033c
_ti0_res_clothes = 0x034c
_ti0_res_cabbage = 0x035c
_ti0_res_spoon = 0x036c
_ti0_res_can = 0x0378
_ti0_res_full_can = 0x0384
_ti0_res_scarecrow = 0x0390
_ti0_item_key_0 = 0x039c
_ti0_item_key_1 = 0x03a8
_ti0_item_key_2 = 0x03b4
_ti0_item_key_3 = 0x03c0
_ti0_item_key_4 = 0x03cc
_ti0_res_empty = 0x03d8
_ti0_item_empty = 0x03e6

