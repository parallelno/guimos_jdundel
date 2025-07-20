@memusage_npc

NPC_ANIM_SPEED_IDLE = 20

NPC_HEALTH = 0
NPC_DAMAGE = 0

green_hat_init:
boy_init:
old_man_init:
scarecrow_init:
mom_init:
.breakpoint
			MONSTER_INIT(npc_update, npc_draw, mom_impacted, NPC_HEALTH, ACTOR_STATUS_INIT, npc_mom_idle_anim, False, MONSTER_TYPE_ALLY)


;========================================================
; anim and a gameplay logic update
; in:
; de - ptr to monster_update_ptr
npc_update:
			; advance hl to monster_anim_timer
			HL_ADVANCE(monster_update_ptr, monster_anim_timer, BY_HL_FROM_DE)
			mvi a, NPC_ANIM_SPEED_IDLE
			; hl - monster_anim_timer
			; a - anim speed
			call actor_anim_update
			ret

; in:
; de - ptr to monster_impacted_ptr + 1
; c - hero_weapon_id
mom_impacted:
			; check the weapon_id
			mvi a, HERO_WEAPON_ID_SNOWFLAKE
			cmp c
			rz ; return if the hero used a snowflake
			; de - ptr to monster_impacted_ptr+1

			; TODO: add interaction logic
			ret

; draw a sprite into a backbuffer
; in:
; de - ptr to monster_draw_ptr
npc_draw:
			lhld npc_get_scr_addr
			lda npc_ram_disk_s_cmd
			jmp actor_draw
