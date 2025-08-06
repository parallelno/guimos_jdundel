@memusage_trap

;=============================================================================
; This is a quest trap.
; It looks like a metal can propped up by a small wooden stick.
; If a caterpillar touches it, the trap is triggered and captures the caterpillar.
;
; When placed on the ground, a countdown timer starts.
; If the timer expires, the trap opens and any captured caterpillars are released.
;
; The hero must lift the trap before the timer runs out.
; Once time is up, the trap changes appearance:
; - If a caterpillar was caught, the trap stands upright.
; - If nothing was caught, it falls over.

; statuses.
TRAP_STATUS_ON		= ACTOR_STATUS_INIT
TRAP_STATUS_SUCCESS	= 1
TRAP_STATUS_FAIL	= 2

TRAP_STATUS_ON_TIME	= $FF


; in:
; bc - caster pos
trap_init: