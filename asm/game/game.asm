game_start:
			di
			MEM_ERASE_SP(SCR_ADDR, SCR_BUFFS_LEN)
			call v6_sound_init
			ei

			di
			load_permanent()
			load_level0()
			ei
@loop:
			; prepare to return back from the screen
			lxi h, @loop
			push h
			lda global_request
			HL_TO_AX2_PLUS_INT16(global_funcs) ; because GLOBAL_REQ_NONE is excluded from main_screens_call_ptrs
			mov e, m
			inx h
			mov d, m
			
			xchg
			pchl

global_funcs:
			.word empty_func		; GLOBAL_REQ_NONE		= 0
			.word main_menu			; GLOBAL_REQ_MAIN_MENU	= 1
			.word gameplay			; GLOBAL_REQ_GAME		= 2
			.word settings_screen	; GLOBAL_REQ_OPTIONS	= 3
			.word scores_screen		; GLOBAL_REQ_SCORES		= 4
			.word credits_screen	; GLOBAL_REQ_CREDITS	= 5
			.word stats_screen		; GLOBAL_REQ_END_HOME	= 6