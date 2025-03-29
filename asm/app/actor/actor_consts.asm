	; this line for VSCode proper formating
; actor states
; they denote the handle prodedures like actors_call_if_alive 
; what to do with the actor runtime data.
; this status is stored in the second byte of *_update_ptr pointer.
; if the status is below the $fc, the actor is concidered alive, its update func
; will be called, it will be rendered and put on the screen, etc.
; TODO: optimize. use a lastRemovedMonsterRuntimeDataPtr as a starter to find empty data
;ACTOR_RUNTIME_DATA_ALIVE < $fc
ACTOR_RUNTIME_DATA_DESTR  = $fc ; an actor's runtime data is ready to be destroyed
ACTOR_RUNTIME_DATA_EMPTY  = $fd ; an actor's runtime data is available for a new actor
ACTOR_RUNTIME_DATA_LAST	  = $fe ; the end of the last existing actor's runtime data
ACTOR_RUNTIME_DATA_END	  = $ff ; the end of the actor's runtime data

; statuses describe what set of animations and behavior is active
; There is only one status can be applied to the actor at a time. Status bits are
; special states of the actor. Multiple status bits can be applied to the actor.
; The current status plus status bits are stored in *_status byte, i.e. hero_status, 
; monster_status, bullet_status.
ACTOR_STATUS_BIT_INVIS		= %1000_0000
ACTOR_STATUS_BIT_INVINCIBLE	= %0100_0000
; can be used as a unique status defined in the actor's code
ACTOR_STATUS_BIT_RESERVED	= %0010_0000
; combines all status bits
ACTOR_STATUS_BITS = ACTOR_STATUS_BIT_INVIS | ACTOR_STATUS_BIT_INVINCIBLE | ACTOR_STATUS_BIT_RESERVED

; disables the update and render functionality. An actor will be controlled by
; another entity
ACTOR_STATUS_INIT		= 0
ACTOR_STATUS_NO_UPDATE	= ~ACTOR_STATUS_BITS
ACTOR_STATUS_KICKOFF	= ~ACTOR_STATUS_BITS - 1
ACTOR_STATUS_FREEZE		= ~ACTOR_STATUS_BITS - 2
; statuses 0 to ACTOR_STATUS_CUSTOM are defined by the particular actor
ACTOR_STATUS_CUSTOM		= ~ACTOR_STATUS_BITS - 3

ACTOR_STATUS_FREEZE_TIME = BUFF_FREEZE_TIME