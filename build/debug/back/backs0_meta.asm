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
_backs0_torch_front0_relative = 2
_backs0_torch_front1_relative = 64
_backs0_torch_front2_relative = 126
_backs0_torch_front3_relative = 188
_backs0_flag_front0_relative = 250
_backs0_flag_front1_relative = 312
_backs0_flag_front2_relative = 374
_backs0_flag_front3_relative = 436
_backs0_dialog_press_key0_relative = 498
_backs0_dialog_press_key1_relative = 560

backs0_preshifted_sprites:
			.byte 1
backs0_anims:
			.word backs0_torch_front, backs0_flag_front, backs0_dialog_press_key, EOD
backs0_torch_front:
			.byte 3, 0 ; offset to the next frame
			.word _backs0_torch_front0_relative, 
			.byte 3, 0 ; offset to the next frame
			.word _backs0_torch_front1_relative, 
			.byte 3, 0 ; offset to the next frame
			.word _backs0_torch_front2_relative, 
			.byte 243, $ff ; offset to the first frame
			.word _backs0_torch_front3_relative, 
backs0_flag_front:
			.byte 3, 0 ; offset to the next frame
			.word _backs0_flag_front0_relative, 
			.byte 3, 0 ; offset to the next frame
			.word _backs0_flag_front1_relative, 
			.byte 3, 0 ; offset to the next frame
			.word _backs0_flag_front2_relative, 
			.byte 3, 0 ; offset to the next frame
			.word _backs0_flag_front3_relative, 
			.byte 3, 0 ; offset to the next frame
			.word _backs0_flag_front2_relative, 
			.byte 235, $ff ; offset to the first frame
			.word _backs0_flag_front1_relative, 
backs0_dialog_press_key:
			.byte 3, 0 ; offset to the next frame
			.word _backs0_dialog_press_key0_relative, 
			.byte 251, $ff ; offset to the first frame
			.word _backs0_dialog_press_key1_relative, 
