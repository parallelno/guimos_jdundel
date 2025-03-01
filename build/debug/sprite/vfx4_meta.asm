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
_vfx4_hit0_0 = 2
_vfx4_hit0_1 = 140
_vfx4_hit0_2 = 278
_vfx4_hit0_3 = 416
_vfx4_hit1_0 = 554
_vfx4_hit1_1 = 704
_vfx4_hit1_2 = 854
_vfx4_hit1_3 = 1004
_vfx4_hit2_0 = 1154
_vfx4_hit2_1 = 1328
_vfx4_hit2_2 = 1502
_vfx4_hit2_3 = 1676
_vfx4_hit3_0 = 1850
_vfx4_hit3_1 = 2048
_vfx4_hit3_2 = 2246
_vfx4_hit3_3 = 2444
_vfx4_hero_death1_0 = 2642
_vfx4_hero_death1_1 = 2792
_vfx4_hero_death1_2 = 2942
_vfx4_hero_death1_3 = 3164
_vfx4_hero_death2_0 = 3386
_vfx4_hero_death2_1 = 3488
_vfx4_hero_death2_2 = 3590
_vfx4_hero_death2_3 = 3740

sprite_get_scr_addr_vfx4 = sprite_get_scr_addr4

_vfx4_preshifted_sprites:
			.byte 4
_vfx4_anims:
			.word _vfx4_hit, _vfx4_hero_death, _vfx4_spark, EOD, 
_vfx4_hit:
			.byte 9, 0 ; offset to the next frame
			.word _vfx4_hit0_0, _vfx4_hit0_1, _vfx4_hit0_2, _vfx4_hit0_3, 
			.byte 9, 0 ; offset to the next frame
			.word _vfx4_hit0_0, _vfx4_hit0_1, _vfx4_hit0_2, _vfx4_hit0_3, 
			.byte 9, 0 ; offset to the next frame
			.word _vfx4_hit1_0, _vfx4_hit1_1, _vfx4_hit1_2, _vfx4_hit1_3, 
			.byte 9, 0 ; offset to the next frame
			.word _vfx4_hit2_0, _vfx4_hit2_1, _vfx4_hit2_2, _vfx4_hit2_3, 
			.byte -1, $ff ; offset to the same last frame
			.word _vfx4_hit3_0, _vfx4_hit3_1, _vfx4_hit3_2, _vfx4_hit3_3, 
_vfx4_hero_death:
			.byte 9, 0 ; offset to the next frame
			.word _vfx4_hero_death1_0, _vfx4_hero_death1_1, _vfx4_hero_death1_2, _vfx4_hero_death1_3, 
			.byte 9, 0 ; offset to the next frame
			.word _vfx4_hero_death1_0, _vfx4_hero_death1_1, _vfx4_hero_death1_2, _vfx4_hero_death1_3, 
			.byte 9, 0 ; offset to the next frame
			.word _vfx4_hero_death1_0, _vfx4_hero_death1_1, _vfx4_hero_death1_2, _vfx4_hero_death1_3, 
			.byte 9, 0 ; offset to the next frame
			.word _vfx4_hero_death1_0, _vfx4_hero_death1_1, _vfx4_hero_death1_2, _vfx4_hero_death1_3, 
			.byte 9, 0 ; offset to the next frame
			.word _vfx4_hero_death2_0, _vfx4_hero_death2_1, _vfx4_hero_death2_2, _vfx4_hero_death2_3, 
			.byte 9, 0 ; offset to the next frame
			.word _vfx4_hero_death2_0, _vfx4_hero_death2_1, _vfx4_hero_death2_2, _vfx4_hero_death2_3, 
			.byte 9, 0 ; offset to the next frame
			.word _vfx4_hero_death2_0, _vfx4_hero_death2_1, _vfx4_hero_death2_2, _vfx4_hero_death2_3, 
			.byte 9, 0 ; offset to the next frame
			.word _vfx4_hero_death2_0, _vfx4_hero_death2_1, _vfx4_hero_death2_2, _vfx4_hero_death2_3, 
			.byte 9, 0 ; offset to the next frame
			.word _vfx4_hero_death2_0, _vfx4_hero_death2_1, _vfx4_hero_death2_2, _vfx4_hero_death2_3, 
			.byte 9, 0 ; offset to the next frame
			.word _vfx4_hero_death2_0, _vfx4_hero_death2_1, _vfx4_hero_death2_2, _vfx4_hero_death2_3, 
			.byte 9, 0 ; offset to the next frame
			.word _vfx4_hero_death2_0, _vfx4_hero_death2_1, _vfx4_hero_death2_2, _vfx4_hero_death2_3, 
			.byte 9, 0 ; offset to the next frame
			.word _vfx4_hero_death2_0, _vfx4_hero_death2_1, _vfx4_hero_death2_2, _vfx4_hero_death2_3, 
			.byte -1, $ff ; offset to the same last frame
			.word _vfx4_hero_death2_0, _vfx4_hero_death2_1, _vfx4_hero_death2_2, _vfx4_hero_death2_3, 
_vfx4_spark:
			.byte 9, 0 ; offset to the next frame
			.word _vfx4_hit0_0, _vfx4_hit0_1, _vfx4_hit0_2, _vfx4_hit0_3, 
			.byte 9, 0 ; offset to the next frame
			.word _vfx4_hit1_0, _vfx4_hit1_1, _vfx4_hit1_2, _vfx4_hit1_3, 
			.byte 9, 0 ; offset to the next frame
			.word _vfx4_hit2_0, _vfx4_hit2_1, _vfx4_hit2_2, _vfx4_hit2_3, 
			.byte 225, $ff ; offset to the first frame
			.word _vfx4_hit3_0, _vfx4_hit3_1, _vfx4_hit3_2, _vfx4_hit3_3, 
