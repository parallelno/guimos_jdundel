@memusage_knight_heavy
;========================================================
; this is a quest mod identical to knight, but with different behavior
; it spawns only if the quest was not complite
; it runs away if a hero with fart nearby


KNIGHT_QUEST_DETECT_HERO_DISTANCE	= 60
KNIGHT_QUEST_SPEED					= $0400
KNIGHT_QUEST_MAX_POS_Y				= 255 - 16 - 14

;========================================================
; spawn and init a char
; in:
; c - tile_idx in the room_tiledata array.
; a - char_id * 4
; out:
; a = TILEDATA_RESTORE_TILE
knight_heavy_init:
			CHAR_INIT( knight_heavy_update, knight_draw, empty_func, KNIGHT_HEALTH, ACTOR_STATUS_KNIGHT_DETECT_HERO_INIT, knight_idle_anim, False)

;========================================================
; anim and a gameplay logic update
; in:
; de - ptr to char_update_ptr
knight_heavy_update:
			push d
			call knight_heavy_check_panic
			pop h
			; hl - ptr to char_update_ptr

			; advance hl to char_status
			HL_ADVANCE(char_update_ptr, char_status, BY_DE)
			mov a, m
			cpi ACTOR_STATUS_KNIGHT_MOVE
			jz knight_update_move
			cpi ACTOR_STATUS_KNIGHT_DETECT_HERO
			jz knight_update_detect_hero
			cpi ACTOR_STATUS_KNIGHT_DEFENCE
			jz knight_update_speedup
			cpi ACTOR_STATUS_KNIGHT_MOVE_INIT
			jz knight_update_move_init
			cpi ACTOR_STATUS_KNIGHT_DEFENCE_INIT
			jz knight_heavy_update_defence_init
			cpi ACTOR_STATUS_KNIGHT_DETECT_HERO_INIT
			jz knight_update_detect_hero_init
			cpi ACTOR_STATUS_KNIGHT_PANIC
			jz knight_update_panic
			cpi ACTOR_STATUS_FREEZE
			jz char_update_freeze
			ret

; checks if a hero has game_status_fart acquired,
; if so, check the distance to him,
; if so, panic!
; in:
; de - ptr to char_update_ptr
; uses:
; de, a
knight_heavy_check_panic:
			xchg
			shld @restore_hl + 1
			; check if the hero has game_status_fart
			lda game_status_fart
			CPI_ZERO(GAME_STATUS_NOT_ACQUIRED)
			rz
			; hl - ptr to char_update_ptr

			; check a hero-to-char distance
			; advance hl to char_pos_x + 1
			HL_ADVANCE(char_update_ptr, char_pos_x + 1, BY_DE)
			; hl - ptr to char_pos_x + 1
			mvi c, KNIGHT_QUEST_DETECT_HERO_DISTANCE
			call actor_to_hero_distance
			rnc ; return if it's too distanced

			; set the panic state
@restore_hl:
			lxi h, TEMP_ADDR
			; hl - ptr to char_update_ptr
			; advance hl to char_status
			HL_ADVANCE(char_update_ptr, char_status, BY_DE)
			mvi m, ACTOR_STATUS_KNIGHT_PANIC
			ret

; in:
; hl - ptr to char_status
knight_update_panic:
			; this char goes up to the edge of the screen, then dies
			; advance hl to char_speed_y + 1
			HL_ADVANCE(char_status, char_pos_y + 1, BY_DE)
			; hl - ptr to char_pos_y + 1

			; increase pos_y
			mov a, m
			adi >KNIGHT_QUEST_SPEED
			mov m, a

			; check if a knight hits the screen border
			cpi KNIGHT_QUEST_MAX_POS_Y
			jnc @death
			; hl points to char_pos_y + 1
			; advance hl to char_anim_timer
			HL_ADVANCE(char_pos_y + 1, char_anim_timer, BY_BC)
			mvi a, BURNER_ANIM_SPEED_MOVE
			jmp knight_update_anim_check_collision_hero
@death:
			; hl points to char_pos_y + 1
			; advance hl to char_update_ptr + 1
			HL_ADVANCE(char_pos_y + 1, char_update_ptr + 1, BY_DE)
			; mark this char dead death
			jmp char_destroy

; in:
; hl - ptr to char_status
knight_heavy_update_defence_init:
			mvi m, ACTOR_STATUS_KNIGHT_DEFENCE
			; advance hl to char_status_timer
			inx h
			mvi m, ACTOR_STATUS_KNIGHT_DEFENCE_TIME
@check_anim_dir:
			; aim the char to the hero dir
			; advance hl to char_pos_x + 1
			HL_ADVANCE(char_status_timer, char_pos_x + 1, BY_BC)
			lda hero_pos_x + 1
			cmp m
			lxi d, knight_defence_l_anim
			jc @dir_x_neg
@dir_x_positive:
			lxi d, knight_defence_r_anim
@dir_x_neg:
			; advance hl to char_anim_ptr
			HL_ADVANCE(char_pos_x + 1, char_anim_ptr, BY_BC)
			mov m, e
			inx h
			mov m, d

			; set the speed according to a char_id (KNIGHT_HORIZ_ID / KNIGHT_VERT_ID)
			; advance hl to char_id
			HL_ADVANCE(char_anim_ptr + 1, char_id, BY_BC)
			mov a, m
			cpi KNIGHT_VERT_ID
			jz @speed_vert
@speed_horiz:
			; advance hl to char_speed_x
			HL_ADVANCE(char_id, char_speed_x, BY_BC)
			; dir positive if e == knight_defence_r_anim and vise versa
			mvi a, <knight_defence_r_anim
			cmp e
			lxi d, KNIGHT_DEFENCE_SPEED_NEG
			jnz @speed_x_neg
@speed_x_positive:
			lxi d, KNIGHT_DEFENCE_SPEED
@speed_x_neg:
			mov m, e
			inx h
			mov m, d
			; advance hl to char_speed_y
			inx h
			A_TO_ZERO(NULL)
			mov m, a
			inx h
			mov m, a
			ret
@speed_vert:
			; advance hl to char_pos_y + 1
			HL_ADVANCE(char_id, char_pos_y + 1, BY_BC)
			lda hero_pos_y + 1
			cmp m
			lxi d, KNIGHT_DEFENCE_SPEED_NEG
			jc @speed_y_neg
@speed_y_positive:
			lxi d, KNIGHT_DEFENCE_SPEED
@speed_y_neg:
			; advance hl to char_speed_x
			inx h
			A_TO_ZERO(NULL)
			mov m, a
			inx h
			mov m, a
			; advance hl to char_speed_y
			inx h
			mov m, e
			inx h
			mov m, d
			ret