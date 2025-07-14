; a visual sequence when a hero lost all his life points
hero_dead:
			lda hero_status
			cpi ACTOR_STATUS_HERO_DEATH_FADE_INIT_GB
			jz hero_dead_fade_init_gb
			cpi ACTOR_STATUS_HERO_DEATH_FADE_GB
			jz hero_dead_fade_gb
			cpi ACTOR_STATUS_HERO_DEATH_FADE_R
			jz hero_dead_fade_r
			cpi ACTOR_STATUS_HERO_DEATH_WAIT_SPARKER
			jz hero_dead_wait_sparker
			ret

hero_dead_fade_init_gb:
			KILL_ALL_MONSTERS()
			KILL_ALL_BULLETS()

			; set the status
			mvi a, ACTOR_STATUS_HERO_DEATH_FADE_GB
			sta hero_status

			; kill all the backs
			jmp backs_init

HERO_STATUS_DEATH_FADE_UPDATE_RATE = %00010001
HERO_STATUS_DEATH_FADE_GB_TIMER = 7
; fade out the current pallete
hero_dead_fade_gb:			
@anim_rate: ; do a palette animation only every Nth frame
			mvi a, HERO_STATUS_DEATH_FADE_UPDATE_RATE
			rrc
			sta @anim_rate + 1
			rnc

			lxi h, palette
			mvi c, PALETTE_LEN

@fade_gb_counter:
			mvi a, HERO_STATUS_DEATH_FADE_GB_TIMER
			CPI_ZERO()
			
			jz @next_status
			dcr a
			sta @fade_gb_counter + 1

@loop_bg:
			mov a, m
			rrc
			ani %01011000
			mov b, a
			mov a, m
			ani %00000111
			ora b
			mov m, a

			inx h ; next color
			dcr c
			jnz @loop_bg

@update_palette:
			lxi h, palette_update_request
			mvi m, PALETTE_UPD_REQ_YES
			ret

@next_status:
			; reset a fade timer
			lxi h, @fade_gb_counter + 1
			mvi m, HERO_STATUS_DEATH_FADE_GB_TIMER

			; set the status
			lxi h, hero_status
			mvi m, ACTOR_STATUS_HERO_DEATH_FADE_R

			; draw vfx
			; bc - vfx scrXY
			; de - vfx_anim_ptr (ex. vfx_puff_anim)
			lxi h, hero_pos_x + 1
			mov b, m
			HL_ADVANCE(hero_pos_x + 1, hero_pos_y + 1)
			mov c, m
			lxi d, vfx4_hero_death_anim
			call vfx_init4
			ret

HERO_STATUS_DEATH_FADE_R_TIMER = 7
hero_dead_fade_r:
			HERO_UPDATE_ANIM(HERO_ANIM_SPEED_ATTACK)
			; fade out R channel
			; do a palette animation only every Nth frame
@anim_rate:
			mvi a, HERO_STATUS_DEATH_FADE_UPDATE_RATE
			rrc
			sta @anim_rate + 1
			rnc

			lxi h, palette
			mvi c, PALETTE_LEN

@fade_r_counter:
			mvi a, HERO_STATUS_DEATH_FADE_R_TIMER
			CPI_ZERO()
			jz @next_status
			dcr a
			sta @fade_r_counter + 1

@loop_r:
			mov a, m
			CPI_ZERO()
			jz @next
			dcr m
@next:
			inx h ; next color
			dcr c
			jnz @loop_r

@update_palette:
			lxi h, palette_update_request
			mvi m, PALETTE_UPD_REQ_YES
			ret

@next_status:
			; reset a fade timer
			lxi h, @fade_r_counter + 1
			mvi m, HERO_STATUS_DEATH_FADE_R_TIMER

			; set the status
			lxi h, hero_status
			mvi m, ACTOR_STATUS_HERO_DEATH_WAIT_SPARKER

			; reset the timer
			HL_ADVANCE(hero_status, hero_status_timer)
			mvi m, HERO_STATUS_DEATH_WAIT_SPARKER_DURATION

			; fill all visual buffs with thedarkers color in the current palette
			call fill_all_black

			mvi c, TILEDATA_RESTORE_TILE
			call room_fill_tiledata

			; copy a palette from the RAM Disk, then request for using it
			call level_palette_fade_in

			; create an actor to move it to the right which spawns sparkle effects
			lxi h, hero_pos_x + 1
			mov b, m
			mvi m, 256 - TILE_WIDTH ; sparker the end position where it goes
			HL_ADVANCE(hero_pos_x + 1, hero_pos_y + 1)
			mov c, m
			mvi m, 128
			jmp sparker_init


hero_dead_wait_sparker:
			lxi h, hero_status_timer
			dcr m
			rnz
			jmp trigger_hero_no_health