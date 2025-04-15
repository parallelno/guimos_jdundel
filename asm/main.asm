.setting "ShowLocalLabelsAfterCompiling", true
.setting "Debug", true
.setting "OmitUnusedFunctions", true
.org	0x100

memusage_v6:
.include "v6/v6.asm" ; This mast be included before any other code

memusage_consts:
.include "app/app_consts.asm"
.include "app/levels/room_consts.asm"
.include "app/levels/levels_data_consts.asm"
.include "app/game/game_consts.asm"
.include "app/levels/backs_consts.asm"
.include "app/actor/actor_consts.asm"
.include "app/hero/hero_consts.asm"
.include "app/monsters/monsters_consts.asm"
.include "app/bullets/bullets_consts.asm"

memusage_runtime_data:
; all runtime data assembly should be the last inclusions to not blow up the executible size
;.include "app/app_runtime_data.asm"
; this must be the last runtime data inclusion due to validation checks
;.include "v6/v6_runtime_data.asm"
; TODO: replace the include below with the auto struct packer
.include "runtime_data.asm"

; TODO: think of a better place for it
memusage_gc_runtime_data:
.include "v6/sound/v6_gc_runtime_data.asm"

memusage_macros:
.include "app/app_macros.asm"
.include "app/levels/room_macros.asm"
.include "app/actor/actor_macros.asm"

memusage_levels_data:
.include "app/levels/levels_data.asm"
memusage_app_utils:
.include "app/app_utils.asm"
memusage_score:
.include "app/score.asm"
memusage_score_data:
.include "app/score_data.asm"

memusage_actor:
.include "app/actor/actor.asm"
memusage_hero:
.include "app/hero/hero.asm"
memusage_monsters:
.include "app/monsters/monsters.asm"
memusage_bullets:
.include "app/bullets/bullets.asm"
memusage_breakables:
.include "app/levels/breakables.asm"
memusage_levels:
.include "app/levels/levels.asm"
memusage_room:
.include "app/levels/room.asm"
memusage_backs:
.include "app/levels/backs.asm"
memusage_hero_triggers:
.include "app/hero/hero_triggers.asm"
memusage_dialogs:
.include "app/ui/dialogs.asm"
memusage_ui:
.include "app/ui/ui.asm"

memusage_screen_utils:
.include "app/screens/screen_utils.asm"
memusage_main_menu:
.include "app/screens/main_menu.asm"
memusage_credits:
.include "app/screens/credits.asm"
memusage_scores:
.include "app/screens/scores.asm"
memusage_settings:
.include "app/screens/settings.asm"
memusage_stats:
.include "app/screens/stats.asm"
memusage_game:
.include "app/game/game.asm"
memusage_app:
.include "app/app.asm"
memusage_end:

executible_end:
RAM_FREE_SPACE = BUFFERS_START_ADDR - executible_end

.if executible_end >= BUFFERS_START_ADDR
	.error "Runtime data buffer overlaps the stack buffer at addr (" runtime_data_end ")." 
	.error "It must be within the range " BUFFERS_END_ADDR "."
.endif