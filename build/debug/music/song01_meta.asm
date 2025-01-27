; fdd bin file metadata
; asm data file: build/debug/music/song01_data.asm
; bin file: build/debug/bin/SONG01.BIN

SONG01_META_FILE_LEN = 8547
SONG01_META_LAST_RECORD_LEN = 99
SONG01_META_filename:
			.byte "SONG01" ; filename
			.byte "  " ; filename white chars
			.byte "BIN" ; extension

ay_reg_data00 = 0
ay_reg_data01 = 847
ay_reg_data02 = 1114
ay_reg_data03 = 1949
ay_reg_data04 = 2407
ay_reg_data05 = 3902
ay_reg_data06 = 4015
ay_reg_data07 = 6120
ay_reg_data08 = 6656
ay_reg_data09 = 6854
ay_reg_data10 = 7324
ay_reg_data11 = 7837
ay_reg_data12 = 8512
ay_reg_data13 = 8519

v6_gc_ay_reg_data_ptrs:
			.word ay_reg_data00, ay_reg_data01, ay_reg_data02, ay_reg_data03, ay_reg_data04, ay_reg_data05, ay_reg_data06, ay_reg_data07, ay_reg_data08, ay_reg_data09, ay_reg_data10, ay_reg_data11, ay_reg_data12, ay_reg_data13, 
