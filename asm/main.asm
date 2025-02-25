.setting "ShowLocalLabelsAfterCompiling", true
.setting "Debug", true
.setting "OmitUnusedFunctions", true

.include "v6/v6.asm" ; This mast be included before any other code

.include "asm/game/game_consts.asm"
.include "game/levels/room_consts.asm"

.include "game/levels/levels_data_consts.asm"
.include "game/levels/backs_consts.asm"
.include "game/actor/actor_consts.asm"
.include "game/hero/hero_consts.asm"
.include "game/monsters/monsters_consts.asm"
.include "game/bullets/bullets_consts.asm"

.include "game/levels/room_macro.asm"
.include "game/actor/actor_macro.asm"

; all runtime data assembly should be the last inclusions to not blow up the executible size
.include "game/game_runtime_data.asm"
; this must be the last runtime data inclusion due to of validation checks
.include "asm/v6/v6_runtime_data.asm"

.include "game/game_macros.asm"

.include "game/game_score_data.asm"
.include "game/levels/levels_data.asm"

.include "game/actor/actor.asm"
.include "game/hero/hero.asm"
.include "game/hero/hero_triggers.asm"
.include "game/monsters/monsters.asm"
.include "game/bullets/bullets.asm"
.include "game/levels/breakables.asm"
.include "game/levels/levels.asm"
.include "game/levels/room.asm"
.include "game/levels/backs.asm"
.include "game/ui/dialogs.asm"
.include "game/ui/ui.asm"

.include "game/game_score.asm"
.include "game/game_utils.asm"
.include "game/game.asm"
