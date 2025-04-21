; fdd bin file metadata
; asm data file: build/debug/sprite/npc_data.asm
; bin file: build/debug/bin/NPC.BIN

NPC_FILE_LEN = 3048
NPC_LAST_RECORD_LEN = 104

NPC_FILENAME_PTR:
			.byte "NPC" ; filename
			.byte "     " ; filename white chars
			.byte "BIN" ; extension

; relative frame labels
_npc_mom_idle0_0_relative = 2
_npc_mom_idle0_1_relative = 200
_npc_mom_idle0_2_relative = 398
_npc_mom_idle0_3_relative = 692
_npc_mom_idle1_0_relative = 986
_npc_mom_idle1_1_relative = 1184
_npc_mom_idle1_2_relative = 1478
_npc_mom_idle1_3_relative = 1772
_npc_mom_idle2_0_relative = 2066
_npc_mom_idle2_1_relative = 2264
_npc_mom_idle2_2_relative = 2462
_npc_mom_idle2_3_relative = 2756

sprite_get_scr_addr_npc = sprite_get_scr_addr4

npc_preshifted_sprites:
			.byte 4
npc_anims:
			.word npc_mom_idle_anim, EOD
npc_mom_idle_anim:
			.byte 9, 0 ; offset to the next frame
			.word _npc_mom_idle0_0_relative, _npc_mom_idle0_1_relative, _npc_mom_idle0_2_relative, _npc_mom_idle0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _npc_mom_idle0_0_relative, _npc_mom_idle0_1_relative, _npc_mom_idle0_2_relative, _npc_mom_idle0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _npc_mom_idle1_0_relative, _npc_mom_idle1_1_relative, _npc_mom_idle1_2_relative, _npc_mom_idle1_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _npc_mom_idle2_0_relative, _npc_mom_idle2_1_relative, _npc_mom_idle2_2_relative, _npc_mom_idle2_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _npc_mom_idle2_0_relative, _npc_mom_idle2_1_relative, _npc_mom_idle2_2_relative, _npc_mom_idle2_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _npc_mom_idle1_0_relative, _npc_mom_idle1_1_relative, _npc_mom_idle1_2_relative, _npc_mom_idle1_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _npc_mom_idle0_0_relative, _npc_mom_idle0_1_relative, _npc_mom_idle0_2_relative, _npc_mom_idle0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _npc_mom_idle0_0_relative, _npc_mom_idle0_1_relative, _npc_mom_idle0_2_relative, _npc_mom_idle0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _npc_mom_idle1_0_relative, _npc_mom_idle1_1_relative, _npc_mom_idle1_2_relative, _npc_mom_idle1_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _npc_mom_idle0_0_relative, _npc_mom_idle0_1_relative, _npc_mom_idle0_2_relative, _npc_mom_idle0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _npc_mom_idle0_0_relative, _npc_mom_idle0_1_relative, _npc_mom_idle0_2_relative, _npc_mom_idle0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _npc_mom_idle0_0_relative, _npc_mom_idle0_1_relative, _npc_mom_idle0_2_relative, _npc_mom_idle0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _npc_mom_idle0_0_relative, _npc_mom_idle0_1_relative, _npc_mom_idle0_2_relative, _npc_mom_idle0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _npc_mom_idle0_0_relative, _npc_mom_idle0_1_relative, _npc_mom_idle0_2_relative, _npc_mom_idle0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _npc_mom_idle0_0_relative, _npc_mom_idle0_1_relative, _npc_mom_idle0_2_relative, _npc_mom_idle0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _npc_mom_idle0_0_relative, _npc_mom_idle0_1_relative, _npc_mom_idle0_2_relative, _npc_mom_idle0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _npc_mom_idle2_0_relative, _npc_mom_idle2_1_relative, _npc_mom_idle2_2_relative, _npc_mom_idle2_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _npc_mom_idle0_0_relative, _npc_mom_idle0_1_relative, _npc_mom_idle0_2_relative, _npc_mom_idle0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _npc_mom_idle0_0_relative, _npc_mom_idle0_1_relative, _npc_mom_idle0_2_relative, _npc_mom_idle0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _npc_mom_idle1_0_relative, _npc_mom_idle1_1_relative, _npc_mom_idle1_2_relative, _npc_mom_idle1_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _npc_mom_idle2_0_relative, _npc_mom_idle2_1_relative, _npc_mom_idle2_2_relative, _npc_mom_idle2_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _npc_mom_idle2_0_relative, _npc_mom_idle2_1_relative, _npc_mom_idle2_2_relative, _npc_mom_idle2_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _npc_mom_idle2_0_relative, _npc_mom_idle2_1_relative, _npc_mom_idle2_2_relative, _npc_mom_idle2_3_relative, 
			.byte 25, $ff ; offset to the first frame
			.word _npc_mom_idle2_0_relative, _npc_mom_idle2_1_relative, _npc_mom_idle2_2_relative, _npc_mom_idle2_3_relative, 
