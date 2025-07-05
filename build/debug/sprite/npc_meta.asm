; fdd bin file metadata
; asm data file: build/debug/sprite/npc_data.asm
; bin file: build/debug/bin/NPC.BIN

NPC_FILE_LEN = 2506
NPC_LAST_RECORD_LEN = 74

NPC_FILENAME_PTR:
			.byte "NPC" ; filename
			.byte "     " ; filename white chars
			.byte "BIN" ; extension

; relative frame labels
_npc_mom_idle0_0_relative = 2
_npc_mom_idle1_0_relative = 136
_npc_mom_idle2_0_relative = 270
_npc_sis_idle0_0_relative = 404
_npc_sis_idle1_0_relative = 530
_npc_sis_idle2_0_relative = 664
_npc_sis_idle3_0_relative = 798
_npc_bob_idle0_0_relative = 924
_npc_dotty_idle0_0_relative = 1050
_npc_dotty_idle1_0_relative = 1184
_npc_greenhat_idle0_0_relative = 1318
_npc_greenhat_idle1_0_relative = 1452
_npc_boy_idle0_0_relative = 1586
_npc_boy_idle1_0_relative = 1712
_npc_oldman_idle0_0_relative = 1838
_npc_oldman_idle1_0_relative = 1972
_npc_scarecrow_idle0_0_relative = 2106
_npc_scarecrow_idle1_0_relative = 2240
_npc_scarecrow_idle2_0_relative = 2374

npc_get_scr_addr:
			.word sprite_get_scr_addr1
npc_ram_disk_s_cmd:
			.byte TEMP_BYTE ; inited by sprite_init_meta_data
npc_preshifted_sprites:
			.byte 1
npc_anims:
			.word npc_mom_idle_anim, npc_sis_idle_anim, npc_bob_idle_anim, npc_dotty_idle_anim, npc_greenhat_idle_anim, npc_boy_idle_anim, npc_oldman_idle_anim, npc_scarecrow_idle_anim, EOD
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
npc_bob_idle_anim:
			.byte 255, $ff ; offset to the first frame
			.word _npc_bob_idle0_0_relative, 
npc_dotty_idle_anim:
			.byte 3, 0 ; offset to the next frame
			.word _npc_dotty_idle0_0_relative, 
			.byte 251, $ff ; offset to the first frame
			.word _npc_dotty_idle1_0_relative, 
npc_greenhat_idle_anim:
			.byte 3, 0 ; offset to the next frame
			.word _npc_greenhat_idle0_0_relative, 
			.byte 251, $ff ; offset to the first frame
			.word _npc_greenhat_idle1_0_relative, 
npc_boy_idle_anim:
			.byte 3, 0 ; offset to the next frame
			.word _npc_boy_idle0_0_relative, 
			.byte 251, $ff ; offset to the first frame
			.word _npc_boy_idle1_0_relative, 
npc_oldman_idle_anim:
			.byte 3, 0 ; offset to the next frame
			.word _npc_oldman_idle0_0_relative, 
			.byte 251, $ff ; offset to the first frame
			.word _npc_oldman_idle1_0_relative, 
npc_scarecrow_idle_anim:
			.byte 3, 0 ; offset to the next frame
			.word _npc_scarecrow_idle0_0_relative, 
			.byte 3, 0 ; offset to the next frame
			.word _npc_scarecrow_idle1_0_relative, 
			.byte 3, 0 ; offset to the next frame
			.word _npc_scarecrow_idle2_0_relative, 
			.byte 243, $ff ; offset to the first frame
			.word _npc_scarecrow_idle1_0_relative, 
npc_anims_end:
npc_anims_len: = npc_anims_end - npc_anims
