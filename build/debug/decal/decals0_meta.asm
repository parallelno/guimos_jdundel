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
_decals0_bones_relative = 2
_decals0_skull_relative = 128
_decals0_web1_relative = 274
_decals0_barrel_relative = 420
_decals0_crate_relative = 586
_decals0_cabbage_relative = 752
_decals0_key_0_relative = 908
_decals0_key_1_relative = 1014
_decals0_key_2_relative = 1120
_decals0_key_3_relative = 1226
_decals0_coin_relative = 1332
_decals0_tnt_relative = 1458
_decals0_popsicle_pie_relative = 1574
_decals0_potion_red_relative = 1730
_decals0_dry_clothes_relative = 1856
_decals0_door_0_l_relative = 1962
_decals0_door_0_r_relative = 2128
_decals0_door_1_l_relative = 2294
_decals0_door_1_r_relative = 2450
_decals0_door_4_l_relative = 2606
_decals0_door_4_r_relative = 2762
_decals0_door_0_open_l_relative = 2918
_decals0_door_0_open_r_relative = 3084
_decals0_door_1_open_l_relative = 3250
_decals0_door_1_open_r_relative = 3366
_decals0_chest_small_relative = 3482
_decals0_chest_big_relative = 3598
_decals0_chest_weapon0_relative = 3734
_decals0_chest_small_opened_relative = 3870
_decals0_chest_big_opened_relative = 3976
_decals0_chest_weapon0_opened_relative = 4112

decals0_gfx_ptrs:
decals_walkable_gfx_ptrs: .word _decals0_bones_relative, _decals0_skull_relative, 
decals_collidable_gfx_ptrs: .word _decals0_web1_relative, 
items_gfx_ptrs: .word _decals0_key_0_relative, _decals0_key_1_relative, _decals0_key_1_relative, _decals0_key_2_relative, _decals0_key_3_relative, 
resources_gfx_ptrs: .word _decals0_coin_relative, _decals0_coin_relative, _decals0_coin_relative, _decals0_coin_relative, _decals0_tnt_relative, _decals0_potion_red_relative, _decals0_popsicle_pie_relative, _decals0_dry_clothes_relative, 
breakable_gfx_ptrs: .word _decals0_barrel_relative, _decals0_crate_relative, _decals0_cabbage_relative, 
doors_gfx_ptrs: .word _decals0_door_0_l_relative, _decals0_door_0_r_relative, _decals0_door_1_l_relative, _decals0_door_1_r_relative, _decals0_door_1_l_relative, _decals0_door_1_r_relative, _decals0_door_0_l_relative, _decals0_door_0_r_relative, _decals0_door_4_l_relative, _decals0_door_4_r_relative, 
doors_opened_gfx_ptrs: .word _decals0_door_0_open_l_relative, _decals0_door_0_open_r_relative, _decals0_door_1_open_l_relative, _decals0_door_1_open_r_relative, _decals0_door_1_open_l_relative, _decals0_door_1_open_r_relative, _decals0_door_0_open_l_relative, _decals0_door_0_open_r_relative, _decals0_door_1_open_l_relative, _decals0_door_1_open_r_relative, 
containers_gfx_ptrs: .word _decals0_chest_small_relative, _decals0_chest_big_relative, _decals0_chest_weapon0_relative, 
containers_opened_gfx_ptrs: .word _decals0_chest_small_opened_relative, _decals0_chest_big_opened_relative, _decals0_chest_weapon0_opened_relative, 
.word EOD ; used to convert relative ptrs to absolute
