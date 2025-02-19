; fdd bin file metadata
; asm data file: build/debug/text_eng/text_lv0_data.asm
; bin file: build/debug/bin/TEXT_LV0.BIN

TEXT_LV0_FILE_LEN = 5112
TEXT_LV0_LAST_RECORD_LEN = 120

TEXT_LV0_FILENAME_PTR:
			.byte "TEXT_LV0" ; filename
			.byte "BIN" ; extension

; relative text labels
_main_menu_settings = 2
_main_menu_license = 40
_scores_screen_score_title = 83
_scores_screen_buff = 99
_options_screen_setting_on = 137
_options_screen_setting_off = 144
_options_screen_settings = 152
_options_screen_settings_names = 165
_options_screen_return = 409
_options_screen_dots = 437
_options_screen_change_settings = 482
_options_screen_control_preset_key = 502
_options_screen_control_preset_joy = 511
_options_screen_controls_keyboard = 521
_options_screen_controls_joystic = 571
_credits_screen_credits = 624
_stats_game_stats = 1112
_dialogs_no_health = 1502
_dialogs_knocked_his_home_door = 1681
_dialogs_knocked_his_friend_door = 1866
_dialogs_knocked_his_friend_door_no_clothes = 2034
_dialogs_knocked_his_friend_door_clothes_returns = 2125
_dialogs_hero_gets_sword = 2281
_dialogs_knocked_dungeon_entrance = 2459
_dialogs_hero_gets_spoon = 2591
_dialogs_hero_use_pie = 2744
_dialogs_hero_use_clothes = 2882
_storytelling_storytelling_home = 2960
_storytelling_storytelling_farm_fence = 3087
_storytelling_storytelling_road_to_friends_home = 3252
_storytelling_storytelling_friends_home = 3392
_storytelling_storytelling_friends_backyard = 3503
_storytelling_storytelling_friends_secret_place = 3654
_storytelling_storytelling_crossroad = 3803
_storytelling_storytelling_loop = 3976
_storytelling_storytelling_lost_coins = 4068
_storytelling_storytelling_farm_entrance = 4244
_storytelling_storytelling_farm_storage = 4404
_storytelling_storytelling_dugeon_entrance = 4551
_storytelling_hero_use_cabbage = 4690
_storytelling_hero_use_spoon = 4807
_storytelling_hero_freeze_monster = 4991
