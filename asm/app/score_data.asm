; TODO: check is there is all entities listened

; func_id = 1
game_score_monsters:
			.word 5		; monster_id = 0 - skeleton (tiledata = 1*16+0=16)
			.word 10	; monster_id = 1 - vampire (tiledata = 17)
			.word 12	; monster_id = 2 - burner (tiledata = 18)
			.word 8		; monster_id = 3 - knight horizontal walk (tiledata = 19)
			.word 7		; monster_id = 4 - knight vertical walk (tiledata = 20)
			.word 0		; monster_id = 5 - burner quest that runs to the right
			.word 0		; monster_id = 6 - burner quest that runs to up
			.word 0		; monster_id = 6 - knight quest horizontal walk
			.word 3		; monster_id = 7 - firepool

; func_id = 6
game_score_items:
			.word 0		; item_id = 0 - storytelling - an invisible tiledata to open a dialog window
			.word 30	; item_id = 1 - key 0
			.word 80	; item_id = 2 - key 1
			.word 100	; item_id = 3 - key 2
			.word 200	; item_id = 4 - key 3
			.word 300	; item_id = 5 - key 3
			.word 400	; item_id = 6 - key 3

; func_id = 7
game_score_resources:
			.word 1		; res_id = 0 - a coin (tiledata = 7*16+0 = 160)
			.word 3		; res_id = 1 - a health crystal
			.word 50	; res_id = 2 - a sword
			.word 5		; res_id = 3 - a snowflake
			.word 15	; res_id = 4 - a tnt
			.word 10	; res_id = 5 - a potion health
			.word 15	; res_id = 6 - a popsicle pie
			.word 2		; res_id = 7 - a clothes
			.word 1		; res_id = 8 - a cabbage
			.word 5		; res_id = 9 - a spoon			

; TODO: it was previosly triggered by triggers, it caused a bug
; because friend's door can be accessed multiple times.
; so it dissabled and not used now
; think of using it only for secret places/rooms
; func_id = 10
game_score_secrets:
			.word 10	; entity_id = 0 - a home door trigger
			.word 20	; entity_id = 0 - a home door trigger

; func_id = 11
game_score_containers:
			.word 10	; container_id = 0 - a small chest. small money reward
			.word 30	; container_id = 1 - a big chest. big money reward
			.word 50	; container_id = 2 - a chest with a weapon 1
			.word 75	; container_id = 3 - a chest with a weapon 2
			.word 120	; container_id = 4 - a chest with a weapon 3
			.word 10	; container_id = 5 - a monster spawner chest. it spawns a chest monster when opened
			.word 50	; container_id = 6 - a crate with a teleport under it to a unique location

; func_id = 12
game_score_doors:
			.word 1		; door_id = 0 - a door 1a
			.word 1		; door_id = 1 - a door 1b
			.word 3		; door_id = 2 - a door 2a
			.word 3		; door_id = 3 - a door 2b
			.word 5		; door_id = 4 - a door 3a
			.word 5		; door_id = 5 - a door 3b
			.word 5		; door_id = 6 - a door 4a
			.word 5		; door_id = 7 - a door 4b

; func_id = 13
game_score_breakables:
			.word 1		; breakable_id 			= 0 - a barrel (tiledata = 13*16+0 = 208)
			.word 1		; breakable_id 			= 1 - a crate
			.word 1		; BREAKABLE_ID_CABBAGE	= 2 - cabbage (tiledata = $d2)

; pptr list to score points for each type of entity
game_score_lists_ptrs:
			.word game_score_monsters
			.word NULL_PTR
			.word NULL_PTR
			.word NULL_PTR
			.word NULL_PTR
			.word game_score_items
			.word game_score_resources
			.word NULL_PTR
			.word NULL_PTR
			.word game_score_secrets
			.word game_score_containers
			.word game_score_doors
			.word game_score_breakables

; game stats shown when the game is over
game_stats:
			.word 0		; monsters
			.word NULL	; TODO: secret room
			.word NULL	; TODO: deaths
			.word NULL
			.word NULL
			.word 0		; items
			.word 0		; resource: coins
			.word NULL
			.word NULL
			.word 0		; TODO: check secrets above
			.word 0		; containers
			.word 0		; doors
			.word 0		; breakables
game_stats_end: