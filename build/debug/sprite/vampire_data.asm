_vampire_sprites:
			.word 0  ; safety pair of bytes for reading by POP B
_vampire_run_r0_0_relative:
			.byte 0, 0; offset_y, offset_x
			.byte 14, 1; h, w
			.byte 0x80, 0x18, 0x26, 0x41, 0x07, 0xC8, 0x20, 0x10, 0x07, 0x10, 0x60, 0x88, 0xC0, 0x20, 0x1B, 0x04, 
			.byte 0xE0, 0x0F, 0x00, 0x10, 0x0F, 0x90, 0x00, 0x60, 0x07, 0x00, 0x00, 0xF8, 0xC0, 0x3F, 0x00, 0x00, 
			.byte 0xC0, 0x10, 0x0E, 0x21, 0x07, 0xC8, 0xA0, 0x90, 0x07, 0x10, 0xE0, 0x08, 0xC0, 0x20, 0x17, 0x08, 
			.byte 0xE0, 0x01, 0x00, 0x1F, 0x0F, 0xF0, 0x00, 0x20, 0x0F, 0xC0, 0x20, 0x10, 0xF0, 0x0C, 0x04, 0x03, 
			.byte 0x80, 0x14, 0x1B, 0x7B, 0x0F, 0x70, 0x60, 0x80, 0x0F, 0xA0, 0x00, 0x30, 0xC0, 0x39, 0x28, 0x25, 
			.byte 0xE0, 0x00, 0x07, 0x1F, 0x07, 0x78, 0x60, 0x80, 0x0F, 0x00, 0x40, 0xF0, 0xE0, 0x1F, 0x00, 0x00, 
			.byte 0xF0, 0x00, 0x00, 0x0F, 0x0F, 0xF0, 0x00, 0x00, 0x1F, 0x00, 0x00, 0xE0, 0xF8, 0x07, 0x00, 0x00, 

			.word 0  ; safety pair of bytes for reading by POP B
_vampire_run_r0_1_relative:
			.byte 0, 0; offset_y, offset_x
			.byte 14, 1; h, w
			.byte 0xE0, 0x06, 0x09, 0x10, 0x01, 0x72, 0x88, 0x04, 0x01, 0x04, 0xD8, 0x22, 0xF0, 0x08, 0x06, 0x01, 
			.byte 0xF8, 0x03, 0x00, 0x04, 0x03, 0x24, 0x00, 0xD8, 0x01, 0x00, 0x00, 0xFE, 0xF0, 0x0F, 0x00, 0x00, 
			.byte 0xF0, 0x04, 0x03, 0x08, 0x01, 0x72, 0xA8, 0x24, 0x01, 0x04, 0xF8, 0x02, 0xF0, 0x08, 0x05, 0x02, 
			.byte 0xF8, 0x00, 0x00, 0x07, 0x03, 0xFC, 0x00, 0x48, 0x03, 0xF0, 0x08, 0x04, 0xFC, 0x03, 0x01, 0x00, 
			.byte 0xE0, 0x05, 0x06, 0x1E, 0x03, 0xDC, 0xD8, 0x20, 0x03, 0x68, 0x00, 0x4C, 0xF0, 0x0E, 0x0A, 0x09, 
			.byte 0xF8, 0x00, 0x01, 0x07, 0x01, 0xDE, 0xD8, 0x20, 0x03, 0x00, 0x10, 0xFC, 0xF8, 0x07, 0x00, 0x00, 
			.byte 0xFC, 0x00, 0x00, 0x03, 0x03, 0xFC, 0x00, 0x00, 0x07, 0x00, 0x00, 0xF8, 0xFE, 0x01, 0x00, 0x00, 

			.word 0  ; safety pair of bytes for reading by POP B
_vampire_run_r0_2_relative:
			.byte 0, 0; offset_y, offset_x
			.byte 14, 1; h, w
			.byte 0xF8, 0x01, 0x02, 0x04, 0x00, 0x1C, 0x62, 0x81, 0x00, 0x41, 0xB6, 0x08, 0xFC, 0x02, 0x01, 0x00, 
			.byte 0xFE, 0x00, 0x00, 0x01, 0x00, 0x09, 0x00, 0xF6, 0x00, 0x00, 0x00, 0xFF, 0xFC, 0x03, 0x00, 0x00, 
			.byte 0xFC, 0x01, 0x00, 0x02, 0x00, 0x1C, 0xEA, 0x09, 0x00, 0x81, 0x7E, 0x00, 0xFC, 0x02, 0x01, 0x00, 
			.byte 0xFE, 0x00, 0x00, 0x01, 0x00, 0xFF, 0x00, 0x12, 0x00, 0x3C, 0x42, 0xC1, 0xFF, 0x00, 0x00, 0x00, 
			.byte 0xF8, 0x01, 0x01, 0x07, 0x00, 0xB7, 0xB6, 0x48, 0x00, 0x5A, 0x80, 0x93, 0xFC, 0x03, 0x02, 0x02, 
			.byte 0xFE, 0x00, 0x00, 0x01, 0x00, 0xF7, 0x76, 0x08, 0x00, 0x00, 0x04, 0xFF, 0xFE, 0x01, 0x00, 0x00, 
			.byte 0xFF, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x81, 0x00, 0x00, 0x7E, 0xFF, 0x00, 0x00, 0x00, 

			.word 0  ; safety pair of bytes for reading by POP B
_vampire_run_r0_3_relative:
			.byte 0, 0; offset_y, offset_x
			.byte 14, 2; h, w
			.byte 0xFE, 0x00, 0x00, 0x01, 0x00, 0x07, 0x98, 0x60, 0x1F, 0x40, 0x80, 0x20, 0x1F, 0x20, 0x80, 0x40, 
			.byte 0x00, 0x10, 0x6D, 0x82, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x80, 0x42, 0x00, 0x3D, 
			.byte 0x3F, 0x80, 0x00, 0x40, 0x1F, 0xE0, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0x00, 
			.byte 0xFF, 0x00, 0x00, 0x00, 0x00, 0x87, 0x3A, 0x42, 0x1F, 0x40, 0x80, 0x20, 0x1F, 0x20, 0x80, 0x40, 
			.byte 0x00, 0x20, 0x5F, 0x80, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x80, 0x7F, 0x00, 0x04, 
			.byte 0x3F, 0x80, 0x00, 0xC0, 0x3F, 0x40, 0x80, 0x00, 0xC0, 0x0F, 0x10, 0x30, 0xFF, 0x00, 0x00, 0x00, 
			.byte 0xFE, 0x00, 0x00, 0x01, 0x00, 0xED, 0x6D, 0x52, 0x3F, 0x00, 0x80, 0xC0, 0x3F, 0xC0, 0x00, 0x80, 
			.byte 0x00, 0x96, 0xA0, 0xE4, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x80, 0x7D, 0x1D, 0x02, 
			.byte 0x1F, 0x00, 0x80, 0xE0, 0x3F, 0xC0, 0x00, 0x00, 0x80, 0x00, 0x01, 0x7F, 0xFF, 0x00, 0x00, 0x00, 
			.byte 0xFF, 0x00, 0x00, 0x00, 0xC0, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x00, 0xC0, 0x7F, 0x80, 0x00, 0x00, 
			.byte 0xE0, 0x00, 0x00, 0x1F, 0xFF, 0x00, 0x00, 0x00, 

			.word 0  ; safety pair of bytes for reading by POP B
_vampire_run_r1_0_relative:
			.byte 0, 0; offset_y, offset_x
			.byte 14, 1; h, w
			.byte 0xC0, 0x08, 0x16, 0x21, 0x07, 0xC8, 0x20, 0x10, 0x0F, 0x20, 0x40, 0x90, 0xC0, 0x20, 0x13, 0x0C, 
			.byte 0xE0, 0x07, 0x08, 0x10, 0x0F, 0x90, 0x00, 0x60, 0x07, 0x00, 0x00, 0xF8, 0xC0, 0x3F, 0x00, 0x00, 
			.byte 0xC0, 0x10, 0x0E, 0x21, 0x07, 0xC8, 0xA0, 0x90, 0x07, 0x10, 0xE0, 0x08, 0xC0, 0x20, 0x17, 0x08, 
			.byte 0xE0, 0x01, 0x00, 0x1F, 0x0F, 0xF0, 0x00, 0x20, 0x0F, 0xC0, 0x20, 0x10, 0x80, 0x7C, 0x14, 0x13, 
			.byte 0xC0, 0x24, 0x2B, 0x3B, 0x0F, 0x70, 0x60, 0x80, 0x0F, 0xA0, 0x00, 0x30, 0xE0, 0x19, 0x08, 0x05, 
			.byte 0xE0, 0x00, 0x07, 0x1F, 0x07, 0x78, 0x60, 0x80, 0x0F, 0x00, 0x40, 0xF0, 0xE0, 0x1F, 0x00, 0x00, 
			.byte 0xF0, 0x00, 0x00, 0x0F, 0x0F, 0xF0, 0x00, 0x00, 0x1F, 0x00, 0x00, 0xE0, 0xF8, 0x07, 0x00, 0x00, 

			.word 0  ; safety pair of bytes for reading by POP B
_vampire_run_r1_1_relative:
			.byte 0, 0; offset_y, offset_x
			.byte 14, 1; h, w
			.byte 0xF0, 0x02, 0x05, 0x08, 0x01, 0x72, 0x88, 0x04, 0x03, 0x08, 0xD0, 0x24, 0xF0, 0x08, 0x04, 0x03, 
			.byte 0xF8, 0x01, 0x02, 0x04, 0x03, 0x24, 0x00, 0xD8, 0x01, 0x00, 0x00, 0xFE, 0xF0, 0x0F, 0x00, 0x00, 
			.byte 0xF0, 0x04, 0x03, 0x08, 0x01, 0x72, 0xA8, 0x24, 0x01, 0x04, 0xF8, 0x02, 0xF0, 0x08, 0x05, 0x02, 
			.byte 0xF8, 0x00, 0x00, 0x07, 0x03, 0xFC, 0x00, 0x48, 0x03, 0xF0, 0x08, 0x04, 0xE0, 0x1F, 0x05, 0x04, 
			.byte 0xF0, 0x09, 0x0A, 0x0E, 0x03, 0xDC, 0xD8, 0x20, 0x03, 0x68, 0x00, 0x4C, 0xF8, 0x06, 0x02, 0x01, 
			.byte 0xF8, 0x00, 0x01, 0x07, 0x01, 0xDE, 0xD8, 0x20, 0x03, 0x00, 0x10, 0xFC, 0xF8, 0x07, 0x00, 0x00, 
			.byte 0xFC, 0x00, 0x00, 0x03, 0x03, 0xFC, 0x00, 0x00, 0x07, 0x00, 0x00, 0xF8, 0xFE, 0x01, 0x00, 0x00, 

			.word 0  ; safety pair of bytes for reading by POP B
_vampire_run_r1_2_relative:
			.byte 0, 0; offset_y, offset_x
			.byte 14, 1; h, w
			.byte 0xFC, 0x00, 0x01, 0x02, 0x00, 0x1C, 0x62, 0x81, 0x00, 0xC2, 0x34, 0x09, 0xFC, 0x02, 0x01, 0x00, 
			.byte 0xFE, 0x00, 0x00, 0x01, 0x00, 0x09, 0x80, 0x76, 0x00, 0x00, 0x00, 0xFF, 0xFC, 0x03, 0x00, 0x00, 
			.byte 0xFC, 0x01, 0x00, 0x02, 0x00, 0x1C, 0xEA, 0x09, 0x00, 0x81, 0x7E, 0x00, 0xFC, 0x02, 0x01, 0x00, 
			.byte 0xFE, 0x00, 0x00, 0x01, 0x00, 0xFF, 0x00, 0x12, 0x00, 0x3C, 0x42, 0xC1, 0xF8, 0x07, 0x01, 0x01, 
			.byte 0xFC, 0x02, 0x02, 0x03, 0x00, 0xB7, 0xB6, 0x48, 0x00, 0x5A, 0x80, 0x93, 0xFE, 0x01, 0x00, 0x00, 
			.byte 0xFE, 0x00, 0x00, 0x01, 0x00, 0xF7, 0x76, 0x08, 0x00, 0x00, 0x04, 0xFF, 0xFE, 0x01, 0x00, 0x00, 
			.byte 0xFF, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x81, 0x00, 0x00, 0x7E, 0xFF, 0x00, 0x00, 0x00, 

			.word 0  ; safety pair of bytes for reading by POP B
_vampire_run_r1_3_relative:
			.byte 0, 0; offset_y, offset_x
			.byte 14, 2; h, w
			.byte 0xFF, 0x00, 0x00, 0x00, 0x00, 0x87, 0x58, 0x20, 0x1F, 0x40, 0x80, 0x20, 0x3F, 0x40, 0x00, 0x80, 
			.byte 0x00, 0x30, 0x4D, 0x82, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x80, 0x42, 0x20, 0x1D, 
			.byte 0x3F, 0x80, 0x00, 0x40, 0x1F, 0xE0, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0x00, 
			.byte 0xFF, 0x00, 0x00, 0x00, 0x00, 0x87, 0x3A, 0x42, 0x1F, 0x40, 0x80, 0x20, 0x1F, 0x20, 0x80, 0x40, 
			.byte 0x00, 0x20, 0x5F, 0x80, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x80, 0x7F, 0x00, 0x04, 
			.byte 0x3F, 0x80, 0x00, 0xC0, 0x3F, 0x40, 0x80, 0x00, 0x00, 0x4F, 0x50, 0xF0, 0xFE, 0x01, 0x00, 0x00, 
			.byte 0xFF, 0x00, 0x00, 0x00, 0x00, 0xED, 0xAD, 0x92, 0x3F, 0x00, 0x80, 0xC0, 0x3F, 0xC0, 0x00, 0x80, 
			.byte 0x80, 0x16, 0x20, 0x64, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x80, 0x7D, 0x1D, 0x02, 
			.byte 0x1F, 0x00, 0x80, 0xE0, 0x3F, 0xC0, 0x00, 0x00, 0x80, 0x00, 0x01, 0x7F, 0xFF, 0x00, 0x00, 0x00, 
			.byte 0xFF, 0x00, 0x00, 0x00, 0xC0, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x00, 0xC0, 0x7F, 0x80, 0x00, 0x00, 
			.byte 0xE0, 0x00, 0x00, 0x1F, 0xFF, 0x00, 0x00, 0x00, 

			.word 0  ; safety pair of bytes for reading by POP B
_vampire_run_r2_0_relative:
			.byte 0, 0; offset_y, offset_x
			.byte 15, 1; h, w
			.byte 0xC0, 0x08, 0x16, 0x21, 0x07, 0xC8, 0x20, 0x10, 0x0F, 0x20, 0x40, 0x90, 0xC0, 0x20, 0x13, 0x0C, 
			.byte 0xE0, 0x04, 0x0B, 0x10, 0x0F, 0x90, 0x40, 0x20, 0x07, 0x60, 0x00, 0x98, 0xC0, 0x30, 0x00, 0x0F, 
			.byte 0xC0, 0x10, 0x00, 0x2F, 0x07, 0xE8, 0x00, 0x10, 0x07, 0x90, 0xA0, 0xC8, 0xC0, 0x21, 0x1E, 0x00, 
			.byte 0xE0, 0x08, 0x07, 0x10, 0x0F, 0x10, 0xE0, 0x00, 0x0F, 0x20, 0x00, 0xF0, 0xB0, 0x4F, 0x00, 0x01, 
			.byte 0xC0, 0x13, 0x14, 0x3C, 0x0F, 0x10, 0x20, 0xC0, 0x0F, 0x80, 0x60, 0x70, 0xC0, 0x3B, 0x2B, 0x24, 
			.byte 0xE0, 0x05, 0x08, 0x19, 0x07, 0x38, 0x00, 0xA0, 0x0F, 0x80, 0x60, 0x70, 0xE0, 0x1F, 0x07, 0x00, 
			.byte 0xE0, 0x00, 0x00, 0x1F, 0x0F, 0xF0, 0x40, 0x00, 0x0F, 0x00, 0x00, 0xF0, 0xF0, 0x0F, 0x00, 0x00, 
			.byte 0xF8, 0x00, 0x00, 0x07, 0x1F, 0xE0, 0x00, 0x00, 

			.word 0  ; safety pair of bytes for reading by POP B
_vampire_run_r2_1_relative:
			.byte 0, 0; offset_y, offset_x
			.byte 15, 1; h, w
			.byte 0xF0, 0x02, 0x05, 0x08, 0x01, 0x72, 0x88, 0x04, 0x03, 0x08, 0xD0, 0x24, 0xF0, 0x08, 0x04, 0x03, 
			.byte 0xF8, 0x01, 0x02, 0x04, 0x03, 0x24, 0xD0, 0x08, 0x01, 0xD8, 0x00, 0x26, 0xF0, 0x0C, 0x00, 0x03, 
			.byte 0xF0, 0x04, 0x00, 0x0B, 0x01, 0xFA, 0x00, 0x04, 0x01, 0x24, 0xA8, 0x72, 0xF0, 0x08, 0x07, 0x00, 
			.byte 0xF8, 0x02, 0x01, 0x04, 0x03, 0x04, 0xF8, 0x00, 0x03, 0x48, 0x00, 0xFC, 0xEC, 0x13, 0x00, 0x00, 
			.byte 0xF0, 0x04, 0x05, 0x0F, 0x03, 0x04, 0x08, 0xF0, 0x03, 0x20, 0xD8, 0xDC, 0xF0, 0x0E, 0x0A, 0x09, 
			.byte 0xF8, 0x01, 0x02, 0x06, 0x01, 0x4E, 0x00, 0x68, 0x03, 0x20, 0xD8, 0xDC, 0xF8, 0x07, 0x01, 0x00, 
			.byte 0xF8, 0x00, 0x00, 0x07, 0x03, 0xFC, 0x10, 0x00, 0x03, 0x00, 0x00, 0xFC, 0xFC, 0x03, 0x00, 0x00, 
			.byte 0xFE, 0x00, 0x00, 0x01, 0x07, 0xF8, 0x00, 0x00, 

			.word 0  ; safety pair of bytes for reading by POP B
_vampire_run_r2_2_relative:
			.byte 0, 0; offset_y, offset_x
			.byte 15, 1; h, w
			.byte 0xFC, 0x00, 0x01, 0x02, 0x00, 0x1C, 0x62, 0x81, 0x00, 0xC2, 0x34, 0x09, 0xFC, 0x02, 0x01, 0x00, 
			.byte 0xFE, 0x00, 0x00, 0x01, 0x00, 0x09, 0xB4, 0x42, 0x00, 0xF6, 0x00, 0x09, 0xFC, 0x03, 0x00, 0x00, 
			.byte 0xFC, 0x01, 0x00, 0x02, 0x00, 0xFE, 0x00, 0x01, 0x00, 0x09, 0xEA, 0x1C, 0xFC, 0x02, 0x01, 0x00, 
			.byte 0xFE, 0x00, 0x00, 0x01, 0x00, 0x01, 0x7E, 0x80, 0x00, 0x12, 0x00, 0xFF, 0xFB, 0x04, 0x00, 0x00, 
			.byte 0xFC, 0x01, 0x01, 0x03, 0x00, 0xC1, 0x42, 0x3C, 0x00, 0x48, 0xB6, 0xB7, 0xFC, 0x03, 0x02, 0x02, 
			.byte 0xFE, 0x00, 0x00, 0x01, 0x00, 0x93, 0x80, 0x5A, 0x00, 0x08, 0x76, 0xF7, 0xFE, 0x01, 0x00, 0x00, 
			.byte 0xFE, 0x00, 0x00, 0x01, 0x00, 0xFF, 0x04, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0x00, 
			.byte 0xFF, 0x00, 0x00, 0x00, 0x81, 0x7E, 0x00, 0x00, 

			.word 0  ; safety pair of bytes for reading by POP B
_vampire_run_r2_3_relative:
			.byte 0, 0; offset_y, offset_x
			.byte 15, 2; h, w
			.byte 0xFF, 0x00, 0x00, 0x00, 0x00, 0x87, 0x58, 0x20, 0x1F, 0x40, 0x80, 0x20, 0x3F, 0x40, 0x00, 0x80, 
			.byte 0x00, 0x30, 0x4D, 0x82, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x80, 0x42, 0x2D, 0x10, 
			.byte 0x3F, 0x80, 0x00, 0x40, 0x1F, 0x60, 0x00, 0x80, 0x00, 0x3D, 0x00, 0xC2, 0xFF, 0x00, 0x00, 0x00, 
			.byte 0xFF, 0x00, 0x00, 0x00, 0x00, 0xBF, 0x00, 0x40, 0x1F, 0x40, 0x00, 0xA0, 0x1F, 0x20, 0x80, 0x40, 
			.byte 0x00, 0x02, 0x7A, 0x87, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x80, 0x40, 0x1F, 0x20, 
			.byte 0x3F, 0x00, 0x80, 0x40, 0x3F, 0xC0, 0x00, 0x80, 0xC0, 0x04, 0x00, 0x3F, 0xFE, 0x01, 0x00, 0x00, 
			.byte 0xFF, 0x00, 0x00, 0x00, 0x00, 0xF0, 0x50, 0x4F, 0x3F, 0x00, 0x80, 0x40, 0x3F, 0xC0, 0x80, 0x00, 
			.byte 0x00, 0x92, 0xAD, 0xED, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x80, 0x64, 0x20, 0x16, 
			.byte 0x1F, 0x80, 0x00, 0xE0, 0x3F, 0xC0, 0x80, 0x00, 0x80, 0x02, 0x1D, 0x7D, 0xFF, 0x00, 0x00, 0x00, 
			.byte 0xFF, 0x00, 0x00, 0x00, 0x80, 0x7F, 0x01, 0x00, 0x3F, 0x00, 0x00, 0xC0, 0x3F, 0xC0, 0x00, 0x00, 
			.byte 0xC0, 0x00, 0x00, 0x3F, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0xE0, 0x1F, 0x00, 0x00, 
			.byte 0x7F, 0x00, 0x00, 0x80, 

			.word 0  ; safety pair of bytes for reading by POP B
_vampire_run_r3_0_relative:
			.byte 0, 0; offset_y, offset_x
			.byte 15, 1; h, w
			.byte 0x80, 0x18, 0x26, 0x41, 0x07, 0xC8, 0x20, 0x10, 0x07, 0x10, 0x60, 0x88, 0xC0, 0x20, 0x13, 0x0C, 
			.byte 0xE0, 0x04, 0x0B, 0x10, 0x0F, 0x90, 0x40, 0x20, 0x0F, 0x60, 0x00, 0x90, 0xE0, 0x10, 0x00, 0x0F, 
			.byte 0xC0, 0x00, 0x00, 0x3F, 0x07, 0xF8, 0x00, 0x00, 0x07, 0x90, 0xA0, 0xC8, 0xC0, 0x21, 0x0E, 0x10, 
			.byte 0xC0, 0x08, 0x17, 0x20, 0x07, 0x08, 0xE0, 0x10, 0x0F, 0x20, 0x00, 0xF0, 0xE0, 0x1F, 0x00, 0x01, 
			.byte 0x80, 0x13, 0x14, 0x7C, 0x0F, 0x10, 0x20, 0xC0, 0x0F, 0x80, 0x60, 0x70, 0xC0, 0x3B, 0x2B, 0x24, 
			.byte 0xE0, 0x05, 0x08, 0x19, 0x0F, 0x30, 0x00, 0xA0, 0x07, 0x80, 0x60, 0x78, 0xE0, 0x1F, 0x07, 0x00, 
			.byte 0xE0, 0x00, 0x00, 0x1F, 0x0F, 0xF0, 0x40, 0x00, 0x0F, 0x00, 0x00, 0xF0, 0xF0, 0x0F, 0x00, 0x00, 
			.byte 0xF8, 0x00, 0x00, 0x07, 0x1F, 0xE0, 0x00, 0x00, 

			.word 0  ; safety pair of bytes for reading by POP B
_vampire_run_r3_1_relative:
			.byte 0, 0; offset_y, offset_x
			.byte 15, 1; h, w
			.byte 0xE0, 0x06, 0x09, 0x10, 0x01, 0x72, 0x88, 0x04, 0x01, 0x04, 0xD8, 0x22, 0xF0, 0x08, 0x04, 0x03, 
			.byte 0xF8, 0x01, 0x02, 0x04, 0x03, 0x24, 0xD0, 0x08, 0x03, 0xD8, 0x00, 0x24, 0xF8, 0x04, 0x00, 0x03, 
			.byte 0xF0, 0x00, 0x00, 0x0F, 0x01, 0xFE, 0x00, 0x00, 0x01, 0x24, 0xA8, 0x72, 0xF0, 0x08, 0x03, 0x04, 
			.byte 0xF0, 0x02, 0x05, 0x08, 0x01, 0x02, 0xF8, 0x04, 0x03, 0x48, 0x00, 0xFC, 0xF8, 0x07, 0x00, 0x00, 
			.byte 0xE0, 0x04, 0x05, 0x1F, 0x03, 0x04, 0x08, 0xF0, 0x03, 0x20, 0xD8, 0xDC, 0xF0, 0x0E, 0x0A, 0x09, 
			.byte 0xF8, 0x01, 0x02, 0x06, 0x03, 0x4C, 0x00, 0x68, 0x01, 0x20, 0xD8, 0xDE, 0xF8, 0x07, 0x01, 0x00, 
			.byte 0xF8, 0x00, 0x00, 0x07, 0x03, 0xFC, 0x10, 0x00, 0x03, 0x00, 0x00, 0xFC, 0xFC, 0x03, 0x00, 0x00, 
			.byte 0xFE, 0x00, 0x00, 0x01, 0x07, 0xF8, 0x00, 0x00, 

			.word 0  ; safety pair of bytes for reading by POP B
_vampire_run_r3_2_relative:
			.byte 0, 0; offset_y, offset_x
			.byte 15, 1; h, w
			.byte 0xF8, 0x01, 0x02, 0x04, 0x00, 0x1C, 0x62, 0x81, 0x00, 0xC1, 0x36, 0x08, 0xFC, 0x02, 0x01, 0x00, 
			.byte 0xFE, 0x00, 0x00, 0x01, 0x00, 0x09, 0xB4, 0x42, 0x00, 0xF6, 0x00, 0x09, 0xFE, 0x01, 0x00, 0x00, 
			.byte 0xFC, 0x00, 0x00, 0x03, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x09, 0xEA, 0x1C, 0xFC, 0x02, 0x00, 0x01, 
			.byte 0xFC, 0x00, 0x01, 0x02, 0x00, 0x00, 0x7E, 0x81, 0x00, 0x12, 0x00, 0xFF, 0xFE, 0x01, 0x00, 0x00, 
			.byte 0xF8, 0x01, 0x01, 0x07, 0x00, 0xC1, 0x42, 0x3C, 0x00, 0x48, 0xB6, 0xB7, 0xFC, 0x03, 0x02, 0x02, 
			.byte 0xFE, 0x00, 0x00, 0x01, 0x00, 0x93, 0x80, 0x5A, 0x00, 0x08, 0x76, 0xF7, 0xFE, 0x01, 0x00, 0x00, 
			.byte 0xFE, 0x00, 0x00, 0x01, 0x00, 0xFF, 0x04, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0x00, 
			.byte 0xFF, 0x00, 0x00, 0x00, 0x81, 0x7E, 0x00, 0x00, 

			.word 0  ; safety pair of bytes for reading by POP B
_vampire_run_r3_3_relative:
			.byte 0, 0; offset_y, offset_x
			.byte 15, 2; h, w
			.byte 0xFE, 0x00, 0x00, 0x01, 0x00, 0x07, 0x98, 0x60, 0x1F, 0x40, 0x80, 0x20, 0x1F, 0x20, 0x80, 0x40, 
			.byte 0x00, 0x30, 0x4D, 0x82, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x80, 0x42, 0x2D, 0x10, 
			.byte 0x3F, 0x80, 0x00, 0x40, 0x3F, 0x40, 0x00, 0x80, 0x80, 0x3D, 0x00, 0x42, 0xFF, 0x00, 0x00, 0x00, 
			.byte 0xFF, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x1F, 0x00, 0x00, 0xE0, 0x1F, 0x20, 0x80, 0x40, 
			.byte 0x00, 0x42, 0x3A, 0x87, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x80, 0x5F, 0x20, 
			.byte 0x1F, 0x40, 0x80, 0x20, 0x3F, 0xC0, 0x00, 0x80, 0x80, 0x04, 0x00, 0x7F, 0xFF, 0x00, 0x00, 0x00, 
			.byte 0xFE, 0x00, 0x00, 0x01, 0x00, 0xF0, 0x50, 0x4F, 0x3F, 0x00, 0x80, 0x40, 0x3F, 0xC0, 0x80, 0x00, 
			.byte 0x00, 0x92, 0xAD, 0xED, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x80, 0x64, 0x20, 0x16, 
			.byte 0x3F, 0x80, 0x00, 0xC0, 0x1F, 0xE0, 0x80, 0x00, 0x80, 0x02, 0x1D, 0x7D, 0xFF, 0x00, 0x00, 0x00, 
			.byte 0xFF, 0x00, 0x00, 0x00, 0x80, 0x7F, 0x01, 0x00, 0x3F, 0x00, 0x00, 0xC0, 0x3F, 0xC0, 0x00, 0x00, 
			.byte 0xC0, 0x00, 0x00, 0x3F, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0xE0, 0x1F, 0x00, 0x00, 
			.byte 0x7F, 0x00, 0x00, 0x80, 

			.word 0  ; safety pair of bytes for reading by POP B
_vampire_run_l0_0_relative:
			.byte 0, 0; offset_y, offset_x
			.byte 14, 1; h, w
			.byte 0xC0, 0x10, 0x08, 0x27, 0x03, 0x04, 0xC8, 0x30, 0x07, 0x40, 0xB0, 0x08, 0xC0, 0x22, 0x0D, 0x10, 
			.byte 0xE0, 0x0D, 0x00, 0x12, 0x0F, 0x10, 0x00, 0xE0, 0x07, 0x00, 0x00, 0xF8, 0xC0, 0x3F, 0x00, 0x00, 
			.byte 0xC0, 0x12, 0x0A, 0x27, 0x07, 0x08, 0xE0, 0x10, 0x07, 0x20, 0xD0, 0x08, 0xC0, 0x20, 0x0F, 0x10, 
			.byte 0xE0, 0x09, 0x00, 0x1F, 0x0F, 0xF0, 0x00, 0x00, 0x1F, 0x80, 0x40, 0x60, 0xE0, 0x10, 0x08, 0x07, 
			.byte 0xE0, 0x02, 0x0D, 0x1D, 0x03, 0xBC, 0xB0, 0x50, 0x07, 0x48, 0x28, 0x38, 0xE0, 0x19, 0x00, 0x0B, 
			.byte 0xC0, 0x02, 0x0D, 0x3D, 0x0F, 0xF0, 0xC0, 0x00, 0x0F, 0x00, 0x00, 0xF0, 0xE0, 0x1F, 0x04, 0x00, 
			.byte 0xE0, 0x00, 0x00, 0x1F, 0x1F, 0xE0, 0x00, 0x00, 0x3F, 0x00, 0x00, 0xC0, 0xF0, 0x0F, 0x00, 0x00, 

			.word 0  ; safety pair of bytes for reading by POP B
_vampire_run_l0_1_relative:
			.byte 0, 0; offset_y, offset_x
			.byte 14, 1; h, w
			.byte 0xF0, 0x04, 0x02, 0x09, 0x00, 0xC1, 0x32, 0x0C, 0x01, 0x10, 0x6C, 0x82, 0xF0, 0x08, 0x03, 0x04, 
			.byte 0xF8, 0x03, 0x00, 0x04, 0x03, 0x84, 0x00, 0x78, 0x01, 0x00, 0x00, 0xFE, 0xF0, 0x0F, 0x00, 0x00, 
			.byte 0xF0, 0x04, 0x02, 0x09, 0x01, 0xC2, 0xB8, 0x84, 0x01, 0x08, 0xF4, 0x02, 0xF0, 0x08, 0x03, 0x04, 
			.byte 0xF8, 0x02, 0x00, 0x07, 0x03, 0xFC, 0x00, 0x40, 0x07, 0xE0, 0x10, 0x18, 0xF8, 0x04, 0x02, 0x01, 
			.byte 0xF8, 0x00, 0x03, 0x07, 0x00, 0x6F, 0x6C, 0x94, 0x01, 0xD2, 0x0A, 0x4E, 0xF8, 0x06, 0x00, 0x02, 
			.byte 0xF0, 0x00, 0x03, 0x0F, 0x03, 0x7C, 0x70, 0x80, 0x03, 0x00, 0x00, 0xFC, 0xF8, 0x07, 0x01, 0x00, 
			.byte 0xF8, 0x00, 0x00, 0x07, 0x07, 0xF8, 0x00, 0x00, 0x0F, 0x00, 0x00, 0xF0, 0xFC, 0x03, 0x00, 0x00, 

			.word 0  ; safety pair of bytes for reading by POP B
_vampire_run_l0_2_relative:
			.byte 0, 0; offset_y, offset_x
			.byte 14, 2; h, w
			.byte 0xFC, 0x01, 0x00, 0x02, 0x00, 0x70, 0x8C, 0x03, 0x3F, 0x00, 0x80, 0x40, 0x7F, 0x80, 0x00, 0x00, 
			.byte 0x00, 0x04, 0xDB, 0x20, 0xFC, 0x02, 0x00, 0x01, 0xFE, 0x00, 0x00, 0x01, 0x00, 0x21, 0x00, 0xDE, 
			.byte 0xFF, 0x00, 0x00, 0x00, 0x7F, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFC, 0x03, 0x00, 0x00, 
			.byte 0xFC, 0x01, 0x00, 0x02, 0x00, 0x70, 0xAE, 0x21, 0x7F, 0x00, 0x00, 0x80, 0x7F, 0x80, 0x00, 0x00, 
			.byte 0x00, 0x02, 0xFD, 0x00, 0xFC, 0x02, 0x00, 0x01, 0xFE, 0x00, 0x00, 0x01, 0x00, 0xFF, 0x00, 0x90, 
			.byte 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x01, 0x78, 0x84, 0x06, 0xFE, 0x01, 0x00, 0x00, 
			.byte 0xFE, 0x00, 0x00, 0x01, 0x00, 0xDB, 0xDB, 0x25, 0x3F, 0x00, 0x00, 0xC0, 0x7F, 0x80, 0x80, 0x80, 
			.byte 0x00, 0xB4, 0x02, 0x93, 0xFE, 0x01, 0x00, 0x00, 0xFC, 0x00, 0x00, 0x03, 0x00, 0xDF, 0xDC, 0x20, 
			.byte 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0xFF, 0xFE, 0x01, 0x00, 0x00, 
			.byte 0xFE, 0x00, 0x00, 0x01, 0x01, 0xFE, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 
			.byte 0x03, 0x00, 0x00, 0xFC, 0xFF, 0x00, 0x00, 0x00, 

			.word 0  ; safety pair of bytes for reading by POP B
_vampire_run_l0_3_relative:
			.byte 0, 1; offset_y, offset_x
			.byte 14, 1; h, w
			.byte 0x00, 0x40, 0x23, 0x9C, 0x0F, 0x10, 0x20, 0xC0, 0x1F, 0x00, 0xC0, 0x20, 0x00, 0x88, 0x36, 0x41, 
			.byte 0x80, 0x37, 0x00, 0x48, 0x3F, 0x40, 0x00, 0x80, 0x1F, 0x00, 0x00, 0xE0, 0x00, 0xFF, 0x00, 0x00, 
			.byte 0x00, 0x48, 0x2B, 0x9C, 0x1F, 0x20, 0x80, 0x40, 0x1F, 0x80, 0x40, 0x20, 0x00, 0x80, 0x3F, 0x40, 
			.byte 0x80, 0x24, 0x00, 0x7F, 0x3F, 0xC0, 0x00, 0x00, 0x7F, 0x00, 0x00, 0x80, 0x80, 0x41, 0x21, 0x1E, 
			.byte 0x80, 0x09, 0x36, 0x76, 0x0F, 0xF0, 0xC0, 0x40, 0x1F, 0x20, 0xA0, 0xE0, 0x80, 0x64, 0x00, 0x2D, 
			.byte 0x00, 0x08, 0x37, 0xF7, 0x3F, 0xC0, 0x00, 0x00, 0x3F, 0x00, 0x00, 0xC0, 0x80, 0x7F, 0x10, 0x00, 
			.byte 0x80, 0x00, 0x00, 0x7F, 0x7F, 0x80, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0xC0, 0x3F, 0x00, 0x00, 

			.word 0  ; safety pair of bytes for reading by POP B
_vampire_run_l1_0_relative:
			.byte 0, 0; offset_y, offset_x
			.byte 14, 1; h, w
			.byte 0xC0, 0x10, 0x08, 0x27, 0x07, 0x08, 0xD0, 0x20, 0x07, 0x60, 0x90, 0x08, 0xE0, 0x12, 0x05, 0x08, 
			.byte 0xE0, 0x0D, 0x00, 0x12, 0x0F, 0x10, 0x20, 0xC0, 0x07, 0x00, 0x00, 0xF8, 0xC0, 0x3F, 0x00, 0x00, 
			.byte 0xC0, 0x12, 0x0A, 0x27, 0x07, 0x08, 0xE0, 0x10, 0x07, 0x20, 0xD0, 0x08, 0xC0, 0x20, 0x0F, 0x10, 
			.byte 0xE0, 0x09, 0x00, 0x1F, 0x0F, 0xF0, 0x00, 0x00, 0x03, 0x90, 0x50, 0x7C, 0xE0, 0x10, 0x08, 0x07, 
			.byte 0xE0, 0x02, 0x0D, 0x1D, 0x07, 0xB8, 0xA8, 0x48, 0x0F, 0x40, 0x20, 0x30, 0xE0, 0x19, 0x00, 0x0B, 
			.byte 0xC0, 0x02, 0x0D, 0x3D, 0x0F, 0xF0, 0xC0, 0x00, 0x0F, 0x00, 0x00, 0xF0, 0xE0, 0x1F, 0x04, 0x00, 
			.byte 0xE0, 0x00, 0x00, 0x1F, 0x1F, 0xE0, 0x00, 0x00, 0x3F, 0x00, 0x00, 0xC0, 0xF0, 0x0F, 0x00, 0x00, 

			.word 0  ; safety pair of bytes for reading by POP B
_vampire_run_l1_1_relative:
			.byte 0, 0; offset_y, offset_x
			.byte 14, 1; h, w
			.byte 0xF0, 0x04, 0x02, 0x09, 0x01, 0xC2, 0x34, 0x08, 0x01, 0x18, 0x64, 0x82, 0xF8, 0x04, 0x01, 0x02, 
			.byte 0xF8, 0x03, 0x00, 0x04, 0x03, 0x84, 0x08, 0x70, 0x01, 0x00, 0x00, 0xFE, 0xF0, 0x0F, 0x00, 0x00, 
			.byte 0xF0, 0x04, 0x02, 0x09, 0x01, 0xC2, 0xB8, 0x84, 0x01, 0x08, 0xF4, 0x02, 0xF0, 0x08, 0x03, 0x04, 
			.byte 0xF8, 0x02, 0x00, 0x07, 0x03, 0xFC, 0x00, 0x40, 0x00, 0xE4, 0x14, 0x1F, 0xF8, 0x04, 0x02, 0x01, 
			.byte 0xF8, 0x00, 0x03, 0x07, 0x01, 0x6E, 0x6A, 0x92, 0x03, 0xD0, 0x08, 0x4C, 0xF8, 0x06, 0x00, 0x02, 
			.byte 0xF0, 0x00, 0x03, 0x0F, 0x03, 0x7C, 0x70, 0x80, 0x03, 0x00, 0x00, 0xFC, 0xF8, 0x07, 0x01, 0x00, 
			.byte 0xF8, 0x00, 0x00, 0x07, 0x07, 0xF8, 0x00, 0x00, 0x0F, 0x00, 0x00, 0xF0, 0xFC, 0x03, 0x00, 0x00, 

			.word 0  ; safety pair of bytes for reading by POP B
_vampire_run_l1_2_relative:
			.byte 0, 0; offset_y, offset_x
			.byte 14, 2; h, w
			.byte 0xFC, 0x01, 0x00, 0x02, 0x00, 0x70, 0x8D, 0x02, 0x7F, 0x00, 0x00, 0x80, 0x7F, 0x80, 0x00, 0x00, 
			.byte 0x00, 0x86, 0x59, 0x20, 0xFE, 0x01, 0x00, 0x00, 0xFE, 0x00, 0x00, 0x01, 0x00, 0x21, 0x02, 0xDC, 
			.byte 0xFF, 0x00, 0x00, 0x00, 0x7F, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFC, 0x03, 0x00, 0x00, 
			.byte 0xFC, 0x01, 0x00, 0x02, 0x00, 0x70, 0xAE, 0x21, 0x7F, 0x00, 0x00, 0x80, 0x7F, 0x80, 0x00, 0x00, 
			.byte 0x00, 0x02, 0xFD, 0x00, 0xFC, 0x02, 0x00, 0x01, 0xFE, 0x00, 0x00, 0x01, 0x00, 0xFF, 0x00, 0x90, 
			.byte 0xFF, 0x00, 0x00, 0x00, 0x3F, 0xC0, 0x00, 0x00, 0x00, 0x79, 0x85, 0x07, 0xFE, 0x01, 0x00, 0x00, 
			.byte 0xFE, 0x00, 0x00, 0x01, 0x00, 0xDB, 0xDA, 0x24, 0x7F, 0x80, 0x80, 0x80, 0xFF, 0x00, 0x00, 0x00, 
			.byte 0x00, 0xB4, 0x02, 0x93, 0xFE, 0x01, 0x00, 0x00, 0xFC, 0x00, 0x00, 0x03, 0x00, 0xDF, 0xDC, 0x20, 
			.byte 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0xFF, 0xFE, 0x01, 0x00, 0x00, 
			.byte 0xFE, 0x00, 0x00, 0x01, 0x01, 0xFE, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 
			.byte 0x03, 0x00, 0x00, 0xFC, 0xFF, 0x00, 0x00, 0x00, 

			.word 0  ; safety pair of bytes for reading by POP B
_vampire_run_l1_3_relative:
			.byte 0, 1; offset_y, offset_x
			.byte 14, 1; h, w
			.byte 0x00, 0x40, 0x23, 0x9C, 0x1F, 0x20, 0x40, 0x80, 0x1F, 0x80, 0x40, 0x20, 0x80, 0x48, 0x16, 0x21, 
			.byte 0x80, 0x37, 0x00, 0x48, 0x3F, 0x40, 0x80, 0x00, 0x1F, 0x00, 0x00, 0xE0, 0x00, 0xFF, 0x00, 0x00, 
			.byte 0x00, 0x48, 0x2B, 0x9C, 0x1F, 0x20, 0x80, 0x40, 0x1F, 0x80, 0x40, 0x20, 0x00, 0x80, 0x3F, 0x40, 
			.byte 0x80, 0x24, 0x00, 0x7F, 0x3F, 0xC0, 0x00, 0x00, 0x0F, 0x40, 0x40, 0xF0, 0x80, 0x41, 0x21, 0x1E, 
			.byte 0x80, 0x09, 0x36, 0x76, 0x1F, 0xE0, 0xA0, 0x20, 0x3F, 0x00, 0x80, 0xC0, 0x80, 0x64, 0x00, 0x2D, 
			.byte 0x00, 0x08, 0x37, 0xF7, 0x3F, 0xC0, 0x00, 0x00, 0x3F, 0x00, 0x00, 0xC0, 0x80, 0x7F, 0x10, 0x00, 
			.byte 0x80, 0x00, 0x00, 0x7F, 0x7F, 0x80, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0xC0, 0x3F, 0x00, 0x00, 

			.word 0  ; safety pair of bytes for reading by POP B
_vampire_run_l2_0_relative:
			.byte 0, 0; offset_y, offset_x
			.byte 15, 1; h, w
			.byte 0xC0, 0x10, 0x08, 0x27, 0x07, 0x08, 0xD0, 0x20, 0x07, 0x60, 0x90, 0x08, 0xE0, 0x12, 0x05, 0x08, 
			.byte 0xE0, 0x08, 0x05, 0x12, 0x0F, 0x10, 0xA0, 0x40, 0x07, 0xE0, 0x00, 0x18, 0xC0, 0x32, 0x00, 0x0D, 
			.byte 0xC0, 0x10, 0x00, 0x2F, 0x07, 0xE8, 0x00, 0x10, 0x07, 0x00, 0xF0, 0x08, 0xC0, 0x27, 0x0A, 0x12, 
			.byte 0xE0, 0x00, 0x0F, 0x10, 0x0F, 0x10, 0xC0, 0x20, 0x1B, 0x00, 0x00, 0xE4, 0xE0, 0x1F, 0x00, 0x09, 
			.byte 0xE0, 0x07, 0x08, 0x10, 0x07, 0x78, 0x50, 0x90, 0x07, 0x48, 0xA8, 0xB8, 0xE0, 0x1D, 0x0D, 0x02, 
			.byte 0xC0, 0x0B, 0x00, 0x39, 0x0F, 0x30, 0x20, 0x40, 0x0F, 0x00, 0xC0, 0xF0, 0xE0, 0x1D, 0x0D, 0x02, 
			.byte 0xE0, 0x00, 0x04, 0x1F, 0x0F, 0xF0, 0x00, 0x00, 0x1F, 0x00, 0x00, 0xE0, 0xE0, 0x1F, 0x00, 0x00, 
			.byte 0xF0, 0x00, 0x00, 0x0F, 0x3F, 0xC0, 0x00, 0x00, 

			.word 0  ; safety pair of bytes for reading by POP B
_vampire_run_l2_1_relative:
			.byte 0, 0; offset_y, offset_x
			.byte 15, 1; h, w
			.byte 0xF0, 0x04, 0x02, 0x09, 0x01, 0xC2, 0x34, 0x08, 0x01, 0x18, 0x64, 0x82, 0xF8, 0x04, 0x01, 0x02, 
			.byte 0xF8, 0x02, 0x01, 0x04, 0x03, 0x84, 0x68, 0x10, 0x01, 0x78, 0x00, 0x86, 0xF0, 0x0C, 0x00, 0x03, 
			.byte 0xF0, 0x04, 0x00, 0x0B, 0x01, 0xFA, 0x00, 0x04, 0x01, 0x80, 0xBC, 0xC2, 0xF0, 0x09, 0x02, 0x04, 
			.byte 0xF8, 0x00, 0x03, 0x04, 0x03, 0x04, 0xF0, 0x08, 0x06, 0x40, 0x00, 0xF9, 0xF8, 0x07, 0x00, 0x02, 
			.byte 0xF8, 0x01, 0x02, 0x04, 0x01, 0x1E, 0x14, 0xE4, 0x01, 0x92, 0x6A, 0x6E, 0xF8, 0x07, 0x03, 0x00, 
			.byte 0xF0, 0x02, 0x00, 0x0E, 0x03, 0x4C, 0x08, 0xD0, 0x03, 0x80, 0x70, 0x7C, 0xF8, 0x07, 0x03, 0x00, 
			.byte 0xF8, 0x00, 0x01, 0x07, 0x03, 0xFC, 0x00, 0x00, 0x07, 0x00, 0x00, 0xF8, 0xF8, 0x07, 0x00, 0x00, 
			.byte 0xFC, 0x00, 0x00, 0x03, 0x0F, 0xF0, 0x00, 0x00, 

			.word 0  ; safety pair of bytes for reading by POP B
_vampire_run_l2_2_relative:
			.byte 0, 0; offset_y, offset_x
			.byte 15, 2; h, w
			.byte 0xFC, 0x01, 0x00, 0x02, 0x00, 0x70, 0x8D, 0x02, 0x7F, 0x00, 0x00, 0x80, 0x7F, 0x80, 0x00, 0x00, 
			.byte 0x00, 0x86, 0x59, 0x20, 0xFE, 0x01, 0x00, 0x00, 0xFE, 0x00, 0x00, 0x01, 0x00, 0x21, 0x5A, 0x84, 
			.byte 0xFF, 0x00, 0x00, 0x00, 0x7F, 0x80, 0x00, 0x00, 0x00, 0xDE, 0x00, 0x21, 0xFC, 0x03, 0x00, 0x00, 
			.byte 0xFC, 0x01, 0x00, 0x02, 0x00, 0xFE, 0x00, 0x01, 0x7F, 0x00, 0x00, 0x80, 0x7F, 0x80, 0x00, 0x00, 
			.byte 0x00, 0x20, 0xAF, 0x70, 0xFC, 0x02, 0x00, 0x01, 0xFE, 0x00, 0x00, 0x01, 0x00, 0x01, 0xFC, 0x02, 
			.byte 0xFF, 0x00, 0x00, 0x00, 0xBF, 0x40, 0x00, 0x00, 0x01, 0x90, 0x00, 0xFE, 0xFE, 0x01, 0x00, 0x00, 
			.byte 0xFE, 0x00, 0x00, 0x01, 0x00, 0x07, 0x85, 0x79, 0x7F, 0x00, 0x00, 0x80, 0x7F, 0x80, 0x80, 0x80, 
			.byte 0x00, 0x24, 0xDA, 0xDB, 0xFE, 0x01, 0x00, 0x00, 0xFC, 0x00, 0x00, 0x03, 0x00, 0x93, 0x02, 0xB4, 
			.byte 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x20, 0xDC, 0xDF, 0xFE, 0x01, 0x00, 0x00, 
			.byte 0xFE, 0x00, 0x00, 0x01, 0x00, 0xFF, 0x40, 0x00, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 
			.byte 0x01, 0x00, 0x00, 0xFE, 0xFE, 0x01, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x03, 0xFC, 0x00, 0x00, 
			.byte 0xFF, 0x00, 0x00, 0x00, 

			.word 0  ; safety pair of bytes for reading by POP B
_vampire_run_l2_3_relative:
			.byte 0, 1; offset_y, offset_x
			.byte 15, 1; h, w
			.byte 0x00, 0x40, 0x23, 0x9C, 0x1F, 0x20, 0x40, 0x80, 0x1F, 0x80, 0x40, 0x20, 0x80, 0x48, 0x16, 0x21, 
			.byte 0x80, 0x21, 0x16, 0x48, 0x3F, 0x40, 0x80, 0x00, 0x1F, 0x80, 0x00, 0x60, 0x00, 0xC8, 0x00, 0x37, 
			.byte 0x00, 0x40, 0x00, 0xBF, 0x1F, 0xA0, 0x00, 0x40, 0x1F, 0x00, 0xC0, 0x20, 0x00, 0x9C, 0x2B, 0x48, 
			.byte 0x80, 0x00, 0x3F, 0x40, 0x3F, 0x40, 0x00, 0x80, 0x6F, 0x00, 0x00, 0x90, 0x80, 0x7F, 0x00, 0x24, 
			.byte 0x80, 0x1E, 0x21, 0x41, 0x1F, 0xE0, 0x40, 0x40, 0x1F, 0x20, 0xA0, 0xE0, 0x80, 0x76, 0x36, 0x09, 
			.byte 0x00, 0x2D, 0x00, 0xE4, 0x3F, 0xC0, 0x80, 0x00, 0x3F, 0x00, 0x00, 0xC0, 0x80, 0x77, 0x37, 0x08, 
			.byte 0x80, 0x00, 0x10, 0x7F, 0x3F, 0xC0, 0x00, 0x00, 0x7F, 0x00, 0x00, 0x80, 0x80, 0x7F, 0x00, 0x00, 
			.byte 0xC0, 0x00, 0x00, 0x3F, 0xFF, 0x00, 0x00, 0x00, 

			.word 0  ; safety pair of bytes for reading by POP B
_vampire_run_l3_0_relative:
			.byte 0, 0; offset_y, offset_x
			.byte 15, 1; h, w
			.byte 0xC0, 0x10, 0x08, 0x27, 0x03, 0x04, 0xC8, 0x30, 0x07, 0x60, 0x90, 0x08, 0xC0, 0x22, 0x0D, 0x10, 
			.byte 0xE0, 0x08, 0x05, 0x12, 0x0F, 0x10, 0xA0, 0x40, 0x0F, 0xE0, 0x00, 0x10, 0xE0, 0x12, 0x00, 0x0D, 
			.byte 0xC0, 0x00, 0x00, 0x3F, 0x07, 0xF8, 0x00, 0x00, 0x07, 0x10, 0xE0, 0x08, 0xC0, 0x27, 0x0A, 0x12, 
			.byte 0xC0, 0x10, 0x0F, 0x20, 0x07, 0x08, 0xD0, 0x20, 0x0F, 0x00, 0x00, 0xF0, 0xE0, 0x1F, 0x00, 0x09, 
			.byte 0xE0, 0x07, 0x08, 0x10, 0x03, 0x7C, 0x50, 0x90, 0x07, 0x48, 0xA8, 0xB8, 0xE0, 0x1D, 0x0D, 0x02, 
			.byte 0xE0, 0x0B, 0x00, 0x19, 0x0F, 0x30, 0x20, 0x40, 0x0F, 0x00, 0xC0, 0xF0, 0xC0, 0x3D, 0x0D, 0x02, 
			.byte 0xE0, 0x00, 0x04, 0x1F, 0x0F, 0xF0, 0x00, 0x00, 0x1F, 0x00, 0x00, 0xE0, 0xE0, 0x1F, 0x00, 0x00, 
			.byte 0xF0, 0x00, 0x00, 0x0F, 0x3F, 0xC0, 0x00, 0x00, 

			.word 0  ; safety pair of bytes for reading by POP B
_vampire_run_l3_1_relative:
			.byte 0, 0; offset_y, offset_x
			.byte 15, 1; h, w
			.byte 0xF0, 0x04, 0x02, 0x09, 0x00, 0xC1, 0x32, 0x0C, 0x01, 0x18, 0x64, 0x82, 0xF0, 0x08, 0x03, 0x04, 
			.byte 0xF8, 0x02, 0x01, 0x04, 0x03, 0x84, 0x68, 0x10, 0x03, 0x78, 0x00, 0x84, 0xF8, 0x04, 0x00, 0x03, 
			.byte 0xF0, 0x00, 0x00, 0x0F, 0x01, 0xFE, 0x00, 0x00, 0x01, 0x84, 0xB8, 0xC2, 0xF0, 0x09, 0x02, 0x04, 
			.byte 0xF0, 0x04, 0x03, 0x08, 0x01, 0x02, 0xF4, 0x08, 0x03, 0x40, 0x00, 0xFC, 0xF8, 0x07, 0x00, 0x02, 
			.byte 0xF8, 0x01, 0x02, 0x04, 0x00, 0x1F, 0x14, 0xE4, 0x01, 0x92, 0x6A, 0x6E, 0xF8, 0x07, 0x03, 0x00, 
			.byte 0xF8, 0x02, 0x00, 0x06, 0x03, 0x4C, 0x08, 0xD0, 0x03, 0x80, 0x70, 0x7C, 0xF0, 0x0F, 0x03, 0x00, 
			.byte 0xF8, 0x00, 0x01, 0x07, 0x03, 0xFC, 0x00, 0x00, 0x07, 0x00, 0x00, 0xF8, 0xF8, 0x07, 0x00, 0x00, 
			.byte 0xFC, 0x00, 0x00, 0x03, 0x0F, 0xF0, 0x00, 0x00, 

			.word 0  ; safety pair of bytes for reading by POP B
_vampire_run_l3_2_relative:
			.byte 0, 0; offset_y, offset_x
			.byte 15, 2; h, w
			.byte 0xFC, 0x01, 0x00, 0x02, 0x00, 0x70, 0x8C, 0x03, 0x3F, 0x00, 0x80, 0x40, 0x7F, 0x80, 0x00, 0x00, 
			.byte 0x00, 0x06, 0xD9, 0x20, 0xFC, 0x02, 0x00, 0x01, 0xFE, 0x00, 0x00, 0x01, 0x00, 0x21, 0x5A, 0x84, 
			.byte 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x00, 0xDE, 0x00, 0x21, 0xFE, 0x01, 0x00, 0x00, 
			.byte 0xFC, 0x00, 0x00, 0x03, 0x00, 0xFF, 0x00, 0x00, 0x7F, 0x00, 0x00, 0x80, 0x7F, 0x80, 0x00, 0x00, 
			.byte 0x00, 0x21, 0xAE, 0x70, 0xFC, 0x02, 0x00, 0x01, 0xFC, 0x01, 0x00, 0x02, 0x00, 0x00, 0xFD, 0x02, 
			.byte 0x7F, 0x00, 0x00, 0x80, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x90, 0x00, 0xFF, 0xFE, 0x01, 0x00, 0x00, 
			.byte 0xFE, 0x00, 0x00, 0x01, 0x00, 0x07, 0x85, 0x79, 0x3F, 0x00, 0x00, 0xC0, 0x7F, 0x80, 0x80, 0x80, 
			.byte 0x00, 0x24, 0xDA, 0xDB, 0xFE, 0x01, 0x00, 0x00, 0xFE, 0x00, 0x00, 0x01, 0x00, 0x93, 0x02, 0xB4, 
			.byte 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x20, 0xDC, 0xDF, 0xFC, 0x03, 0x00, 0x00, 
			.byte 0xFE, 0x00, 0x00, 0x01, 0x00, 0xFF, 0x40, 0x00, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 
			.byte 0x01, 0x00, 0x00, 0xFE, 0xFE, 0x01, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x03, 0xFC, 0x00, 0x00, 
			.byte 0xFF, 0x00, 0x00, 0x00, 

			.word 0  ; safety pair of bytes for reading by POP B
_vampire_run_l3_3_relative:
			.byte 0, 1; offset_y, offset_x
			.byte 15, 1; h, w
			.byte 0x00, 0x40, 0x23, 0x9C, 0x0F, 0x10, 0x20, 0xC0, 0x1F, 0x80, 0x40, 0x20, 0x00, 0x88, 0x36, 0x41, 
			.byte 0x80, 0x21, 0x16, 0x48, 0x3F, 0x40, 0x80, 0x00, 0x3F, 0x80, 0x00, 0x40, 0x80, 0x48, 0x00, 0x37, 
			.byte 0x00, 0x00, 0x00, 0xFF, 0x1F, 0xE0, 0x00, 0x00, 0x1F, 0x40, 0x80, 0x20, 0x00, 0x9C, 0x2B, 0x48, 
			.byte 0x00, 0x40, 0x3F, 0x80, 0x1F, 0x20, 0x40, 0x80, 0x3F, 0x00, 0x00, 0xC0, 0x80, 0x7F, 0x00, 0x24, 
			.byte 0x80, 0x1E, 0x21, 0x41, 0x0F, 0xF0, 0x40, 0x40, 0x1F, 0x20, 0xA0, 0xE0, 0x80, 0x76, 0x36, 0x09, 
			.byte 0x80, 0x2D, 0x00, 0x64, 0x3F, 0xC0, 0x80, 0x00, 0x3F, 0x00, 0x00, 0xC0, 0x00, 0xF7, 0x37, 0x08, 
			.byte 0x80, 0x00, 0x10, 0x7F, 0x3F, 0xC0, 0x00, 0x00, 0x7F, 0x00, 0x00, 0x80, 0x80, 0x7F, 0x00, 0x00, 
			.byte 0xC0, 0x00, 0x00, 0x3F, 0xFF, 0x00, 0x00, 0x00, 

			.word 0  ; safety pair of bytes for reading by POP B
_vampire_cast_0_0_relative:
			.byte 0, 0; offset_y, offset_x
			.byte 16, 1; h, w
			.byte 0xC0, 0x08, 0x16, 0x21, 0x07, 0x08, 0xD0, 0x20, 0x07, 0x20, 0xD0, 0x08, 0xC0, 0x21, 0x16, 0x08, 
			.byte 0xC0, 0x04, 0x1A, 0x21, 0x0F, 0x10, 0xA0, 0x40, 0x0F, 0xE0, 0x00, 0x10, 0xE0, 0x11, 0x00, 0x0E, 
			.byte 0xC0, 0x00, 0x06, 0x39, 0x07, 0x78, 0x80, 0x00, 0x07, 0x20, 0xC0, 0x18, 0xC0, 0x21, 0x0E, 0x10, 
			.byte 0x80, 0x14, 0x08, 0x63, 0x07, 0x88, 0x10, 0x60, 0x03, 0x00, 0x10, 0xEC, 0x80, 0x4F, 0x30, 0x00, 
			.byte 0x00, 0x02, 0x60, 0x9F, 0x01, 0xF6, 0x08, 0x40, 0x01, 0xC4, 0x28, 0x12, 0x00, 0x98, 0x28, 0x47, 
			.byte 0x00, 0x21, 0x0E, 0xDE, 0x01, 0xD4, 0xC2, 0x28, 0x01, 0x60, 0x06, 0x58, 0x00, 0x3A, 0xC8, 0x03, 
			.byte 0xA0, 0x40, 0x47, 0x1F, 0x09, 0xF2, 0xC6, 0x02, 0x0F, 0x00, 0x80, 0xF0, 0xE0, 0x1F, 0x00, 0x00, 
			.byte 0xF0, 0x00, 0x00, 0x0F, 0x1F, 0xE0, 0x00, 0x00, 0x3F, 0x00, 0x00, 0xC0, 0xF8, 0x07, 0x00, 0x00, 

			.word 0  ; safety pair of bytes for reading by POP B
_vampire_cast_0_1_relative:
			.byte 0, 0; offset_y, offset_x
			.byte 16, 1; h, w
			.byte 0xF0, 0x02, 0x05, 0x08, 0x01, 0x42, 0xB4, 0x08, 0x01, 0x08, 0xB4, 0x42, 0xF0, 0x08, 0x05, 0x02, 
			.byte 0xF0, 0x01, 0x06, 0x08, 0x03, 0x44, 0xA8, 0x10, 0x03, 0xB8, 0x00, 0x44, 0xF8, 0x04, 0x00, 0x03, 
			.byte 0xF0, 0x00, 0x01, 0x0E, 0x01, 0x5E, 0xA0, 0x00, 0x01, 0x08, 0xB0, 0x46, 0xF0, 0x08, 0x03, 0x04, 
			.byte 0xE0, 0x05, 0x02, 0x18, 0x01, 0xE2, 0x04, 0x18, 0x00, 0x00, 0x04, 0xFB, 0xE0, 0x13, 0x0C, 0x00, 
			.byte 0xC0, 0x00, 0x18, 0x27, 0x00, 0xFD, 0x02, 0x90, 0x00, 0xF1, 0x0A, 0x04, 0xC0, 0x26, 0x0A, 0x11, 
			.byte 0xC0, 0x08, 0x03, 0x37, 0x00, 0xB5, 0xB0, 0x4A, 0x00, 0xD8, 0x01, 0x96, 0xC0, 0x0E, 0x32, 0x00, 
			.byte 0xE8, 0x10, 0x11, 0x07, 0x02, 0xFC, 0xF1, 0x00, 0x03, 0x00, 0x20, 0xFC, 0xF8, 0x07, 0x00, 0x00, 
			.byte 0xFC, 0x00, 0x00, 0x03, 0x07, 0xF8, 0x00, 0x00, 0x0F, 0x00, 0x00, 0xF0, 0xFE, 0x01, 0x00, 0x00, 

			.word 0  ; safety pair of bytes for reading by POP B
_vampire_cast_0_2_relative:
			.byte 0, 0; offset_y, offset_x
			.byte 16, 2; h, w
			.byte 0xFC, 0x00, 0x01, 0x02, 0x00, 0x10, 0x6D, 0x82, 0x7F, 0x00, 0x00, 0x80, 0x7F, 0x80, 0x00, 0x00, 
			.byte 0x00, 0x82, 0x6D, 0x10, 0xFC, 0x02, 0x01, 0x00, 0xFC, 0x00, 0x01, 0x02, 0x00, 0x11, 0xAA, 0x44, 
			.byte 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x00, 0xEE, 0x00, 0x11, 0xFE, 0x01, 0x00, 0x00, 
			.byte 0xFC, 0x00, 0x00, 0x03, 0x00, 0x97, 0x68, 0x00, 0x7F, 0x00, 0x00, 0x80, 0x7F, 0x80, 0x00, 0x00, 
			.byte 0x00, 0x02, 0xEC, 0x11, 0xFC, 0x02, 0x00, 0x01, 0xF8, 0x01, 0x00, 0x06, 0x00, 0x38, 0x81, 0x46, 
			.byte 0x7F, 0x00, 0x00, 0x80, 0x3F, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x01, 0xFE, 0xF8, 0x04, 0x03, 0x00, 
			.byte 0xF0, 0x00, 0x06, 0x09, 0x00, 0xFF, 0x00, 0x24, 0x1F, 0x00, 0x80, 0x60, 0x1F, 0x20, 0x80, 0x40, 
			.byte 0x00, 0x7C, 0x82, 0x81, 0xF0, 0x09, 0x02, 0x04, 0xF0, 0x02, 0x00, 0x0D, 0x00, 0xED, 0xEC, 0x12, 
			.byte 0x1F, 0x80, 0x20, 0x40, 0x1F, 0x80, 0x60, 0x00, 0x00, 0x36, 0x80, 0xA5, 0xF0, 0x03, 0x0C, 0x00, 
			.byte 0xFA, 0x04, 0x04, 0x01, 0x00, 0xFF, 0x7C, 0x00, 0x9F, 0x20, 0x60, 0x20, 0xFF, 0x00, 0x00, 0x00, 
			.byte 0x00, 0x00, 0x08, 0xFF, 0xFE, 0x01, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x01, 0xFE, 0x00, 0x00, 
			.byte 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x83, 0x00, 0x00, 0x7C, 0xFF, 0x00, 0x00, 0x00, 

			.word 0  ; safety pair of bytes for reading by POP B
_vampire_cast_0_3_relative:
			.byte 0, 0; offset_y, offset_x
			.byte 16, 2; h, w
			.byte 0xFF, 0x00, 0x00, 0x00, 0x00, 0x84, 0x5B, 0x20, 0x1F, 0x80, 0x40, 0x20, 0x1F, 0x20, 0x40, 0x80, 
			.byte 0x00, 0x20, 0x5B, 0x84, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x84, 0x6A, 0x11, 
			.byte 0x3F, 0x00, 0x80, 0x40, 0x3F, 0x40, 0x00, 0x80, 0x80, 0x3B, 0x00, 0x44, 0xFF, 0x00, 0x00, 0x00, 
			.byte 0xFF, 0x00, 0x00, 0x00, 0x00, 0xE5, 0x1A, 0x00, 0x1F, 0x00, 0x00, 0xE0, 0x1F, 0x60, 0x00, 0x80, 
			.byte 0x00, 0x40, 0x3B, 0x84, 0xFF, 0x00, 0x00, 0x00, 0xFE, 0x00, 0x00, 0x01, 0x00, 0x8E, 0x20, 0x51, 
			.byte 0x1F, 0x80, 0x40, 0x20, 0x0F, 0xB0, 0x40, 0x00, 0x00, 0x00, 0xC0, 0x3F, 0xFE, 0x01, 0x00, 0x00, 
			.byte 0xFC, 0x00, 0x01, 0x02, 0x00, 0x7F, 0x80, 0x09, 0x07, 0x00, 0x20, 0xD8, 0x07, 0x48, 0xA0, 0x10, 
			.byte 0x00, 0x1F, 0xA0, 0x60, 0xFC, 0x02, 0x00, 0x01, 0xFC, 0x00, 0x00, 0x03, 0x00, 0x7B, 0x3B, 0x84, 
			.byte 0x07, 0xA0, 0x08, 0x50, 0x07, 0x60, 0x18, 0x80, 0x00, 0x0D, 0x20, 0xE9, 0xFC, 0x00, 0x03, 0x00, 
			.byte 0xFE, 0x01, 0x01, 0x00, 0x80, 0x7F, 0x1F, 0x00, 0x27, 0x08, 0x18, 0xC8, 0x3F, 0xC0, 0x00, 0x00, 
			.byte 0x80, 0x00, 0x02, 0x7F, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0xC0, 0x3F, 0x00, 0x00, 
			.byte 0x7F, 0x00, 0x00, 0x80, 0xFF, 0x00, 0x00, 0x00, 0xE0, 0x00, 0x00, 0x1F, 0xFF, 0x00, 0x00, 0x00, 
