; fdd bin file metadata
; asm data file: build/debug/music/song01_data.asm
; bin file: build/debug/bin/SONG01.BIN

SONG01_META_FILE_LEN = 8575
SONG01_META_LAST_RECORD_LEN = 127
SONG01_META_filename
			.byte "SONG01" ; filename
			.byte "  " ; filename white chars
			.byte "BIN" ; extension

