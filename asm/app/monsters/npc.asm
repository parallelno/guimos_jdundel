memusage_npc:
;========================================================
; npc is a quest monster. it can't be destroied.
; all all npcs visual and logic is in this assembly.
; npc chose logic an a skin based on the room_id, level_id,

; statuses.
; personal actor statuses must be in a range of 0 to ACTOR_STATUS_CUSTOM including.
ACTOR_STATUS_NPC_IDLE				= ACTOR_STATUS_INIT

; status duration in updates.
ACTOR_STATUS_NPC_RELAX_TIME			= 25
ACTOR_STATUS_NPC_MOVE_TIME			= 55

; animation speed (the less the slower, 0-255, 255 means the next frame is almost every update)
NPC_ANIM_SPEED_IDLE	= 20

; gameplay
NPC_DAMAGE = 0
NPC_HEALTH = 0

NPC_COLLISION_WIDTH		= 16
NPC_COLLISION_HEIGHT	= 16

;========================================================
; spawn and init a monster
; in:
; c - tile_idx in the room_tiledata array.
; a - monster_id * 4
; out:
; a = TILEDATA_RESTORE_TILE
npc_init:
			mov b, a ; tmp
			lda game_status_fire_extinguished
			CPI_ZERO(False)
			jnz @return
			mov a, b
			MONSTER_INIT(npc_update, npc_draw, npc_impacted, NPC_HEALTH, ACTOR_STATUS_NPC_IDLE, npc_mom_idle_anim, False)
@return:
			mvi a, TILEDATA_RESTORE_TILE
			ret

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
			;MONSTER_CHECK_COLLISION_HERO(NPC_COLLISION_WIDTH, NPC_COLLISION_HEIGHT, NPC_DAMAGE)
			ret

; in:
; de - ptr to monster_impacted_ptr + 1
; c - hero_weapon_id
npc_impacted:
			; check the weapon_id
			mvi a, HERO_WEAPON_ID_SNOWFLAKE
			cmp c
			rnz
			; de - ptr to monster_impacted_ptr+1

			mvi a, True
			sta game_status_fire_extinguished


			; die
			; advance hl to monster_pos_x+1			
			HL_ADVANCE(monster_impacted_ptr+1, monster_pos_x+1, BY_HL_FROM_DE)
			push h
			; play a hit vfx
			mov b, m
			; advance hl to monster_pos_y+1
			INX_H(2)
			mov c, m
			lxi d, vfx4_hit_anim
			call vfx_init4
			pop h
			; hl - ptr to monster_pos_x+1

			; mark this monster dead
			; advance hl to monster_update_ptr+1
			HL_ADVANCE(monster_pos_x+1, monster_update_ptr+1, BY_DE)
			ACTOR_DESTROY()
			ret

; draw a sprite into a backbuffer
; in:
; de - ptr to monster_draw_ptr 
npc_draw:
			; TODO: error. do not use sprite_get_scr_addr_burner
			ACTOR_DRAW(sprite_get_scr_addr_npc, RAM_DISK_S_NPC, false)
