.setting "ShowLocalLabelsAfterCompiling", true
.setting "Debug", true
.setting "OmitUnusedFunctions", true

.include "v6/v6.asm" ; This mast be included before any other code


.include "app/app_consts.asm"
.include "app/levels/room_consts.asm"
.include "app/levels/levels_data_consts.asm"
.include "app/game/game_consts.asm"
.include "app/levels/backs_consts.asm"
.include "app/actor/actor_consts.asm"
.include "app/hero/hero_consts.asm"
.include "app/monsters/monsters_consts.asm"
.include "app/bullets/bullets_consts.asm"

; all runtime data assembly should be the last inclusions to not blow up the executible size
;.include "app/app_runtime_data.asm"
; this must be the last runtime data inclusion due to of validation checks
;.include "v6/v6_runtime_data.asm"
; TODO: replace the include below with the auto struct packer
.include "runtime_data.asm"
; TODO: think of better place for it
.include "v6/sound/v6_gc_runtime_data.asm"


.include "app/app_macros.asm"
.include "app/levels/room_macros.asm"
.include "app/actor/actor_macros.asm"

.include "app/levels/levels_data.asm"

.include "app/app_utils.asm"
.include "app/score.asm"
.include "app/score_data.asm"


.include "app/actor/actor.asm"
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

executible_end:
RAM_FREE_SPACE = BUFFERS_START_ADDR - executible_end

.if executible_end >= BUFFERS_START_ADDR
	.error "Runtime data buffer overlaps the stack buffer at addr (" runtime_data_end ")." 
	.error "It must be within the range " BUFFERS_END_ADDR "."
.endif