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


; updates sprite label addrs
; in:
; de - _hero_l_preshifted_sprites
; hl - sprite gfx addr (_hero_l_sprites)
.function sprite_update_labels()
			shld @gfx_addr+1
			xchg
			; hl - _hero_l_preshifted_sprites
			mov a, m
			sta @preshifted_sprites+1
			inx h
			; read the anim ptr
@next_anim:			
			mov e, m
			inx h
			mov d, m
			inx h
			; check if all anims are updated
			mov a, d
			ora e
			rz
			; de - anim ptr
			push h
			xchg
			; hl - anim ptr
			call @update_frame_labels
			pop h
			jmp @next_anim
			ret

; in:
; hl - anim ptr
@update_frame_labels:
			; check if it's the last frame (offset to the next frame < 0)
			mov a, m
			push psw
			inx h
			inx h
			; hl - ptr to array of frame ptrs
			; the len of array = @preshifted_sprites
@preshifted_sprites:
			mvi c, TEMP_BYTE
@gfx_addr:
			lxi d, TEMP_ADDR
			; hl - points to the array of ptrs to the data
			; de - the data addr
			; c - the len of the array
			update_labels()
			pop psw
			; if a < 0, we updated the last frame in the animation
			ora a
			jp @update_frame_labels
			;ret
.endf






			
