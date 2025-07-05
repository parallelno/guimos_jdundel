memusage_npc:


; draw a sprite into a backbuffer
; in:
; de - ptr to monster_draw_ptr 
npc_draw:
			ACTOR_DRAW(npc_get_scr_addr, npc_ram_disk_s_cmd, false)
