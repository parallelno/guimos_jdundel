; fdd bin file metadata
; asm data file: build/debug/music/song01_data.asm
; bin file: build/debug/bin/SONG01.BIN

SONG01_FILE_LEN = 8548
SONG01_LAST_RECORD_LEN = 100

SONG01_FILENAME_PTR:
			.byte "SONG01" ; filename
			.byte "  " ; filename white chars
			.byte "BIN" ; extension

_song01_ay_reg_data00_relative = 0
_song01_ay_reg_data01_relative = 847
_song01_ay_reg_data02_relative = 1114
_song01_ay_reg_data03_relative = 1949
_song01_ay_reg_data04_relative = 2407
_song01_ay_reg_data05_relative = 3902
_song01_ay_reg_data06_relative = 4015
_song01_ay_reg_data07_relative = 6120
_song01_ay_reg_data08_relative = 6656
_song01_ay_reg_data09_relative = 6854
_song01_ay_reg_data10_relative = 7324
_song01_ay_reg_data11_relative = 7837
_song01_ay_reg_data12_relative = 8512
_song01_ay_reg_data13_relative = 8519

song01_ay_reg_data_ptrs:
			.word _song01_ay_reg_data00_relative, _song01_ay_reg_data01_relative, _song01_ay_reg_data02_relative, _song01_ay_reg_data03_relative, _song01_ay_reg_data04_relative, _song01_ay_reg_data05_relative, _song01_ay_reg_data06_relative, _song01_ay_reg_data07_relative, _song01_ay_reg_data08_relative, _song01_ay_reg_data09_relative, _song01_ay_reg_data10_relative, _song01_ay_reg_data11_relative, _song01_ay_reg_data12_relative, _song01_ay_reg_data13_relative, 
