; fdd bin file metadata
; asm data file: build/debug/music/song01_data.asm
; bin file: build/debug/bin/SONG01.BIN

SONG01_FILE_LEN = 8548
SONG01_LAST_RECORD_LEN = 100

SONG01_FILENAME_PTR:
			.byte "SONG01" ; filename
			.byte "  " ; filename white chars
			.byte "BIN" ; extension

_SONG01_ay_reg_data00 = 0
_SONG01_ay_reg_data01 = 847
_SONG01_ay_reg_data02 = 1114
_SONG01_ay_reg_data03 = 1949
_SONG01_ay_reg_data04 = 2407
_SONG01_ay_reg_data05 = 3902
_SONG01_ay_reg_data06 = 4015
_SONG01_ay_reg_data07 = 6120
_SONG01_ay_reg_data08 = 6656
_SONG01_ay_reg_data09 = 6854
_SONG01_ay_reg_data10 = 7324
_SONG01_ay_reg_data11 = 7837
_SONG01_ay_reg_data12 = 8512
_SONG01_ay_reg_data13 = 8519

SONG01_ay_reg_data_ptrs:
			.word _SONG01_ay_reg_data00, _SONG01_ay_reg_data01, _SONG01_ay_reg_data02, _SONG01_ay_reg_data03, _SONG01_ay_reg_data04, _SONG01_ay_reg_data05, _SONG01_ay_reg_data06, _SONG01_ay_reg_data07, _SONG01_ay_reg_data08, _SONG01_ay_reg_data09, _SONG01_ay_reg_data10, _SONG01_ay_reg_data11, _SONG01_ay_reg_data12, _SONG01_ay_reg_data13, 
