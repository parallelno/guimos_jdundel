@memusage_friends_mom
;========================================================
; npc is a quest char. it can't be destroied.
; all all npcs visual and logic is in this assembly.
; npc chose logic an a skin based on the room_id, level_id,

; statuses.
; personal actor statuses must be in a range of 0 to ACTOR_STATUS_CUSTOM including.
ACTOR_STATUS_FRIENDS_MOM_IDLE				= ACTOR_STATUS_INIT

; status duration in updates.
ACTOR_STATUS_FRIENDS_MOM_RELAX_TIME			= 25
ACTOR_STATUS_FRIENDS_MOM_MOVE_TIME			= 55

; animation speed (the less the slower, 0-255, 255 means the next frame is almost every update)
FRIENDS_MOM_ANIM_SPEED_IDLE	= 20

; gameplay

FRIENDS_MOM_COLLISION_WIDTH		= 16
FRIENDS_MOM_COLLISION_HEIGHT	= 16

;========================================================
; spawn and init a char
; in:
; c - tile_idx in the room_tiledata array.
; a - char_id * 4
; out:
; a = TILEDATA_RESTORE_TILE
friends_mom_init:
			CHAR_INIT(npc_update, npc_draw, @impacted, NPC_HEALTH, ACTOR_STATUS_FRIENDS_MOM_IDLE, npc_friends_mom_idle_anim, False, CHAR_TYPE_ALLY)

; Interaction with a friend's mom NPC.
; In this routine the hero gets a key 0 to open the backyard
; Then he gets a popsicle pie in exchange of a dry clothes
; in:
; de - ptr to char_impacted_ptr + 1
; c - hero_weapon_id
@impacted:
			; check the weapon_id
			mvi a, HERO_WEAPON_ID_SNOWFLAKE
			cmp c
			rz ; return if the hero used a snowflake
			; de - ptr to char_impacted_ptr+1

			; prevents multiple calls this function
			; when a hero hits multiple triggers at once
			call dialog_is_inited
			rz

			; check the key 0 status
			lxi h, global_items + ITEM_ID_KEY_0 - 1 ; because the first item_id = 1
			A_TO_ZERO(ITEM_STATUS_NOT_ACQUIRED)
			cmp m
			; if it's been acquired/used, check clothes item
			jnz @check_clothes

			; if a key_0 isn't acquired,
			; set key_0 status = ITEM_STATUS_ACQUIRED
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
