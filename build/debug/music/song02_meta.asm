; fdd bin file metadata
; asm data file: build/debug/music/song02_data.asm
; bin file: build/debug/bin/SONG02.BIN

SONG02_FILE_LEN = 8548
SONG02_LAST_RECORD_LEN = 100
SONG02_FILENAME_PTR:
			.byte "SONG02" ; filename
			.byte "  " ; filename white chars
			.byte "BIN" ; extension

_SONG02_ay_reg_data00 = 0
_SONG02_ay_reg_data01 = 847
_SONG02_ay_reg_data02 = 1114
_SONG02_ay_reg_data03 = 1949
_SONG02_ay_reg_data04 = 2407
_SONG02_ay_reg_data05 = 3902
_SONG02_ay_reg_data06 = 4015
_SONG02_ay_reg_data07 = 6120
_SONG02_ay_reg_data08 = 6656
_SONG02_ay_reg_data09 = 6854
_SONG02_ay_reg_data10 = 7324
_SONG02_ay_reg_data11 = 7837
_SONG02_ay_reg_data12 = 8512
_SONG02_ay_reg_data13 = 8519

SONG02_ay_reg_data_ptrs:
			.word _SONG02_ay_reg_data00, _SONG02_ay_reg_data01, _SONG02_ay_reg_data02, _SONG02_ay_reg_data03, _SONG02_ay_reg_data04, _SONG02_ay_reg_data05, _SONG02_ay_reg_data06, _SONG02_ay_reg_data07, _SONG02_ay_reg_data08, _SONG02_ay_reg_data09, _SONG02_ay_reg_data10, _SONG02_ay_reg_data11, _SONG02_ay_reg_data12, _SONG02_ay_reg_data13, 
