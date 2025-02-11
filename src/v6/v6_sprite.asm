; get a sprite data addr
; in:
; hl - anim_ptr
; c - preshifted sprite idx*2 offset based on pos_x then +2
; out:
; bc - ptr to a sprite
sprite_get_addr:
			mvi b, 0
			dad b
			mov c, m
			inx h
			mov b, m
			ret

; getting scr addr of sprites preshifted for each pixel
; in:
; hl - ptr to pos_x+1 (high byte in 16-bit pos)
; out:
; de - sprite screen addr
; c - preshifted sprite idx*2 offset based on pos_x then +2
; hl - ptr to pos_y+1
; use: a
sprite_get_scr_addr8:
			; calc preshifted sprite idx*2 offset
			mov	a, m
			ani SPRITES_PRESHIFTED_8 - 1 ; %0000_0111
			rlc
			adi 2 ; because there are two bytes of next_frame_offset in front of sprite ptrs
			mov	c, a
			; calc screen addr X
			mov	a, m
			RRC_(3)
			ani %00011111
			adi SPRITE_X_SCR_ADDR
			INX_H(2)
			mov e, m
			mov	d, a
			; de - sprite screen addr			
			ret

; getting scr addr of sprites preshifted for each second pixel
; in:
; hl - ptr to pos_x+1 (high byte in 16-bit pos)
; out:
; de - sprite screen addr
; c - preshifted sprite idx*2 offset based on pos_x then +2
; hl - ptr to pos_y+1
; use: a
sprite_get_scr_addr4:
			; calc preshifted sprite idx*2 offset
			mov	a, m
			ani (SPRITES_PRESHIFTED_4 - 1) * 2 ; %0000_0110
			adi 2 ; because there are two bytes of next_frame_offset in front of sprite ptrs
			mov	c, a
			; calc screen addr X
			mov	a, m
			RRC_(3)
			ani %00011111
			adi SPRITE_X_SCR_ADDR
			INX_H(2)
			mov e, m
			mov	d, a
			; de - sprite screen addr			
			ret

; getting scr addr of non-preshifted sprites. alligned by 8 pixels horizontally
; in:
; hl - ptr to pos_x+1 (high byte in 16-bit pos)
; out:
; de - sprite screen addr
; c - preshifted sprite idx*2 offset based on pos_x then +2
; hl - ptr to pos_y+1
; use: a
sprite_get_scr_addr1:
			; calc preshifted sprite idx*2 offset
			mvi	c, 2
			; calc screen addr X
			mov	a, m
			RRC_(3)
			ani %00011111
			adi SPRITE_X_SCR_ADDR
			INX_H(2)
			mov e, m
			mov	d, a
			; de - sprite screen addr
			ret