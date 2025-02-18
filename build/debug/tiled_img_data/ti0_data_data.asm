_TI0_FRAME_INGAME_DIALOG_COPY_LEN = 44
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_frame_ingame_dialog:
			.word _TI0_FRAME_INGAME_DIALOG_COPY_LEN ; data len to copy
			.word 0x8000 + (0<<8 | 0)	; scr addr
			.word 0x8000 + (32<<8 | 64)	; scr addr end
			.byte 8,255,9,30,10,7,255,5,30,6,4,255,5,30,6,4,
			.byte 255,5,30,6,4,255,5,30,6,4,255,5,30,6,4,255,
			.byte 5,30,6,1,255,2,30,3,
_TI0_MAIN_MENU_BACK2_COPY_LEN = 192
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_main_menu_back2:
			.word _TI0_MAIN_MENU_BACK2_COPY_LEN ; data len to copy
			.word 0x8000 + (0<<8 | 0)	; scr addr
			.word 0x8000 + (32<<8 | 128)	; scr addr end
			.byte 30,31,32,33,34,35,36,34,35,32,33,35,36,34,35,32,
			.byte 33,34,35,37,36,34,35,32,33,34,35,33,34,35,38,30,
			.byte 23,24,25,26,25,26,27,25,26,26,25,26,27,25,26,25,
			.byte 26,25,26,28,27,25,26,26,28,25,26,28,25,26,29,23,
			.byte 17,18,19,20,19,20,19,20,19,20,19,20,19,20,19,20,
			.byte 19,20,19,20,19,19,19,20,20,19,19,20,20,20,21,22,
			.byte 11,12,255,0,28,16,14,11,15,255,0,28,13,14,11,12,
			.byte 255,0,28,13,14,11,12,255,0,28,16,14,11,15,255,0,
			.byte 28,13,14,11,15,255,0,28,16,14,11,12,255,0,28,13,
			.byte 14,11,15,255,0,28,16,14,11,12,255,0,28,13,14,11,
			.byte 15,255,0,28,16,14,11,12,255,0,28,13,14,11,15,255,
			.byte 0,28,16,14,11,12,255,0,28,13,14,
_TI0_MAIN_MENU_BACK1_COPY_LEN = 166
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_main_menu_back1:
			.word _TI0_MAIN_MENU_BACK1_COPY_LEN ; data len to copy
			.word 0x8000 + (0<<8 | 128)	; scr addr
			.word 0x8000 + (32<<8 | 0)	; scr addr end
			.byte 11,12,255,0,28,16,14,11,12,255,0,28,13,29,29,15,
			.byte 255,0,28,16,22,17,12,255,0,28,13,14,11,15,255,0,
			.byte 28,16,14,11,12,255,0,28,13,14,11,12,255,0,28,16,
			.byte 14,11,15,255,0,28,13,14,11,12,255,0,28,16,14,11,
			.byte 15,255,0,28,13,14,11,12,255,0,28,16,14,11,15,255,
			.byte 0,28,13,14,11,12,255,0,28,16,14,11,15,255,0,28,
			.byte 16,14,11,39,40,41,40,41,40,40,41,41,40,41,41,41,
			.byte 40,40,41,41,40,40,41,41,40,41,41,40,41,41,40,41,
			.byte 41,14,17,18,18,28,27,25,26,28,27,25,26,28,27,26,
			.byte 25,26,25,26,28,27,25,26,25,30,26,27,27,25,26,17,
			.byte 22,22,
_TI0_TITLE1_COPY_LEN = 186
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_title1:
			.word _TI0_TITLE1_COPY_LEN ; data len to copy
			.word 0x8000 + (4<<8 | 160)	; scr addr
			.word 0x8000 + (27<<8 | 232)	; scr addr end
			.byte 165,166,167,168,169,255,170,15,171,0,0,150,151,152,153,154,
			.byte 155,156,157,158,159,158,160,159,158,158,159,159,158,155,161,162,
			.byte 163,164,0,131,132,133,134,135,136,137,138,139,140,141,142,143,
			.byte 144,145,137,146,147,0,148,149,0,0,0,115,116,117,0,118,
			.byte 119,0,120,121,122,123,124,0,125,119,126,127,128,129,130,0,
			.byte 0,0,96,97,98,99,100,101,0,102,103,104,105,106,107,108,
			.byte 109,110,111,112,113,114,0,0,0,77,0,78,79,80,81,82,
			.byte 83,84,85,86,87,88,89,90,91,92,0,93,94,95,255,0,
			.byte 4,63,64,65,66,67,68,69,70,71,72,73,74,75,76,255,
			.byte 0,5,255,0,4,49,50,51,52,53,54,55,56,57,58,59,
			.byte 60,61,62,255,0,5,255,0,5,42,43,44,255,0,7,45,
			.byte 46,47,48,255,0,4,
_TI0_FRAME_MAIN_MENU_COPY_LEN = 108
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_frame_main_menu:
			.word _TI0_FRAME_MAIN_MENU_COPY_LEN ; data len to copy
			.word 0x8000 + (9<<8 | 56)	; scr addr
			.word 0x8000 + (23<<8 | 160)	; scr addr end
			.byte 40,41,40,41,41,40,41,40,41,40,41,40,41,0,8,255,
			.byte 9,11,10,12,7,15,255,0,10,6,15,4,12,255,0,10,
			.byte 6,12,4,15,255,0,10,6,15,4,12,255,0,10,6,12,
			.byte 4,15,255,0,10,6,15,4,12,255,0,10,6,12,4,15,
			.byte 255,0,10,6,15,4,12,255,0,10,6,12,4,15,255,0,
			.byte 10,6,15,4,172,41,40,41,40,41,40,40,41,40,41,6,
			.byte 12,1,255,2,11,3,15,
_TI0_FRAME_INGAME_TOP_COPY_LEN = 44
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_frame_ingame_top:
			.word _TI0_FRAME_INGAME_TOP_COPY_LEN ; data len to copy
			.word 0x8000 + (0<<8 | 240)	; scr addr
			.word 0x8000 + (32<<8 | 0)	; scr addr end
			.byte 183,184,185,186,186,187,255,186,12,187,186,186,188,189,190,191,
			.byte 255,186,6,192,173,174,175,176,176,177,255,176,12,177,176,176,
			.byte 178,179,180,181,255,176,6,182,
_TI0_RES_MANA_COPY_LEN = 12
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_res_mana:
			.word _TI0_RES_MANA_COPY_LEN ; data len to copy
			.word 0x8000 + (6<<8 | 240)	; scr addr
			.word 0x8000 + (10<<8 | 0)	; scr addr end
			.byte 195,196,186,186,193,194,176,176,
_TI0_RES_SWORD_COPY_LEN = 12
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_res_sword:
			.word _TI0_RES_SWORD_COPY_LEN ; data len to copy
			.word 0x8000 + (6<<8 | 240)	; scr addr
			.word 0x8000 + (10<<8 | 0)	; scr addr end
			.byte 199,200,186,186,197,198,176,176,
_TI0_RES_POTION_HEALTH_COPY_LEN = 12
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_res_potion_health:
			.word _TI0_RES_POTION_HEALTH_COPY_LEN ; data len to copy
			.word 0x8000 + (6<<8 | 240)	; scr addr
			.word 0x8000 + (10<<8 | 0)	; scr addr end
			.byte 203,204,186,186,201,202,176,176,
_TI0_RES_POTION_MANA_COPY_LEN = 12
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_res_potion_mana:
			.word _TI0_RES_POTION_MANA_COPY_LEN ; data len to copy
			.word 0x8000 + (6<<8 | 240)	; scr addr
			.word 0x8000 + (10<<8 | 0)	; scr addr end
			.byte 207,208,186,186,205,206,176,176,
_TI0_RES_TNT_COPY_LEN = 12
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_res_tnt:
			.word _TI0_RES_TNT_COPY_LEN ; data len to copy
			.word 0x8000 + (6<<8 | 240)	; scr addr
			.word 0x8000 + (10<<8 | 0)	; scr addr end
			.byte 211,212,186,186,209,210,176,176,
_TI0_RES_CLOTHES_COPY_LEN = 12
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_res_clothes:
			.word _TI0_RES_CLOTHES_COPY_LEN ; data len to copy
			.word 0x8000 + (6<<8 | 240)	; scr addr
			.word 0x8000 + (10<<8 | 0)	; scr addr end
			.byte 215,216,186,186,213,214,176,176,
_TI0_RES_CABBAGE_COPY_LEN = 12
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_res_cabbage:
			.word _TI0_RES_CABBAGE_COPY_LEN ; data len to copy
			.word 0x8000 + (6<<8 | 240)	; scr addr
			.word 0x8000 + (10<<8 | 0)	; scr addr end
			.byte 219,220,186,186,217,218,176,176,
_TI0_RES_SPOON_COPY_LEN = 8
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_res_spoon:
			.word _TI0_RES_SPOON_COPY_LEN ; data len to copy
			.word 0x8000 + (6<<8 | 240)	; scr addr
			.word 0x8000 + (8<<8 | 0)	; scr addr end
			.byte 223,224,221,222,
_TI0_ITEM_KEY_0_COPY_LEN = 8
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_item_key_0:
			.word _TI0_ITEM_KEY_0_COPY_LEN ; data len to copy
			.word 0x8000 + (19<<8 | 240)	; scr addr
			.word 0x8000 + (21<<8 | 0)	; scr addr end
			.byte 227,228,225,226,
_TI0_ITEM_KEY_1_COPY_LEN = 8
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_item_key_1:
			.word _TI0_ITEM_KEY_1_COPY_LEN ; data len to copy
			.word 0x8000 + (19<<8 | 240)	; scr addr
			.word 0x8000 + (21<<8 | 0)	; scr addr end
			.byte 231,232,229,230,
_TI0_ITEM_KEY_2_COPY_LEN = 8
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_item_key_2:
			.word _TI0_ITEM_KEY_2_COPY_LEN ; data len to copy
			.word 0x8000 + (19<<8 | 240)	; scr addr
			.word 0x8000 + (21<<8 | 0)	; scr addr end
			.byte 235,236,233,234,
_TI0_ITEM_KEY_3_COPY_LEN = 8
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_item_key_3:
			.word _TI0_ITEM_KEY_3_COPY_LEN ; data len to copy
			.word 0x8000 + (19<<8 | 240)	; scr addr
			.word 0x8000 + (21<<8 | 0)	; scr addr end
			.byte 239,240,237,238,
_TI0_RES_EMPTY_COPY_LEN = 10
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_res_empty:
			.word _TI0_RES_EMPTY_COPY_LEN ; data len to copy
			.word 0x8000 + (6<<8 | 240)	; scr addr
			.word 0x8000 + (10<<8 | 0)	; scr addr end
			.byte 255,186,4,255,176,4,
_TI0_ITEM_EMPTY_COPY_LEN = 8
			.word 0 ; safety pair of bytes for reading by POP B
_ti0_item_empty:
			.word _TI0_ITEM_EMPTY_COPY_LEN ; data len to copy
			.word 0x8000 + (19<<8 | 240)	; scr addr
			.word 0x8000 + (21<<8 | 0)	; scr addr end
			.byte 186,186,176,176,
