; =============================================
; It does not draw a sprite, but saves a return scr addr, width, height
; it is used for invinceble status
; it uses sp to read the sprite data
; ex. CALL_RAM_DISK_FUNC(sprite_draw_invis_vm, __RAM_DISK_S_HERO_ATTACK01 | RAM_DISK_? | RAM_DISK_M_8F)
; input:
; bc	sprite data
; de	screen addr
; use: a, hl, sp
//		IT IS NOT RECOMMENDED TO USE
//		BECAUSE OF THE RISK OF DATA CORRUPTION
//		RAM_DISK_ON_BANK macro must not be used before calling a function!
//		check the reqs of RAM_DISK_ON_BANK_NO_RESTORE before using it here
/*
sprite_draw_invis_vm:	; VM stands for: V - variable height, M - mask support
			; store SP
			lxi h, 0
			dad sp
			shld sprite_draw_restore_sp_ram_disk + 1
			; sp = BC
			mov	h, b
			mov	l, c
			sphl
			xchg
			; b - offset_x
			; c - offset_y
			pop b
			dad b
			; store a sprite screen addr to return it from this func
			shld sprite_draw_scr_addr_ram_disk+1

			; store sprite width and height
			; b - width, c - height
			pop b
			mov d, b
			mov e, c
			xchg
			shld sprite_draw_width_height_ram_disk+1
			jmp sprite_draw_ret_ram_disk
*/