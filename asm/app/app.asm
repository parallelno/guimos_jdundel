memusage_app:
;=======================================================

app_start:
			GLOBAL_LOAD(load_permanent, false)

@app_loop:
			; store the return addr
			lxi h, @app_loop
			push h
			; read the global func
app_request: = * + 1
			lxi h, GLOBAL_REQ_LOAD_MENU_MAIN
			lxi b, app_funcs
			dad h
			dad b
			mov e, m
			inx h
			mov d, m
			xchg
			; call a global func
			pchl

app_funcs:
			.word empty_func		; GLOBAL_REQ_NONE			= 0
			.word main_menu			; GLOBAL_REQ_MENU_MAIN		= 1
			.word app_start_game	; GLOBAL_REQ_GAME			= 2
			.word settings_screen	; GLOBAL_REQ_MENU_OPTIONS	= 3
			.word scores_screen		; GLOBAL_REQ_MENU_SCORES	= 4
			.word credits_screen	; GLOBAL_REQ_MENU_CREDITS	= 5
			.word stats_screen		; GLOBAL_REQ_MENU_STATS		= 6
			.word app_load_lv0		; GLOBAL_REQ_LOAD_LEVEL0 	= 7
			.word app_load_lv1		; GLOBAL_REQ_LOAD_LEVEL1 	= 8
			.word app_load_main_menu; GLOBAL_REQ_LOAD_MENU_MAIN	= 9
			.word app_respawn		; GLOBAL_REQ_RESPAWN		= 10


app_load_main_menu:
			mvi a, GLOBAL_REQ_MENU_MAIN
			sta app_request

			GLOBAL_LOAD(load_menu, true, true)

app_start_game:
			lxi d, PERMANENT_PAL_MENU_ADDR + _pal_menu_palette_fade_to_load_relative
			mvi a, PERMANENT_PAL_MENU_RAM_DISK_S
			call pallete_fade_out

			MEM_ERASE_SP(SCR_ADDR, SCR_BUFFS_LEN)
			lxi d, PERMANENT_PAL_MENU_ADDR + _pal_menu_palette_fade_to_load_relative
			mvi a, PERMANENT_PAL_MENU_RAM_DISK_S
			call pallete_fade_in

			GLOBAL_LOAD(load_level0, true)

			lxi d, PERMANENT_PAL_MENU_ADDR + _pal_menu_palette_fade_to_load_relative
			mvi a, PERMANENT_PAL_MENU_RAM_DISK_S
			call pallete_fade_out

			call game_init
			call game_level_init
			jmp game_loop

app_load_lv0:
			call app_uninit_level
			mvi a, LEVEL_PALETTE_FADE_OUT
			call level_palette_fade

			MEM_ERASE_SP(SCR_ADDR, SCR_BUFFS_LEN)
			lxi d, PERMANENT_PAL_MENU_ADDR + _pal_menu_palette_fade_to_load_relative
			mvi a, PERMANENT_PAL_MENU_RAM_DISK_S
			call pallete_fade_in

			GLOBAL_LOAD(load_level0, true)

			lxi d, PERMANENT_PAL_MENU_ADDR + _pal_menu_palette_fade_to_load_relative
			mvi a, PERMANENT_PAL_MENU_RAM_DISK_S
			call pallete_fade_out

			A_TO_ZERO(LEVEL_ID_0)
			sta level_id

			call game_level_init
			jmp game_loop

app_load_lv1:
			call app_uninit_level
			mvi a, LEVEL_PALETTE_FADE_OUT
			call level_palette_fade

			MEM_ERASE_SP(SCR_ADDR, SCR_BUFFS_LEN)
			lxi d, PERMANENT_PAL_MENU_ADDR + _pal_menu_palette_fade_to_load_relative
			mvi a, PERMANENT_PAL_MENU_RAM_DISK_S
			call pallete_fade_in

			GLOBAL_LOAD(load_level1, true)

			lxi d, PERMANENT_PAL_MENU_ADDR + _pal_menu_palette_fade_to_load_relative
			mvi a, PERMANENT_PAL_MENU_RAM_DISK_S
			call pallete_fade_out

			mvi a, LEVEL_ID_1
			sta level_id

			call game_level_init
			jmp game_loop

app_respawn:
			call app_uninit_level
			mvi a, LEVEL_PALETTE_FADE_OUT
			call level_palette_fade

			MEM_ERASE_SP(SCR_ADDR, SCR_BUFFS_LEN)
			lxi d, PERMANENT_PAL_MENU_ADDR + _pal_menu_palette_fade_to_load_relative
			mvi a, PERMANENT_PAL_MENU_RAM_DISK_S
			call pallete_fade_in

			GLOBAL_LOAD(load_level0, true)

			lxi d, PERMANENT_PAL_MENU_ADDR + _pal_menu_palette_fade_to_load_relative
			mvi a, PERMANENT_PAL_MENU_RAM_DISK_S
			call pallete_fade_out

			A_TO_ZERO(LEVEL_ID_0)
			sta level_id

			mvi a, RES_HEALTH_RESPAWN
			sta hero_res_health

			call game_level_init
			jmp game_loop

; restores sprite anim data
app_uninit_level:
			lda level_id
			CPI_ZERO(LEVEL_ID_0)
			jz uninit_level0
			cpi LEVEL_ID_1
			jz uninit_level1
			ret

; calls a load func, disables interrupts,
; can init the sound
.macro GLOBAL_LOAD(load_func, init_sound, _jmp = false)
			lxi h, load_func
		.if init_sound
			stc ; set CY flag, to init/start music
		.endif
		.if init_sound == false
			ora a
		.endif
		.if _jmp == false
			call app_load
		.endif
		.if _jmp == true
			jmp app_load
		.endif
.endmacro

; calls a load func, disables interrupts,
; can init the sound
; in:
; hl - load func addr, ex. load_level0
; If CY flag is set, init the sound and start the music
app_load:
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
			CALL_RAM_DISK_FUNC_NO_RESTORE(v6_gc_start, PERMANENT_SONG01_RAM_DISK_M | RAM_DISK_M_8F)
			ret
