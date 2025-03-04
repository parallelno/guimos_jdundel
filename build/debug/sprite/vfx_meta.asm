; fdd bin file metadata
; asm data file: build/debug/sprite/vfx_data.asm
; bin file: build/debug/bin/VFX.BIN

VFX_FILE_LEN = 2184
VFX_LAST_RECORD_LEN = 8

VFX_FILENAME_PTR:
			.byte "VFX" ; filename
			.byte "     " ; filename white chars
			.byte "BIN" ; extension

; relative frame labels
_vfx_invis_0 = 2
_vfx_puff0_0 = 38
_vfx_puff1_0 = 176
_vfx_puff2_0 = 362
_vfx_puff3_0 = 548
_vfx_reward0_0 = 734
_vfx_reward1_0 = 920
_vfx_reward2_0 = 1118
_vfx_reward3_0 = 1280
_vfx_selection_0 = 1394
_vfx_firepool0_0 = 1592
_vfx_firepool1_0 = 1790
_vfx_firepool2_0 = 1988

sprite_get_scr_addr_vfx = sprite_get_scr_addr1

_vfx_preshifted_sprites:
			.byte 1
_vfx_anims:
			.word _vfx_puff, _vfx_puff_loop, _vfx_reward, _vfx_firepool, EOD
_vfx_puff:
			.byte 3, 0 ; offset to the next frame
			.word _vfx_puff0_0, 
			.byte 3, 0 ; offset to the next frame
			.word _vfx_puff0_0, 
			.byte 3, 0 ; offset to the next frame
			.word _vfx_puff1_0, 
			.byte 3, 0 ; offset to the next frame
			.word _vfx_puff2_0, 
			.byte -1, $ff ; offset to the same last frame
			.word _vfx_puff3_0, 
_vfx_puff_loop:
			.byte 3, 0 ; offset to the next frame
			.word _vfx_puff0_0, 
			.byte 3, 0 ; offset to the next frame
			.word _vfx_puff0_0, 
			.byte 3, 0 ; offset to the next frame
			.word _vfx_puff1_0, 
			.byte 3, 0 ; offset to the next frame
			.word _vfx_puff2_0, 
			.byte 3, 0 ; offset to the next frame
			.word _vfx_puff3_0, 
			.byte 3, 0 ; offset to the next frame
			.word _vfx_invis_0, 
			.byte 3, 0 ; offset to the next frame
			.word _vfx_invis_0, 
			.byte 227, $ff ; offset to the first frame
			.word _vfx_invis_0, 
_vfx_reward:
			.byte 3, 0 ; offset to the next frame
			.word _vfx_reward0_0, 
			.byte 3, 0 ; offset to the next frame
			.word _vfx_reward1_0, 
			.byte 3, 0 ; offset to the next frame
			.word _vfx_reward3_0, 
			.byte 3, 0 ; offset to the next frame
			.word _vfx_reward2_0, 
			.byte 3, 0 ; offset to the next frame
			.word _vfx_reward3_0, 
			.byte 3, 0 ; offset to the next frame
			.word _vfx_reward0_0, 
			.byte -1, $ff ; offset to the same last frame
			.word _vfx_reward3_0, 
_vfx_firepool:
			.byte 3, 0 ; offset to the next frame
			.word _vfx_firepool0_0, 
			.byte 3, 0 ; offset to the next frame
			.word _vfx_firepool1_0, 
			.byte 247, $ff ; offset to the first frame
			.word _vfx_firepool2_0, 
