memusage_npc4:

; draw a sprite into a backbuffer
; in:
; de - ptr to monster_draw_ptr 
npc4_draw:
			ACTOR_DRAW(sprite_get_scr_addr_npc4, RAM_DISK_S_NPC4, false)
