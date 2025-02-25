v6_draw_tiled_img:

TILED_IMG_SCR_BUFFS = 4
TILED_IMG_TILE_H = 8
TILE_IMG_TILE_LEN = TILED_IMG_TILE_H * TILED_IMG_SCR_BUFFS + 2 ; 8*4 bytes + a couple of safety bytes

REPEATER_CODE = $FF


; init the tiled image drawing
; in:
; a - idxs data ram-disk activation command
; c - gfx data ram-disk activation command
; de - idx data addr (points to the addr where it was loaded)
; hl - gfx data addr (points to the addr where it was loaded)
tiled_img_init:
			sta tiled_img_draw_ramdisk_access_idxs + 1
			mov a, c
			sta tiled_img_draw_ramdisk_access_gfx + 1
			; -TILE_IMG_TILE_LEN because there is no tile_gfx associated with idx = 0
			; + PALETTE_LEN because the pallete is palette stored before gfx data
			; + 4 because there are 4 reserved bytes stored before gfx data
			LXI_B(-TILE_IMG_TILE_LEN + PALETTE_LEN + 4)
			dad b
			shld tiled_img_draw_gfx_addr + 1
			xchg
			shld tiled_img_draw_data_addr + 1
			ret

;----------------------------------------------------------------
; draw a tiled image (8x8 tiles)
; input:
; de - local idx_data addr

; if called tiled_img_draw_pos_offset
; in:
; hl - scr_addr_offset
; de - local idx_data addr

tiled_img_draw:
			lxi h, 0
tiled_img_draw_pos_offset_set:
			shld tiled_img_draw_pos_offset + 1
			; de - idx data addr in the ram-disk
tiled_img_draw_data_addr:
			lxi h, TEMP_ADDR
			dad d
			push h
			xchg
tiled_img_draw_ramdisk_access_idxs:
			mvi a, TEMP_BYTE
			push psw
			; a - idx data ram-disk activation command
			; de - points to the idx data len
			call get_word_from_ram_disk
			; bc = idxs_data_len
			lxi d, temp_buff
			pop psw
			pop h
			inx h
			inx h

			; hl - idxs_data addr + 2, because the first two bytes are the length
			; de - temp_buff addr
			; bc - length
			; a - ram-disk activation command
			; copy an image indices into a temp buffer
			mem_copy_from_ram_disk()

tiled_img_draw_ramdisk_access_gfx:
			mvi a, TEMP_BYTE
			RAM_DISK_ON_BANK()
			lxi h, 0x0000
			dad sp
			shld restore_sp + 1

			lxi h, temp_buff

			; get scr addr
			; add scr addr offset
tiled_img_draw_pos_offset:
			lxi b, TEMP_WORD
			mov e, m
			inx h
			mov d, m
			inx h
			xchg
			dad b
			xchg

			; de - scr addr
			; store scr_x for restoration every new line
			mov a, d
			sta tiled_img_draw_restore_scr_x + 1

			; bc - scr addr offset
			; store scr_y_end for checking the end of drawing
			mov a, m
			add c
			inx h
			sta tiled_img_draw_check_end + 1

			; store scr_x_end for checking the end of the line
			mov a, m
			add b
			inx h
			sta tiled_img_draw_check_end_line + 1
			; de - scr addr
			; hl - tile idx data ptr
			
tiled_img_draw_loop:
			; get tile_idx
			mov c, m
			inx h
			; skip if tile_idx = 0
			A_TO_ZERO(NULL)
			ora c
			jz tiled_img_draw_skip
			cpi REPEATER_CODE
			jnz @it_is_idx

			; it is REPEATER_CODE
			; meaning the next two bytes represent
			; idx and repeating counter
			mov c, m
			; c - tile_idx
			inx h
			mov b, m
			inx h

			; skip if tile_idx = 0
			A_TO_ZERO(NULL)
			ora c
			jnz @get_gfx_ptr
			; tile_idx = 0,
			; advance dce to the proper pos, and skip drawing
			; b - repeating counter
			mov a, d
			add b
			mov d, a
			jmp tiled_img_draw_check_end_line
@it_is_idx:
			mvi b, 1

@get_gfx_ptr:
			; c - tile_idx
			; b - repeating counter
			mov a, b
			sta tiled_img_draw_repeating_counter
			; tile gfx ptr = tile_gfxs_ptr + tile_idx * 34
			shld tiled_img_draw_data_ptr + 1
			mov l, c
			mvi h, 0
			; offset = tile_idx * 32
			dad h
			mov c, l
			mov b, h
			dad h
			dad h
			dad h
			dad h
			; offset += tile_idx * 2
			dad b
			; add tile_gfxs_ptr
tiled_img_draw_gfx_addr:
			lxi b, TEMP_ADDR
			dad b
			; hl - tile gfx ptr
			shld @tile_gfx_addr + 1
@repeat:
@tile_gfx_addr:
			lxi h, TEMP_ADDR
			TILED_IMG_DRAW_TILE()
			xchg
			; de - screen addr + $6000
			mov a, d
			adi -$60 + 1
			mov d, a
			; de - scr_addr
			lxi h, tiled_img_draw_repeating_counter
			dcr m
			jnz @repeat
			; restore a pointer to the next tile_idx
tiled_img_draw_data_ptr:
			lxi h, TEMP_ADDR
			; decr d register because to compensate the next inc d after tiled_img_draw_skip
			dcr d
tiled_img_draw_skip:
			; advance pos_x to the next tile
			inr d
tiled_img_draw_check_end_line:
			mvi a, TEMP_BYTE
			cmp d
			jnz tiled_img_draw_loop
tiled_img_draw_restore_scr_x:
			; advance pos to a new line
			mvi d, TEMP_BYTE
			mvi a, TILED_IMG_TILE_H
			add e
			mov e, a
tiled_img_draw_check_end:
			cpi TEMP_BYTE
			jnz tiled_img_draw_loop

			jmp restore_sp

tiled_img_draw_repeating_counter:
			.byte TEMP_BYTE

; min: 42*4 = 168cc
; max: 45*4 = 180cc
.macro TILED_IMG_DRAW_8BYTES(draw_up, advace_to_next_scr = true)
	.if draw_up
		.loop 3
			pop b
			mov m, c
			inr l
			mov m, b
			inr l
		.endloop
			pop b
			mov m, c
			inr l
			mov m, b
	.endif
	.if draw_up == false
		.loop 3
			pop b
			mov m, c
			dcr l
			mov m, b
			dcr l
		.endloop
			pop b
			mov m, c
			dcr l
			mov m, b
	.endif
		.if advace_to_next_scr
			dad d
		.endif
.endmacro

; draw a tile (8x8 pixels in 4 scr buffs)
; input:
; hl - a tile gfx ptr
; de - screen addr
; out:
; hl - screen addr + $6000

; tile gfx format:
; SCR_BUFF0_ADDR : 8 bytes from bottom to top
; SCR_BUFF1_ADDR : 8 bytes from top to bottom
; SCR_BUFF2_ADDR : 8 bytes from bottom to top
; SCR_BUFF3_ADDR : 8 bytes from top to bottom

TILED_IMG_DRAW_UP = true
TILED_IMG_DRAW_DOWN = false

.macro TILED_IMG_DRAW_TILE()
			sphl
			xchg

			lxi d, SCR_BUFF_LEN
			; hl - screen buff addr
			; sp - tile_gfx data
			; de - next scr addr offset

			; copy 32 bytes below takes 684cc
			TILED_IMG_DRAW_8BYTES(TILED_IMG_DRAW_UP)
			TILED_IMG_DRAW_8BYTES(TILED_IMG_DRAW_DOWN)
			TILED_IMG_DRAW_8BYTES(TILED_IMG_DRAW_UP)
			TILED_IMG_DRAW_8BYTES(TILED_IMG_DRAW_DOWN, false)

			lxi sp, STACK_SAFE_ADDR
.endmacro

v6_tiled_img_draw_end: