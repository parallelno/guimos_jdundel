	; This line is for proper formatting in VSCode

GAME_REQ				= %1000_0000
; reqs below must be aligned with the options
; in the main menu in the game.
; check global_funcs in the app.asm for details
GLOBAL_REQ_NONE			= 0
GLOBAL_REQ_MENU_MAIN	= 1
GLOBAL_REQ_GAME			= 2
GLOBAL_REQ_MENU_OPTIONS	= 3
GLOBAL_REQ_MENU_SCORES	= 4
GLOBAL_REQ_MENU_CREDITS	= 5
GLOBAL_REQ_MENU_STATS	= 6
GLOBAL_REQ_LOAD_LEVEL0	= 7
GLOBAL_REQ_LOAD_LEVEL1	= 8
GLOBAL_REQ_LOAD_MENU_MAIN	= 9