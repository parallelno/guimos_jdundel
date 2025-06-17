; fdd bin file metadata
; asm data file: build/debug/text_eng/txt_lv0_data.asm
; bin file: build/debug/bin/TXT_LV0.BIN

TXT_LV0_FILE_LEN = 4052
TXT_LV0_LAST_RECORD_LEN = 84

TXT_LV0_FILENAME_PTR:
			.byte "TXT_LV0" ; filename
			.byte " " ; filename white chars
			.byte "BIN" ; extension

; relative labels
_stats_game_stats = 0x0002
_dialogs_no_health = 0x0188
_dialogs_knocked_his_home_door = 0x023d
_dialogs_knocked_his_friend_door = 0x02f8
_dialogs_knocked_his_friend_door_no_clothes = 0x03a2
_dialogs_knocked_his_friend_door_clothes_returns = 0x03ff
_dialogs_hero_gets_sword = 0x049d
_dialogs_knocked_dungeon_entrance = 0x0551
_dialogs_hero_gets_spoon = 0x05d7
_dialogs_hero_use_pie = 0x0672
_dialogs_hero_use_clothes = 0x06fe
_storytelling_storytelling_home = 0x074e
_storytelling_storytelling_farm_fence = 0x07cf
_storytelling_storytelling_road_to_friends_home = 0x0876
_storytelling_storytelling_friends_home = 0x0904
_storytelling_storytelling_friends_backyard = 0x0975
_storytelling_storytelling_friends_secret_place = 0x0a0e
_storytelling_storytelling_crossroad = 0x0aa5
_storytelling_storytelling_loop = 0x0b54
_storytelling_storytelling_lost_coins = 0x0bb2
_storytelling_storytelling_farm_entrance = 0x0c64
_storytelling_storytelling_farm_storage = 0x0d06
_storytelling_storytelling_dugeon_entrance = 0x0d9b
_storytelling_hero_use_cabbage = 0x0e28
_storytelling_hero_use_spoon = 0x0e9f
_storytelling_hero_freeze_monster = 0x0f59
