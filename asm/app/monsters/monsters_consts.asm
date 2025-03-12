	; this line for VSCode proper formating
; monster types
MONSTER_TYPE_ENEMY	= 0
MONSTER_TYPE_ALLY	= 1

; global monster statuses
; TODO: value ACTOR_STATUS_MONSTER_FREEZE is overlapping with ACTOR_STATUS_NO_UPDATE
; make that value lower
ACTOR_STATUS_MONSTER_INIT		= 0
ACTOR_STATUS_MONSTER_FREEZE		= $40
; accumulates all monster global statuses
ACTOR_STATUS_MONSTER_GLOBAL		= ACTOR_STATUS_MONSTER_FREEZE

; status time
MONSTER_STATUS_FREEZE_TIME = BUFF_FREEZE_TIME