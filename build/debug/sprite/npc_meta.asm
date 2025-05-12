; fdd bin file metadata
; asm data file: build/debug/sprite/npc_data.asm
; bin file: build/debug/bin/NPC.BIN

NPC_FILE_LEN = 1362
NPC_LAST_RECORD_LEN = 82

NPC_FILENAME_PTR:
			.byte "NPC" ; filename
			.byte "     " ; filename white chars
			.byte "BIN" ; extension

; relative frame labels
_npc_mom_idle0_0_relative = 2
_npc_mom_idle1_0_relative = 200
_npc_mom_idle2_0_relative = 398
_npc_sis_idle0_0_relative = 596
_npc_sis_idle1_0_relative = 782
_npc_sis_idle2_0_relative = 980
_npc_sis_idle3_0_relative = 1178

sprite_get_scr_addr_npc = sprite_get_scr_addr1

npc_preshifted_sprites:
			.byte 1
npc_anims:
			.word npc_mom_idle_anim, npc_sis_idle_anim, EOD
npc_mom_idle_anim:
			.byte 3, 0 ; offset to the next frame
			.word _npc_mom_idle0_0_relative, 
			.byte 3, 0 ; offset to the next frame
			.word _npc_mom_idle0_0_relative, 
			.byte 3, 0 ; offset to the next frame
			.word _npc_mom_idle1_0_relative, 
			.byte 3, 0 ; offset to the next frame
			.word _npc_mom_idle2_0_relative, 
			.byte 3, 0 ; offset to the next frame
			.word _npc_mom_idle2_0_relative, 
			.byte 235, $ff ; offset to the first frame
			.word _npc_mom_idle1_0_relative, 
npc_sis_idle_anim:
			.byte 3, 0 ; offset to the next frame
			.word _npc_sis_idle0_0_relative, 
			.byte 3, 0 ; offset to the next frame
			.word _npc_sis_idle1_0_relative, 
			.byte 3, 0 ; offset to the next frame
			.word _npc_sis_idle2_0_relative, 
			.byte 243, $ff ; offset to the first frame
			.word _npc_sis_idle3_0_relative, 
npc_anims_end:
npc_anims_len: = npc_anims_end - npc_anims
