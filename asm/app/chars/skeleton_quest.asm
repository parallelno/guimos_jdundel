@memusage_skeleton_quest
; this mob is absolutly the same as a skeleton.asm
; but it spawns only if the hero has the res_spoon


;========================================================
; spawn and init a char
; in:
; c - tile_idx in the room_tiledata array.
; a - char_id * 4
; out:
; a = TILEDATA_RESTORE_TILE
skeleton_quest_init:
			mov b, a
			lda hero_res_spoon
			CPI_ZERO()
			jz @return
			mov a, b
			jmp skeleton_init
@return:
			mvi a, TILEDATA_RESTORE_TILE
			ret