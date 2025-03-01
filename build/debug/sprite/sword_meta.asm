; fdd bin file metadata
; asm data file: build/debug/sprite/sword_data.asm
; bin file: build/debug/bin/SWORD.BIN

SWORD_FILE_LEN = 8688
SWORD_LAST_RECORD_LEN = 112

SWORD_FILENAME_PTR:
			.byte "SWORD" ; filename
			.byte "   " ; filename white chars
			.byte "BIN" ; extension

; relative frame labels
_sword_sword_delay_0 = 2
_sword_sword_delay_1 = 8
_sword_sword_delay_2 = 14
_sword_sword_delay_3 = 20
_sword_sword_delay_4 = 26
_sword_sword_delay_5 = 32
_sword_sword_delay_6 = 38
_sword_sword_delay_7 = 44
_sword_sword_r0_0 = 50
_sword_sword_r0_1 = 248
_sword_sword_r0_2 = 446
_sword_sword_r0_3 = 740
_sword_sword_r0_4 = 1034
_sword_sword_r0_5 = 1328
_sword_sword_r0_6 = 1622
_sword_sword_r0_7 = 1916
_sword_sword_r1_0 = 2210
_sword_sword_r1_1 = 2408
_sword_sword_r1_2 = 2606
_sword_sword_r1_3 = 2900
_sword_sword_r1_4 = 3194
_sword_sword_r1_5 = 3488
_sword_sword_r1_6 = 3782
_sword_sword_r1_7 = 4076
_sword_sword_l0_0 = 4370
_sword_sword_l0_1 = 4568
_sword_sword_l0_2 = 4766
_sword_sword_l0_3 = 5060
_sword_sword_l0_4 = 5354
_sword_sword_l0_5 = 5648
_sword_sword_l0_6 = 5942
_sword_sword_l0_7 = 6236
_sword_sword_l1_0 = 6530
_sword_sword_l1_1 = 6728
_sword_sword_l1_2 = 6926
_sword_sword_l1_3 = 7220
_sword_sword_l1_4 = 7514
_sword_sword_l1_5 = 7808
_sword_sword_l1_6 = 8102
_sword_sword_l1_7 = 8396

sprite_get_scr_addr_sword = sprite_get_scr_addr8

_sword_preshifted_sprites:
			.byte 8
_sword_anims:
			.word _sword_delay, _sword_attk_r, _sword_attk_l, EOD, 
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
