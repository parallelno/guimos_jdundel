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
			mov b, a ; tmp store
			; if it's the level 0 & the room 0
			; spawn a goose
			lda room_id
			CPI_ZERO(ROOM_ID_0)
			mov a, b
			jz goose_init
@friends_mom:
			MONSTER_INIT(npc_update, npc_draw, npc_impacted, NPC_HEALTH, ACTOR_STATUS_NPC_IDLE, npc_mom_idle_anim, False, MONSTER_TYPE_NPC_FRIENDS_MOM)

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
			rz ; return if the hero used a snowflake
			; de - ptr to monster_impacted_ptr+1

			HL_ADVANCE(monster_impacted_ptr+1, monster_type, BY_HL_FROM_DE)
			cpi MONSTER_TYPE_NPC_FRIENDS_MOM
			rnz ; return if the npc is not friend's mom
			call npc_friends_mom
			ret


; Interaction with a friend's mom NPC.
; In this routine the hero gets a key 0 to open the backyard
; Then he gets a popsicle pie in exchange of a dry clothes
npc_friends_mom:
			; fix for multiple calls this function when a hero hits several trigger tiledatas
			call dialog_is_inited
			rz

			lxi h, global_items + ITEM_ID_KEY_0 - 1 ; because the first item_id = 1
			; check the key 0 status
			A_TO_ZERO(ITEM_STATUS_NOT_ACQUIRED)
			cmp m
			jnz @check_clothes; if it is acquired or used, check clothes item

			; if a key_0 isn't acquired, set key_0 status = ITEM_STATUS_ACQUIRED
			mvi m, ITEM_STATUS_ACQUIRED
			
			lxi d, TILEDATA_FUNC_ID_ITEMS<<8 | ITEM_ID_KEY_0
			call game_score_add
			call game_ui_draw_score_text

			; init a dialog
			mvi a, GAME_REQ_PAUSE
			lxi h, dialog_callback_room_redraw
			lxi d, _dialogs_knocked_his_friend_door
			jmp dialog_init

@check_clothes:
			; key_0 is acquired
			; check if clothes are acquired
			lxi h, hero_res_clothes
			A_TO_ZERO(0)
			cmp m
			jnz @clothes_acquired
@clothes_not_acquired:
			; the hero returns without clothes
			mvi a, GAME_REQ_PAUSE
			lxi h, dialog_callback_room_redraw
			lxi d, _dialogs_knocked_his_friend_door_no_clothes
			jmp dialog_init

@clothes_acquired:
			; a hero returns with clothes
			; remove the clothes item
			; a = 0
			mov m, a
			lxi h, hero_res_popsicle_pie
			inr m
			lxi h, hero_res_sword
			call game_ui_res_select_and_draw

			lxi d, TILEDATA_FUNC_ID_RESOURCES<<8 | RES_ID_PIE
			call game_score_add
			call game_ui_draw_score_text

			; init a dialog
			mvi a, GAME_REQ_PAUSE
			lxi h, dialog_callback_room_redraw
			lxi d, _dialogs_knocked_his_friend_door_clothes_returns
			jmp dialog_init

; draw a sprite into a backbuffer
; in:
; de - ptr to monster_draw_ptr 
npc_draw:
			ACTOR_DRAW(sprite_get_scr_addr_npc, RAM_DISK_S_NPC, false)
