; fdd bin file metadata
; asm data file: build/debug/back/backs0_data.asm
; bin file: build/debug/bin/BACKS0.BIN

BACKS0_FILE_LEN = 620
BACKS0_LAST_RECORD_LEN = 108

BACKS0_FILENAME_PTR:
			.byte "BACKS0" ; filename
			.byte "  " ; filename white chars
			.byte "BIN" ; extension

; relative frame labels
_backs0_torch_front0 = 2
_backs0_torch_front1 = 64
_backs0_torch_front2 = 126
_backs0_torch_front3 = 188
_backs0_flag_front0 = 250
_backs0_flag_front1 = 312
_backs0_flag_front2 = 374
_backs0_flag_front3 = 436
_backs0_dialog_press_key0 = 498
_backs0_dialog_press_key1 = 560

_backs0_preshifted_sprites:
			.byte 1
_backs0_anims:
			.word _backs0_torch_front, _backs0_flag_front, _backs0_dialog_press_key, EOD
_backs0_torch_front:
			.byte 3, 0 ; offset to the next frame
			.word _backs0_torch_front0, 
			.byte 3, 0 ; offset to the next frame
			.word _backs0_torch_front1, 
			.byte 3, 0 ; offset to the next frame
			.word _backs0_torch_front2, 
			.byte 243, $ff ; offset to the first frame
			.word _backs0_torch_front3, 
_backs0_flag_front:
			.byte 3, 0 ; offset to the next frame
			.word _backs0_flag_front0, 
			.byte 3, 0 ; offset to the next frame
			.word _backs0_flag_front1, 
			.byte 3, 0 ; offset to the next frame
			.word _backs0_flag_front2, 
			.byte 3, 0 ; offset to the next frame
			.word _backs0_flag_front3, 
			.byte 3, 0 ; offset to the next frame
			.word _backs0_flag_front2, 
			.byte 235, $ff ; offset to the first frame
			.word _backs0_flag_front1, 
_backs0_dialog_press_key:
			.byte 3, 0 ; offset to the next frame
			.word _backs0_dialog_press_key0, 
			.byte 251, $ff ; offset to the first frame
			.word _backs0_dialog_press_key1, 
