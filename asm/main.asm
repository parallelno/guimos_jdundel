.setting "ShowLocalLabelsAfterCompiling", true
.setting "Debug", true
.setting "OmitUnusedFunctions", true

.include "v6/v6.asm" ; This mast be included before any other code
.include "game/game.asm"

; all runtime data assembly should be the last inclusions to not blow up the executible size
.include "game/game_runtime_data.asm"
; this must be the last runtime data inclusion due to of validation checks
.include "asm/v6/v6_runtime_data.asm"