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

; actor statuses
; status is stored in *_status byte (monster_status, bullet_status)
; statuses prescribe the behavior of monsters, boolets, and also used by
; the render system to blink an actor, make it invisible, etc.
; statuses below can be combined with other statuses
; make it invisible
ACTOR_STATUS_BIT_INVIS			= %1000_0000
; blink every second frame
;ACTOR_STATUS_BIT_BLINK			= %0100_0000
; non-gameplay statuses like the hero death animation can be combined 
; with ACTOR_STATUS_BIT_NON_GAMEPLAY to make the status checking faster
;ACTOR_STATUS_BIT_NON_GAMEPLAY	= %0010_0000
; disables the update and render functionality. 
; the actor will be controlled by another entity
ACTOR_STATUS_NO_UPDATE			= %1110_0000

ACTOR_STATUS_BIT_GLOBAL			= ACTOR_STATUS_NO_UPDATE | ACTOR_STATUS_BIT_INVIS