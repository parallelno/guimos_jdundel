.include "game/hero/hero_data.asm"
.include "game/hero/hero_update.asm"
.include "game/hero/hero_collision.asm"
.include "game/hero/hero_tile_funcs.asm"
.include "game/hero/hero_render.asm"


hero_game_init:
			; erase hero runtime data
			lxi h, hero_runtime_data
			lxi b, hero_runtime_data_end - hero_runtime_data
			call mem_erase
			lxi h, hero_update
			shld hero_update_ptr
			lxi h, hero_draw
			shld hero_draw_ptr
			lxi h, hero_impacted
			shld hero_impacted_ptr
						
			; erase hero resources buffs
			lxi h, hero_resources
			lxi b, hero_resources_end - hero_resources
			jmp mem_erase

hero_respawn:
			mvi a, RES_HEALTH_INIT
			sta hero_res_health

			; setup a hero pos
			lhld level_start_pos_ptr
			xchg
			lda level_ram_disk_s_data
			call get_word_from_ram_disk
			; set pos
			; b - pos_x
			; c - pos_y		
			mov a, b
			sta hero_pos_x+1
			mov a, c
			sta hero_pos_y+1
			ret

hero_room_init:
			call hero_idle_start
			
			; reset key data
			A_TO_ZERO(CONTROL_CODE_NO)
			sta action_code

			lxi h, hero_pos_x+1
			call sprite_get_scr_addr8
			xchg
			shld hero_erase_scr_addr_old
			; 16x15 size
			lxi h, SPRITE_W_PACKED_MIN<<8 | SPRITE_H_MIN
			shld hero_erase_wh_old
			ret