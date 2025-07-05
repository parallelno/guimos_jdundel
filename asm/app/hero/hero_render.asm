memusage_hero_render:
; TODO: use actor_draw instead of hero_draw
hero_draw:
			lhld hero_get_scr_addr
			shld @get_scr_addr+1
			lxi h, hero_pos_x+1
@get_scr_addr:
			call TEMP_ADDR ; sprite_get_scr_addr8

			lhld hero_anim_addr
			call sprite_get_addr

			lda hero_ram_disk_s_cmd
			mov l, a

			lda hero_status
			ani ACTOR_STATUS_BIT_INVIS
			jnz @invis

@draw:
			mov a, l
			CALL_RAM_DISK_FUNC_BANK(sprite_draw_vm)
			; d - width
			;		00 - 8pxs,
			;		01 - 16pxs,
			;		10 - 24pxs,
			;		11 - 32pxs,
			; e - height
			; bc - sprite screen addr + offset			

@save_params:
			; store an old scr addr, width, and height
			lxi h, hero_erase_scr_addr
			mov m, c
			HL_ADVANCE(hero_erase_scr_addr, hero_erase_scr_addr + 1)
			mov m, b
			xchg
			shld hero_erase_wh
			ret

@invis:
			mov a, l
			CALL_RAM_DISK_FUNC_BANK(sprite_draw_invis_vm)
			jmp @save_params

hero_copy_to_scr:
			; get min(h, d), min(e,l)
			lhld hero_erase_scr_addr_old
			xchg
			lhld hero_erase_scr_addr
			mov a, h
			cmp d
			jc @keepCurrentX
			mov h, d
@keepCurrentX:
			mov a, l
			cmp e
			jc @keepCurrentY
			mov l, e
@keepCurrentY:
			; hl - a scr addr to copy
			push h
			; de - an old sprite scr addr
			lhld hero_erase_wh_old
			dad d
			push h
			lhld hero_erase_scr_addr
			; store as old
			shld hero_erase_scr_addr_old
			xchg
			lhld hero_erase_wh
			; store as old
			shld hero_erase_wh_old
			dad d
			; hl - current sprite top-right corner scr addr
			; de - old sprite top-right corner scr addr
			pop d
			; get the max(h, d), max(e,l)
			mov a, h
			cmp d
			jnc @keepCurrentTRX
			mov h, d
@keepCurrentTRX:
			mov a, l
			cmp e
			jnc @keepCurrentTRY
			mov l, e
@keepCurrentTRY:
			; hl - top-right corner scr addr to copy
			; de - a scr addr to copy
			pop d
			; calc bc (width, height)
			mov a, h
			sub d
			mov b, a
			mov a, l
			sub e
			mov c, a
			jmp sprite_copy_to_scr_v

hero_erase:
			lhld hero_erase_scr_addr
			xchg
			lhld hero_erase_wh

			; check if it needs to restore the background
			call room_check_tiledata_restorable
			lhld hero_erase_scr_addr
			xchg
			lhld hero_erase_wh


			jnz sprite_copy_to_back_buff_v ; restore a background
			CALL_RAM_DISK_FUNC(sprite_erase, RAM_DISK_S_BACKBUFF | RAM_DISK_M_8F)
			ret