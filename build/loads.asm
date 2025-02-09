/*
Ram 'permanent' usage:
	FONT.BIN [1624], SONG01.BIN [8548], 
reserved: 0
used: 10172
free: 22596

Ram-disk 'permanent' usage:
reserved: 0
used: 0
free: 262144

Ram 'level0' usage:
reserved: 10172
used: 0
free: 22596

Ram-disk 'level0' usage:
	LV0_DATA.BIN [bank idx: 0, addr: 0, len:3638], 
	LV0_GFX.BIN [bank idx: 0, addr: 3638, len:5524], 

reserved: 0
used: 9162
free: 252982

*/
;===============================================
; permanent
;===============================================
.function load_permanent
			; ram:

			FONT_ADDR = STACK_MIN_ADDR - 0 - FONT_FILE_LEN
			LOAD_FILE(FONT_FILENAME_PTR, 0, FONT_ADDR, FONT_FILE_LEN)

			SONG01_ADDR = STACK_MIN_ADDR - 1624 - SONG01_FILE_LEN
			LOAD_FILE(SONG01_FILENAME_PTR, 0, SONG01_ADDR, SONG01_FILE_LEN)

			; ram-disk:
.endf
;===============================================
; level0
;===============================================
.function load_level0
			; ram:

			; ram-disk:
			RAM_DISK_S_LV0_DATA = RAM_DISK_S0
			LV0_DATA_ADDR = 0
			LOAD_FILE(LV0_DATA_FILENAME_PTR, RAM_DISK_S_LV0_DATA, LV0_DATA_ADDR, LV0_DATA_FILE_LEN)

			RAM_DISK_S_LV0_GFX = RAM_DISK_S0
			LV0_GFX_ADDR = 3638
			LOAD_FILE(LV0_GFX_FILENAME_PTR, RAM_DISK_S_LV0_GFX, LV0_GFX_ADDR, LV0_GFX_FILE_LEN)

.endf
LOADED_DATA_START_ADDR = STACK_MIN_ADDR - 10172
