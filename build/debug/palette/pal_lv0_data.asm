			.word 0 ; safety pair of bytes for reading by POP B
_pal_lv0_palette_relative:
; assets\palettes/art/pal_lv0.png
			.byte %01100101, %01010010, %01011100, %01101011, 
			.byte %10100100, %01101100, %10110111, %01101111, 
			.byte %10011011, %11111101, %10101111, %01011111, 
			.byte %11111111, %11100010, %01100010, %00011111, 

			.word 0 ; safety pair of bytes for reading by POP B
_pal_lv0_palette_fade_to_black_relative:
			.byte 5 ; fade_iterations - 2
			.word 0 ; safety pair of bytes for reading by POP B
			.byte 0x65, 0x52, 0x5c, 0x6b, 0xa4, 0x6c, 0xb7, 0x6f, 0x9b, 0xfd, 0xaf, 0x5f, 0xff, 0xe2, 0x62, 0x1f, 
			.word 0 ; safety pair of bytes for reading by POP B
			.byte 0x1c, 0x09, 0x13, 0x22, 0x5b, 0x23, 0xad, 0x25, 0x52, 0xac, 0x66, 0x15, 0xf6, 0x99, 0x19, 0x15, 
			.word 0 ; safety pair of bytes for reading by POP B
			.byte 0x13, 0x09, 0x12, 0x1a, 0x52, 0x1a, 0x64, 0x1c, 0x52, 0xa3, 0x5d, 0x14, 0xad, 0x91, 0x11, 0x14, 
			.word 0 ; safety pair of bytes for reading by POP B
			.byte 0x12, 0x09, 0x0a, 0x11, 0x52, 0x12, 0x5b, 0x13, 0x49, 0x5a, 0x53, 0x0b, 0x5b, 0x51, 0x11, 0x0b, 
			.word 0 ; safety pair of bytes for reading by POP B
			.byte 0x09, 0x00, 0x09, 0x09, 0x09, 0x09, 0x12, 0x0a, 0x09, 0x51, 0x0a, 0x0a, 0x52, 0x48, 0x08, 0x0a, 
			.word 0 ; safety pair of bytes for reading by POP B
			.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09, 0x01, 0x00, 0x08, 0x01, 0x01, 0x09, 0x00, 0x00, 0x01, 
			.word 0 ; safety pair of bytes for reading by POP B
			.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 

