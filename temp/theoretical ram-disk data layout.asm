;TODO: the stack can be decreased to 32 bytes.
; that can get up to 960 bytes (768 ram-disk, 192 ram)
; 

; MAIN_MENU ram-disk data layout
; bank0 addr0    [ 31180 free] description: 
;                             snowflake_sprites [1332], font_gfx [1840], 
; bank0 addr8000 [ 13838 free] description: 
;                             backs_sprites [620], decals_sprites [4446], vfx4_sprites [4686], tiled_images_gfx [8178], tiled_images_data [1000], 
; bank1 addr0    [32752 free] description: 

; bank1 addr8000 [ 8192 free] description: $A000-$FFFF backbuffer2 (to restore a background in the backbuffer) 

; bank2 addr0    [32512 free] description: 
;
; bank2 addr8000 [10985 free] description: sound and music must be at >= $8000 addr. $F102-$FFFF music player runtime buffers 
;                             sound_rd [794], song01 [8576], transition_song01 [8576]
; bank3 addr0    [32752 free] description: 
;
; bank3 addr8000 [ 6736 free] description: $8000-$9FFF code library. $A000-$FFFF backbuffer (to avoid sprite flickering)  
;                             global_consts_rd [0], sprite_rd [168], draw_sprite_rd [340], draw_sprite_hit_rd [318], draw_sprite_invis_rd [26], utils_rd [10], text_ex_rd [384], game_score_data_rd [210],
;[168947 total free]

; Level 0 ram-disk data layout
; bank0 addr0    [ 2796 free] description: 
;                             hero_r_sprites [13818], skeleton_sprites [10140], scythe_sprites [1626], bomb_sprites [960], snowflake_sprites [1332], font_gfx [1840], 
; bank0 addr8000 [16818 free] description: 
;                             level00_data [3820], backs_sprites [620], decals_sprites [4446], vfx4_sprites [4686], tiled_images_gfx [2178], tiled_images_data [200], 
; bank1 addr0    [ 6514 free] description: 
;                             knight_sprites [16398], burner_sprites [9600], 
; bank1 addr8000 [ 8192 free] description: $A000-$FFFF backbuffer2 (to restore a background in the backbuffer) 
;
; bank2 addr0    [ 9172 free] description: 
;                             hero_l_sprites [13818], sword_sprites [9522],
; bank2 addr8000 [10985 free] description: sound and music must be at >= $8000 addr. $F102-$FFFF music player runtime buffers 
;                             sound_rd [794], song00 [8576], transition_song01 [8576]
; bank3 addr0    [26790 free] description: 
;                             level00_gfx [5722], 
; bank3 addr8000 [ 6736 free] description: $8000-$9FFF code library. $A000-$FFFF backbuffer (to avoid sprite flickering)  
;                             global_consts_rd [0], sprite_rd [168], draw_sprite_rd [340], draw_sprite_hit_rd [318], draw_sprite_invis_rd [26], utils_rd [10], text_ex_rd [384], game_score_data_rd [210], 
;[88003 total free]

; Level 1 ram-disk data layout
; bank0 addr0    [ 2796 free] description: 
;                             hero_r_sprites [13818], skeleton_sprites [10140], scythe_sprites [1626], bomb_sprites [960], snowflake_sprites [1332], font_gfx [1840], 
; bank0 addr8000 [ 1886 free] description: 
;                             level01_data [18752], backs_sprites [620], decals_sprites [4446], vfx4_sprites [4686], tiled_images_gfx [2178], tiled_images_data [200], 
; bank1 addr0    [ 6514 free] description: 
;                             knight_sprites [16398], burner_sprites [9600], 
; bank1 addr8000 [  308 free] description: $A000-$FFFF backbuffer2 (to restore a background in the backbuffer) 
;                             vampire_sprites [7884],
; bank2 addr0    [ 9172 free] description: 
;                             hero_l_sprites [13818], sword_sprites [9522],
; bank2 addr8000 [10985 free] description: sound and music must be at >= $8000 addr. $F102-$FFFF music player runtime buffers 
;                             sound_rd [794], song01 [8576], transition_song01 [8576]
; bank3 addr0    [25926 free] description: 
;                             level01_gfx [6586], 
; bank3 addr8000 [ 6736 free] description: $8000-$9FFF code library. $A000-$FFFF backbuffer (to avoid sprite flickering)  
;                             global_consts_rd [0], sprite_rd [168], draw_sprite_rd [340], draw_sprite_hit_rd [318], draw_sprite_invis_rd [26], utils_rd [10], text_ex_rd [384], game_score_data_rd [210], 
;[64323 total free]

