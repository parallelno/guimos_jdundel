; fdd bin file metadata
; asm data file: build/debug/sprite/vfx4_data.asm
; bin file: build/debug/bin/VFX4.BIN

VFX4_FILE_LEN = 3888
VFX4_LAST_RECORD_LEN = 48

VFX4_FILENAME_PTR:
			.byte "VFX4" ; filename
			.byte "    " ; filename white chars
			.byte "BIN" ; extension

; relative frame labels
_vfx4_hit0_0_relative = 2
_vfx4_hit0_1_relative = 140
_vfx4_hit0_2_relative = 278
_vfx4_hit0_3_relative = 416
_vfx4_hit1_0_relative = 554
_vfx4_hit1_1_relative = 704
_vfx4_hit1_2_relative = 854
_vfx4_hit1_3_relative = 1004
_vfx4_hit2_0_relative = 1154
_vfx4_hit2_1_relative = 1328
_vfx4_hit2_2_relative = 1502
_vfx4_hit2_3_relative = 1676
_vfx4_hit3_0_relative = 1850
_vfx4_hit3_1_relative = 2048
_vfx4_hit3_2_relative = 2246
_vfx4_hit3_3_relative = 2444
_vfx4_hero_death1_0_relative = 2642
_vfx4_hero_death1_1_relative = 2792
_vfx4_hero_death1_2_relative = 2942
_vfx4_hero_death1_3_relative = 3164
_vfx4_hero_death2_0_relative = 3386
_vfx4_hero_death2_1_relative = 3488
_vfx4_hero_death2_2_relative = 3590
_vfx4_hero_death2_3_relative = 3740

sprite_get_scr_addr_vfx4 = sprite_get_scr_addr4

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
