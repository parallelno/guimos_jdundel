; fdd bin file metadata
; asm data file: build/debug/text_eng/text_lv0_data.asm
; bin file: build/debug/bin/TEXT_LV0.BIN

TEXT_LV0_FILE_LEN = 5190
TEXT_LV0_LAST_RECORD_LEN = 70

TEXT_LV0_FILENAME_PTR:
			.byte "TEXT_LV0" ; filename
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
_stats_game_stats = 0x0474
_dialogs_no_health = 0x05fa
_dialogs_knocked_his_home_door = 0x06af
_dialogs_knocked_his_friend_door = 0x076a
_dialogs_knocked_his_friend_door_no_clothes = 0x0814
_dialogs_knocked_his_friend_door_clothes_returns = 0x0871
_dialogs_hero_gets_sword = 0x090f
_dialogs_knocked_dungeon_entrance = 0x09c3
_dialogs_hero_gets_spoon = 0x0a49
_dialogs_hero_use_pie = 0x0ae4
_dialogs_hero_use_clothes = 0x0b70
_storytelling_storytelling_home = 0x0bc0
_storytelling_storytelling_farm_fence = 0x0c41
_storytelling_storytelling_road_to_friends_home = 0x0ce8
_storytelling_storytelling_friends_home = 0x0d76
_storytelling_storytelling_friends_backyard = 0x0de7
_storytelling_storytelling_friends_secret_place = 0x0e80
_storytelling_storytelling_crossroad = 0x0f17
_storytelling_storytelling_loop = 0x0fc6
_storytelling_storytelling_lost_coins = 0x1024
_storytelling_storytelling_farm_entrance = 0x10d6
_storytelling_storytelling_farm_storage = 0x1178
_storytelling_storytelling_dugeon_entrance = 0x120d
_storytelling_hero_use_cabbage = 0x129a
_storytelling_hero_use_spoon = 0x1311
_storytelling_hero_freeze_monster = 0x13cb
