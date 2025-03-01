; fdd bin file metadata
; asm data file: build/debug/decal/decals0_data.asm
; bin file: build/debug/bin/DECALS0.BIN

DECALS0_FILE_LEN = 4266
DECALS0_LAST_RECORD_LEN = 42

DECALS0_FILENAME_PTR:
			.byte "DECALS0" ; filename
			.byte " " ; filename white chars
			.byte "BIN" ; extension

; relative frame labels
_decals0_bones = 2
_decals0_skull = 128
_decals0_web1 = 274
_decals0_barrel = 420
_decals0_crate = 586
_decals0_cabbage = 752
_decals0_key_0 = 908
_decals0_key_1 = 1014
_decals0_key_2 = 1120
_decals0_key_3 = 1226
_decals0_coin = 1332
_decals0_tnt = 1458
_decals0_popsicle_pie = 1574
_decals0_potion_red = 1730
_decals0_dry_clothes = 1856
_decals0_door_0_l = 1962
_decals0_door_0_r = 2128
_decals0_door_1_l = 2294
_decals0_door_1_r = 2450
_decals0_door_4_l = 2606
_decals0_door_4_r = 2762
_decals0_door_0_open_l = 2918
_decals0_door_0_open_r = 3084
_decals0_door_1_open_l = 3250
_decals0_door_1_open_r = 3366
_decals0_chest_small = 3482
_decals0_chest_big = 3598
_decals0_chest_weapon0 = 3734
_decals0_chest_small_opened = 3870
_decals0_chest_big_opened = 3976
_decals0_chest_weapon0_opened = 4112

DECALS0_GFX_PTRS_LEN = 45

decals0_gfx_ptrs:
_decals_walkable_gfx_ptrs: .word _decals0_bones, _decals0_skull, 

_decals_collidable_gfx_ptrs: .word _decals0_web1, 

_items_gfx_ptrs: .word _decals0_key_0, _decals0_key_1, _decals0_key_1, _decals0_key_2, _decals0_key_3, 

_resources_gfx_ptrs: .word _decals0_coin, _decals0_coin, _decals0_coin, _decals0_coin, _decals0_tnt, _decals0_potion_red, _decals0_popsicle_pie, _decals0_dry_clothes, 

_breakable_gfx_ptrs: .word _decals0_barrel, _decals0_crate, _decals0_cabbage, 

_doors_gfx_ptrs: .word _decals0_door_0_l, _decals0_door_0_r, _decals0_door_1_l, _decals0_door_1_r, _decals0_door_1_l, _decals0_door_1_r, _decals0_door_0_l, _decals0_door_0_r, _decals0_door_4_l, _decals0_door_4_r, 

_doors_opened_gfx_ptrs: .word _decals0_door_0_open_l, _decals0_door_0_open_r, _decals0_door_1_open_l, _decals0_door_1_open_r, _decals0_door_1_open_l, _decals0_door_1_open_r, _decals0_door_0_open_l, _decals0_door_0_open_r, _decals0_door_1_open_l, _decals0_door_1_open_r, 

_containers_gfx_ptrs: .word _decals0_chest_small, _decals0_chest_big, _decals0_chest_weapon0, 

_containers_opened_gfx_ptrs: .word _decals0_chest_small_opened, _decals0_chest_big_opened, _decals0_chest_weapon0_opened, 

