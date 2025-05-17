; fdd bin file metadata
; asm data file: build/debug/sprite/firepool_data.asm
; bin file: build/debug/bin/FIREPOOL.BIN

FIREPOOL_FILE_LEN = 822
FIREPOOL_LAST_RECORD_LEN = 54

FIREPOOL_FILENAME_PTR:
			.byte "FIREPOOL" ; filename
			.byte "BIN" ; extension

; relative frame labels
_firepool_idle0_0_relative = 2
_firepool_idle1_0_relative = 152
_firepool_idle2_0_relative = 302
_firepool_idle3_0_relative = 488
_firepool_idle4_0_relative = 662

sprite_get_scr_addr_firepool = sprite_get_scr_addr1

firepool_preshifted_sprites:
			.byte 1
firepool_anims:
			.word firepool_idle_anim, EOD
firepool_idle_anim:
			.byte 3, 0 ; offset to the next frame
			.word _firepool_idle0_0_relative, 
			.byte 3, 0 ; offset to the next frame
			.word _firepool_idle1_0_relative, 
			.byte 3, 0 ; offset to the next frame
			.word _firepool_idle2_0_relative, 
			.byte 3, 0 ; offset to the next frame
			.word _firepool_idle3_0_relative, 
			.byte 239, $ff ; offset to the first frame
			.word _firepool_idle4_0_relative, 
firepool_anims_end:
firepool_anims_len: = firepool_anims_end - firepool_anims
