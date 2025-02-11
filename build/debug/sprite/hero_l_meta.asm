; fdd bin file metadata
; asm data file: build/debug/sprite/hero_l_data.asm
; bin file: build/debug/bin/HERO_L.BIN

HERO_L_FILE_LEN = 13818
HERO_L_LAST_RECORD_LEN = 122

HERO_L_FILENAME_PTR:
			.byte "HERO_L" ; filename
			.byte "  " ; filename white chars
			.byte "BIN" ; extension

; relative labels. to make it global call __text_ex_rd_init

sprite_get_scr_addr_hero_l = sprite_get_scr_addr8

_hero_l_preshifted_sprites:
			.byte 8
_hero_l_anims:
			.word _hero_l_idle, _hero_l_run, _hero_l_attk, 0, 
_hero_l_idle:
			.byte 17, 0 ; offset to the next frame
			.word _hero_l_idle0_0, _hero_l_idle0_1, _hero_l_idle0_2, _hero_l_idle0_3, _hero_l_idle0_4, _hero_l_idle0_5, _hero_l_idle0_6, _hero_l_idle0_7, 
			.byte 17, 0 ; offset to the next frame
			.word _hero_l_idle0_0, _hero_l_idle0_1, _hero_l_idle0_2, _hero_l_idle0_3, _hero_l_idle0_4, _hero_l_idle0_5, _hero_l_idle0_6, _hero_l_idle0_7, 
			.byte 17, 0 ; offset to the next frame
			.word _hero_l_idle0_0, _hero_l_idle0_1, _hero_l_idle0_2, _hero_l_idle0_3, _hero_l_idle0_4, _hero_l_idle0_5, _hero_l_idle0_6, _hero_l_idle0_7, 
			.byte 201, $ff ; offset to the first frame
			.word _hero_l_run2_0, _hero_l_run2_1, _hero_l_run2_2, _hero_l_run2_3, _hero_l_run2_4, _hero_l_run2_5, _hero_l_run2_6, _hero_l_run2_7, 
_hero_l_run:
			.byte 17, 0 ; offset to the next frame
			.word _hero_l_run0_0, _hero_l_run0_1, _hero_l_run0_2, _hero_l_run0_3, _hero_l_run0_4, _hero_l_run0_5, _hero_l_run0_6, _hero_l_run0_7, 
			.byte 17, 0 ; offset to the next frame
			.word _hero_l_run1_0, _hero_l_run1_1, _hero_l_run1_2, _hero_l_run1_3, _hero_l_run1_4, _hero_l_run1_5, _hero_l_run1_6, _hero_l_run1_7, 
			.byte 17, 0 ; offset to the next frame
			.word _hero_l_run2_0, _hero_l_run2_1, _hero_l_run2_2, _hero_l_run2_3, _hero_l_run2_4, _hero_l_run2_5, _hero_l_run2_6, _hero_l_run2_7, 
			.byte 201, $ff ; offset to the first frame
			.word _hero_l_run3_0, _hero_l_run3_1, _hero_l_run3_2, _hero_l_run3_3, _hero_l_run3_4, _hero_l_run3_5, _hero_l_run3_6, _hero_l_run3_7, 
_hero_l_attk:
			.byte 17, 0 ; offset to the next frame
			.word _hero_l_attk0_0, _hero_l_attk0_1, _hero_l_attk0_2, _hero_l_attk0_3, _hero_l_attk0_4, _hero_l_attk0_5, _hero_l_attk0_6, _hero_l_attk0_7, 
			.byte -1, $ff ; offset to the same last frame
			.word _hero_l_attk1_0, _hero_l_attk1_1, _hero_l_attk1_2, _hero_l_attk1_3, _hero_l_attk1_4, _hero_l_attk1_5, _hero_l_attk1_6, _hero_l_attk1_7, 
_hero_l_idle0_0 = 1
_hero_l_idle0_1 = 1
_hero_l_idle0_2 = 1
_hero_l_idle0_3 = 1
_hero_l_idle0_4 = 1
_hero_l_idle0_5 = 1
_hero_l_idle0_6 = 1
_hero_l_idle0_7 = 1
_hero_l_run0_0 = 1
_hero_l_run0_1 = 1
_hero_l_run0_2 = 1
_hero_l_run0_3 = 1
_hero_l_run0_4 = 1
_hero_l_run0_5 = 1
_hero_l_run0_6 = 1
_hero_l_run0_7 = 1
_hero_l_run1_0 = 1
_hero_l_run1_1 = 1
_hero_l_run1_2 = 1
_hero_l_run1_3 = 1
_hero_l_run1_4 = 1
_hero_l_run1_5 = 1
_hero_l_run1_6 = 1
_hero_l_run1_7 = 1
_hero_l_run2_0 = 1
_hero_l_run2_1 = 1
_hero_l_run2_2 = 1
_hero_l_run2_3 = 1
_hero_l_run2_4 = 1
_hero_l_run2_5 = 1
_hero_l_run2_6 = 1
_hero_l_run2_7 = 1
_hero_l_run3_0 = 1
_hero_l_run3_1 = 1
_hero_l_run3_2 = 1
_hero_l_run3_3 = 1
_hero_l_run3_4 = 1
_hero_l_run3_5 = 1
_hero_l_run3_6 = 1
_hero_l_run3_7 = 1
_hero_l_attk0_0 = 1
_hero_l_attk0_1 = 1
_hero_l_attk0_2 = 1
_hero_l_attk0_3 = 1
_hero_l_attk0_4 = 1
_hero_l_attk0_5 = 1
_hero_l_attk0_6 = 1
_hero_l_attk0_7 = 1
_hero_l_attk1_0 = 1
_hero_l_attk1_1 = 1
_hero_l_attk1_2 = 1
_hero_l_attk1_3 = 1
_hero_l_attk1_4 = 1
_hero_l_attk1_5 = 1
_hero_l_attk1_6 = 1
_hero_l_attk1_7 = 1
