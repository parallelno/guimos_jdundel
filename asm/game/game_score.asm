; add score points to hero_res_score
; in:
; d - func_id
; e - entity_id
; ex: to add score points of a dead vampire, a = 1, c = 1
game_score_add:
			mov a, d
			; get the ptr to the partucular entity
			HL_TO_AX2_PLUS_INT16(game_stats - WORD_LEN) ; because the list starts with func_id=1
			; increase the entity counter
			inr m
			jnz @score_add
			inx h
			inr m
@score_add:
			mov a, d
			; get the ptr to the scores of partucular entity
			HL_TO_AX2_PLUS_INT16(game_score_lists_ptrs - WORD_LEN) ; because the list starts with func_id=1
			; get a score list ptr
			mov c, m
			inx h
			mov b, m
			; bc - ptr to a list of scores
			; get an entity score ptr
			mvi d, 0
			xchg
			dad h ; entity_id * 2 because score points takes two bytes
			dad b
			; get an entity score
			mov e, m
			inx h
			mov d, m
			; add it to hero_res_score
			lhld hero_res_score
			dad d
			shld hero_res_score
			ret

; init for in-game score data
game_stats_init:
			lxi h, game_stats
			lxi b, game_stats_end - game_stats
			call mem_erase
			ret

; read the game stats
; in:
; c - stat_id (offset in game_stats)
; out:
; de - the stat
game_stats_get:
			mov a, c
			; get the ptr to the partucular entity
			HL_TO_AX2_PLUS_INT16(game_stats - WORD_LEN) ; because the list starts with func_id=1
			; increase the entity counter
			mov e, m
			inx h
			mov d, m
			ret