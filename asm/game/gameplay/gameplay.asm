// .include "asm/game/levels/room_macros.asm"
// .include "asm/game/levels/levels_data.asm"

// .include "asm/game/gameplay/gameplay_consts.asm"
// .include "asm/game/levels/backs_consts.asm"
// .include "asm/game/actor/actor_consts.asm"
// .include "asm/game/hero/hero_consts.asm"
// .include "asm/game/monsters/monsters_consts.asm"
// .include "asm/game/bullets/bullets_consts.asm"

// .include "game/game_score_data.asm"

// .include "asm/game/actor/actor.asm"
// .include "asm/game/hero/hero.asm"
// .include "asm/game/monsters/monsters.asm"
// .include "asm/game/bullets/bullets.asm"
// .include "asm/game/levels/breakables.asm"
// .include "asm/game/levels/levels.asm"
// .include "asm/game/levels/room.asm"
// .include "asm/game/levels/backs.asm"
// .include "asm/game/ui/ui.asm"
// .include "asm/game/hero/hero_triggers.asm"

gameplay:
			call gameplay_init
			call reset_game_updates_required_counter
@loop:
			call gameplay_update
			call gameplay_draw
			jmp	@loop

gameplay_init:
			call game_stats_init
			call hero_game_init
			call levels_init
			call dialogs_init
			call gameplay_ui_init
			ret

gameplay_update:
			lxi h, game_update_counter
			inr m

@loop:
			CHECK_GAME_UPDATE_COUNTER(gameplay_updates_required)

			; check the pause
			lda global_request
			cpi GAME_REQ_PAUSE			
			jz @pause
			cpi GAME_REQ_END_HOME
			jz @end

			call hero_update
			call monsters_update
			call bullets_update
			call level_update
@pause:			
			call backs_update
			call gameplay_ui_update

			; to check repeated key-pressing
			lda action_code
			sta action_code_old
			jmp @loop
@end:		
			mvi a, GLOBAL_REQ_END_HOME
			sta global_request
			POP_H(1) ; to return into main_start loop
			ret

gameplay_draw:
			; update counter to calc fps
			lhld gameplay_draw_counter
			inx h
			shld gameplay_draw_counter
			
			; draw funcs
			call backs_draw

			; return if the game paused
			lda global_request
			cpi GAME_REQ_PAUSE
			rz

			call hero_draw
			call monsters_draw
			call bullets_draw

			call hero_copy_to_scr
			call monsters_copy_to_scr
			call bullets_copy_to_scr

			call hero_erase
			call monsters_erase
			call bullets_erase
			ret



