.include "src/v6/sound/v6_gc.asm"
.include "src/v6/sound/v6_sfx.asm"


; init sound
; ex. CALL_RAM_DISK_FUNC(__sound_init, __RAM_DISK_S_SOUND | RAM_DISK_M_8F)
; ex. CALL_RAM_DISK_FUNC(__sound_init, __RAM_DISK_M_GCPLAYER | RAM_DISK_M_8F)
v6_sound_init:
			call v6_sfx_player_init
			call v6_gc_init
			ret

; play music and sfx
; called by the unterruption routine
; ex. CALL_RAM_DISK_FUNC_NO_RESTORE(__sound_update, __RAM_DISK_M_SOUND | __RAM_DISK_S_SOUND | RAM_DISK_M_8F)
v6_sound_update:
			call v6_gc_update
			call v6_sfx_update
			ret