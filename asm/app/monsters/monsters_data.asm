memusage_monsters_data:

; a newly inited room uses this list to call a monster Init func
; it's ordered by monster_id (see tiledata format in levels_data_consts.asm)
monsters_inits:
			JMP_4( skeleton_init)
			JMP_4( vampire_init)
			JMP_4( burner_init)
			JMP_4( knight_init)
			JMP_4( knight_init)
			JMP_4( burner_quest_init)
			JMP_4( burner_quest_init)
			JMP_4( knight_heavy_init)
			JMP_4( firepool_init)
			JMP_4( skeleton_quest_init)
			JMP_4( npc_init)