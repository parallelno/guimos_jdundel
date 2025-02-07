; fdd bin file metadata
; asm data file: build/debug/music/song04_data.asm
; bin file: build/debug/bin/SONG04.BIN

SONG04_FILE_LEN = 8548
SONG04_LAST_RECORD_LEN = 100
SONG04_FILENAME_PTR:
			.byte "SONG04" ; filename
			.byte "  " ; filename white chars
			.byte "BIN" ; extension

_SONG04_ay_reg_data00 = 0
_SONG04_ay_reg_data01 = 847
_SONG04_ay_reg_data02 = 1114
_SONG04_ay_reg_data03 = 1949
_SONG04_ay_reg_data04 = 2407
_SONG04_ay_reg_data05 = 3902
_SONG04_ay_reg_data06 = 4015
_SONG04_ay_reg_data07 = 6120
_SONG04_ay_reg_data08 = 6656
_SONG04_ay_reg_data09 = 6854
_SONG04_ay_reg_data10 = 7324
_SONG04_ay_reg_data11 = 7837
_SONG04_ay_reg_data12 = 8512
_SONG04_ay_reg_data13 = 8519

SONG04_ay_reg_data_ptrs:
			.word _SONG04_ay_reg_data00, _SONG04_ay_reg_data01, _SONG04_ay_reg_data02, _SONG04_ay_reg_data03, _SONG04_ay_reg_data04, _SONG04_ay_reg_data05, _SONG04_ay_reg_data06, _SONG04_ay_reg_data07, _SONG04_ay_reg_data08, _SONG04_ay_reg_data09, _SONG04_ay_reg_data10, _SONG04_ay_reg_data11, _SONG04_ay_reg_data12, _SONG04_ay_reg_data13, 
