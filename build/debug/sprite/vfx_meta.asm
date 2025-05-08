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
_vfx_invis_0_relative = 2
_vfx_puff0_0_relative = 38
_vfx_puff1_0_relative = 176
_vfx_puff2_0_relative = 362
_vfx_puff3_0_relative = 548
_vfx_reward0_0_relative = 734
_vfx_reward1_0_relative = 920
_vfx_reward2_0_relative = 1118
_vfx_reward3_0_relative = 1280
_vfx_selection0_0_relative = 1394
_vfx_firepool0_0_relative = 1592
_vfx_firepool1_0_relative = 1790
_vfx_firepool2_0_relative = 1988

sprite_get_scr_addr_vfx = sprite_get_scr_addr1

vfx_preshifted_sprites:
			.byte 1
vfx_anims:
			.word vfx_puff_anim, vfx_puff_loop_anim, vfx_reward_anim, vfx_firepool_anim, vfx_selection_anim, EOD
vfx_puff_anim:
			.byte 3, 0 ; offset to the next frame
			.word _vfx_puff0_0_relative, 
			.byte 3, 0 ; offset to the next frame
			.word _vfx_puff0_0_relative, 
			.byte 3, 0 ; offset to the next frame
			.word _vfx_puff1_0_relative, 
			.byte 3, 0 ; offset to the next frame
			.word _vfx_puff2_0_relative, 
			.byte -1, $ff ; offset to the same last frame
			.word _vfx_puff3_0_relative, 
vfx_puff_loop_anim:
			.byte 3, 0 ; offset to the next frame
			.word _vfx_puff0_0_relative, 
			.byte 3, 0 ; offset to the next frame
			.word _vfx_puff0_0_relative, 
			.byte 3, 0 ; offset to the next frame
			.word _vfx_puff1_0_relative, 
			.byte 3, 0 ; offset to the next frame
			.word _vfx_puff2_0_relative, 
			.byte 3, 0 ; offset to the next frame
			.word _vfx_puff3_0_relative, 
			.byte 3, 0 ; offset to the next frame
			.word _vfx_invis_0_relative, 
			.byte 3, 0 ; offset to the next frame
			.word _vfx_invis_0_relative, 
			.byte 227, $ff ; offset to the first frame
			.word _vfx_invis_0_relative, 
vfx_reward_anim:
			.byte 3, 0 ; offset to the next frame
			.word _vfx_reward0_0_relative, 
			.byte 3, 0 ; offset to the next frame
			.word _vfx_reward1_0_relative, 
			.byte 3, 0 ; offset to the next frame
			.word _vfx_reward3_0_relative, 
			.byte 3, 0 ; offset to the next frame
			.word _vfx_reward2_0_relative, 
			.byte 3, 0 ; offset to the next frame
			.word _vfx_reward3_0_relative, 
			.byte 3, 0 ; offset to the next frame
			.word _vfx_reward0_0_relative, 
			.byte -1, $ff ; offset to the same last frame
			.word _vfx_reward3_0_relative, 
vfx_firepool_anim:
			.byte 3, 0 ; offset to the next frame
			.word _vfx_firepool0_0_relative, 
			.byte 3, 0 ; offset to the next frame
			.word _vfx_firepool1_0_relative, 
			.byte 247, $ff ; offset to the first frame
			.word _vfx_firepool2_0_relative, 
vfx_selection_anim:
			.byte 255, $ff ; offset to the first frame
			.word _vfx_selection0_0_relative, 
vfx_anims_end:
vfx_anims_len: = vfx_anims_end - vfx_anims
