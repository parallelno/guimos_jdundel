; fdd bin file metadata
; asm data file: build/debug/music/song02_data.asm
; bin file: build/debug/bin/SONG02.BIN

SONG02_META_FILE_LEN = 8575
SONG02_META_LAST_RECORD_LEN = 127
SONG02_META_filename
			.byte "SONG02" ; filename
			.byte "  " ; filename white chars
			.byte "BIN" ; extension

