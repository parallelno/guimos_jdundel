; fdd bin file metadata
; asm data file: build/debug/sprite/sword_data.asm
; bin file: build/debug/bin/SWORD.BIN

SWORD_FILE_LEN = 9522
SWORD_LAST_RECORD_LEN = 50

SWORD_FILENAME_PTR:
			.byte "SWORD" ; filename
			.byte "   " ; filename white chars
			.byte "BIN" ; extension

; relative labels. to make it global call __text_ex_rd_init
_sword_sword_delay_0 = 2
_sword_sword_delay_1 = 32
_sword_sword_delay_2 = 92
_sword_sword_delay_3 = 152
_sword_sword_delay_4 = 212
_sword_sword_delay_5 = 272
_sword_sword_delay_6 = 332
_sword_sword_delay_7 = 392
_sword_sword_r0_0 = 452
_sword_sword_r0_1 = 644
_sword_sword_r0_2 = 932
_sword_sword_r0_3 = 1220
_sword_sword_r0_4 = 1508
_sword_sword_r0_5 = 1796
_sword_sword_r0_6 = 2084
_sword_sword_r0_7 = 2372
_sword_sword_r1_0 = 2660
_sword_sword_r1_1 = 2852
_sword_sword_r1_2 = 3140
_sword_sword_r1_3 = 3428
_sword_sword_r1_4 = 3716
_sword_sword_r1_5 = 4004
_sword_sword_r1_6 = 4292
_sword_sword_r1_7 = 4580
_sword_sword_l0_0 = 4868
_sword_sword_l0_1 = 5060
_sword_sword_l0_2 = 5348
_sword_sword_l0_3 = 5636
_sword_sword_l0_4 = 5924
_sword_sword_l0_5 = 6212
_sword_sword_l0_6 = 6500
_sword_sword_l0_7 = 6788
_sword_sword_l1_0 = 7076
_sword_sword_l1_1 = 7268
_sword_sword_l1_2 = 7556
_sword_sword_l1_3 = 7844
_sword_sword_l1_4 = 8132
_sword_sword_l1_5 = 8420
_sword_sword_l1_6 = 8708
_sword_sword_l1_7 = 8996

sprite_get_scr_addr_sword = sprite_get_scr_addr8

_sword_preshifted_sprites:
			.byte 8
_sword_anims:
			.word _sword_delay, _sword_attk_r, _sword_attk_l, 0, 
_sword_delay:
			.byte -1, $ff ; offset to the same last frame
			.word _sword_sword_delay_0, _sword_sword_delay_1, _sword_sword_delay_2, _sword_sword_delay_3, _sword_sword_delay_4, _sword_sword_delay_5, _sword_sword_delay_6, _sword_sword_delay_7, 
_sword_attk_r:
			.byte 17, 0 ; offset to the next frame
			.word _sword_sword_r0_0, _sword_sword_r0_1, _sword_sword_r0_2, _sword_sword_r0_3, _sword_sword_r0_4, _sword_sword_r0_5, _sword_sword_r0_6, _sword_sword_r0_7, 
			.byte -1, $ff ; offset to the same last frame
			.word _sword_sword_r1_0, _sword_sword_r1_1, _sword_sword_r1_2, _sword_sword_r1_3, _sword_sword_r1_4, _sword_sword_r1_5, _sword_sword_r1_6, _sword_sword_r1_7, 
_sword_attk_l:
			.byte 17, 0 ; offset to the next frame
			.word _sword_sword_l0_0, _sword_sword_l0_1, _sword_sword_l0_2, _sword_sword_l0_3, _sword_sword_l0_4, _sword_sword_l0_5, _sword_sword_l0_6, _sword_sword_l0_7, 
			.byte -1, $ff ; offset to the same last frame
			.word _sword_sword_l1_0, _sword_sword_l1_1, _sword_sword_l1_2, _sword_sword_l1_3, _sword_sword_l1_4, _sword_sword_l1_5, _sword_sword_l1_6, _sword_sword_l1_7, 
