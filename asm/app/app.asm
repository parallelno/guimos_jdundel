memusage_app:
;=======================================================

app_start:
			lxi h, load_permanent
			ora a ; reset CY flag, to not init/start music
			call global_load

			lxi h, load_menu
			stc ; set CY flag, to init/start music
			call global_load

@loop:
			; prepare to return back from the screen
			lxi h, @loop
			push h
			; read the global func
global_request: = * + 1
			lxi h, GLOBAL_REQ_MAIN_MENU
			lxi b, global_funcs
			dad h
			dad b
			mov e, m
			inx h
			mov d, m
			xchg
			; call a global func
			pchl

global_funcs:
			.word empty_func		; GLOBAL_REQ_NONE		= 0
			.word main_menu			; GLOBAL_REQ_MAIN_MENU	= 1
			.word global_start_game	; GLOBAL_REQ_GAME		= 2
			.word settings_screen	; GLOBAL_REQ_OPTIONS	= 3
			.word scores_screen		; GLOBAL_REQ_SCORES		= 4
			.word credits_screen	; GLOBAL_REQ_CREDITS	= 5
			.word stats_screen		; GLOBAL_REQ_END_HOME	= 6
			.word global_load_lv0	; GLOBAL_REQ_LOAD_LEVEL0 = 7
			.word global_load_lv1	; GLOBAL_REQ_LOAD_LEVEL1 = 8

global_start_game:
			lxi d, PAL_MENU_ADDR + _pal_menu_palette_fade_to_load_relative
			mvi a, RAM_DISK_S_PAL_MENU 
			call pallete_fade_out

			MEM_ERASE_SP(SCR_ADDR, SCR_BUFFS_LEN)
			
			lxi d, PAL_MENU_ADDR + _pal_menu_palette_fade_to_load_relative
			mvi a, RAM_DISK_S_PAL_MENU
			call pallete_fade_in

			lxi h, load_level0
			stc ; set CY flag, to init/start music
			call global_load

			lxi d, PAL_MENU_ADDR + _pal_menu_palette_fade_to_load_relative
			mvi a, RAM_DISK_S_PAL_MENU 
			call pallete_fade_out
			
			MEM_ERASE_SP(SCR_ADDR, SCR_BUFFS_LEN)

			jmp game

global_load_lv0:
			lxi h, load_level0
			stc ; set CY flag, to init/start music
			call global_load
			;jmp game_continue

global_load_lv1:
			lxi h, load_level1
			stc ; set CY flag, to init/start music
			call global_load
			;jmp game_continue

; in: 
; hl - load func addr, ex. load_level0
; If CY flag is set, init the sound and start the music
global_load:
			push psw
			push h
			push psw

			di
			pop psw
			cc v6_sound_init

			lxi h, @return
			xthl
			pchl
@return:
			ei
			pop psw
			rnc ; if the flag c is not set, don't start music
			CALL_RAM_DISK_FUNC_NO_RESTORE(v6_gc_start, RAM_DISK_M_SONG01 | RAM_DISK_M_8F)
			ret
