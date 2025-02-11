; fdd bin file metadata
; asm data file: build/debug/sprite/vfx4_data.asm
; bin file: build/debug/bin/VFX4.BIN

VFX4_FILE_LEN = 4686
VFX4_LAST_RECORD_LEN = 78

VFX4_FILENAME_PTR:
			.byte "VFX4" ; filename
			.byte "    " ; filename white chars
			.byte "BIN" ; extension

; relative labels. to make it global call __text_ex_rd_init
_vfx4_hit0_0 = 2
_vfx4_hit0_1 = 134
_vfx4_hit0_2 = 266
_vfx4_hit0_3 = 464
_vfx4_hit1_0 = 596
_vfx4_hit1_1 = 740
_vfx4_hit1_2 = 884
_vfx4_hit1_3 = 1100
_vfx4_hit2_0 = 1244
_vfx4_hit2_1 = 1412
_vfx4_hit2_2 = 1664
_vfx4_hit2_3 = 1916
_vfx4_hit3_0 = 2168
_vfx4_hit3_1 = 2360
_vfx4_hit3_2 = 2648
_vfx4_hit3_3 = 2936
_vfx4_hero_death1_0 = 3224
_vfx4_hero_death1_1 = 3368
_vfx4_hero_death1_2 = 3584
_vfx4_hero_death1_3 = 3800
_vfx4_hero_death2_0 = 4016
_vfx4_hero_death2_1 = 4112
_vfx4_hero_death2_2 = 4256
_vfx4_hero_death2_3 = 4400

sprite_get_scr_addr_vfx4 = sprite_get_scr_addr4

_vfx4_preshifted_sprites:
			.byte 4
_vfx4_anims:
			.word _vfx4_hit, _vfx4_hero_death, _vfx4_spark, 0, 
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
