_TI0_FRAME_INGAME_DIALOG_COPY_LEN = 44
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_frame_ingame_dialog:
			.word _TI0_FRAME_INGAME_DIALOG_COPY_LEN ; data len to copy
			.word 0x8000 + (0<<8 | 0)	; scr addr
			.word 0x8000 + (32<<8 | 64)	; scr addr end
			.byte 0x08, 0xFF, 0x09, 0x1E, 0x0A, 0x07, 0xFF, 0x05, 0x1E, 0x06, 0x04, 0xFF, 0x05, 0x1E, 0x06, 0x04, 
			.byte 0xFF, 0x05, 0x1E, 0x06, 0x04, 0xFF, 0x05, 0x1E, 0x06, 0x04, 0xFF, 0x05, 0x1E, 0x06, 0x04, 0xFF, 
			.byte 0x05, 0x1E, 0x06, 0x01, 0xFF, 0x02, 0x1E, 0x03, 
_TI0_FRAME_INGAME_TOP_COPY_LEN = 44
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_frame_ingame_top:
			.word _TI0_FRAME_INGAME_TOP_COPY_LEN ; data len to copy
			.word 0x8000 + (0<<8 | 240)	; scr addr
			.word 0x8000 + (32<<8 | 0)	; scr addr end
			.byte 0x15, 0x16, 0x17, 0x18, 0x18, 0x19, 0xFF, 0x18, 0x0C, 0x19, 0x18, 0x18, 0x1A, 0x1B, 0x1C, 0x1D, 
			.byte 0xFF, 0x18, 0x06, 0x1E, 0x0B, 0x0C, 0x0D, 0x0E, 0x0E, 0x0F, 0xFF, 0x0E, 0x0C, 0x0F, 0x0E, 0x0E, 
			.byte 0x10, 0x11, 0x12, 0x13, 0xFF, 0x0E, 0x06, 0x14, 
_TI0_RES_MANA_COPY_LEN = 12
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_res_mana:
			.word _TI0_RES_MANA_COPY_LEN ; data len to copy
			.word 0x8000 + (6<<8 | 240)	; scr addr
			.word 0x8000 + (10<<8 | 0)	; scr addr end
			.byte 0x21, 0x22, 0x18, 0x18, 0x1F, 0x20, 0x0E, 0x0E, 
_TI0_RES_SWORD_COPY_LEN = 12
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_res_sword:
			.word _TI0_RES_SWORD_COPY_LEN ; data len to copy
			.word 0x8000 + (6<<8 | 240)	; scr addr
			.word 0x8000 + (10<<8 | 0)	; scr addr end
			.byte 0x25, 0x26, 0x18, 0x18, 0x23, 0x24, 0x0E, 0x0E, 
_TI0_RES_POTION_HEALTH_COPY_LEN = 12
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_res_potion_health:
			.word _TI0_RES_POTION_HEALTH_COPY_LEN ; data len to copy
			.word 0x8000 + (6<<8 | 240)	; scr addr
			.word 0x8000 + (10<<8 | 0)	; scr addr end
			.byte 0x29, 0x2A, 0x18, 0x18, 0x27, 0x28, 0x0E, 0x0E, 
_TI0_RES_POTION_MANA_COPY_LEN = 12
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_res_potion_mana:
			.word _TI0_RES_POTION_MANA_COPY_LEN ; data len to copy
			.word 0x8000 + (6<<8 | 240)	; scr addr
			.word 0x8000 + (10<<8 | 0)	; scr addr end
			.byte 0x2D, 0x2E, 0x18, 0x18, 0x2B, 0x2C, 0x0E, 0x0E, 
_TI0_RES_TNT_COPY_LEN = 12
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_res_tnt:
			.word _TI0_RES_TNT_COPY_LEN ; data len to copy
			.word 0x8000 + (6<<8 | 240)	; scr addr
			.word 0x8000 + (10<<8 | 0)	; scr addr end
			.byte 0x31, 0x32, 0x18, 0x18, 0x2F, 0x30, 0x0E, 0x0E, 
_TI0_RES_CLOTHES_COPY_LEN = 12
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_res_clothes:
			.word _TI0_RES_CLOTHES_COPY_LEN ; data len to copy
			.word 0x8000 + (6<<8 | 240)	; scr addr
			.word 0x8000 + (10<<8 | 0)	; scr addr end
			.byte 0x35, 0x36, 0x18, 0x18, 0x33, 0x34, 0x0E, 0x0E, 
_TI0_RES_CABBAGE_COPY_LEN = 12
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_res_cabbage:
			.word _TI0_RES_CABBAGE_COPY_LEN ; data len to copy
			.word 0x8000 + (6<<8 | 240)	; scr addr
			.word 0x8000 + (10<<8 | 0)	; scr addr end
			.byte 0x39, 0x3A, 0x18, 0x18, 0x37, 0x38, 0x0E, 0x0E, 
_TI0_RES_SPOON_COPY_LEN = 8
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_res_spoon:
			.word _TI0_RES_SPOON_COPY_LEN ; data len to copy
			.word 0x8000 + (6<<8 | 240)	; scr addr
			.word 0x8000 + (8<<8 | 0)	; scr addr end
			.byte 0x3D, 0x3E, 0x3B, 0x3C, 
_TI0_RES_CAN_COPY_LEN = 8
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_res_can:
			.word _TI0_RES_CAN_COPY_LEN ; data len to copy
			.word 0x8000 + (6<<8 | 240)	; scr addr
			.word 0x8000 + (8<<8 | 0)	; scr addr end
			.byte 0x41, 0x42, 0x3F, 0x40, 
_TI0_RES_FULL_CAN_COPY_LEN = 8
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_res_full_can:
			.word _TI0_RES_FULL_CAN_COPY_LEN ; data len to copy
			.word 0x8000 + (6<<8 | 240)	; scr addr
			.word 0x8000 + (8<<8 | 0)	; scr addr end
			.byte 0x45, 0x46, 0x43, 0x44, 
_TI0_RES_SCARECROW_COPY_LEN = 8
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_res_scarecrow:
			.word _TI0_RES_SCARECROW_COPY_LEN ; data len to copy
			.word 0x8000 + (6<<8 | 240)	; scr addr
			.word 0x8000 + (8<<8 | 0)	; scr addr end
			.byte 0x49, 0x4A, 0x47, 0x48, 
_TI0_ITEM_KEY_0_COPY_LEN = 8
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_item_key_0:
			.word _TI0_ITEM_KEY_0_COPY_LEN ; data len to copy
			.word 0x8000 + (19<<8 | 240)	; scr addr
			.word 0x8000 + (21<<8 | 0)	; scr addr end
			.byte 0x4D, 0x4E, 0x4B, 0x4C, 
_TI0_ITEM_KEY_1_COPY_LEN = 8
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_item_key_1:
			.word _TI0_ITEM_KEY_1_COPY_LEN ; data len to copy
			.word 0x8000 + (19<<8 | 240)	; scr addr
			.word 0x8000 + (21<<8 | 0)	; scr addr end
			.byte 0x51, 0x52, 0x4F, 0x50, 
_TI0_ITEM_KEY_2_COPY_LEN = 8
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_item_key_2:
			.word _TI0_ITEM_KEY_2_COPY_LEN ; data len to copy
			.word 0x8000 + (19<<8 | 240)	; scr addr
			.word 0x8000 + (21<<8 | 0)	; scr addr end
			.byte 0x55, 0x56, 0x53, 0x54, 
_TI0_ITEM_KEY_3_COPY_LEN = 8
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_item_key_3:
			.word _TI0_ITEM_KEY_3_COPY_LEN ; data len to copy
			.word 0x8000 + (19<<8 | 240)	; scr addr
			.word 0x8000 + (21<<8 | 0)	; scr addr end
			.byte 0x59, 0x5A, 0x57, 0x58, 
_TI0_ITEM_KEY_4_COPY_LEN = 8
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_item_key_4:
			.word _TI0_ITEM_KEY_4_COPY_LEN ; data len to copy
			.word 0x8000 + (19<<8 | 240)	; scr addr
			.word 0x8000 + (21<<8 | 0)	; scr addr end
			.byte 0x5D, 0x5E, 0x5B, 0x5C, 
_TI0_RES_EMPTY_COPY_LEN = 10
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_res_empty:
			.word _TI0_RES_EMPTY_COPY_LEN ; data len to copy
			.word 0x8000 + (6<<8 | 240)	; scr addr
			.word 0x8000 + (10<<8 | 0)	; scr addr end
			.byte 0xFF, 0x18, 0x04, 0xFF, 0x0E, 0x04, 
_TI0_ITEM_EMPTY_COPY_LEN = 8
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_item_empty:
			.word _TI0_ITEM_EMPTY_COPY_LEN ; data len to copy
			.word 0x8000 + (19<<8 | 240)	; scr addr
			.word 0x8000 + (21<<8 | 0)	; scr addr end
			.byte 0x18, 0x18, 0x0E, 0x0E, 
