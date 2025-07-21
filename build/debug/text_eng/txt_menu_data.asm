_LINE_BREAK_ = 106
_PARAG_BREAK_ = 255
_EOD_ = 0
.macro TEXT (string, end_code=_EOD_)
.encoding "screencode", "mixed"
    .text string
    .byte end_code
.endmacro

;===================================================================================
; main menu
;===================================================================================

			.word 0 ; safety pair of bytes for reading by POP B
_main_menu_settings:
			.word 36 ; data len to copy to ram
			.byte 131, 96 ; scr pos (y, x)
			TEXT("START GAME", _LINE_BREAK_)
			TEXT("OPTIONS", _LINE_BREAK_)
			TEXT("SCORES", _LINE_BREAK_)
			TEXT("CREDITS", )


			.word 0 ; safety pair of bytes for reading by POP B
_main_menu_license:
			.word 42 ; data len to copy to ram
			.byte 32, 26 ; scr pos (y, x)
			TEXT("2025. Developed by Fedotovskikh family", )

;===================================================================================
; scores screen
;===================================================================================

			.word 0 ; safety pair of bytes for reading by POP B
_scores_screen_score_title:
			.word 14 ; data len to copy to ram
			.byte 216, 88 ; scr pos (y, x)
			TEXT("SCORE BOARD", )


			.word 0 ; safety pair of bytes for reading by POP B
_scores_screen_buff:
			.word 36 ; data len to copy to ram
			.byte 184, 56 ; scr pos (y, x)
			TEXT("TEMPNAME .................. 65535", )

;===================================================================================
; options screen
;===================================================================================

			.word 0 ; safety pair of bytes for reading by POP B
_options_screen_setting_on:
			.word 6 ; data len to copy to ram
			.byte 202, 164 ; scr pos (y, x)
			TEXT("ON", )


			.word 0 ; safety pair of bytes for reading by POP B
_options_screen_setting_off:
			.word 6 ; data len to copy to ram
			.byte 202, 164 ; scr pos (y, x)
			TEXT("OFF", )


			.word 0 ; safety pair of bytes for reading by POP B
_options_screen_settings:
			.word 12 ; data len to copy to ram
			.byte 216, 105 ; scr pos (y, x)
			TEXT("Settings", )


			.word 0 ; safety pair of bytes for reading by POP B
_options_screen_settings_names:
			.word 240 ; data len to copy to ram
			.byte 202, 64 ; scr pos (y, x)
			TEXT("Music", _LINE_BREAK_)
			TEXT("SFX", _PARAG_BREAK_)

			TEXT("Control Preset ...", _LINE_BREAK_)
			TEXT(" UP ..............................", _LINE_BREAK_)
			TEXT(" DOWN ......................", _LINE_BREAK_)
			TEXT(" LEFT ........................", _LINE_BREAK_)
			TEXT(" RIGHT .....................", _LINE_BREAK_)
			TEXT(" FIRE ..........................", _LINE_BREAK_)
			TEXT(" SELECT ..................", _LINE_BREAK_)
			TEXT(" RETURN ................", )


			.word 0 ; safety pair of bytes for reading by POP B
_options_screen_return:
			.word 26 ; data len to copy to ram
			.byte 25, 88 ; scr pos (y, x)
			TEXT("Return to the Main Menu", )


			.word 0 ; safety pair of bytes for reading by POP B
_options_screen_dots:
			.word 44 ; data len to copy to ram
			.byte 0, 0 ; scr pos (y, x)
			TEXT("........................................", )


			.word 0 ; safety pair of bytes for reading by POP B
_options_screen_change_settings:
			.word 18 ; data len to copy to ram
			.byte 25, 138 ; scr pos (y, x)
			TEXT("Change settings", )


			.word 0 ; safety pair of bytes for reading by POP B
_options_screen_control_preset_key:
			.word 8 ; data len to copy to ram
			.byte 164, 164 ; scr pos (y, x)
			TEXT("Keys", )


			.word 0 ; safety pair of bytes for reading by POP B
_options_screen_control_preset_joy:
			.word 8 ; data len to copy to ram
			.byte 164, 164 ; scr pos (y, x)
			TEXT("JoyP1", )


			.word 0 ; safety pair of bytes for reading by POP B
_options_screen_controls_keyboard:
			.word 48 ; data len to copy to ram
			.byte 150, 164 ; scr pos (y, x)
			TEXT("K UP", _LINE_BREAK_)
			TEXT("K DOWN", _LINE_BREAK_)
			TEXT("K LEFT", _LINE_BREAK_)
			TEXT("K RIGHT", _LINE_BREAK_)
			TEXT("K SPACE", _LINE_BREAK_)
			TEXT("K PS", _LINE_BREAK_)
			TEXT("K TAB", )


			.word 0 ; safety pair of bytes for reading by POP B
_options_screen_controls_joystic:
			.word 52 ; data len to copy to ram
			.byte 150, 164 ; scr pos (y, x)
			TEXT("J UP", _LINE_BREAK_)
			TEXT("J DOWN", _LINE_BREAK_)
			TEXT("J LEFT", _LINE_BREAK_)
			TEXT("J RIGHT", _LINE_BREAK_)
			TEXT("J FIRE1", _LINE_BREAK_)
			TEXT("J FIRE2", _LINE_BREAK_)
			TEXT("J TAB", )

;===================================================================================
; credits screen
;===================================================================================

			.word 0 ; safety pair of bytes for reading by POP B
_credits_screen_credits:
			.word 484 ; data len to copy to ram
			.byte 224, 18 ; scr pos (y, x)
			TEXT("    This game was created because I truly", _LINE_BREAK_)
			TEXT("believe in the awesomeness of the Soviet", _LINE_BREAK_)
			TEXT("PC Vector 06c that shaped my life.", _PARAG_BREAK_)

			TEXT("Code: Alex Fedotovskikh", _LINE_BREAK_)
			TEXT("Story and inspiration: Petr Fedotovskikh", _LINE_BREAK_)
			TEXT("Game mechanics: Ilia Fedotovskikh", _LINE_BREAK_)
			TEXT("Support and ideas: Fenia Fedotovskikh", _LINE_BREAK_)
			TEXT("Level design: the whole family!", _LINE_BREAK_)
			TEXT("Big thanks to my amazing family for", _LINE_BREAK_)
			TEXT("working hard to make it a reality!", _PARAG_BREAK_)

			TEXT("Special thanks to zx-pk.ru community", _LINE_BREAK_)
			TEXT("and especially to ivagor, nzeemin, svofski,", _LINE_BREAK_)
			TEXT("and jerry for their contribution and help!", )

