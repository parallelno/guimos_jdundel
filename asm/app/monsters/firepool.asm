memusage_firepool:
;========================================================
; firepool is a quest monster. it can be destroied by snowflake weapon

; statuses.
; personal actor statuses must be in a range of 0 to ACTOR_STATUS_CUSTOM including.
ACTOR_STATUS_FIREPOOL_IDLE				= ACTOR_STATUS_INIT

; status duration in updates.
ACTOR_STATUS_FIREPOOL_DETECT_HERO_TIME	= 50
ACTOR_STATUS_FIREPOOL_SHOOT_PREP_TIME	= 30
ACTOR_STATUS_FIREPOOL_RELAX_TIME		= 25
ACTOR_STATUS_FIREPOOL_MOVE_TIME			= 55

; animation speed (the less the slower, 0-255, 255 means the next frame is almost every update)
FIREPOOL_ANIM_SPEED_IDLE	= 40

; gameplay
FIREPOOL_DAMAGE = 1
FIREPOOL_HEALTH = 0

FIREPOOL_COLLISION_WIDTH	= 16
FIREPOOL_COLLISION_HEIGHT	= 16

;========================================================
; spawn and init a monster
; in:
; c - tile_idx in the room_tiledata array.
; a - monster_id * 4
; out:
; a = TILEDATA_RESTORE_TILE
firepool_init:
			mov b, a ; tmp
			lda game_status_fire_extinguished
			CPI_ZERO(False)
			jnz @return
			mov a, b
			MONSTER_INIT(firepool_update, firepool_draw, firepool_impacted, FIREPOOL_HEALTH, ACTOR_STATUS_FIREPOOL_IDLE, vfx_firepool_anim, False)
@return:
			mvi a, TILEDATA_RESTORE_TILE
			ret			

;========================================================
; anim and a gameplay logic update
; in:
; de - ptr to monster_update_ptr 
firepool_update:
			; advance hl to monster_anim_timer
			HL_ADVANCE(monster_update_ptr, monster_anim_timer, BY_HL_FROM_DE)
			mvi a, FIREPOOL_ANIM_SPEED_IDLE
			; hl - monster_anim_timer
			; a - anim speed
			call actor_anim_update
			MONSTER_CHECK_COLLISION_HERO(FIREPOOL_COLLISION_WIDTH, FIREPOOL_COLLISION_HEIGHT, FIREPOOL_DAMAGE)

; in:
; de - ptr to monster_impacted_ptr + 1
; c - hero_weapon_id
firepool_impacted:
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
firepool_draw:
			ACTOR_DRAW(sprite_get_scr_addr1, RAM_DISK_S_VFX, false)
