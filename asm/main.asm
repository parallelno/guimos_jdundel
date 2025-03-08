.setting "ShowLocalLabelsAfterCompiling", true
.setting "Debug", true
.setting "OmitUnusedFunctions", true

.include "v6/v6.asm" ; This mast be included before any other code


.include "asm/game/game_consts.asm"
.include "game/levels/room_consts.asm"
.include "game/levels/levels_data_consts.asm"
.include "asm/game/gameplay/gameplay_consts.asm"
.include "asm/game/levels/backs_consts.asm"
.include "asm/game/actor/actor_consts.asm"
.include "asm/game/hero/hero_consts.asm"
.include "asm/game/monsters/monsters_consts.asm"
.include "asm/game/bullets/bullets_consts.asm"

; all runtime data assembly should be the last inclusions to not blow up the executible size
;.include "game/game_runtime_data.asm"
; this must be the last runtime data inclusion due to of validation checks
;.include "asm/v6/v6_runtime_data.asm"
; TODO: replace the include below with the auto struct packer
.include "asm/runtime_data.asm"
; TODO: think of better place for it
.include "asm/v6/sound/v6_gc_runtime_data.asm"


.include "game/game_macros.asm"
.include "asm/game/levels/room_macros.asm"
.include "game/actor/actor_macros.asm"

.include "asm/game/levels/levels_data.asm"

.include "game/game_utils.asm"
.include "game/game_score.asm"
.include "game/game_score_data.asm"


.include "asm/game/actor/actor.asm"
.include "asm/game/hero/hero.asm"
.include "asm/game/monsters/monsters.asm"
.include "asm/game/bullets/bullets.asm"
.include "asm/game/levels/breakables.asm"
.include "asm/game/levels/levels.asm"
.include "asm/game/levels/room.asm"
.include "asm/game/levels/backs.asm"
.include "asm/game/hero/hero_triggers.asm"
.include "asm/game/ui/dialogs.asm"
.include "asm/game/ui/ui.asm"

.include "asm/game/screens/screen_utils.asm"
.include "asm/game/screens/main_menu.asm"
.include "asm/game/screens/credits.asm"
.include "asm/game/screens/scores.asm"
.include "asm/game/screens/settings.asm"
.include "asm/game/screens/stats.asm"
.include "asm/game/gameplay/gameplay.asm"

.include "game/game.asm"

executible_end:
RAM_FREE_SPACE = STACK_MIN_ADDR - executible_end

.if executible_end >= STACK_MIN_ADDR
	.error "Runtime data buffer overlaps the stack buffer at addr (" runtime_data_end ")." 
	.error "It must be within the range " BUFFERS_END_ADDR "."
.endif