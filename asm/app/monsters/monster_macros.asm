; check the monster collision against a hero
; ex MONSTER_CHECK_COLLISION_HERO(VAMPIRE_COLLISION_WIDTH, VAMPIRE_COLLISION_HEIGHT, VAMPIRE_DAMAGE)
; in:
; hl points to monster_anim_ptr
; uses:
; bc, de, hl, a
; think of converting this macro into a func. it'll save 168 bytes.
.macro MONSTER_CHECK_COLLISION_HERO(MONSTER_COLLISION_WIDTH, MONSTER_COLLISION_HEIGHT, MONSTER_DAMAGE)
			; hl points to monster_anim_ptr
			; advance hl to monster_pos_x
			HL_ADVANCE(monster_anim_ptr, monster_pos_x+1, BY_BC)
			; horizontal check
			mov c, m ; pos_x
			lda hero_pos_x+1
			mov b, a ; tmp
			adi HERO_COLLISION_WIDTH-1
			cmp c
			rc
			mvi a, MONSTER_COLLISION_WIDTH-1
			add c
			cmp b
			rc
			; vertical check
			; advance hl to monster_pos_y+1
			INX_H(2)
			mov c, m ; pos_y
			lda hero_pos_y+1
			mov b, a
			adi HERO_COLLISION_HEIGHT-1
			cmp c
			rc
			mvi a, MONSTER_COLLISION_HEIGHT-1
			add c
			cmp b
			rc
@collides_hero:
			; hero collides
			; send him a damage
			mvi c, MONSTER_DAMAGE
			jmp hero_impacted
.endmacro

; in:
; hl - ptr to monster_status
; TODO: 45 bytes per instance
.macro MONSTER_UPDATE_DETECT_HERO(distance, hero_detected_status, hero_detected_status_time, hero_detected_anim, detect_anim_speed, anim_check_collision_hero, next_status, next_status_time)
			; hl - ptr to monster_status
			; advance hl to monster_status_timer
			inx h
			dcr m
			jz @set_move_init
			
			; check a hero-to-monster distance
			; advance hl to monster_pos_x+1
			HL_ADVANCE(monster_status_timer, monster_pos_x+1, BY_DE)
			mvi c, distance
			call actor_to_hero_distance
			jnc @anim_check_collision_hero

			; hero detected
			; hl - ptr to monster_pos_x+1
			; advance hl to monster_status
			HL_ADVANCE(monster_pos_x+1, monster_status, BY_BC)
			mvi m, hero_detected_status

		.if hero_detected_status_time != NULL
			inx h
			mvi m, hero_detected_status_time
			; advance hl to monster_anim_ptr
			HL_ADVANCE(monster_status_timer, monster_anim_ptr)
			mvi m, <hero_detected_anim
			inx h
			mvi m, >hero_detected_anim
		.endif
			ret

@anim_check_collision_hero:
			HL_ADVANCE(monster_pos_x+1, monster_anim_timer, BY_DE)
			mvi a, detect_anim_speed
			jmp anim_check_collision_hero


@set_move_init:
 			; hl - ptr to monster_status_timer
			mvi m, next_status_time ; TODO: use a rnd number instead of a const
			; advance hl to monster_status
			dcx h
			mvi m, next_status
			ret
.endmacro

; Inserts a monster runtime data at the beginning of 
; the monster runtime data list
; in:
; hl - ptr to monster_update_ptr + 1
; out:
; hl - points to monster_data_next_ptr
; uses:
; de, hl
; 18*4 cc
.macro MONSTER_DATA_INSERT_AT_HEAD()
			HL_ADVANCE(monster_update_ptr + 1, monster_data_next_ptr + 1, BY_DE)

			; read the monster_data_next_ptr from the actor_data_head_ptr
			xchg
			lhld actor_data_head_ptr

			; store addr from the actor_data_head_ptr
			; into monster_data_next_ptr
			xchg
			; de - points to the monster_data_next_ptr of the previosly first monster data
			mov m, d
			HL_ADVANCE(monster_data_next_ptr + 1, monster_data_next_ptr)
			mov m, e
			; de - points to the monster_data_next_ptr of the previosly first monster data
			; hl - points to monster_data_next_ptr
			
			; store monster_data_next_ptr to the actor_data_head_ptr
			shld actor_data_head_ptr
.endmacro

; Deletes a monster runtime data from the monster runtime data list
; in:
; hl - ptr to monster_update_ptr + 1
; uses:
; a, bc, de, hl
.macro MONSTER_DATA_REMOVE()
			HL_ADVANCE(monster_update_ptr + 1, monster_data_next_ptr, BY_BC)

			; current element = head
			lxi d, actor_data_head_ptr
			xchg

			; find the element that points to the element we want to delete
@loop:			
			; hl - current element
			; de - element we want to delete
			; get the next element
			mov c, m
			inx h
			mov b, m
			
			; check if the next element is the element we want to delete
			mov a, b
			cmp d
			jnz @advance			
			mov a, c
			cmp e
			jz @found
			
@advance:
			; bc - next element
			; current element = next element
			mov h, b
			mov l, c
			jmp @loop

	@found:
			; hl - previous element + 1
			dcx h
			; hl - previous element
			; de - monster_data_next_ptr of element we want to delete
			
			; make the previous element point to 
			; the next element of the element we want to delete
			ldax d
			mov m, a
			inx d
			inx h
			ldax d
			mov m, a
.endmacro