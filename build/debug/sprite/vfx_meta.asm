; fdd bin file metadata
; asm data file: build/debug/sprite/vfx_data.asm
; bin file: build/debug/bin/VFX.BIN

VFX_FILE_LEN = 2184
VFX_LAST_RECORD_LEN = 8

VFX_FILENAME_PTR:
			.byte "VFX" ; filename
			.byte "     " ; filename white chars
			.byte "BIN" ; extension

; relative labels. to make it global call __text_ex_rd_init
_vfx_invis_0 = 2
_vfx_puff0_0 = 32
_vfx_puff1_0 = 164
_vfx_puff2_0 = 344
_vfx_puff3_0 = 524
_vfx_reward0_0 = 704
_vfx_reward1_0 = 884
_vfx_reward2_0 = 1076
_vfx_reward3_0 = 1232
_vfx_selection_0 = 1340
_vfx_firepool0_0 = 1532
_vfx_firepool1_0 = 1724
_vfx_firepool2_0 = 1916

_vfx_anims:
			.word _vfx_puff, _vfx_puff_loop, _vfx_reward, _vfx_firepool, 0, 
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
