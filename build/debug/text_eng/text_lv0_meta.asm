; fdd bin file metadata
; asm data file: build/debug/text_eng/text_lv0_data.asm
; bin file: build/debug/bin/TEXT_LV0.BIN

TEXT_LV0_FILE_LEN = 5190
TEXT_LV0_LAST_RECORD_LEN = 70

TEXT_LV0_FILENAME_PTR:
			.byte "TEXT_LV0" ; filename
			.byte "BIN" ; extension

; relative text labels
_main_menu_settings = 2
_main_menu_license = 42
_scores_screen_score_title = 87
_scores_screen_buff = 105
_options_screen_setting_on = 145
_options_screen_setting_off = 154
_options_screen_settings = 164
_options_screen_settings_names = 179
_options_screen_return = 423
_options_screen_dots = 453
_options_screen_change_settings = 500
_options_screen_control_preset_key = 522
_options_screen_control_preset_joy = 533
_options_screen_controls_keyboard = 545
_options_screen_controls_joystic = 597
_credits_screen_credits = 652
_stats_game_stats = 1140
_dialogs_no_health = 1530
_dialogs_knocked_his_home_door = 1711
_dialogs_knocked_his_friend_door = 1898
_dialogs_knocked_his_friend_door_no_clothes = 2068
_dialogs_knocked_his_friend_door_clothes_returns = 2161
_dialogs_hero_gets_sword = 2319
_dialogs_knocked_dungeon_entrance = 2499
_dialogs_hero_gets_spoon = 2633
_dialogs_hero_use_pie = 2788
_dialogs_hero_use_clothes = 2928
_storytelling_storytelling_home = 3008
_storytelling_storytelling_farm_fence = 3137
_storytelling_storytelling_road_to_friends_home = 3304
_storytelling_storytelling_friends_home = 3446
_storytelling_storytelling_friends_backyard = 3559
_storytelling_storytelling_friends_secret_place = 3712
_storytelling_storytelling_crossroad = 3863
_storytelling_storytelling_loop = 4038
_storytelling_storytelling_lost_coins = 4132
_storytelling_storytelling_farm_entrance = 4310
_storytelling_storytelling_farm_storage = 4472
_storytelling_storytelling_dugeon_entrance = 4621
_storytelling_hero_use_cabbage = 4762
_storytelling_hero_use_spoon = 4881
_storytelling_hero_freeze_monster = 5067
