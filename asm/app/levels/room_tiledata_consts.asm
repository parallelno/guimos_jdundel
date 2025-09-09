;===============================================================================
; TILEDATA Definitions
;===============================================================================
; Tiledata is an 8-bit value that describes a tile game-behaviour and how it
; interacts with the game entities.
; NOTE:
; - Each room consists of a grid of tiles 16x16 pixels each. Each tile has a
;     graphics data index and a tiledata. Room tiledata values are stored in
;     the `room_tiledata` array.
; - Tiledata can be triggered by:
;   1. During the room initialization when a hero enters it.
;   2. Actor stepping on the tile.
; - When a tile is triggered, an assiciated function is called.
; - A function can replace the tiledata with a new one.
; - If an actor steps on tiledata > 0, a tile is restored on the screen.
; - tiledata = 0 means no graphics is drawn on the tile, it's monotonic and
;     do not require restoring.
;
;-------------------------------------------------------------------------------
; Tiledata Format:
;-------------------------------------------------------------------------------
; Tiledata bits - %ffffdddd.
;   ffff - func_id: a function called when a tile is triggered.
;   dddd - func_arg: argument passed to the function (typically entity ID)
;
; Example:
;   Tiledata = %00010000.
;   func_id = 1 (CHARS), func_arg = 0 (Skeleton).
;   Behavior: Spawn Skeleton when a hero enters a room. Tiledata is replaced
;			 with TILEDATA_RESTORE_TILE, which means the tile's walkable,
;			 and background tile requires restoration after anyone steps on it.

; Masks
TILEDATA_FUNC_MASK		= %11110000
TILEDATA_ARG_MASK		= %00001111
TILEDATA_ARG_MAX		= TILEDATA_ARG_MASK + 1

; Func IDs
TILEDATA_FUNC_ID_CHARS	= 1
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

;-------------------------------------------------------------------------------
; func_id = 0 → Walkable Tiles & Decals
;-------------------------------------------------------------------------------
TILEDATA_NO_COLLISION = 0 ; Walkable, no decal or back restore
TILEDATA_RESTORE_TILE = 1 ; Walkable, no decal, back tile restoration
; If dddd >= 2, tile is walkable, back tile restoration, and decal overlay
;     decal_walkable_id == 2 - a bones (tiledata = 1)
;     decal_walkable_id == 3 - a skull (tiledata = 2)

;-------------------------------------------------------------------------------
; func_id = 1 → Spawn chars
;-------------------------------------------------------------------------------
SKELETON_ID 	= 0	;
VAMPIRE_ID		= 1	;
BURNER_ID		= 2	;
KNIGHT_HORIZ_ID = 3	; knight horizontal walk
KNIGHT_VERT_ID	= 4 ; knight vertical walk
BURNER_RIGHT_ID = 5 ; burner quest that runs to the right
BURNER_UP_ID	= 6 ; burner quest that runs to up
KNIGHT_QUEST_ID	= 7 ; knight quest horizontal walk
FIREPOOL_ID		= 8 ; firepool
SKELETON_QUEST_ID	= 9 ; skeleton spawned after opening a container with a spoon

;-------------------------------------------------------------------------------
; func_id = 2 → Teleports
;-------------------------------------------------------------------------------
; - teleport_id = dddd
; - Teleport_ids is in a range of 0 to 15.
; - Converts to room_id using room_teleports_data[teleport_id]

;-------------------------------------------------------------------------------
; func_id = 3 → NPCs
;-------------------------------------------------------------------------------
; - An NPC is spawned when a hero enters a room.
NPC_ID_FRIENDS_MOM	= 0
NPC_ID_FRIENDS_SIS	= 1
NPC_ID_GOOSE		= 2
NPC_ID_CAT			= 3
NPC_ID_CATERPILLAR	= 4
NPC_ID_CHICKEN		= 5
NPC_ID_CROW			= 6
NPC_ID_BOB			= 7
NPC_ID_DOTTY		= 8
NPC_ID_VILLAGER2	= 9
NPC_ID_VILLAGER3	= 10
NPC_ID_VILLAGER4	= 11

; ffff = 4, not used
; ffff = 5, not used

;-------------------------------------------------------------------------------
; func_id = 6 → Global Items
;-------------------------------------------------------------------------------
; - A hero interacts with it when he steps on
;   it.
; - Item_id = d. See runtime_data.asm->global_items for details.

ITEM_ID_STORYTELLING = 0 ; Opens dialog when a hero steps on it
ITEM_ID_KEY_0	= 1	; friend's mom gives it
; item_id 		= 2 ;
ITEM_ID_KEY_2	= 3 ; uncle bob gives it
; item_id 		= 4 ;
; item_id 		= 5 ;
; item_id 		= 6 ;
ITEM_ID_UI_MAX	= 8	; Items >= this ID don't appear in UI panel

;-------------------------------------------------------------------------------
; func_id = 7 → Resources
;-------------------------------------------------------------------------------
; - Collectable items that the hero can pick up by stepping on them.
; - Some resources are usabler (cabbage), some are not visible in UI (coins).
; - Some are renewable (e.g., cabbage), others not (e.g., coin).
; - A hero interacts with it when he steps on it.
; - Max resource instances in all level = RESOURCES_INST_DATA_PTRS_LEN/2-RESOURCES_UNIQUE_MAX.
; - res_id = d (see Resource Instance Status Data for details).

; res_id 			= 0 ; Coin: increases the hero's score
; res_id 			= 1 ; Health Crystal: increases health immedietly when picked up
RES_ID_SWORD		= 2 ; Main weapon. Enables melee attacking when equipped.
RES_ID_SNOWFLAKE	= 3 ; Snowflakes: increases mana immedietly when picked up
; res_id 			= 4 ; TNT (can be instanced as a overlay)
; res_id 			= 5 ; Restores multiple health points
RES_ID_PIE 			= 6 ; Popsicle Pie. Grants multiple snowflakes when used with RES_ID_SPOON)
RES_ID_CLOTHES 		= 7 ; Quest resource. Used in dialog and specific puzzles.
RES_ID_CABBAGE		= 8 ; Quest resource. Enables "fart" status on consumption.
RES_ID_SPOON		= 9	; use it to convert hero_res_popsicle_pie into hero_res_snowflake
RES_ID_SCARECROW    = 10 ; quest resource to plant in into the field
RES_ID_TRAP = 11 ; quest resource to catch caterpillars

; all tiledatas with values bigger than TILEDATA_COLLIDABLE are collidable
; (a hero and chars can't step on that tile)
TILEDATA_COLLIDABLE		= 8 * TILEDATA_ARG_MAX


; ffff == 8, not used

;-------------------------------------------------------------------------------
; func_id = 9 → Switches (2-state visuals)
;-------------------------------------------------------------------------------
; - Switches have two visual states: active and inactive.
; - Switch can become active when a hero hits it.
; - When a switch is active, an associated decal is drawn.
; - Switches usually used to demonstrate a quest tile it game mechanic state.
; - Example: a statuse of a cat. When a hero use a milk item on it,
;   the cat statue changes its visual time to the graphics of a milked cat.

SWITCH_BONGO_CAT	= 0
SWITCH_POP_CAT		= 1
SWITCH_NYAN_CAT		= 2

;-------------------------------------------------------------------------------
; func_id = 10 → Triggers
;-------------------------------------------------------------------------------
; - Triggers funcs are called when a hero hits a trigger tile.
; - Used for extra game logic like ending the game, loading the level 2, etc.
; - trigger_id = d
TRIGGER_ID_HOME_DOOR = 0 ; when he hits his house door.
TRIGGER_ID_END_GAME  = 1 ; when a hero ended the game
TRIGGER_ID_MAIN_MENU = 7 ; go to the main menu
TRIGGER_ID_LV0 = 8       ; ... level0
TRIGGER_ID_LV1 = 9       ; ... level1
TRIGGER_ID_LV2 = 10      ; ... level2

;-------------------------------------------------------------------------------
; func_id = 11 → Containers
;-------------------------------------------------------------------------------
; - Containers drop items or any other reward when a hero hits it.
; - Usually used for getting special weapons or keys, but can spawn chars.
; - When a hero pick up a container, the container tiledata is replaced with
;    a walkable tiledata.
; - container_id = d.

; container_id = 0 - a chest with a sword
; container_id = 1 - a big chest. big money reward
; container_id = 2 - a chest 2
; container_id = 3 - a chest 3
; container_id = 4 - a chest 4
; container_id = 5 - a char spawner chest. it spawns a chest char when opened
; container_id = 6 - a crate with a teleport under it to a unique location

;-------------------------------------------------------------------------------
; func_id = 12 → Doors (interact via weapon hit)
;-------------------------------------------------------------------------------
; - Doors have a collission.
; - Doors are interacted with via a weapon hit.
; - If a hero has a key for a door, the door is unlocked, and the tile is replaced
;   with a walkable tile, the graphics of the unlocked door is drawn.
; - Each two sequential doors in a room are connected and can be opened with the
;     same key. If one door is unlocked, the other door is also unlocked. That
;     happens because they unlocking state belongs to the key.
; - door_id = d.
; door_id = 0 - a door 1 left
; door_id = 1 - a door 1 right
; door_id = 2 - a door 2 left
; door_id = 3 - a door 2 right
; door_id = 4 - a door 3 left
; door_id = 5 - a door 3 right
; door_id = 6 - a door 4 left
; door_id = 7 - a door 4 right

;-------------------------------------------------------------------------------
; func_id = 13 → Breakables (destroyable for rewards)
;-------------------------------------------------------------------------------
; - Breakables are interacted with via a weapon hit.
; - Mostly used for getting a small random reward and improve interactivity.
; - The game remembers if a breakable was destroyed and do not respawn it when
;     a hero reenters the room.
; - breakable_id = d.
TILEDATA_BREAKABLES = TILEDATA_FUNC_ID_BREAKABLES * TILEDATA_ARG_MAX

; breakable_id 		= 0  ; Barrel
; breakable_id 		= 1  ; Crate
BREAKABLE_ID_CABBAGE = 2 ; Cabbage

;-------------------------------------------------------------------------------
; func_id = 14 → Collidable Decals
;-------------------------------------------------------------------------------
; - It's drawn on top of graphics tiles to increase background variety.
; - decal_collidable_id = d

; decal_collidable_id == 0 - a spider web.

;-------------------------------------------------------------------------------
; func_id = 15 → Animated Backgrounds
;-------------------------------------------------------------------------------
; - Animated background tiles. Each tile starts from a random frame.
; - All background animations share the same playback speed.
; - These tiles are drawn directly to the screen (not copied from the back buffer)
;     to improve performance. As a result, they are non-walkable.
; - To reduce the mem usage, they do not have an alpha channel, but their height
;    is variable.
TILEDATA_BACKS = TILEDATA_FUNC_ID_COLLISION * TILEDATA_ARG_MAX ; animated background tiles

; back_id = 0 - torch front
; back_id = 1 - flag front
TILEDATA_DIALOG_PRESS_KEY = TILEDATA_BACKS + 2
TILEDATA_COLLISION = TILEDATA_BACKS + 15 ; just a collision. no graphics, no animation
