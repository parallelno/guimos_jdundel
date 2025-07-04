; tiledata is a 8-bit value that describes a tile game-behaviour.
; it's stored in room_tiledata and unique per each room.
; Tilidata has two activation events: when a hero enters a room, and
; when a a hero and monsters steps on it.

; timedata has a format: %ffffDDDD, ffff - func_id, dddd - a func argument
; func_id is used to determine what group of entities it belongs to.
; func_arg is used to determine a specific entity in that group.
; for example, func_id = 1 means it's a monster, and func_arg = 0 means
; it's a skeleton. So %00010000 means spawn a skeleton when a hero enters
; a room.

TILEDATA_FUNC_MASK		= %11110000
TILEDATA_ARG_MASK		= %00001111
TILEDATA_ARG_MAX		= TILEDATA_ARG_MASK + 1

TILEDATA_FUNC_ID_MONSTERS	= 1
TILEDATA_FUNC_ID_TELEPORTS	= 2
TILEDATA_FUNC_ID_NPCS		= 3
TILEDATA_FUNC_ID_ITEMS		= 6
TILEDATA_FUNC_ID_RESOURCES	= 7
TILEDATA_FUNC_ID_SWITCHES	= 9
TILEDATA_FUNC_ID_TRIGGERS	= 10
TILEDATA_FUNC_ID_CONTAINERS	= 11
TILEDATA_FUNC_ID_DOORS		= 12
TILEDATA_FUNC_ID_BREAKABLES	= 13
TILEDATA_FUNC_ID_DECALS		= 14
TILEDATA_FUNC_ID_COLLISION	= 15

; ffff == 0, walkable tile
		TILEDATA_NO_COLLISION = 0 ; walkable tile, no back restoration, no decal
		TILEDATA_RESTORE_TILE = 1 ; walkable tile, restore back, no decal
;		d >= 2 - walkable tile, restore back + a decal. it's drawn on top of tiles to increase background variety. decal_walkable_id = d
;			decal_walkable_id == 2 - a bones (tiledata = 1)
;			decal_walkable_id == 3 - a skull (tiledata = 2)

; ffff == 1, spawn a monster, monster_id = d
		SKELETON_ID 	= 0	; tiledata = 1 * TILEDATA_ARG_MAX + 0 = 16
		VAMPIRE_ID		= 1	; tiledata = 17
		BURNER_ID		= 2	; tiledata = 18
		KNIGHT_HORIZ_ID = 3	; knight horizontal walk (tiledata = 19)
		KNIGHT_VERT_ID	= 4 ; knight vertical walk (tiledata = 20)
		BURNER_RIGHT_ID = 5 ; burner quest that runs to the right
		BURNER_UP_ID	= 6 ; burner quest that runs to up
		KNIGHT_QUEST_ID	= 7 ; knight quest horizontal walk
		FIREPOOL_ID		= 8 ; firepool
		SKELETON_QUEST_ID	= 9 ; skeleton spawned after opening a container with a spoon

; ffff = 2, teleports, teleport_ids 0-15. To convert in into a room_id use the 
;		room_teleports_data table.

; ffff = 3, npcs, npc_id = d
		NPC_ID_FRIENDS_MOM	= 0 ; tiledata = 3*TILEDATA_ARG_MAX+0=48
		NPC_ID_FRIENDS_SIS	= 1 ; tiledata = 49
		NPC_ID_GOOSE		= 2 ; tiledata = 50
		NPC_ID_CAT			= 3 ; tiledata = 51
		NPC_ID_CATERPILLAR	= 4 ; tiledata = 52
		NPC_ID_CHICKEN		= 5 ; tiledata = 53
		NPC_ID_CROW			= 6 ; tiledata = 54
		NPC_ID_BOB			= 7 ; tiledata = 55
		NPC_ID_DOTTY		= 8 ; tiledata = 56
		NPC_ID_VILLAGER2	= 9 ; tiledata = 57
		NPC_ID_VILLAGER3	= 10; tiledata = 58
		NPC_ID_VILLAGER4	= 11; tiledata = 59

; ffff = 4, not used
; ffff = 5, not used

; ffff == 6, global items. a hero interacts with it when he steps on 
;		it. Item_id = d. See runtime_data.asm->global_items for details.
		ITEM_ID_STORYTELLING = 0 ; storytelling - an invisible tiledata to open a dialog window
		ITEM_ID_KEY_0	= 1	; 	key 0
;		item_id 		= 2 ; key 1
;		item_id 		= 3 ; key 2
;		item_id 		= 4 ; key 3
;		item_id 		= 5 ; key 4
;		item_id 		= 6 ; key 5
		ITEM_ID_UI_MAX	= 8		; items with item_id >= ITEM_ID_UI_MAX do not show up on the ui panel

; ffff == 7, resources. a hero interacts with it when he steps on it. 
;		Max instances in all rooms = RESOURCES_LEN/2-RESOURCES_UNIQUE_MAX. 
;		res_id = d. see runtime_data.asm->resources_inst_data for 
;		details.
;		res_id 				= 0 ; a coin (increases the game score when picked up) ; (tiledata = 7*16+0 = 160)
;		res_id 				= 1 ; a health crystal (increases health immedietly when picked up)
		RES_ID_SWORD		= 2 ; a sword (the main weapon)
		RES_ID_SNOWFLAKE	= 3 ; a snowflakes (increases mana immedietly when picked up)		
;		res_id 				= 4 ; tnt (spawns a bullet called tnt)
;		res_id 				= 5 ; a potion health (gives several health points when used)
		RES_ID_PIE 			= 6 ; a popsicle pie (gives several snowflakes when RES_ID_SPOON is used)
		RES_ID_CLOTHES 		= 7 ; clothes ; it is a quest resource
		RES_ID_CABBAGE		= 8 ; cabbage ; it is a quest resource
		RES_ID_SPOON		= 9	; use it to convert hero_res_popsicle_pie into hero_res_snowflake

TILEDATA_COLLIDABLE		= 8 * TILEDATA_ARG_MAX ; all tiledatas with values bigger than this are collidable
; 		(a hero and monsters can't step on that tile)

; ffff == 8, not used

; ffff == 9, switches with two visual states switching them when a hero hits it.
		SWITCH_BONGO_CAT	= 0
		SWITCH_POP_CAT		= 1
		SWITCH_NYAN_CAT		= 2

; ffff == 10, triggers. activated when a hero hits it. trigger_id = d
		TRIGGER_ID_HOME_DOOR = 0 ; when he hits his house door.
		TRIGGER_ID_HOME_DUNGEON_ENTRANCE = 1 ; when he hits the dungeon door.
		TRIGGER_ID_TEMP_LV1 = 7 ; enter the second level

; ffff == 11, collidable containers that leave rewards on the floor 
;		when a hero hits it. container_id = d.
;		container_id = 0 - a chest with a sword
;		container_id = 1 - a big chest. big money reward
;		container_id = 2 - a chest 2
;		container_id = 3 - a chest 3
;		container_id = 4 - a chest 4
;		container_id = 5 - a monster spawner chest. it spawns a chest monster when opened
;		container_id = 6 - a crate with a teleport under it to a unique location

; ffff == 12, doors. a hero interacts with it only when he hits it with
;		a weapon. door_id = d.
;		door_id = 0 - a door 1a
;		door_id = 1 - a door 1b
;		door_id = 2 - a door 2a
;		door_id = 3 - a door 2b
;		door_id = 4 - a door 3a
;		door_id = 5 - a door 3b
;		door_id = 6 - a door 4a
;		door_id = 7 - a door 4b

TILEDATA_BREAKABLES = TILEDATA_FUNC_ID_BREAKABLES * TILEDATA_ARG_MAX
; 		breakable items, a hero can only break it with a hit and
; 		get a random reward. A room tracks how many it was broken to 
;		manage a reward and a spawn rate. breakable_id = d.
;		breakable_id == 0 - a barrel (tiledata = 13 * TILEDATA_ARG_MAX + 0 = 208, $d0)
;		breakable_id == 1 - a crate
		BREAKABLE_ID_CABBAGE = 2 ;cabbage (tiledata = $d2)

; ffff == 14, decals collidable. it's drawn on top of tiles to increase background variety. decal_collidable_id = d
;		decal_collidable_id == 0 - a spider web.

  TILEDATA_BACKS = TILEDATA_FUNC_ID_COLLISION * TILEDATA_ARG_MAX ; animated background tiles
; 		back_id = 0 - torch front
;  	    back_id = 1 - flag front
   	    TILEDATA_DIALOG_PRESS_KEY = TILEDATA_BACKS + 2
		TILEDATA_COLLISION = TILEDATA_BACKS + 15 ; just a collision. no graphics, no animation

; if tiledata > 0 then a tile is restored on the screen when a hero,
; 		a monster, or a bullet steps on it.

