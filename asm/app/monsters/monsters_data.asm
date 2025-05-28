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

monsters2_inits:
			JMP_4( friends_mom_init)
			JMP_4( friends_sis_init)
			JMP_4( goose_init)
			JMP_4( cat_init)
			JMP_4( caterpillar_init)
			JMP_4( chiken_init)
			JMP_4( crow_init)
			JMP_4( bob_init)
			JMP_4( dotty_init)
			JMP_4( villager2_init)
			JMP_4( villager3_init)
			JMP_4( villager4_init)