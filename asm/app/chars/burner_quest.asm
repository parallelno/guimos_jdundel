@memusage_burner_quest
;========================================================
; this is a quest mod identical to burner, but with different behavior
; it is spawned once for every screen where its spawner
; it runs only up until the top edge of the screen


BURNER_QUEST_SPEED		= $0200
BURNER_QUEST_MAX_POS_X	= 255 - 16
BURNER_QUEST_MAX_POS_Y	= 255 - 16 - 14

BURNER_QUEST_STATUS_ROOM_6	= 0
BURNER_QUEST_STATUS_ROOM_9	= 1
BURNER_QUEST_STATUS_ROOM_5	= 2
BURNER_QUEST_STATUS_ROOM_10	= 3

BURNER_QUEST_ROOM_IDS_END = $ff

burner_quest_room_ids:
			.byte ROOM_ID_6, ROOM_ID_9, ROOM_ID_5, ROOM_ID_10, BURNER_QUEST_ROOM_IDS_END
burner_quest_room_ids_end:
burner_quest_room_ids_len: = burner_quest_room_ids_end - burner_quest_room_ids

;========================================================
; spawn and init a char
; in:
; c - tile_idx in the room_tiledata array.
; a - char_id * 4
; out:
; a = TILEDATA_RESTORE_TILE
burner_quest_init:
			mov b, a ; temp

			; game_status_burner_quest_room contains an index for burner_quest_room_ids array.
			; That array contains room_ids in a proper sequence where a player will see it.
			; when a burner shows up in a room, item_id_burner offsets to the next room_id
			lda game_status_burner_quest_room
			HL_TO_A_PLUS_INT16(burner_quest_room_ids)
			lda room_id
			cmp m
			jnz @return; if it is not dedicated room for a burner_quest

			; it is a dedicated room,
			; advance the index to the next dedicated room in a sequence
			lxi h, game_status_burner_quest_room
			inr m

			mov a, b
			CHAR_INIT(burner_quest_update, burner_draw, empty_func, BURNER_HEALTH, ACTOR_STATUS_BURNER_DETECT_HERO_INIT, burner_dash_anim)
@return:
			mvi a, TILEDATA_RESTORE_TILE
			ret
;========================================================
; anim and a gameplay logic update
; in:
; de - ptr to char_update_ptr
burner_quest_update:
			; store de
			push d
			; advance hl to char_id
			HL_ADVANCE(char_update_ptr, char_id, BY_HL_FROM_DE)
			; check what burner it is
			mov a, m
			cpi BURNER_RIGHT_ID
			jz @burner_right
@burner_up:
			; advance hl to char_speed_y + 1
			HL_ADVANCE(char_id, char_pos_y + 1, BY_BC)
			; hl - ptr to char_pos_y + 1
			; increase pos_y
			mov a, m
			adi >BURNER_QUEST_SPEED
			mov m, a

			; advance hl to char_update_ptr
			pop h

			; check if a burner hits the screen border
			cpi BURNER_QUEST_MAX_POS_Y
			jnc @death
			jmp @update_anim

@burner_right:
			; advance hl to char_pos_x + 1
			HL_ADVANCE(char_id, char_pos_x + 1, BY_BC)
			; hl - ptr to char_pos_x + 1
			; increase pos_x
			mov a, m
			adi >BURNER_QUEST_SPEED
			mov m, a

			; advance hl to char_update_ptr
			pop h

			; check if a burner hits the screen border
			cpi BURNER_QUEST_MAX_POS_X
			jnc @death
@update_anim:
			; hl points to char_update_ptr
			; advance hl to char_anim_timer
			HL_ADVANCE(char_update_ptr, char_anim_timer, BY_BC)

			mvi a, BURNER_ANIM_SPEED_MOVE
			jmp burner_update_anim_check_collision_hero
@death:
			; hl points to char_update_ptr
			HL_ADVANCE(char_update_ptr, char_update_ptr + 1)
			; mark this char dead death
			jmp char_destroy
