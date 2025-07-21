@memusage_npc

NPC_ANIM_SPEED_IDLE = 2

NPC_HEALTH = 0
NPC_DAMAGE = 0

green_hat_init:
boy_init:
old_man_init:


;========================================================
; anim and a gameplay logic update
; in:
; de - ptr to char_update_ptr
npc_update:
			; advance hl to char_anim_timer
			HL_ADVANCE(char_update_ptr, char_anim_timer, BY_HL_FROM_DE)
			mvi a, NPC_ANIM_SPEED_IDLE
			; hl - char_anim_timer
			; a - anim speed
			call actor_anim_update
			ret

; draw a sprite into a backbuffer
; in:
; de - ptr to char_draw_ptr
npc_draw:
			lhld npc_get_scr_addr
			lda npc_ram_disk_s_cmd
			jmp actor_draw
