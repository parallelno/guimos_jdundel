memusage_loads_permanent:
; TODO: think of convoluting the loading function into an array and the loop
;===============================================
; permanent
;===============================================
.function load_permanent
			; ram-disk:
			RAM_DISK_M_FONT = RAM_DISK_M0
			RAM_DISK_S_FONT = RAM_DISK_S0
			FONT_ADDR = 32768
			LOAD_FILE(FONT_FILENAME_PTR, RAM_DISK_S_FONT, FONT_ADDR, FONT_FILE_LEN)
			mvi a, RAM_DISK_S_FONT
			lxi h, font_gfx_ptrs
			lxi b, FONT_ADDR
			call text_ex_init_font

.endf
memusage_loads_permanent_end:
memusage_loads_level0:
; TODO: think of convoluting the loading function into an array and the loop
;===============================================
; level0
;===============================================
.function load_level0
			; ram-disk:
			RAM_DISK_M_SKELETON = RAM_DISK_M0
			RAM_DISK_S_SKELETON = RAM_DISK_S0
			SKELETON_ADDR = 0
			LOAD_FILE(SKELETON_FILENAME_PTR, RAM_DISK_S_SKELETON, SKELETON_ADDR, SKELETON_FILE_LEN)
			lxi d, skeleton_preshifted_sprites
			lxi h, SKELETON_ADDR
			call sprite_update_labels

			RAM_DISK_M_BURNER = RAM_DISK_M0
			RAM_DISK_S_BURNER = RAM_DISK_S0
			BURNER_ADDR = 9870
			LOAD_FILE(BURNER_FILENAME_PTR, RAM_DISK_S_BURNER, BURNER_ADDR, BURNER_FILE_LEN)
			lxi d, burner_preshifted_sprites
			lxi h, BURNER_ADDR
			call sprite_update_labels

			RAM_DISK_M_SWORD = RAM_DISK_M0
			RAM_DISK_S_SWORD = RAM_DISK_S0
			SWORD_ADDR = 18900
			LOAD_FILE(SWORD_FILENAME_PTR, RAM_DISK_S_SWORD, SWORD_ADDR, SWORD_FILE_LEN)
			lxi d, sword_preshifted_sprites
			lxi h, SWORD_ADDR
			call sprite_update_labels

			RAM_DISK_M_VFX4 = RAM_DISK_M0
			RAM_DISK_S_VFX4 = RAM_DISK_S0
			VFX4_ADDR = 27828
			LOAD_FILE(VFX4_FILENAME_PTR, RAM_DISK_S_VFX4, VFX4_ADDR, VFX4_FILE_LEN)
			lxi d, vfx4_preshifted_sprites
			lxi h, VFX4_ADDR
			call sprite_update_labels

			RAM_DISK_M_BOMB = RAM_DISK_M0
			RAM_DISK_S_BOMB = RAM_DISK_S0
			BOMB_ADDR = 31716
			LOAD_FILE(BOMB_FILENAME_PTR, RAM_DISK_S_BOMB, BOMB_ADDR, BOMB_FILE_LEN)
			lxi d, bomb_preshifted_sprites
			lxi h, BOMB_ADDR
			call sprite_update_labels

			RAM_DISK_M_LV0_GFX = RAM_DISK_M0
			RAM_DISK_S_LV0_GFX = RAM_DISK_S0
			LV0_GFX_ADDR = 34392
			LOAD_FILE(LV0_GFX_FILENAME_PTR, RAM_DISK_S_LV0_GFX, LV0_GFX_ADDR, LV0_GFX_FILE_LEN)
			call lv0_gfx_load

			RAM_DISK_M_TI0_DATA = RAM_DISK_M0
			RAM_DISK_S_TI0_DATA = RAM_DISK_S0
			TI0_DATA_ADDR = 39934
			LOAD_FILE(TI0_DATA_FILENAME_PTR, RAM_DISK_S_TI0_DATA, TI0_DATA_ADDR, TI0_DATA_FILE_LEN)
			mvi a, RAM_DISK_S_TI0_DATA
			lxi h, TI0_DATA_ADDR
			call tiled_img_init_idxs

			RAM_DISK_M_VAMPIRE = RAM_DISK_M1
			RAM_DISK_S_VAMPIRE = RAM_DISK_S1
			VAMPIRE_ADDR = 0
			LOAD_FILE(VAMPIRE_FILENAME_PTR, RAM_DISK_S_VAMPIRE, VAMPIRE_ADDR, VAMPIRE_FILE_LEN)
			lxi d, vampire_preshifted_sprites
			lxi h, VAMPIRE_ADDR
			call sprite_update_labels

			RAM_DISK_M_TEXT_LV0 = RAM_DISK_M1
			RAM_DISK_S_TEXT_LV0 = RAM_DISK_S1
			TEXT_LV0_ADDR = 7440
			LOAD_FILE(TEXT_LV0_FILENAME_PTR, RAM_DISK_S_TEXT_LV0, TEXT_LV0_ADDR, TEXT_LV0_FILE_LEN)
			mvi a, RAM_DISK_S_TEXT_LV0
			lxi h, TEXT_LV0_ADDR
			call text_ex_init_text

			RAM_DISK_M_SCYTHE = RAM_DISK_M1
			RAM_DISK_S_SCYTHE = RAM_DISK_S1
			SCYTHE_ADDR = 12630
			LOAD_FILE(SCYTHE_FILENAME_PTR, RAM_DISK_S_SCYTHE, SCYTHE_ADDR, SCYTHE_FILE_LEN)
			lxi d, scythe_preshifted_sprites
			lxi h, SCYTHE_ADDR
			call sprite_update_labels

			RAM_DISK_M_SNOWFLAK = RAM_DISK_M1
			RAM_DISK_S_SNOWFLAK = RAM_DISK_S1
			SNOWFLAK_ADDR = 14184
			LOAD_FILE(SNOWFLAK_FILENAME_PTR, RAM_DISK_S_SNOWFLAK, SNOWFLAK_ADDR, SNOWFLAK_FILE_LEN)
			lxi d, snowflake_preshifted_sprites
			lxi h, SNOWFLAK_ADDR
			call sprite_update_labels

			RAM_DISK_M_TNT = RAM_DISK_M1
			RAM_DISK_S_TNT = RAM_DISK_S1
			TNT_ADDR = 15396
			LOAD_FILE(TNT_FILENAME_PTR, RAM_DISK_S_TNT, TNT_ADDR, TNT_FILE_LEN)
			lxi d, tnt_preshifted_sprites
			lxi h, TNT_ADDR
			call sprite_update_labels

			RAM_DISK_M_BACKS0 = RAM_DISK_M1
			RAM_DISK_S_BACKS0 = RAM_DISK_S1
			BACKS0_ADDR = 16452
			LOAD_FILE(BACKS0_FILENAME_PTR, RAM_DISK_S_BACKS0, BACKS0_ADDR, BACKS0_FILE_LEN)
			lxi d, backs0_preshifted_sprites
			lxi h, BACKS0_ADDR
			call sprite_update_labels

			RAM_DISK_M_TI0_GFX = RAM_DISK_M1
			RAM_DISK_S_TI0_GFX = RAM_DISK_S1
			TI0_GFX_ADDR = 32768
			LOAD_FILE(TI0_GFX_FILENAME_PTR, RAM_DISK_S_TI0_GFX, TI0_GFX_ADDR, TI0_GFX_FILE_LEN)
			mvi a, RAM_DISK_S_TI0_GFX
			lxi h, TI0_GFX_ADDR
			call tiled_img_init_gfx

			RAM_DISK_M_SONG01 = RAM_DISK_M2
			RAM_DISK_S_SONG01 = RAM_DISK_S2
			SONG01_ADDR = 32768
			LOAD_FILE(SONG01_FILENAME_PTR, RAM_DISK_S_SONG01, SONG01_ADDR, SONG01_FILE_LEN)
			lxi d, SONG01_ADDR
			lxi h, song01_ay_reg_data_ptrs
			call v6_gc_init_song

			RAM_DISK_M_KNIGHT = RAM_DISK_M2
			RAM_DISK_S_KNIGHT = RAM_DISK_S2
			KNIGHT_ADDR = 45124
			LOAD_FILE(KNIGHT_FILENAME_PTR, RAM_DISK_S_KNIGHT, KNIGHT_ADDR, KNIGHT_FILE_LEN)
			lxi d, knight_preshifted_sprites
			lxi h, KNIGHT_ADDR
			call sprite_update_labels

			RAM_DISK_M_DECALS0 = RAM_DISK_M2
			RAM_DISK_S_DECALS0 = RAM_DISK_S2
			DECALS0_ADDR = 60904
			LOAD_FILE(DECALS0_FILENAME_PTR, RAM_DISK_S_DECALS0, DECALS0_ADDR, DECALS0_FILE_LEN)
			lxi h, decals0_gfx_ptrs
			lxi b, DECALS0_ADDR
			call update_labels_eod

			RAM_DISK_M_LV0_DATA = RAM_DISK_M3
			RAM_DISK_S_LV0_DATA = RAM_DISK_S3
			LV0_DATA_ADDR = 32768
			LOAD_FILE(LV0_DATA_FILENAME_PTR, RAM_DISK_S_LV0_DATA, LV0_DATA_ADDR, LV0_DATA_FILE_LEN)
			call lv0_data_load

			RAM_DISK_M_HERO_L = RAM_DISK_M3
			RAM_DISK_S_HERO_L = RAM_DISK_S3
			HERO_L_ADDR = 36538
			LOAD_FILE(HERO_L_FILENAME_PTR, RAM_DISK_S_HERO_L, HERO_L_ADDR, HERO_L_FILE_LEN)
			lxi d, hero_l_preshifted_sprites
			lxi h, HERO_L_ADDR
			call sprite_update_labels

			RAM_DISK_M_HERO_R = RAM_DISK_M3
			RAM_DISK_S_HERO_R = RAM_DISK_S3
			HERO_R_ADDR = 49714
			LOAD_FILE(HERO_R_FILENAME_PTR, RAM_DISK_S_HERO_R, HERO_R_ADDR, HERO_R_FILE_LEN)
			lxi d, hero_r_preshifted_sprites
			lxi h, HERO_R_ADDR
			call sprite_update_labels

			RAM_DISK_M_VFX = RAM_DISK_M3
			RAM_DISK_S_VFX = RAM_DISK_S3
			VFX_ADDR = 62890
			LOAD_FILE(VFX_FILENAME_PTR, RAM_DISK_S_VFX, VFX_ADDR, VFX_FILE_LEN)
			lxi d, vfx_preshifted_sprites
			lxi h, VFX_ADDR
			call sprite_update_labels

.endf
memusage_loads_level0_end:
