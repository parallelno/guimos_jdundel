memusage_friends_sis:
;========================================================
; npc is a quest monster. it can't be destroied.
; all all npcs visual and logic is in this assembly.
; npc chose logic an a skin based on the room_id, level_id,

; statuses.
; personal actor statuses must be in a range of 0 to ACTOR_STATUS_CUSTOM including.
ACTOR_STATUS_FRIENDS_SIS_IDLE				= ACTOR_STATUS_INIT

; status duration in updates.
ACTOR_STATUS_FRIENDS_SIS_RELAX_TIME			= 25
ACTOR_STATUS_FRIENDS_SIS_MOVE_TIME			= 55

; animation speed (the less the slower, 0-255, 255 means the next frame is almost every update)
FRIENDS_SIS_ANIM_SPEED_IDLE	= 20

; gameplay
FRIENDS_SIS_DAMAGE = 0
FRIENDS_SIS_HEALTH = 0

FRIENDS_SIS_COLLISION_WIDTH		= 16
FRIENDS_SIS_COLLISION_HEIGHT	= 16

;========================================================
; spawn and init a monster
; in:
; c - tile_idx in the room_tiledata array.
; a - monster_id * 4
; out:
; a = TILEDATA_RESTORE_TILE
friends_sis_init:
crazy_man_init:
villager1_init:
villager2_init:
villager3_init:
villager4_init:
			MONSTER_INIT(npc_update, npc_draw, friends_sis_impacted, FRIENDS_SIS_HEALTH, ACTOR_STATUS_FRIENDS_SIS_IDLE, npc_sis_idle_anim, False, MONSTER_TYPE_FRIENDS_SIS)

; in:
; de - ptr to monster_impacted_ptr + 1
; c - hero_weapon_id
friends_sis_impacted:
			; check the weapon_id
			mvi a, HERO_WEAPON_ID_SNOWFLAKE
			cmp c
			rz ; return if the hero used a snowflake
			; de - ptr to monster_impacted_ptr+1

			;call npc_friends_mom
			ret


