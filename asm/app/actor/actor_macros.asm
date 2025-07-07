; hl - ptr to actor_status_timer
; out:
; hl - ptr to actor_pos_x+1
; rev 1 268cc
; rev 2 212cc (26.4% faster!)
.macro ACTOR_UPDATE_MOVEMENT()
			HL_ADVANCE(monster_status_timer, monster_speed_y + 1, BY_BC)
			mov d, m
			dcx h
			mov a, m
			dcx h
			; d - speed_y_h
			; a - speed_y_l
			; hl - ptr to speed_x+1
			mov b, m
			dcx h
			mov c, m
			dcx h
			; bc - speed_x
			; hl - ptr to pos_y+1
			dcx h
			; hl - ptr to pos_y
			add m
			mov m, a
			inx h
			; hl = ptr to pos_y+1
			mov a, m
			adc d
			mov m, a

			HL_ADVANCE(monster_pos_y + 1, monster_pos_x)
			mov a, m
			add c
			mov m, a
			inx h
			; hl - ptr to pos_x+1
			mov a, m
			adc b
			mov m, a
			; cc = 212

			/*
			; TODO: if the pos_xy data layout is like below
			; this procedure can be faster
			actor_speed_x_l:
			.byte speed_x_l
			.byte pos_x_l
			.byte speed_x_h
			.byte pos_x_h

			.byte pos_y_h
			.byte speed_y_h
			.byte pos_y_l
			actor_speed_y_l:
			.byte speed_y_l

			HL_ADVANCE(pos_??, actor_speed_x_l, BY_BC)
			; new_pos_x = pos_x + speed_x
			mov a, m
			inx h
			add m
			mov m, a ; store pos_x_l
			inx h
			; cy flag
			mov a, m
			inx h
			adc m
			; a - new pos_x_h
			mov m, a ; store new pos_x_h

			HL_ADVANCE(actor_pos_x_h, actor_speed_y_l, BY_BC)
			; new_pos_y = pos_y + speed_y
			mov a, m
			dcx h
			add m
			mov m, a ; store pos_y_l
			dcx h
			; cy flag
			mov a, m
			dcx h
			adc m
			; a - new pos_y_h
			mov m, a ; store new pos_y_h
			; cc = 192
			; 39.6% faster!
			*/
.endmacro

; in:
; hl points to actor_status_timer
; out:
; if no collision: hl points to actor_pos_y+1
; if a collision: hl points to actor_pos_x
; uses:
; bc, de, hl, a
; TODO: it is 93 bytes used 7 times = 651 bytes total
; rev 1 380cc
; rev 2 324cc (17.3% faster!)
.macro ACTOR_UPDATE_MOVEMENT_CHECK_TILE_COLLISION(actor_status_timer, actor_pos_x, ACTOR_COLLISION_WIDTH, ACTOR_COLLISION_HEIGHT, _collision_handler)
			HL_ADVANCE(monster_status_timer, monster_speed_y+1, BY_BC)
			mov d, m
			dcx h
			mov e, m
			dcx h
			; de - speed_y
			; hl - ptr to speed_x+1
			mov b, m
			dcx h
			mov c, m
			dcx h
			; bc - speed_x
			; hl - ptr to pos_y+1
			push h
			dcx h
			; hl - ptr to pos_y
			mov a, m
			sta @old_pos_y_l+1
			add e
			mov m, a
			inx h
			; hl = ptr to pos_y+1
			mov a, m
			sta @old_pos_y_h+1
			adc d
			mov m, a
			mov e, a

			HL_ADVANCE(monster_pos_y+1, monster_pos_x)
			mov a, m
			sta @old_pos_x_l+1
			add c
			mov m, a
			inx h
			; hl - ptr to pos_x+1
			mov a, m
			sta @old_pos_x_h+1
			adc b
			mov m, a
			mov d, a
			; cc = 312
			; cc = 312+12=324 with pop h
			; 17.3% faster!

			/*
			; TODO: if the pos_xy data layout is like below
			; this procedure can be faster
			; and the access of reading/storing pos_xy is faster as well
			; to make it 100%, the @collided branch should restore the old pos,
			; the @no_collision branch should do only little, like pop h
			actor_speed_x_l:
			.byte speed_x_l
			.byte pos_x_l
			.byte speed_x_h
			.byte pos_x_h

			.byte pos_y_h
			.byte speed_y_h
			.byte pos_y_l
			actor_speed_y_l:
			.byte speed_y_l

			HL_ADVANCE(actor_???, actor_speed_y_l, BY_BC)
			; new_pos_y = pos_y + speed_y
			mov a, m
			dcx h
			add m
			sta @new_pos_y_l+1
			dcx h
			; cy flag
			mov a, m
			dcx h
			adc m
			sta @new_pos_y_h+1
			mov e, a ; new_pos_y_h

			HL_ADVANCE(actor_speed_y_h, actor_speed_x_l, BY_BC)
			; new_pos_x = pos_x + speed_x
			mov a, m
			inx h
			add m
			sta @new_pos_x_l+1
			inx h
			; cy flag
			mov a, m
			inx h
			adc m
			sta @new_pos_x_h+1
			mov d, a
			push h
			; de - new pos_xy
			; a - new pos_x_h
			; hl - ptr to actor_pos_x_h
			; cc = 256

			; store a new pos_x
			pop h
			mvi m, TEMP_BYTE
			inx h
			mvi m, TEMP_BYTE
			inx h
			; store a new pos_y
			mvi m, TEMP_BYTE
			inx h
			mvi m, TEMP_BYTE
			; cc = 256+84=340
			; 11.8% faster!
*/
			; check the collision against a border of the screen
			; check the X coord
			cpi TILE_WIDTH
			jc @collided
			cpi ROOM_WIDTH * TILE_WIDTH - TILE_WIDTH - ACTOR_COLLISION_WIDTH
			jnc @collided
			; check if the Y coord
			mov a, e
			cpi TILE_HEIGHT
			jc @collided
			cpi ROOM_HEIGHT * TILE_HEIGHT - TILE_HEIGHT - ACTOR_COLLISION_HEIGHT
			jnc @collided
			; 88cc


@check_tile_collision
			; check the collision against a collidable tiles
			lxi b, (ACTOR_COLLISION_WIDTH-1)<<8 | ACTOR_COLLISION_HEIGHT-1
			; de - new_pos_xy
			; bc - width, height
			call room_get_collision_tiledata
			ani TILEDATA_COLLIDABLE
			jz @no_collision

@collided:
			pop h
			; hl points to pos_y+1
			; store a old pos_x
@old_pos_y_h:
			mvi m, TEMP_BYTE
			dcx h
@old_pos_y_l:
			mvi m, TEMP_BYTE
			dcx h
			; store a new pos_y
@old_pos_x_h:
			mvi m, TEMP_BYTE
			dcx h
@old_pos_x_l:
			mvi m, TEMP_BYTE
			; hl points to pos_x
			jmp _collision_handler

@no_collision:
			pop h
			; hl points to pos_y+1
.endmacro


; replaces the actor runtime data with a marker
; indicating that there is no actor runtime data here and beyond
; used mostly for erasing all runtime data
.macro ACTOR_ERASE_RUNTIME_DATA(actor_update_ptr)
			lxi h, actor_update_ptr + 1
			mvi m, ACTOR_RUNTIME_DATA_LAST
.endmacro

; marks the actor's runtime data as it's going to be destroyed
; in:
; hl - update_ptr+1 ptr
; TODO: optimize. fill up lastRemovedBulletRuntimeDataPtr
.macro ACTOR_DESTROY()
			mvi m, ACTOR_RUNTIME_DATA_DESTR
.endmacro


; marks the actor runtime data as empty
; in:
; hl - update_ptr+1 ptr
; TODO: optimize. fiil up lastRemovedBulletRuntimeDataPtr
.macro ACTOR_EMPTY()
			mvi m, ACTOR_RUNTIME_DATA_EMPTY
.endmacro