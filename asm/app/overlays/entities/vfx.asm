@memusage_vfx:
;===============================================================================

; utilizes overlay runtime data for preshifted VFX (x coord aligned to 2 pxls)
; in:
; bc - vfx pos_xy
; de - vfx_anim_ptr (ex. vfx_puff_anim)
; rev1: 496 cc
; rev2: 464 cc
; rev3: 608 cc (using overlay_init rev4)
vfx_init4:
			call vfx_common_init
			; OVERLAY_DRAW_PTR
			lxi h, vfx_draw4
			push h
			lxi b, vfx_update
			jmp overlay_init


; Init for non-preshifted VFX (x coord aligned to 8 pixels)
; in:
; bc - vfx screen addr
; de - vfx_anim_ptr (ex. vfx_puff_anim)
; it utilizes overlay runtime data
; rev1: 568 cc
; rev2: 480 cc
; rev3: 608 cc (using overlay_init rev4)
vfx_init:
			call vfx_common_init
			; OVERLAY_DRAW_PTR
			lxi h, vfx_draw
			push h
			lxi b, vfx_update
			jmp overlay_init

vfx_common_init:
			pop h
			shld @ret + 1

			lxi h, NULL
			; speed_y
			push h
			; speed_x
			push h
			; pos_xy
			push b
			; OVERLAY_ANIM_PTR
			push d
			; OVERLAY_STATUS | OVERLAY_STATUS_TIMER<<8
			push h
@ret:		jmp TEMP_ADDR

; anim and a gameplay logic update
; in:
; de - ptr to overlay_update_ptr
vfx_update:
			HL_ADVANCE(overlay_update_ptr, overlay_anim_timer, BY_HL_FROM_DE)
			mvi a, VFX_ANIM_SPEED
			call actor_anim_update
			rnc
@die:
			; hl points to overlay_anim_ptr
			; advance hl to overlay_update_ptr + 1
			L_ADVANCE(overlay_anim_ptr, overlay_update_ptr + 1, BY_A)
			ACTOR_DESTROY()
			ret


; draws a sprite into a backbuffer
; in:
; de - ptr to overlay_draw_ptr
vfx_draw:
			lhld vfx_get_scr_addr
			lda vfx_ram_disk_s_cmd
			jmp actor_draw

; draws a sprite into a backbuffer
; in:
; de - ptr to overlay_draw_ptr
vfx_draw4:
			lhld vfx4_get_scr_addr
			lda vfx4_ram_disk_s_cmd
			jmp actor_draw
