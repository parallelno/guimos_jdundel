; update anim, check collision against the hero
; in:
; hl - overlay_anim_timer
; a - anim speed
; out:
; if no collision:
;	it returns
; if it collides:
;	no returns
;	hl - overlay_pos_y+1
; rev 1 168cc
; rev 2 144cc
.macro OVERLAY_UPDATE_ANIM_CHECK_COLLISION_HERO(overlay_collision_w, overlay_collision_h, overlay_damage)
			call actor_anim_update
@check_collision:
			; hl points to overlay_anim_ptr
			; advance hl to overlay_pos_x
			L_ADVANCE(overlay_anim_ptr, overlay_pos_x+1, BY_A)

			; rough collision check. it assumes the biggest overlay collision dimention <= the biggest hero dimension
			HERO_COLLISION_SIZE .var HERO_COLLISION_WIDTH
			.if HERO_COLLISION_WIDTH < overlay_collision_h
				HERO_COLLISION_SIZE = overlay_collision_h
			.endif

			; precise collision check
			; horizontal check
			lda hero_pos_x+1
			adi HERO_COLLISION_WIDTH
			cmp m
			rc ; 48cc
			sui HERO_COLLISION_WIDTH + overlay_collision_w
			cmp m
			rnc ; 72cc
			; 64cc

			; advance hl to overlay_pos_y+1
			INX_H(2)

			; vertical check
			lda hero_pos_y+1
			adi HERO_COLLISION_HEIGHT
			cmp m
			rc
			sui HERO_COLLISION_HEIGHT + overlay_collision_h
			cmp m
			rnc
			; cc = 144

@collides_hero:
			; hero collides
			; hl points to overlay_pos_y+1
			push h
			; send him a damage
			mvi c, overlay_damage
			call hero_impacted
			pop h
.endmacro