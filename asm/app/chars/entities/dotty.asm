@memusage_dotty
;========================================================
; npc is a quest char. it can't be destroied.
; all all npcs visual and logic is in this assembly.
; npc chose logic an a skin based on the room_id, level_id,

; statuses.
; personal actor statuses must be in a range of 0 to ACTOR_STATUS_CUSTOM including.
ACTOR_STATUS_DOTTY_IDLE				= ACTOR_STATUS_INIT

; status duration in updates.
ACTOR_STATUS_DOTTY_RELAX_TIME			= 25
ACTOR_STATUS_DOTTY_MOVE_TIME			= 55

; animation speed (the less the slower, 0-255, 255 means the next frame is almost every update)
DOTTY_ANIM_SPEED_IDLE	= 60

; gameplay
DOTTY_DAMAGE = 0
DOTTY_HEALTH = 0

DOTTY_COLLISION_WIDTH		= 16
DOTTY_COLLISION_HEIGHT	= 16

;========================================================
; spawn and init a char
; in:
; c - tile_idx in the room_tiledata array.
; a - char_id * 4
; out:
; a = TILEDATA_RESTORE_TILE
dotty_init:
			CHAR_INIT(npc_update, npc_draw, dotty_impacted, DOTTY_HEALTH, ACTOR_STATUS_DOTTY_IDLE, npc_dotty_idle_anim, False, CHAR_TYPE_ALLY)

; in:
; de - ptr to char_impacted_ptr + 1
; c - hero_weapon_id
dotty_impacted:
			; check the weapon_id
			mvi a, HERO_WEAPON_ID_SNOWFLAKE
			cmp c
			rz ; return if the hero used a snowflake
			; de - ptr to char_impacted_ptr + 1

			;call npc_friends_mom
			ret
