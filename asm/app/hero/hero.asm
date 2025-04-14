.include "app/hero/hero_data.asm"
.include "app/hero/hero_update.asm"
.include "app/hero/hero_collision.asm"
.include "app/hero/hero_tile_funcs.asm"
.include "app/hero/hero_render.asm"


hero_game_init:
			; erase hero runtime data
			lxi h, hero_runtime_data
			lxi b, hero_runtime_data_end
			call mem_erase
			
			lxi h, hero_update
			shld hero_update_ptr
			lxi h, hero_draw
			shld hero_draw_ptr
			lxi h, hero_impacted
			shld hero_impacted_ptr
						
			; erase hero resources buffs
			lxi h, hero_resources
			lxi b, hero_resources_end
			jmp mem_erase

hero_respawn:
			mvi a, RES_HEALTH_INIT
			sta hero_res_health

			; setup a hero pos
			lhld lv_start_pos
			; h - pos_x, l - pos_y
			mov a, l
			mvi l, 0
			shld hero_pos_x
			mov h, a
			shld hero_pos_y
			ret

hero_room_init:
			call hero_idle_init
			
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