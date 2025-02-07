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

Ram 'main_menu' usage:
reserved: 10172
used: 0
free: 22596

Ram-disk 'main_menu' usage:
reserved: 0
used: 0
free: 262144

*/
;===============================================
; permanent
;===============================================
.function load_permanent
			; ram:
			FONT_DATA_ADDR = 0x4000 + 0
			LOAD_FILE(FONT_FILENAME_PTR, 0, FONT_DATA_ADDR, FONT_FILE_LEN)

			SONG01_DATA_ADDR = 0x4000 + 1624
			LOAD_FILE(SONG01_FILENAME_PTR, 0, SONG01_DATA_ADDR, SONG01_FILE_LEN)

			; ram-disk:
.endf
;===============================================
; main_menu
;===============================================
.function load_main_menu
			; ram:
			; ram-disk:
.endf
