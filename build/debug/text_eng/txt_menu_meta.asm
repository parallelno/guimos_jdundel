; fdd bin file metadata
; asm data file: build/debug/text_eng/txt_menu_data.asm
; bin file: build/debug/bin/TXT_MENU.BIN

TXT_MENU_FILE_LEN = 1138
TXT_MENU_LAST_RECORD_LEN = 114

TXT_MENU_FILENAME_PTR:
			.byte "TXT_MENU" ; filename
			.byte "BIN" ; extension

; relative labels
_main_menu_settings = 0x0002
_main_menu_license = 0x002a
_scores_screen_score_title = 0x0057
_scores_screen_buff = 0x0069
_options_screen_setting_on = 0x0091
_options_screen_setting_off = 0x009a
_options_screen_settings = 0x00a4
_options_screen_settings_names = 0x00b3
_options_screen_return = 0x01a7
_options_screen_dots = 0x01c5
_options_screen_change_settings = 0x01f4
_options_screen_control_preset_key = 0x020a
_options_screen_control_preset_joy = 0x0215
_options_screen_controls_keyboard = 0x0221
_options_screen_controls_joystic = 0x0255
_credits_screen_credits = 0x028c
