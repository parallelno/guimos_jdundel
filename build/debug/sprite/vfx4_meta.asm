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
_vfx4_hit0_0 = 1
_vfx4_hit0_1 = 1
_vfx4_hit0_2 = 1
_vfx4_hit0_3 = 1
_vfx4_hit1_0 = 1
_vfx4_hit1_1 = 1
_vfx4_hit1_2 = 1
_vfx4_hit1_3 = 1
_vfx4_hit2_0 = 1
_vfx4_hit2_1 = 1
_vfx4_hit2_2 = 1
_vfx4_hit2_3 = 1
_vfx4_hit3_0 = 1
_vfx4_hit3_1 = 1
_vfx4_hit3_2 = 1
_vfx4_hit3_3 = 1
_vfx4_hero_death1_0 = 1
_vfx4_hero_death1_1 = 1
_vfx4_hero_death1_2 = 1
_vfx4_hero_death1_3 = 1
_vfx4_hero_death2_0 = 1
_vfx4_hero_death2_1 = 1
_vfx4_hero_death2_2 = 1
_vfx4_hero_death2_3 = 1
