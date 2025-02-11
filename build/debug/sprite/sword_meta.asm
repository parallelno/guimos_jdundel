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
_sword_sword_delay_1 = 38
_sword_sword_delay_2 = 98
_sword_sword_delay_3 = 158
_sword_sword_delay_4 = 218
_sword_sword_delay_5 = 278
_sword_sword_delay_6 = 338
_sword_sword_delay_7 = 398
_sword_sword_r0_0 = 458
_sword_sword_r0_1 = 656
_sword_sword_r0_2 = 944
_sword_sword_r0_3 = 1232
_sword_sword_r0_4 = 1520
_sword_sword_r0_5 = 1808
_sword_sword_r0_6 = 2096
_sword_sword_r0_7 = 2384
_sword_sword_r1_0 = 2672
_sword_sword_r1_1 = 2870
_sword_sword_r1_2 = 3158
_sword_sword_r1_3 = 3446
_sword_sword_r1_4 = 3734
_sword_sword_r1_5 = 4022
_sword_sword_r1_6 = 4310
_sword_sword_r1_7 = 4598
_sword_sword_l0_0 = 4886
_sword_sword_l0_1 = 5084
_sword_sword_l0_2 = 5372
_sword_sword_l0_3 = 5660
_sword_sword_l0_4 = 5948
_sword_sword_l0_5 = 6236
_sword_sword_l0_6 = 6524
_sword_sword_l0_7 = 6812
_sword_sword_l1_0 = 7100
_sword_sword_l1_1 = 7298
_sword_sword_l1_2 = 7586
_sword_sword_l1_3 = 7874
_sword_sword_l1_4 = 8162
_sword_sword_l1_5 = 8450
_sword_sword_l1_6 = 8738
_sword_sword_l1_7 = 9026

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
