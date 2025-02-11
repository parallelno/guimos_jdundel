; fdd bin file metadata
; asm data file: build/debug/sprite/bomb_data.asm
; bin file: build/debug/bin/BOMB.BIN

BOMB_FILE_LEN = 960
BOMB_LAST_RECORD_LEN = 64

BOMB_FILENAME_PTR:
			.byte "BOMB" ; filename
			.byte "    " ; filename white chars
			.byte "BIN" ; extension

; relative labels. to make it global call __text_ex_rd_init

sprite_get_scr_addr_bomb = sprite_get_scr_addr4

_bomb_preshifted_sprites:
			.byte 4
_bomb_anims:
			.word _bomb_run, _bomb_dmg, 0, 
_bomb_run:
			.byte 9, 0 ; offset to the next frame
			.word _bomb_run0_0, _bomb_run0_1, _bomb_run0_2, _bomb_run0_3, 
			.byte 245, $ff ; offset to the first frame
			.word _bomb_run1_0, _bomb_run1_1, _bomb_run1_2, _bomb_run1_3, 
_bomb_dmg:
			.byte 9, 0 ; offset to the next frame
			.word _bomb_dmg0_0, _bomb_dmg0_1, _bomb_dmg0_2, _bomb_dmg0_3, 
			.byte 245, $ff ; offset to the first frame
			.word _bomb_dmg1_0, _bomb_dmg1_1, _bomb_dmg1_2, _bomb_dmg1_3, 
_bomb_run0_0 = 1
_bomb_run0_1 = 1
_bomb_run0_2 = 1
_bomb_run0_3 = 1
_bomb_run1_0 = 1
_bomb_run1_1 = 1
_bomb_run1_2 = 1
_bomb_run1_3 = 1
_bomb_dmg0_0 = 1
_bomb_dmg0_1 = 1
_bomb_dmg0_2 = 1
_bomb_dmg0_3 = 1
_bomb_dmg1_0 = 1
_bomb_dmg1_1 = 1
_bomb_dmg1_2 = 1
_bomb_dmg1_3 = 1
