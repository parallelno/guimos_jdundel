@memusage_vfx
;=================================================

; init a preshifted VFX
; in:
; bc - vfx pos_xy
; de - vfx_anim_ptr (ex. vfx_puff_anim)
; it utilizes bullet runtime data
; cc 496
vfx_init4:
; TODO: think of using BULLET_INIT instead of the code below
			xchg
			shld @anim_ptr + 1

			lxi h, bullet_update_ptr+1
			mvi e, BULLET_RUNTIME_DATA_LEN
			call actor_get_empty_data_ptr
			rnz ; return because too many objects

			; hl - ptr to bullet_update_ptr+1
			; advance hl to bullet_update_ptr
			dcx h
			mvi m, <vfx_update
			inx h
			mvi m, >vfx_update
			; advance hl to bullet_draw_ptr
			inx h
			mvi m, <vfx_draw4
			inx h
			mvi m, >vfx_draw4

			; advance hl to bullet_anim_ptr
			L_ADVANCE(bullet_draw_ptr + 1, bullet_anim_ptr, BY_A)

@anim_ptr:  ; store anim ptr
			lxi d, TEMP_ADDR
			mov m, e
			inx h
			mov m, d

			mov a, b
			; a - pos_x
			; scr_x = pos_x/8 + $a0
			RRC_(3)
			ani %00011111
			adi SPRITE_X_SCR_ADDR
			mvi e, 0
			; a = scr_x
			; b = pos_x
			; c = pos_y
			; e = 0 and SPRITE_W_PACKED_MIN
			; hl - ptr to bullet_erase_scr_addr_old

			; advance hl to bullet_erase_scr_addr
			inx h
			mov m, c
			inx h
			mov m, a
			; advance hl to bullet_erase_scr_addr_old
			inx h
			mov m, c
			inx h
			mov m, a
			; advance hl to bullet_erase_wh
			inx h
			mvi m, SPRITE_H_MIN
			inx h
			mov m, e
			; advance hl to bullet_erase_wh_old
			inx h
			mvi m, SPRITE_H_MIN
			inx h
			mov m, e
			; advance hl to bullet_pos_x
			inx h
			mov m, e
			inx h
			mov m, b
			; advance hl to bullet_pos_y
			inx h
			mov m, e
			inx h
			mov m, c
			ret

; Init for non-preshifted VFX (x coord aligned to 8 pixels )
; in:
; bc - vfx screen addr
; de - vfx_anim_ptr (ex. vfx_puff_anim)
; it utilizes bullet runtime data
; cc 568
vfx_init:
; TODO: think of using BULLET_INIT instead of the code below
			xchg
			shld @anim_ptr + 1

			lxi h, bullet_update_ptr+1
			mvi e, BULLET_RUNTIME_DATA_LEN
			call actor_get_empty_data_ptr
			rnz ; return because too many objects

			; hl - ptr to bullet_update_ptr+1
			; advance hl to bullet_update_ptr
			dcx h
			mvi m, <vfx_update
			inx h
			mvi m, >vfx_update
			; advance hl to bullet_draw_ptr
			inx h
			mvi m, <vfx_draw
			inx h
			mvi m, >vfx_draw

			; advance hl to bullet_status
			inx h
			mvi m, VFX_STATUS_DEFAULT

			; advance hl to bullet_anim_ptr
			L_ADVANCE(bullet_status, bullet_anim_ptr, BY_A)

@anim_ptr:  ; store anim ptr
			lxi d, TEMP_ADDR
			mov m, e
			inx h
			mov m, d

			; make a proper scr addr
			mvi a, %00011111
			ana b
			ori SPRITE_X_SCR_ADDR
			mov b, a

			mvi d, 2
			mvi e, 0
			; bc - screen addr
			; d - anim ptr offset. used in a draw func
			; e - 0 and SPRITE_W_PACKED_MIN
			; hl - ptr to bullet_erase_scr_addr_old

			; advance hl to bullet_erase_scr_addr
			inx h
			mov m, c
			inx h
			mov m, b
			; advance hl to bullet_erase_scr_addr_old
			inx h
			mov m, c
			inx h
			mov m, b
			; advance hl to bullet_erase_wh
			inx h
			mvi m, SPRITE_H_MIN
			inx h
			mov m, e
			; advance hl to bullet_erase_wh_old
			inx h
			mvi m, SPRITE_H_MIN
			inx h
			mov m, e
			; advance hl to bullet_pos_x
			inx h
			inx h
			mov m, b
			; advance hl to bullet_pos_y
			inx h
			mov m, d ; anim ptr offset
			inx h
			mov m, c
			ret

; anim and a gameplay logic update
; in:
; de - ptr to bullet_update_ptr
vfx_update:
			HL_ADVANCE(bullet_update_ptr, bullet_anim_timer, BY_HL_FROM_DE)
			mvi a, VFX_ANIM_SPEED
			call actor_anim_update
			rnc
@die:
			; hl points to bullet_anim_ptr
			; advance hl to bullet_update_ptr+1
			L_ADVANCE(bullet_anim_ptr, bullet_update_ptr+1, BY_A)
			ACTOR_DESTROY()
			ret


; in:
; hl - ptr to pos_x+1 (high byte in 16-bit pos)
; out:
; de - sprite screen addr
; c - preshifted sprite idx*2 offset based on pos_x then +2
; hl - ptr to pos_y+1
; use: a
sprite_get_scr_addr1_vfx:
			mov d, m
			inx h
			mov c, m ; (pos_y) contains an anim ptr offset to get a proper preshifted frame
			inx h
			mov e, m
			ret
sprite_get_scr_addr1_vfx_ptr:
			.word sprite_get_scr_addr1_vfx

; draw a non-preshifted sprite into a backbuffer
; in:
; de - ptr to bullet_draw_ptr
vfx_draw:
			lhld sprite_get_scr_addr1_vfx_ptr
			lda vfx_ram_disk_s_cmd
			jmp actor_draw

; draw a sprite into a backbuffer
; in:
; de - ptr to bullet_draw_ptr
vfx_draw4:
			lhld vfx4_get_scr_addr
			lda vfx4_ram_disk_s_cmd
			jmp actor_draw
