; fdd bin file metadata
; asm data file: build/debug/text_eng/txt_lv0_data.asm
; bin file: build/debug/bin/TXT_LV0.BIN

TXT_LV0_FILE_LEN = 4880
TXT_LV0_LAST_RECORD_LEN = 16

TXT_LV0_FILENAME_PTR:
			.byte "TXT_LV0" ; filename
			.byte " " ; filename white chars
			.byte "BIN" ; extension

; relative labels
_stats_game_stats = 0x0002
_dialogs_no_health = 0x0188
_dialogs_knocked_his_home_door = 0x023d
_dialogs_knocked_his_friend_door = 0x02f8
_dialogs_knocked_his_friend_door_no_laundry = 0x03a2
_dialogs_knocked_his_friend_door_laundry_returns = 0x03ff
_dialogs_hero_gets_sword = 0x049e
_dialogs_knocked_dungeon_entrance = 0x0552
_dialogs_hero_gets_spoon = 0x05d8
_dialogs_hero_use_pie = 0x0673
_dialogs_hero_use_laundry = 0x06ff
_dialogs_mom_first_hi = 0x074f
_dialogs_bob_first_hi = 0x07f2
_dialogs_bob_waits_scare = 0x08a6
_dialogs_got_scarecrow = 0x0907
_dialogs_set_scarecrow = 0x0948
_dialogs_bob_happy = 0x0987
_dialogs_mom_hit_by_snowflake = 0x09aa
_dialogs_bob_hit_by_snowflake = 0x09cb
_dialogs_mom_catch_caterpillars = 0x09ec
_dialogs_hi_trap = 0x0a3f
_storytelling_storytelling_home = 0x0a8c
_storytelling_storytelling_farm_fence = 0x0b0d
_storytelling_storytelling_road_to_friends_home = 0x0bb4
_storytelling_storytelling_friends_home = 0x0c42
_storytelling_storytelling_friends_backyard = 0x0cb3
_storytelling_storytelling_friends_secret_place = 0x0d4c
_storytelling_storytelling_crossroad = 0x0de3
_storytelling_storytelling_loop = 0x0e8f
_storytelling_storytelling_lost_coins = 0x0eed
_storytelling_storytelling_farm_entrance = 0x0f9f
_storytelling_storytelling_farm_storage = 0x1041
_storytelling_storytelling_dugeon_entrance = 0x10d6
_storytelling_hero_use_cabbage = 0x1163
_storytelling_hero_use_spoon = 0x11da
_storytelling_hero_freeze_char = 0x1294
