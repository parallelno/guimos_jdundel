	; This line is for proper formatting in VSCode
;=============================================================================
; Actor Runtime States
;=============================================================================
; Note:
; - These values define how the actor system handles each runtime data entry.
; - The states is stored in the second byte of the hero_update_ptr,
;     char_update_ptr, bullet_update_ptr, and back_anim_ptr depending on
;     the actor type.
; - If states < $FC, the actor is considered **alive**:
;     • Its update function will be called.
;     • It will be rendered into the back buffer, copied to the screen, etc.

; TODO:
; - Optimize actor allocation using lastRemovedCharRuntimeDataPtr
;   as a starting point for finding free slots.

;ACTOR_RUNTIME_DATA_ALIVE < $fc
ACTOR_RUNTIME_DATA_DESTR  = $fc ; Marked for destruction; runtime data will be cleared.
ACTOR_RUNTIME_DATA_EMPTY  = $fd ; Available for reuse by a new actor.
ACTOR_RUNTIME_DATA_LAST	  = $fe ; Last active actor in the list (end marker).
ACTOR_RUNTIME_DATA_END	  = $ff ; End of the entire actor runtime data pool.

;=============================================================================
; Actor Status & Status Bits
;=============================================================================
; Statuses describe what set of animations and behavior is active.
; Note:
; - Statuses are stored in the `*_status` field (e.g., hero_status,
;   char_status, bullet_status).
; - Status defines animation & behavior.
; - Status can have multiple enabled special bits (Flags).

;----------------------------
; Status Bits (Flags)
;----------------------------
ACTOR_STATUS_BIT_INVIS       = %1000_0000 ; Actor is invisible
ACTOR_STATUS_BIT_INVINCIBLE  = %0100_0000 ; Actor can't take damage
ACTOR_STATUS_BIT_RESERVED    = %0010_0000 ; Custom/reserved bit

; Mask for all status bits
ACTOR_STATUS_BITS = ACTOR_STATUS_BIT_INVIS | ACTOR_STATUS_BIT_INVINCIBLE | ACTOR_STATUS_BIT_RESERVED

;----------------------------
; Primary Status Values
;----------------------------
ACTOR_STATUS_INIT        = 0 ; Disabled the update and render functionality.
							; An actor is controlled by another entity.
ACTOR_STATUS_NO_UPDATE   = ~ACTOR_STATUS_BITS     ; Disabled update. Used in the hero cinematic.
ACTOR_STATUS_KICKOFF     = ~ACTOR_STATUS_BITS - 1 ; Temporary kickoff state (e.g. spawned actor)
ACTOR_STATUS_FREEZE      = ~ACTOR_STATUS_BITS - 2 ; Temporarily frozen (e.g. stunned)
ACTOR_STATUS_CUSTOM      = ~ACTOR_STATUS_BITS - 3

; statuses 0 to ACTOR_STATUS_CUSTOM are reserved for the particular actor.
; For example, ACTOR_STATUS_KNIGHT_DEFENCE, ACTOR_STATUS_BURNER_DASH, etc.

; Freeze duration constant
ACTOR_STATUS_FREEZE_TIME = BUFF_FREEZE_TIME