; fdd bin file metadata
; asm data file: build/debug/sprite/bomb_data.asm
; bin file: build/debug/bin/BOMB.BIN

BOMB_FILE_LEN = 960
BOMB_LAST_RECORD_LEN = 64

BOMB_FILENAME_PTR:
			.byte "BOMB" ; filename
			.byte "    " ; filename white chars
			.byte "BIN" ; extension

; relative frame labels
_bomb_run0_0_relative = 2
_bomb_run0_1_relative = 44
_bomb_run0_2_relative = 86
_bomb_run0_3_relative = 164
_bomb_run1_0_relative = 242
_bomb_run1_1_relative = 284
_bomb_run1_2_relative = 326
_bomb_run1_3_relative = 404
_bomb_dmg0_0_relative = 482
_bomb_dmg0_1_relative = 524
_bomb_dmg0_2_relative = 566
_bomb_dmg0_3_relative = 644
_bomb_dmg1_0_relative = 722
_bomb_dmg1_1_relative = 764
_bomb_dmg1_2_relative = 806
_bomb_dmg1_3_relative = 884

bomb_get_scr_addr:
			.word sprite_get_scr_addr4
bomb_ram_disk_s_cmd:
			.byte TEMP_BYTE ; inited by sprite_init_meta_data
bomb_preshifted_sprites:
			.byte 4
bomb_anims:
			.word bomb_run_anim, bomb_dmg_anim, EOD
bomb_run_anim:
			.byte 9, 0 ; offset to the next frame
			.word _bomb_run0_0_relative, _bomb_run0_1_relative, _bomb_run0_2_relative, _bomb_run0_3_relative, 
			.byte 245, $ff ; offset to the first frame
			.word _bomb_run1_0_relative, _bomb_run1_1_relative, _bomb_run1_2_relative, _bomb_run1_3_relative, 
bomb_dmg_anim:
			.byte 9, 0 ; offset to the next frame
			.word _bomb_dmg0_0_relative, _bomb_dmg0_1_relative, _bomb_dmg0_2_relative, _bomb_dmg0_3_relative, 
			.byte 245, $ff ; offset to the first frame
			.word _bomb_dmg1_0_relative, _bomb_dmg1_1_relative, _bomb_dmg1_2_relative, _bomb_dmg1_3_relative, 
bomb_anims_end:
bomb_anims_len: = bomb_anims_end - bomb_anims
