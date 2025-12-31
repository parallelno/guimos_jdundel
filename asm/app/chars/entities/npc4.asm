@memusage_npc4:

; draw a sprite into a backbuffer
; in:
; de - ptr to char_draw_ptr
npc4_draw:
			lhld npc4_get_scr_addr
			lda npc4_ram_disk_s_cmd
			jmp actor_draw
