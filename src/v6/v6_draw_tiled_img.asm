v6_draw_tiled_img:

TILED_IMG_SCR_BUFFS = 4
TILED_IMG_TILE_H = 8
TILE_IMG_TILE_LEN = TILED_IMG_TILE_H * TILED_IMG_SCR_BUFFS + 2 ; 8*4 bytes + a couple of safety bytes

REPEATER_CODE = $FF
EOF_CODE = $FFFF


; init the tiled image drawing
; in:
; a - idxs data ram-disk activation command
; c - gfx data ram-disk activation command
; de - idx data ptr
; hl - gfx data addr
.function tiled_img_init()
			sta draw_tiled_img_ramdisk_access_idxs + 1
			mov a, c
			sta draw_tiled_img_ramdisk_access_gfx + 1
			; -TILE_IMG_TILE_LEN because there is no tile_gfx associated with idx = 0
			; + PALETTE_LEN because the pallete is palette stored before gfx data
			; + 4 because there are 4 reserved bytes stored before gfx data
			LXI_B(-TILE_IMG_TILE_LEN + PALETTE_LEN + 4)
			dad b
			shld draw_tiled_img_gfx_addr + 1
			xchg
			shld draw_tiled_img_data_addr + 1
			;ret
.endf

;----------------------------------------------------------------
; draw a tiled image (8x8 tiles)
; input:
; de - idx_data addr

; if called draw_tiled_img_pos_offset
; in: 
; hl - scr_addr_offset
; de - idx_data addr

draw_tiled_img:
			lxi h, 0
draw_tiled_img_pos_offset_set:
			shld draw_tiled_img_pos_offset + 1
			; de - idx data addr in the ram-disk
draw_tiled_img_data_addr:
			lxi h, TEMP_ADDR
			dad d			
			push h
			xchg
draw_tiled_img_ramdisk_access_idxs:	
			mvi a, TEMP_BYTE
			push psw
			; a - idx data ram-disk activation command
			; de - points to the idx data len
			call get_word_from_ram_disk
			; bc = idxs_data_len
			lxi d, tiled_img_idxs
			pop psw
			pop h
			inx h
			inx h

			; hl - idxs_data addr + 2, because the first two bytes are the length
			; de - tiled_img_idxs temp buffer addr
			; bc - length
			; a - ram-disk activation command
			; copy an image indices into a temp buffer			
			mem_copy_from_ram_disk()

draw_tiled_img_ramdisk_access_gfx:
			mvi a, TEMP_BYTE
			RAM_DISK_ON_BANK()

			lxi h, tiled_img_idxs

			; get scr addr
			; add scr addr offset	
draw_tiled_img_pos_offset:
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
			sta draw_tiled_img_restore_scr_x + 1

			; bc - scr addr offset
			; store scr_y_end for checking the end of drawing
			mov a, m
			add c
			inx h
			sta draw_tiled_img_check_end + 1

			; store scr_x_end for checking the end of the line
			mov a, m
			add b
			inx h
			sta draw_tiled_img_check_end_line + 1
			; de - scr addr
			; hl - tile idx data ptr
draw_tiled_img_loop:
			; get tile_idx
			mov c, m
.breakpoint
			inx h
			; skip if tile_idx = 0
			A_TO_ZERO(NULL)
			ora c
			jz draw_tiled_img_skip
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
			jmp draw_tiled_img_check_end_line
@it_is_idx:
			mvi b, 1

@get_gfx_ptr:
			; c - tile_idx
			; b - repeating counter
			mov a, b
			sta draw_tiled_img_repeating_counter
			; tile gfx ptr = tile_gfxs_ptr + tile_idx * 34
			shld draw_tiled_img_data_ptr + 1
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
draw_tiled_img_gfx_addr:
			lxi b, TEMP_ADDR
			dad b
			; hl - tile gfx ptr
			shld @tile_gfx_addr + 1
@repeat:
@tile_gfx_addr:
			lxi h, TEMP_ADDR
.breakpoint			
			TILED_IMG_DRAW_TILE()
			xchg
			; de - screen addr + $6000
			mov a, d
			adi -$60 + 1
			mov d, a
			; de - scr_addr
			lxi h, draw_tiled_img_repeating_counter
			dcr m
			jnz @repeat
			; restore a pointer to the next tile_idx
draw_tiled_img_data_ptr:
			lxi h, TEMP_ADDR
			; decr d register because to compensate the next inc d after draw_tiled_img_skip
			dcr d
draw_tiled_img_skip:
			; advance pos_x to the next tile
			inr d
draw_tiled_img_check_end_line:
			mvi a, TEMP_BYTE
			cmp d
			jnz draw_tiled_img_loop
draw_tiled_img_restore_scr_x:
			; advance pos to a new line
			mvi d, TEMP_BYTE
			mvi a, TILED_IMG_TILE_H
			add e
			mov e, a
draw_tiled_img_check_end:
			cpi TEMP_BYTE
			jnz draw_tiled_img_loop

			RAM_DISK_OFF()
			ret

draw_tiled_img_repeating_counter:
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

			lxi d, $2000
			; hl - screen buff addr
			; sp - tile_gfx data
			; de - next scr addr offset

			; copy 32 bytes below takes 684cc
			TILED_IMG_DRAW_8BYTES(TILED_IMG_DRAW_UP)
			TILED_IMG_DRAW_8BYTES(TILED_IMG_DRAW_DOWN)
			TILED_IMG_DRAW_8BYTES(TILED_IMG_DRAW_UP)
			TILED_IMG_DRAW_8BYTES(TILED_IMG_DRAW_DOWN, false)

			lxi sp, 0x0002 ; set SP to addr imunne to potential data corruption
.endmacro

v6_draw_tiled_img_end: