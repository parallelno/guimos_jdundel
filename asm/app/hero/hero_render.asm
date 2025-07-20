@memusage_hero_render
; TODO: use actor_draw instead of hero_draw
hero_draw:
			lhld hero_get_scr_addr
			lda hero_ram_disk_s_cmd
			jmp actor_draw


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