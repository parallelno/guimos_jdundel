_font_gfx:
			.word 0 ; safety pair of bytes for reading by POP B
_font_0:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x70,0x88,0x88,0x88,0x88,0x88,0x88,0x88,0x70,
			.byte 0, 6 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_1:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x40,0x40,0x40,0x40,0x40,0x40,0x40,0xC0,0x40,
			.byte 0, 3 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_2:
			.byte 0, 0 ; offset_y, offset_x
			.word 0xF8,0x80,0x80,0x60,0x10,0x8,0x88,0x88,0x70,
			.byte 0, 6 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_3:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x70,0x88,0x8,0x8,0x10,0x8,0x88,0x88,0x70,
			.byte 0, 6 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_4:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x10,0x10,0x10,0x10,0xF8,0x90,0x90,0x50,0x50,
			.byte 0, 6 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_5:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x70,0x88,0x88,0x8,0x8,0xF0,0x80,0x80,0xF8,
			.byte 0, 6 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_6:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x70,0x88,0x88,0x88,0xF0,0x80,0x88,0x88,0x70,
			.byte 0, 6 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_7:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x40,0x40,0x40,0x40,0x20,0x10,0x10,0x10,0xF0,
			.byte 0, 5 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_8:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x70,0x88,0x88,0x88,0x70,0x88,0x88,0x88,0x70,
			.byte 0, 6 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_9:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x70,0x8,0x8,0x8,0x78,0x88,0x88,0x88,0x70,
			.byte 0, 6 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_space:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x0,
			.byte 0, 5 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_exclamation:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x80,0x0,0x80,0x80,0x80,0x80,0x80,0x80,0x80,0x80,
			.byte 0, 2 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_d_quote:
			.byte 0, 0 ; offset_y, offset_x
			.word 0xF0,
			.byte 0, 5 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_ampersand:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x71,0x8A,0x84,0x8A,0x50,0x30,0x48,0x48,0x30,
			.byte 0, 9 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_hash:
			.byte 0, 0 ; offset_y, offset_x
			.word 0xF0,
			.byte 0, 5 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_dollar:
			.byte 0, 0 ; offset_y, offset_x
			.word 0xF0,
			.byte 0, 5 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_percent:
			.byte 0, 0 ; offset_y, offset_x
			.word 0xF0,
			.byte 0, 5 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_ampercent:
			.byte 0, 0 ; offset_y, offset_x
			.word 0xF0,
			.byte 0, 5 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_quote:
			.byte 6, 0 ; offset_y, offset_x
			.word 0x80,0x40,
			.byte 0, 3 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_parent_l:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x20,0x40,0x80,0x80,0x80,0x80,0x40,0x20,
			.byte 0, 4 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_parent_r:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x80,0x40,0x20,0x20,0x20,0x20,0x40,0x80,
			.byte 0, 4 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_comma:
			.byte -1, -1 ; offset_y, offset_x
			.word 0x80,0x40,
			.byte 0, 3 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_dash:
			.byte 3, 0 ; offset_y, offset_x
			.word 0xF8,
			.byte 0, 6 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_period:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x80,
			.byte 0, 2 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_colon:
			.byte 1, 0 ; offset_y, offset_x
			.word 0x80,0x0,0x0,0x80,
			.byte 0, 2 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_equal:
			.byte 0, 0 ; offset_y, offset_x
			.word 0xF0,
			.byte 0, 5 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_question:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x20,0x0,0x20,0x20,0x10,0x18,0x8,0x8,0x88,0x70,
			.byte 0, 6 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_A:
			.byte 0, 0 ; offset_y, offset_x
			.word 0xC4,0x44,0x44,0x7C,0x28,0x28,0x10,0x10,0x10,
			.byte 0, 7 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_B:
			.byte 0, -1 ; offset_y, offset_x
			.word 0x7C,0x22,0x22,0x22,0x24,0x38,0x24,0xA4,0x78,
			.byte 0, 7 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_C:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x70,0xC8,0x88,0x80,0x80,0x80,0x80,0xC8,0x70,
			.byte 0, 6 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_D:
			.byte 0, 0 ; offset_y, offset_x
			.word 0xF0,0x48,0x48,0x48,0x48,0x48,0x48,0x48,0xF0,
			.byte 0, 6 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_E:
			.byte 0, 0 ; offset_y, offset_x
			.word 0xF8,0x48,0x40,0x50,0x70,0x50,0x40,0x48,0xF8,
			.byte 0, 6 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_F:
			.byte 0, 0 ; offset_y, offset_x
			.word 0xC0,0x40,0x40,0x50,0x70,0x50,0x40,0x48,0xF8,
			.byte 0, 6 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_G:
			.byte -2, -1 ; offset_y, offset_x
			.word 0x4,0x4,0x74,0xCC,0x8C,0x8C,0x84,0x9C,0x80,0xC4,0x78,
			.byte 0, 7 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_H:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x48,0x48,0x48,0x48,0x78,0x48,0x48,0x48,0xC8,
			.byte 0, 6 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_I:
			.byte 0, 0 ; offset_y, offset_x
			.word 0xE0,0x40,0x40,0x40,0x40,0x40,0x40,0x40,0xC0,
			.byte 0, 4 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_J:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x60,0xD0,0x90,0x10,0x10,0x10,0x10,0x10,0x38,
			.byte 0, 6 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_K:
			.byte 0, 0 ; offset_y, offset_x
			.word 0xE4,0x4C,0x58,0x70,0x70,0x50,0x48,0x48,0xC4,
			.byte 0, 7 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_L:
			.byte 0, 0 ; offset_y, offset_x
			.word 0xF8,0x48,0x48,0x40,0x40,0x40,0x40,0x40,0xC0,
			.byte 0, 6 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_M:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x41,0x41,0x41,0x49,0x5D,0x77,0x63,0x63,0xC1,0x1,
			.byte 0, 9 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_N:
			.byte 0, 0 ; offset_y, offset_x
			.word 0xC4,0x44,0x4C,0x5C,0x5C,0x74,0x64,0x44,0xC4,
			.byte 0, 7 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_O:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x30,0x48,0x84,0x84,0xB4,0x84,0x84,0x48,0x30,
			.byte 0, 7 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_P:
			.byte 0, 0 ; offset_y, offset_x
			.word 0xE0,0x40,0x40,0x40,0x70,0x48,0x48,0x48,0xF0,
			.byte 0, 6 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_Q:
			.byte -1, -1 ; offset_y, offset_x
			.word 0xC,0x2C,0x58,0x84,0x84,0xB4,0x84,0x84,0x48,0x30,
			.byte 0, 7 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_R:
			.byte -2, -1 ; offset_y, offset_x
			.word 0x7,0x8,0xC8,0x50,0x50,0x60,0x50,0x48,0x48,0x48,0xF0,
			.byte 0, 6 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_S:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x70,0xC8,0x88,0x10,0x20,0x40,0x88,0x88,0x70,
			.byte 0, 6 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_T:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x38,0x10,0x10,0x10,0x10,0x10,0x10,0x92,0xFE,
			.byte 0, 8 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_U:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x30,0x68,0x44,0x44,0x44,0x44,0x44,0x44,0xC6,
			.byte 0, 8 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_V:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x10,0x10,0x38,0x38,0x28,0x28,0x44,0x44,0xC6,
			.byte 0, 8 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_W:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x22,0x22,0x22,0x77,0x55,0x49,0x49,0x49,0xC9,
			.byte 0, 9 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_X:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x84,0x8C,0x48,0x78,0x30,0x30,0x68,0xC8,0x84,
			.byte 0, 7 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_Y:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x38,0x10,0x10,0x10,0x38,0x28,0x68,0x44,0xC6,
			.byte 0, 8 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_Z:
			.byte 0, 0 ; offset_y, offset_x
			.word 0xFC,0xC4,0x40,0x20,0x20,0x10,0x48,0x4C,0xFC,
			.byte 0, 7 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_a:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x88,0xF0,0x90,0x90,0x50,0x70,
			.byte 0, 5 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_b:
			.byte 0, 0 ; offset_y, offset_x
			.word 0xE0,0x90,0x90,0x90,0x90,0xE0,0x80,0x80,
			.byte 0, 5 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_c:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x60,0x90,0x90,0x80,0x90,0x60,
			.byte 0, 5 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_d:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x70,0x90,0x90,0x90,0x90,0x70,0x10,0x10,
			.byte 0, 5 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_e:
			.byte 0, 0 ; offset_y, offset_x
			.word 0xF0,0x90,0x80,0xC0,0x90,0xE0,
			.byte 0, 5 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_f:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x40,0x40,0x40,0x40,0x40,0xF0,0x40,0x40,0x3C,
			.byte 0, 5 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_g:
			.byte -2, -3 ; offset_y, offset_x
			.word 0xF8,0x4,0x1C,0x24,0x24,0x24,0x24,0x1C,
			.byte 0, 5 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_h:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x90,0x90,0x90,0xF0,0x90,0x90,
			.byte 0, 5 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_i:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x40,0x40,0x40,0x40,0x40,0xC0,0x0,0x40,
			.byte 0, 3 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_j:
			.byte -3, -2 ; offset_y, offset_x
			.word 0x80,0x40,0x40,0x40,0x40,0x40,0x40,0x40,0x40,0x0,0x40,
			.byte 0, 2 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_k:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x58,0x60,0x50,0x50,0x48,0xC8,
			.byte 0, 6 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_l:
			.byte 0, 0 ; offset_y, offset_x
			.word 0xF0,0x90,0x80,0x80,0x80,0x80,
			.byte 0, 5 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_m:
			.byte 0, 0 ; offset_y, offset_x
			.word 0xAC,0xA8,0xA8,0xA8,0xA8,0xD0,
			.byte 0, 7 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_n:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x90,0x90,0x90,0x90,0x90,0xE0,
			.byte 0, 5 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_o:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x70,0x88,0xA8,0x88,0x88,0x70,
			.byte 0, 6 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_p:
			.byte -4, -2 ; offset_y, offset_x
			.word 0x40,0x40,0x40,0x40,0x70,0x48,0x48,0x48,0x48,0xF0,
			.byte 0, 5 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_q:
			.byte -1, -1 ; offset_y, offset_x
			.word 0x4,0x68,0x90,0xA8,0x88,0x88,0x70,
			.byte 0, 6 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_r:
			.byte -2, -1 ; offset_y, offset_x
			.word 0xC,0x10,0x50,0x60,0x50,0x50,0x50,0xE0,
			.byte 0, 5 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_s:
			.byte 0, 0 ; offset_y, offset_x
			.word 0xE0,0x10,0x10,0xE0,0x80,0x60,
			.byte 0, 5 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_t:
			.byte -1, -1 ; offset_y, offset_x
			.word 0x30,0x40,0x40,0x40,0x40,0x40,0xF0,0x40,0x40,0x40,
			.byte 0, 5 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_u:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x70,0x88,0x88,0x88,0x88,0x88,
			.byte 0, 6 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_v:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x20,0x70,0x50,0x88,0x88,0x88,
			.byte 0, 6 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_w:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x50,0xA8,0xA8,0xA8,0x88,0x88,
			.byte 0, 6 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_x:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x90,0x90,0x60,0x60,0x90,0x90,
			.byte 0, 5 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_y:
			.byte 0, 0 ; offset_y, offset_x
			.word 0x20,0x20,0x20,0x50,0x88,0x88,
			.byte 0, 6 ; next_char_pos_y_offset, next_char_pos_x_offset

			.word 0 ; safety pair of bytes for reading by POP B
_font_z:
			.byte 0, 0 ; offset_y, offset_x
			.word 0xF0,0x80,0x40,0x20,0x10,0xF0,
			.byte 0, 5 ; next_char_pos_y_offset, next_char_pos_x_offset
