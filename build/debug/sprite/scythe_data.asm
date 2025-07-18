_scythe_sprites:
			.word 0  ; safety pair of bytes for reading by POP B
_scythe_run0_0_relative:
			.byte 4, 0; offset_y, offset_x
			.byte 5, 1; h, w
			.byte 0xFF, 0x00, 0x00, 0x00, 0x3F, 0xC0, 0x00, 0x40, 0x9F, 0x20, 0x00, 0x60, 0xFB, 0x04, 0x00, 0x00, 
			.byte 0xF0, 0x00, 0x04, 0x0B, 0x0F, 0xE0, 0x00, 0x30, 0x0F, 0x30, 0xC0, 0x20, 0x00, 0xF8, 0x07, 0x00, 
			.byte 0x07, 0x00, 0x78, 0x80, 0xCF, 0x30, 0x00, 0x10, 

			.word 0  ; safety pair of bytes for reading by POP B
_scythe_run0_1_relative:
			.byte 4, 0; offset_y, offset_x
			.byte 5, 1; h, w
			.byte 0xFF, 0x00, 0x00, 0x00, 0xCF, 0x30, 0x00, 0x10, 0xE7, 0x08, 0x00, 0x18, 0xFE, 0x01, 0x00, 0x00, 
			.byte 0xFC, 0x00, 0x01, 0x02, 0x03, 0xF8, 0x00, 0x0C, 0x03, 0x0C, 0xF0, 0x08, 0xC0, 0x3E, 0x01, 0x00, 
			.byte 0xC1, 0x00, 0x1E, 0x20, 0xF3, 0x0C, 0x00, 0x04, 

			.word 0  ; safety pair of bytes for reading by POP B
_scythe_run0_2_relative:
			.byte 4, 0; offset_y, offset_x
			.byte 5, 1; h, w
			.byte 0xFF, 0x00, 0x00, 0x00, 0xF3, 0x0C, 0x00, 0x04, 0xB9, 0x02, 0x00, 0x46, 0xFF, 0x00, 0x00, 0x00, 
			.byte 0xFF, 0x00, 0x00, 0x00, 0x00, 0xBE, 0x40, 0x03, 0x00, 0x03, 0x7C, 0x82, 0xF0, 0x0F, 0x00, 0x00, 
			.byte 0xF0, 0x00, 0x07, 0x08, 0x7C, 0x03, 0x80, 0x01, 

			.word 0  ; safety pair of bytes for reading by POP B
_scythe_run0_3_relative:
			.byte 4, 0; offset_y, offset_x
			.byte 5, 2; h, w
			.byte 0xFF, 0x00, 0x00, 0x00, 0xFC, 0x03, 0x00, 0x01, 0xFF, 0x00, 0x00, 0x00, 0x7F, 0x80, 0x00, 0x80, 
			.byte 0xEE, 0x00, 0x00, 0x11, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0xC0, 0x2F, 0x10, 0x00, 
			.byte 0x3F, 0xC0, 0x00, 0x80, 0x3F, 0x80, 0x00, 0xC0, 0x00, 0x00, 0x1F, 0xE0, 0xFC, 0x03, 0x00, 0x00, 
			.byte 0xFC, 0x00, 0x01, 0x02, 0x1F, 0x00, 0xE0, 0x00, 0x3F, 0x40, 0x00, 0xC0, 

			.word 0  ; safety pair of bytes for reading by POP B
_scythe_run1_0_relative:
			.byte 0, 0; offset_y, offset_x
			.byte 12, 0; h, w
			.byte 0xF8, 0x00, 0x00, 0x07, 0xF0, 0x09, 0x00, 0x07, 0xE0, 0x0E, 0x00, 0x1D, 0xEC, 0x11, 0x02, 0x10, 
			.byte 0xFC, 0x00, 0x02, 0x01, 0xFC, 0x01, 0x02, 0x00, 0xF8, 0x00, 0x02, 0x05, 0xF8, 0x01, 0x06, 0x00, 
			.byte 0xFE, 0x00, 0x01, 0x00, 0xFE, 0x00, 0x01, 0x00, 0xFE, 0x00, 0x01, 0x00, 0xFE, 0x00, 0x01, 0x00, 

			.word 0  ; safety pair of bytes for reading by POP B
_scythe_run1_1_relative:
			.byte 0, 0; offset_y, offset_x
			.byte 12, 1; h, w
			.byte 0xFE, 0x00, 0x00, 0x01, 0x3F, 0xC0, 0x00, 0x00, 0x3F, 0xC0, 0x00, 0x40, 0xFC, 0x02, 0x00, 0x01, 
			.byte 0xF8, 0x03, 0x00, 0x07, 0x3F, 0x40, 0x00, 0x80, 0x3F, 0x00, 0x80, 0x40, 0xFB, 0x04, 0x00, 0x04, 
			.byte 0xFF, 0x00, 0x00, 0x00, 0x3F, 0x40, 0x80, 0x00, 0x3F, 0x00, 0x80, 0x40, 0xFF, 0x00, 0x00, 0x00, 
			.byte 0xFE, 0x00, 0x00, 0x01, 0x3F, 0x40, 0x80, 0x00, 0x3F, 0x00, 0x80, 0x40, 0xFE, 0x00, 0x01, 0x00, 
			.byte 0xFF, 0x00, 0x00, 0x00, 0x9F, 0x20, 0x40, 0x00, 0x9F, 0x00, 0x40, 0x20, 0xFF, 0x00, 0x00, 0x00, 
			.byte 0xFF, 0x00, 0x00, 0x00, 0x9F, 0x20, 0x40, 0x00, 0x9F, 0x00, 0x40, 0x20, 0xFF, 0x00, 0x00, 0x00, 

			.word 0  ; safety pair of bytes for reading by POP B
_scythe_run1_2_relative:
			.byte 0, 0; offset_y, offset_x
			.byte 12, 1; h, w
			.byte 0xFF, 0x00, 0x00, 0x00, 0x8F, 0x70, 0x00, 0x00, 0x0F, 0x70, 0x00, 0x90, 0xFF, 0x00, 0x00, 0x00, 
			.byte 0xFE, 0x00, 0x00, 0x01, 0x0F, 0xD0, 0x00, 0xE0, 0xCF, 0x00, 0x20, 0x10, 0xFE, 0x01, 0x00, 0x01, 
			.byte 0xFF, 0x00, 0x00, 0x00, 0xCF, 0x10, 0x20, 0x00, 0xCF, 0x00, 0x20, 0x10, 0xFF, 0x00, 0x00, 0x00, 
			.byte 0xFF, 0x00, 0x00, 0x00, 0x8F, 0x50, 0x20, 0x00, 0x8F, 0x00, 0x60, 0x10, 0xFF, 0x00, 0x00, 0x00, 
			.byte 0xFF, 0x00, 0x00, 0x00, 0xE7, 0x08, 0x10, 0x00, 0xE7, 0x00, 0x10, 0x08, 0xFF, 0x00, 0x00, 0x00, 
			.byte 0xFF, 0x00, 0x00, 0x00, 0xE7, 0x08, 0x10, 0x00, 0xE7, 0x00, 0x10, 0x08, 0xFF, 0x00, 0x00, 0x00, 

			.word 0  ; safety pair of bytes for reading by POP B
_scythe_run1_3_relative:
			.byte 0, 1; offset_y, offset_x
			.byte 12, 0; h, w
			.byte 0xE3, 0x00, 0x00, 0x1C, 0xC3, 0x24, 0x00, 0x1C, 0x83, 0x38, 0x00, 0x74, 0xB3, 0x44, 0x08, 0x40, 
			.byte 0xF3, 0x00, 0x08, 0x04, 0xF3, 0x04, 0x08, 0x00, 0xE3, 0x00, 0x08, 0x14, 0xE3, 0x04, 0x18, 0x00, 
			.byte 0xF9, 0x00, 0x04, 0x02, 0xF9, 0x02, 0x04, 0x00, 0xF9, 0x00, 0x04, 0x02, 0xF9, 0x02, 0x04, 0x00, 

			.word 0  ; safety pair of bytes for reading by POP B
_scythe_run2_0_relative:
			.byte 4, 0; offset_y, offset_x
			.byte 6, 1; h, w
			.byte 0x7E, 0x00, 0x00, 0x81, 0x0F, 0xF0, 0x00, 0x00, 0x0F, 0x00, 0xE0, 0x10, 0x00, 0x7E, 0x01, 0x80, 
			.byte 0x00, 0xC0, 0x3E, 0x01, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x1C, 0xA1, 0x02, 0xC0, 
			.byte 0x9F, 0x40, 0x00, 0x60, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0xDF, 0x20, 0x00, 0x20, 

			.word 0  ; safety pair of bytes for reading by POP B
_scythe_run2_1_relative:
			.byte 4, 0; offset_y, offset_x
			.byte 6, 1; h, w
			.byte 0xDF, 0x00, 0x00, 0x20, 0x83, 0x7C, 0x00, 0x00, 0x03, 0x00, 0x78, 0x84, 0xC0, 0x1F, 0x00, 0x20, 
			.byte 0xC0, 0x30, 0x0F, 0x00, 0x3F, 0x40, 0x80, 0x00, 0x3F, 0x00, 0x80, 0x40, 0xC7, 0x28, 0x00, 0x30, 
			.byte 0xE7, 0x10, 0x00, 0x18, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0xF7, 0x08, 0x00, 0x08, 

			.word 0  ; safety pair of bytes for reading by POP B
_scythe_run2_2_relative:
			.byte 4, 0; offset_y, offset_x
			.byte 6, 1; h, w
			.byte 0xF7, 0x00, 0x00, 0x08, 0xE0, 0x1F, 0x00, 0x00, 0x00, 0x00, 0x1E, 0xE1, 0xF0, 0x07, 0x00, 0x08, 
			.byte 0xF0, 0x0C, 0x03, 0x00, 0x0F, 0x10, 0xE0, 0x00, 0xCF, 0x00, 0x20, 0x10, 0xF1, 0x0A, 0x00, 0x0C, 
			.byte 0xF9, 0x04, 0x00, 0x06, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0xFD, 0x02, 0x00, 0x02, 

			.word 0  ; safety pair of bytes for reading by POP B
_scythe_run2_3_relative:
			.byte 4, 0; offset_y, offset_x
			.byte 6, 2; h, w
			.byte 0xFD, 0x00, 0x00, 0x02, 0xF8, 0x07, 0x00, 0x00, 0x3F, 0x00, 0x00, 0xC0, 0x3F, 0x40, 0x80, 0x00, 
			.byte 0x00, 0x00, 0x07, 0xF8, 0xFC, 0x01, 0x00, 0x02, 0xFC, 0x03, 0x00, 0x00, 0x03, 0x04, 0xF8, 0x00, 
			.byte 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x73, 0x00, 0x08, 0x84, 0xFC, 0x02, 0x00, 0x03, 
			.byte 0xFE, 0x01, 0x00, 0x01, 0x7F, 0x80, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 
			.byte 0x7F, 0x80, 0x00, 0x80, 0xFF, 0x00, 0x00, 0x00, 

			.word 0  ; safety pair of bytes for reading by POP B
_scythe_run3_0_relative:
			.byte 0, 0; offset_y, offset_x
			.byte 12, 1; h, w
			.byte 0xF9, 0x00, 0x00, 0x06, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0xF9, 0x02, 0x04, 0x00, 
			.byte 0xF9, 0x00, 0x04, 0x02, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0xF9, 0x02, 0x04, 0x00, 
			.byte 0xF8, 0x00, 0x04, 0x03, 0xFF, 0x00, 0x00, 0x00, 0x7F, 0x00, 0x00, 0x80, 0xFC, 0x00, 0x03, 0x00, 
			.byte 0xFC, 0x00, 0x02, 0x01, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0xFC, 0x01, 0x02, 0x00, 
			.byte 0xFC, 0x00, 0x02, 0x01, 0xBF, 0x40, 0x00, 0x00, 0x3F, 0x40, 0x00, 0xC0, 0xFC, 0x01, 0x02, 0x00, 
			.byte 0xF8, 0x03, 0x00, 0x04, 0x7F, 0x80, 0x00, 0x80, 0xFF, 0x00, 0x00, 0x00, 0xF8, 0x07, 0x00, 0x07, 

			.word 0  ; safety pair of bytes for reading by POP B
_scythe_run3_1_relative:
			.byte 0, 0; offset_y, offset_x
			.byte 12, 1; h, w
			.byte 0xFE, 0x00, 0x00, 0x01, 0x7F, 0x80, 0x00, 0x00, 0x7F, 0x00, 0x00, 0x80, 0xFE, 0x00, 0x01, 0x00, 
			.byte 0xFE, 0x00, 0x01, 0x00, 0x7F, 0x80, 0x00, 0x00, 0x7F, 0x00, 0x00, 0x80, 0xFE, 0x00, 0x01, 0x00, 
			.byte 0xFE, 0x00, 0x01, 0x00, 0x3F, 0xC0, 0x00, 0x00, 0x1F, 0x00, 0xC0, 0x20, 0xFF, 0x00, 0x00, 0x00, 
			.byte 0xFF, 0x00, 0x00, 0x00, 0x3F, 0x40, 0x80, 0x00, 0x3F, 0x00, 0x80, 0x40, 0xFF, 0x00, 0x00, 0x00, 
			.byte 0xFF, 0x00, 0x00, 0x00, 0x2F, 0x50, 0x80, 0x00, 0x0F, 0x10, 0x80, 0x70, 0xFF, 0x00, 0x00, 0x00, 
			.byte 0xFE, 0x00, 0x00, 0x01, 0x1F, 0x20, 0x00, 0xE0, 0x3F, 0xC0, 0x00, 0xC0, 0xFE, 0x01, 0x00, 0x01, 

			.word 0  ; safety pair of bytes for reading by POP B
_scythe_run3_2_relative:
			.byte 0, 1; offset_y, offset_x
			.byte 12, 0; h, w
			.byte 0x9F, 0x00, 0x00, 0x60, 0x9F, 0x20, 0x40, 0x00, 0x9F, 0x00, 0x40, 0x20, 0x9F, 0x20, 0x40, 0x00, 
			.byte 0x8F, 0x00, 0x40, 0x30, 0xC7, 0x08, 0x30, 0x00, 0xCF, 0x00, 0x20, 0x10, 0xCF, 0x10, 0x20, 0x00, 
			.byte 0xCB, 0x00, 0x20, 0x14, 0xC3, 0x1C, 0x20, 0x04, 0x87, 0x38, 0x00, 0x48, 0x8F, 0x70, 0x00, 0x70, 

			.word 0  ; safety pair of bytes for reading by POP B
_scythe_run3_3_relative:
			.byte 0, 1; offset_y, offset_x
			.byte 12, 0; h, w
			.byte 0xE7, 0x00, 0x00, 0x18, 0xE7, 0x08, 0x10, 0x00, 0xE7, 0x00, 0x10, 0x08, 0xE7, 0x08, 0x10, 0x00, 
			.byte 0xE3, 0x00, 0x10, 0x0C, 0xF1, 0x02, 0x0C, 0x00, 0xF3, 0x00, 0x08, 0x04, 0xF3, 0x04, 0x08, 0x00, 
			.byte 0xF2, 0x00, 0x08, 0x05, 0xF0, 0x07, 0x08, 0x01, 0xE1, 0x0E, 0x00, 0x12, 0xE3, 0x1C, 0x00, 0x1C, 
