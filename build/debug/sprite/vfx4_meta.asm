; fdd bin file metadata
; asm data file: build/debug/sprite/vfx4_data.asm
; bin file: build/debug/bin/VFX4.BIN

VFX4_FILE_LEN = 2640
VFX4_LAST_RECORD_LEN = 80

VFX4_FILENAME_PTR:
			.byte "VFX4" ; filename
			.byte "    " ; filename white chars
			.byte "BIN" ; extension

; relative frame labels
_vfx4_hit0_0_relative = 2
_vfx4_hit0_1_relative = 96
_vfx4_hit0_2_relative = 190
_vfx4_hit0_3_relative = 284
_vfx4_hit1_0_relative = 378
_vfx4_hit1_1_relative = 480
_vfx4_hit1_2_relative = 582
_vfx4_hit1_3_relative = 684
_vfx4_hit2_0_relative = 786
_vfx4_hit2_1_relative = 904
_vfx4_hit2_2_relative = 1022
_vfx4_hit2_3_relative = 1140
_vfx4_hit3_0_relative = 1258
_vfx4_hit3_1_relative = 1392
_vfx4_hit3_2_relative = 1526
_vfx4_hit3_3_relative = 1660
_vfx4_hero_death1_0_relative = 1794
_vfx4_hero_death1_1_relative = 1896
_vfx4_hero_death1_2_relative = 1998
_vfx4_hero_death1_3_relative = 2148
_vfx4_hero_death2_0_relative = 2298
_vfx4_hero_death2_1_relative = 2368
_vfx4_hero_death2_2_relative = 2438
_vfx4_hero_death2_3_relative = 2540

vfx4_get_scr_addr:
			.word sprite_get_scr_addr4
vfx4_ram_disk_s_cmd:
			.byte TEMP_BYTE ; inited by sprite_init_meta_data
vfx4_preshifted_sprites:
			.byte 4
vfx4_anims:
			.word vfx4_hit_anim, vfx4_hero_death_anim, vfx4_spark_anim, EOD
vfx4_hit_anim:
			.byte 9, 0 ; offset to the next frame
			.word _vfx4_hit0_0_relative, _vfx4_hit0_1_relative, _vfx4_hit0_2_relative, _vfx4_hit0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _vfx4_hit0_0_relative, _vfx4_hit0_1_relative, _vfx4_hit0_2_relative, _vfx4_hit0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _vfx4_hit1_0_relative, _vfx4_hit1_1_relative, _vfx4_hit1_2_relative, _vfx4_hit1_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _vfx4_hit2_0_relative, _vfx4_hit2_1_relative, _vfx4_hit2_2_relative, _vfx4_hit2_3_relative, 
			.byte -1, $ff ; offset to the same last frame
			.word _vfx4_hit3_0_relative, _vfx4_hit3_1_relative, _vfx4_hit3_2_relative, _vfx4_hit3_3_relative, 
vfx4_hero_death_anim:
			.byte 9, 0 ; offset to the next frame
			.word _vfx4_hero_death1_0_relative, _vfx4_hero_death1_1_relative, _vfx4_hero_death1_2_relative, _vfx4_hero_death1_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _vfx4_hero_death1_0_relative, _vfx4_hero_death1_1_relative, _vfx4_hero_death1_2_relative, _vfx4_hero_death1_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _vfx4_hero_death1_0_relative, _vfx4_hero_death1_1_relative, _vfx4_hero_death1_2_relative, _vfx4_hero_death1_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _vfx4_hero_death1_0_relative, _vfx4_hero_death1_1_relative, _vfx4_hero_death1_2_relative, _vfx4_hero_death1_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _vfx4_hero_death2_0_relative, _vfx4_hero_death2_1_relative, _vfx4_hero_death2_2_relative, _vfx4_hero_death2_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _vfx4_hero_death2_0_relative, _vfx4_hero_death2_1_relative, _vfx4_hero_death2_2_relative, _vfx4_hero_death2_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _vfx4_hero_death2_0_relative, _vfx4_hero_death2_1_relative, _vfx4_hero_death2_2_relative, _vfx4_hero_death2_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _vfx4_hero_death2_0_relative, _vfx4_hero_death2_1_relative, _vfx4_hero_death2_2_relative, _vfx4_hero_death2_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _vfx4_hero_death2_0_relative, _vfx4_hero_death2_1_relative, _vfx4_hero_death2_2_relative, _vfx4_hero_death2_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _vfx4_hero_death2_0_relative, _vfx4_hero_death2_1_relative, _vfx4_hero_death2_2_relative, _vfx4_hero_death2_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _vfx4_hero_death2_0_relative, _vfx4_hero_death2_1_relative, _vfx4_hero_death2_2_relative, _vfx4_hero_death2_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _vfx4_hero_death2_0_relative, _vfx4_hero_death2_1_relative, _vfx4_hero_death2_2_relative, _vfx4_hero_death2_3_relative, 
			.byte -1, $ff ; offset to the same last frame
			.word _vfx4_hero_death2_0_relative, _vfx4_hero_death2_1_relative, _vfx4_hero_death2_2_relative, _vfx4_hero_death2_3_relative, 
vfx4_spark_anim:
			.byte 9, 0 ; offset to the next frame
			.word _vfx4_hit0_0_relative, _vfx4_hit0_1_relative, _vfx4_hit0_2_relative, _vfx4_hit0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _vfx4_hit1_0_relative, _vfx4_hit1_1_relative, _vfx4_hit1_2_relative, _vfx4_hit1_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _vfx4_hit2_0_relative, _vfx4_hit2_1_relative, _vfx4_hit2_2_relative, _vfx4_hit2_3_relative, 
			.byte 225, $ff ; offset to the first frame
			.word _vfx4_hit3_0_relative, _vfx4_hit3_1_relative, _vfx4_hit3_2_relative, _vfx4_hit3_3_relative, 
vfx4_anims_end:
vfx4_anims_len: = vfx4_anims_end - vfx4_anims
