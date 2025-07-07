memusage_npc:


; draw a sprite into a backbuffer
; in:
; de - ptr to monster_draw_ptr 
npc_draw:
			lhld npc_get_scr_addr
			lda npc_ram_disk_s_cmd
			jmp actor_draw
