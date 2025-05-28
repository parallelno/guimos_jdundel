memusage_npc:


; draw a sprite into a backbuffer
; in:
; de - ptr to monster_draw_ptr 
npc_draw:
			ACTOR_DRAW(sprite_get_scr_addr_npc, RAM_DISK_S_NPC, false)
