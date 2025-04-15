; fdd bin file metadata
; asm data file: build/debug/music/song01_data.asm
; bin file: build/debug/bin/SONG01.BIN

SONG01_FILE_LEN = 12132
SONG01_LAST_RECORD_LEN = 100

SONG01_FILENAME_PTR:
			.byte "SONG01" ; filename
			.byte "  " ; filename white chars
			.byte "BIN" ; extension

; relative labels
_v6_gc_buffer = 0x0000
_song01_ay_reg_data00_relative = 0x0e00
_song01_ay_reg_data01_relative = 0x114f
_song01_ay_reg_data02_relative = 0x125a
_song01_ay_reg_data03_relative = 0x159d
_song01_ay_reg_data04_relative = 0x1767
_song01_ay_reg_data05_relative = 0x1d3e
_song01_ay_reg_data06_relative = 0x1daf
_song01_ay_reg_data07_relative = 0x25e8
_song01_ay_reg_data08_relative = 0x2800
_song01_ay_reg_data09_relative = 0x28c6
_song01_ay_reg_data10_relative = 0x2a9c
_song01_ay_reg_data11_relative = 0x2c9d
_song01_ay_reg_data12_relative = 0x2f40
_song01_ay_reg_data13_relative = 0x2f47


song01_ay_reg_data_ptrs:
			.word _song01_ay_reg_data00_relative, _song01_ay_reg_data01_relative, _song01_ay_reg_data02_relative, _song01_ay_reg_data03_relative, _song01_ay_reg_data04_relative, _song01_ay_reg_data05_relative, _song01_ay_reg_data06_relative, _song01_ay_reg_data07_relative, _song01_ay_reg_data08_relative, _song01_ay_reg_data09_relative, _song01_ay_reg_data10_relative, _song01_ay_reg_data11_relative, _song01_ay_reg_data12_relative, _song01_ay_reg_data13_relative, 

