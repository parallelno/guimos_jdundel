; fdd bin file metadata
; asm data file: build/debug/sprite/knight_data.asm
; bin file: build/debug/bin/KNIGHT.BIN

KNIGHT_FILE_LEN = 10664
KNIGHT_LAST_RECORD_LEN = 40

KNIGHT_FILENAME_PTR:
			.byte "KNIGHT" ; filename
			.byte "  " ; filename white chars
			.byte "BIN" ; extension

; relative frame labels
_knight_idle_0_0_relative = 2
_knight_idle_0_1_relative = 128
_knight_idle_0_2_relative = 254
_knight_idle_0_3_relative = 440
_knight_idle_1_0_relative = 626
_knight_idle_1_1_relative = 752
_knight_idle_1_2_relative = 878
_knight_idle_1_3_relative = 1004
_knight_run_r0_0_relative = 1190
_knight_run_r0_1_relative = 1308
_knight_run_r0_2_relative = 1426
_knight_run_r0_3_relative = 1600
_knight_run_r1_0_relative = 1774
_knight_run_r1_1_relative = 1900
_knight_run_r1_2_relative = 2026
_knight_run_r1_3_relative = 2152
_knight_run_r2_0_relative = 2278
_knight_run_r2_1_relative = 2404
_knight_run_r2_2_relative = 2530
_knight_run_r2_3_relative = 2656
_knight_run_r3_0_relative = 2842
_knight_run_r3_1_relative = 2960
_knight_run_r3_2_relative = 3078
_knight_run_r3_3_relative = 3252
_knight_run_l0_0_relative = 3426
_knight_run_l0_1_relative = 3544
_knight_run_l0_2_relative = 3662
_knight_run_l0_3_relative = 3836
_knight_run_l1_0_relative = 4010
_knight_run_l1_1_relative = 4136
_knight_run_l1_2_relative = 4262
_knight_run_l1_3_relative = 4388
_knight_run_l2_0_relative = 4514
_knight_run_l2_1_relative = 4640
_knight_run_l2_2_relative = 4766
_knight_run_l2_3_relative = 4952
_knight_run_l3_0_relative = 5078
_knight_run_l3_1_relative = 5196
_knight_run_l3_2_relative = 5314
_knight_run_l3_3_relative = 5488
_knight_defence_r0_0_relative = 5662
_knight_defence_r0_1_relative = 5780
_knight_defence_r0_2_relative = 5954
_knight_defence_r0_3_relative = 6128
_knight_defence_r1_0_relative = 6302
_knight_defence_r1_1_relative = 6428
_knight_defence_r1_2_relative = 6614
_knight_defence_r1_3_relative = 6800
_knight_defence_r2_0_relative = 6926
_knight_defence_r2_1_relative = 7052
_knight_defence_r2_2_relative = 7238
_knight_defence_r2_3_relative = 7424
_knight_defence_r3_0_relative = 7610
_knight_defence_r3_1_relative = 7728
_knight_defence_r3_2_relative = 7902
_knight_defence_r3_3_relative = 8076
_knight_defence_l0_0_relative = 8250
_knight_defence_l0_1_relative = 8368
_knight_defence_l0_2_relative = 8486
_knight_defence_l0_3_relative = 8660
_knight_defence_l1_0_relative = 8834
_knight_defence_l1_1_relative = 8960
_knight_defence_l1_2_relative = 9086
_knight_defence_l1_3_relative = 9272
_knight_defence_l2_0_relative = 9458
_knight_defence_l2_1_relative = 9584
_knight_defence_l2_2_relative = 9710
_knight_defence_l2_3_relative = 9896
_knight_defence_l3_0_relative = 10082
_knight_defence_l3_1_relative = 10200
_knight_defence_l3_2_relative = 10318
_knight_defence_l3_3_relative = 10492

knight_get_scr_addr:
			.word sprite_get_scr_addr4
knight_ram_disk_s_cmd:
			.byte TEMP_BYTE ; inited by sprite_init_meta_data
knight_preshifted_sprites:
			.byte 4
knight_anims:
			.word knight_idle_anim, knight_run_r_anim, knight_run_l_anim, knight_defence_r_anim, knight_defence_l_anim, EOD
knight_idle_anim:
			.byte 9, 0 ; offset to the next frame
			.word _knight_idle_0_0_relative, _knight_idle_0_1_relative, _knight_idle_0_2_relative, _knight_idle_0_3_relative, 
			.byte 245, $ff ; offset to the first frame
			.word _knight_idle_1_0_relative, _knight_idle_1_1_relative, _knight_idle_1_2_relative, _knight_idle_1_3_relative, 
knight_run_r_anim:
			.byte 9, 0 ; offset to the next frame
			.word _knight_run_r0_0_relative, _knight_run_r0_1_relative, _knight_run_r0_2_relative, _knight_run_r0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _knight_run_r1_0_relative, _knight_run_r1_1_relative, _knight_run_r1_2_relative, _knight_run_r1_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _knight_run_r2_0_relative, _knight_run_r2_1_relative, _knight_run_r2_2_relative, _knight_run_r2_3_relative, 
			.byte 225, $ff ; offset to the first frame
			.word _knight_run_r3_0_relative, _knight_run_r3_1_relative, _knight_run_r3_2_relative, _knight_run_r3_3_relative, 
knight_run_l_anim:
			.byte 9, 0 ; offset to the next frame
			.word _knight_run_l0_0_relative, _knight_run_l0_1_relative, _knight_run_l0_2_relative, _knight_run_l0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _knight_run_l1_0_relative, _knight_run_l1_1_relative, _knight_run_l1_2_relative, _knight_run_l1_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _knight_run_l2_0_relative, _knight_run_l2_1_relative, _knight_run_l2_2_relative, _knight_run_l2_3_relative, 
			.byte 225, $ff ; offset to the first frame
			.word _knight_run_l3_0_relative, _knight_run_l3_1_relative, _knight_run_l3_2_relative, _knight_run_l3_3_relative, 
knight_defence_r_anim:
			.byte 9, 0 ; offset to the next frame
			.word _knight_defence_r0_0_relative, _knight_defence_r0_1_relative, _knight_defence_r0_2_relative, _knight_defence_r0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _knight_defence_r1_0_relative, _knight_defence_r1_1_relative, _knight_defence_r1_2_relative, _knight_defence_r1_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _knight_defence_r2_0_relative, _knight_defence_r2_1_relative, _knight_defence_r2_2_relative, _knight_defence_r2_3_relative, 
			.byte 225, $ff ; offset to the first frame
			.word _knight_defence_r3_0_relative, _knight_defence_r3_1_relative, _knight_defence_r3_2_relative, _knight_defence_r3_3_relative, 
knight_defence_l_anim:
			.byte 9, 0 ; offset to the next frame
			.word _knight_defence_l0_0_relative, _knight_defence_l0_1_relative, _knight_defence_l0_2_relative, _knight_defence_l0_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _knight_defence_l1_0_relative, _knight_defence_l1_1_relative, _knight_defence_l1_2_relative, _knight_defence_l1_3_relative, 
			.byte 9, 0 ; offset to the next frame
			.word _knight_defence_l2_0_relative, _knight_defence_l2_1_relative, _knight_defence_l2_2_relative, _knight_defence_l2_3_relative, 
			.byte 225, $ff ; offset to the first frame
			.word _knight_defence_l3_0_relative, _knight_defence_l3_1_relative, _knight_defence_l3_2_relative, _knight_defence_l3_3_relative, 
knight_anims_end:
knight_anims_len: = knight_anims_end - knight_anims
