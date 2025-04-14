; fdd bin file metadata
; asm data file: build/debug/sprite/knight_data.asm
; bin file: build/debug/bin/KNIGHT.BIN

KNIGHT_FILE_LEN = 15780
KNIGHT_LAST_RECORD_LEN = 36

KNIGHT_FILENAME_PTR:
			.byte "KNIGHT" ; filename
			.byte "  " ; filename white chars
			.byte "BIN" ; extension

; relative frame labels
_knight_idle_0_0_relative = 2
_knight_idle_0_1_relative = 188
_knight_idle_0_2_relative = 374
_knight_idle_0_3_relative = 650
_knight_idle_1_0_relative = 926
_knight_idle_1_1_relative = 1112
_knight_idle_1_2_relative = 1298
_knight_idle_1_3_relative = 1484
_knight_run_r0_0_relative = 1760
_knight_run_r0_1_relative = 1934
_knight_run_r0_2_relative = 2108
_knight_run_r0_3_relative = 2366
_knight_run_r1_0_relative = 2624
_knight_run_r1_1_relative = 2810
_knight_run_r1_2_relative = 2996
_knight_run_r1_3_relative = 3182
_knight_run_r2_0_relative = 3368
_knight_run_r2_1_relative = 3554
_knight_run_r2_2_relative = 3740
_knight_run_r2_3_relative = 3926
_knight_run_r3_0_relative = 4202
_knight_run_r3_1_relative = 4376
_knight_run_r3_2_relative = 4550
_knight_run_r3_3_relative = 4808
_knight_run_l0_0_relative = 5066
_knight_run_l0_1_relative = 5240
_knight_run_l0_2_relative = 5414
_knight_run_l0_3_relative = 5672
_knight_run_l1_0_relative = 5930
_knight_run_l1_1_relative = 6116
_knight_run_l1_2_relative = 6302
_knight_run_l1_3_relative = 6488
_knight_run_l2_0_relative = 6674
_knight_run_l2_1_relative = 6860
_knight_run_l2_2_relative = 7046
_knight_run_l2_3_relative = 7322
_knight_run_l3_0_relative = 7508
_knight_run_l3_1_relative = 7682
_knight_run_l3_2_relative = 7856
_knight_run_l3_3_relative = 8114
_knight_defence_r0_0_relative = 8372
_knight_defence_r0_1_relative = 8546
_knight_defence_r0_2_relative = 8804
_knight_defence_r0_3_relative = 9062
_knight_defence_r1_0_relative = 9320
_knight_defence_r1_1_relative = 9506
_knight_defence_r1_2_relative = 9782
_knight_defence_r1_3_relative = 10058
_knight_defence_r2_0_relative = 10244
_knight_defence_r2_1_relative = 10430
_knight_defence_r2_2_relative = 10706
_knight_defence_r2_3_relative = 10982
_knight_defence_r3_0_relative = 11258
_knight_defence_r3_1_relative = 11432
_knight_defence_r3_2_relative = 11690
_knight_defence_r3_3_relative = 11948
_knight_defence_l0_0_relative = 12206
_knight_defence_l0_1_relative = 12380
_knight_defence_l0_2_relative = 12554
_knight_defence_l0_3_relative = 12812
_knight_defence_l1_0_relative = 13070
_knight_defence_l1_1_relative = 13256
_knight_defence_l1_2_relative = 13442
_knight_defence_l1_3_relative = 13718
_knight_defence_l2_0_relative = 13994
_knight_defence_l2_1_relative = 14180
_knight_defence_l2_2_relative = 14366
_knight_defence_l2_3_relative = 14642
_knight_defence_l3_0_relative = 14918
_knight_defence_l3_1_relative = 15092
_knight_defence_l3_2_relative = 15266
_knight_defence_l3_3_relative = 15524

sprite_get_scr_addr_knight = sprite_get_scr_addr4

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
