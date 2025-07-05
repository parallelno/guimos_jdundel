memusage_npc4:

; draw a sprite into a backbuffer
; in:
; de - ptr to monster_draw_ptr 
npc4_draw:
			ACTOR_DRAW(npc4_get_scr_addr, npc4_ram_disk_s_cmd, false)
