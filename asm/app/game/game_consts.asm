	; This line is for proper formatting in VSCode
;======================================================
; gameplay

LEVEL_FIRST	= 0
LEVEL_ID_0	= 0
LEVEL_ID_1	= 1
LEVEL_ID_2	= 2
LEVEL_ID_3	= 3

ROOM_ID_0	= 0
ROOM_ID_1	= 1
ROOM_ID_2	= 2
ROOM_ID_3	= 3
ROOM_ID_4	= 4
ROOM_ID_5	= 5
ROOM_ID_6	= 6
ROOM_ID_7	= 7
ROOM_ID_8	= 8
ROOM_ID_9	= 9
ROOM_ID_10	= 10
ROOM_ID_11	= 11
ROOM_ID_12	= 12
ROOM_ID_13	= 13
ROOM_ID_14	= 14
ROOM_ID_15	= 15
ROOM_ID_16	= 16
ROOM_ID_17	= 17
ROOM_ID_18	= 18
ROOM_ID_19	= 19
ROOM_ID_20	= 20
ROOM_ID_21	= 21
ROOM_ID_22	= 22
ROOM_ID_23	= 23
ROOM_ID_24	= 24
ROOM_ID_25	= 25
ROOM_ID_26	= 26
ROOM_ID_27	= 27
ROOM_ID_28	= 28
ROOM_ID_29	= 29
ROOM_ID_30	= 30
ROOM_ID_31	= 31
ROOM_ID_32	= 32
ROOM_ID_33	= 33
ROOM_ID_34	= 34
ROOM_ID_35	= 35
ROOM_ID_36	= 36
ROOM_ID_37	= 37
ROOM_ID_38	= 38
ROOM_ID_39	= 39
ROOM_ID_40	= 40
ROOM_ID_41	= 41
ROOM_ID_42	= 42
ROOM_ID_43	= 43
ROOM_ID_44	= 44
ROOM_ID_45	= 45
ROOM_ID_46	= 46
ROOM_ID_47	= 47
ROOM_ID_48	= 48
ROOM_ID_49	= 49
ROOM_ID_50	= 50
ROOM_ID_51	= 51
ROOM_ID_52	= 52
ROOM_ID_53	= 53
ROOM_ID_54	= 54
ROOM_ID_55	= 55
ROOM_ID_56	= 56
ROOM_ID_57	= 57
ROOM_ID_58	= 58
ROOM_ID_59	= 59
ROOM_ID_60	= 60
ROOM_ID_61	= 61
ROOM_ID_62	= 62
ROOM_ID_63	= 63

SCORES_MAX	= 10

SECRET_ENDING_HOME	= 1
SECRETS_MAX = 16
;======================================================


BREAKABLE_SPAWN_RATE_MAX	= 255
BREAKABLE_SPAWN_RATE_DELTA	= 256/8 ; destroying 8 breakable items makes their spawning chance = 255 - BREAKABLE_SPAWN_RATE_MAX
CHAR_SPAWN_RATE_MAX		= 250
CHAR_SPAWN_RATE_DELTA	= 256/16

RES_POTION_HEALTH_VAL		= 5
RES_POPSICLE_PIE_MANA_VAL	= 25
RES_CABBAGE_HEALTH_VAL		= 1

RES_EMPTY				= 0
RES_HEALTH_MAX 			= 10
RES_HEALTH_INIT			= 5 ; hero health
RES_HEALTH_RESPAWN		= 1 ; hero health when respawning
RES_SNOWFLAKES_MAX		= 80
RES_POTION_HEALTH_MAX	= 10
RES_POPSICLE_PIE_MAX	= 10
RES_CLOTHS_MAX			= 5
RES_SWORD_MAX			= 1
RES_SPOON_MAX			= 1
RES_CABBAGE_MAX			= 10
RES_CABBAGE_FART		= 4

BUFF_FREEZE_TIME		= 80

GAME_REQ_ROOM_INIT_AND_DRAW		= 0 | GAME_REQ
GAME_REQ_ROOM_REDRAW			= 1 | GAME_REQ ; after dialog
GAME_REQ_PAUSE					= 2 | GAME_REQ
GAME_REQ_ROOM_INIT_AND_DRAW_FADE_IN	= 3 | GAME_REQ
