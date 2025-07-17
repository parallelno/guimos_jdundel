.setting "ShowLocalLabelsAfterCompiling", true
.setting "Debug", true
.setting "OmitUnusedFunctions", true
.org	0x100

.include "v6/v6.asm" ; This must be included before any other code

.include "app/app_consts.asm"
.include "app/levels/room_consts.asm"
.include "app/levels/room_tiledata_consts.asm"
.include "app/game/game_consts.asm"
.include "app/levels/backs_consts.asm"
.include "app/actor/actor_consts.asm"
.include "app/hero/hero_consts.asm"
.include "app/monsters/monsters_consts.asm"
.include "app/bullets/bullets_consts.asm"

; TODO: think of a way to generate runtime_data structure asm
; to avoid manual packing the runtime data structures
.include "runtime_data.asm"
.include "v6/sound/v6_gc_runtime_data.asm"

.include "app/app_macros.asm"
.include "app/levels/room_macros.asm"
.include "app/actor/actor_macros.asm"

.include "app/app_utils.asm"
.include "app/score.asm"
.include "app/score_data.asm"

.include "app/actor/actor.asm"
.include "app/actor/actor_draw.asm"
.include "app/hero/hero.asm"
.include "app/monsters/monsters.asm"
.include "app/bullets/bullets.asm"
.include "app/levels/breakables.asm"
.include "app/levels/levels.asm"
.include "app/levels/room.asm"
.include "app/levels/backs.asm"
.include "app/hero/hero_triggers.asm"
.include "app/ui/dialogs.asm"
.include "app/ui/ui.asm"

.include "app/screens/screen_utils.asm"
.include "app/screens/main_menu.asm"
.include "app/screens/credits.asm"
.include "app/screens/scores.asm"
.include "app/screens/settings.asm"
.include "app/screens/stats.asm"
.include "app/game/game.asm"
.include "app/app.asm"
memusage_end:

RAM_FREE_SPACE = RUNTIME_DATA - memusage_end

.if memusage_end >= RUNTIME_DATA
	.error "Runtime data buffer overlaps the stack buffer at addr (" runtime_data_end ")." 
	.error "It must be within the range " BUFFERS_END_ADDR "."
.endif