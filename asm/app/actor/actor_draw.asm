; renders an actor (hero, char, overlay, vfx, etc) on the screen or back buffer
; in:
; de - ptr to actor_draw_ptr
; hl - sprite_get_scr_addr1, sprite_get_scr_addr4, or sprite_get_scr_addr8
; a - ram_disk_access_cmd | RAM_DISK_M_BACKBUFF | RAM_DISK_M_8F
actor_draw:
			shld @get_scr_addr_actor + 1
			sta @ramdisk_cmd + 1

			DE_ADVANCE(char_draw_ptr, char_status)
			ldax d
			sta @actor_status + 1

			HL_ADVANCE(char_status, char_erase_scr_addr, BY_HL_FROM_DE)
			push h

			HL_ADVANCE(char_erase_scr_addr, char_pos_x + 1, BY_DE)
			; hl - ptr to char_pos_x + 1
@get_scr_addr_actor:
			call TEMP_ADDR ; sprite_get_scr_addr1 or sprite_get_scr_addr4 or sprite_get_scr_addr8
			; de - sprite screen addr
			; c - preshifted sprite idx*2 offset based on pos_x then +2
			; hl - ptr to pos_y+1
			; advance to char_anim_ptr

			HL_ADVANCE(char_pos_y+1, char_anim_ptr, BY_A)
			mov b, m
			HL_ADVANCE(char_anim_ptr, char_anim_ptr+1)
			mov h, m
			mov l, b
			; hl - anim_ptr
			; c - preshifted sprite idx*2 offset
			; de - sprite screen addr
@sprite_get_addr:
			mvi b, 0
			dad b
			mov c, m
			inx h
			mov b, m
			; bc - ptr to a sprite
			; de - sprite screen addr

@actor_status:
			mvi a, TEMP_BYTE
			ani ACTOR_STATUS_BIT_INVIS

@ramdisk_cmd:
			mvi a, TEMP_BYTE

			jnz @invis

			CALL_RAM_DISK_FUNC_BANK(sprite_draw_vm)

@store_params:
			pop h
			; d - width
			;		00 - 8pxs,
			;		01 - 16pxs,
			;		10 - 24pxs,
			;		11 - 32pxs,
			; e - height
			; bc - sprite screen addr + offset
			; hl - ptr to char_erase_scr_addr
			; store the current scr addr, into char_erase_scr_addr
			mov m, c
			inx h
			mov m, b
			; advance to char_erase_wh
			HL_ADVANCE(char_erase_scr_addr + 1, char_erase_wh)
			; store a width and a height into char_erase_wh
			mov m, e
			inx h
			mov m, d
			ret
@invis:
			; hl - ptr to char_status
			; a - RAM Disk access cmd
			CALL_RAM_DISK_FUNC_BANK(sprite_draw_invis_vm)
			jmp @store_params