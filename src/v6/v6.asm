.org	0x100
jmp v6_main_init

.include "src/v6/v6_macros.asm"
.include "src/v6/v6_consts.asm"
.include "src/game/consts.asm"
.include "build/build_consts.asm"
.include "src/v6/v6_os.asm"
.include "src/v6/v6_utils.asm"
.include "src/v6/v6_controls.asm"
.include "src/v6/v6_interruption.asm"
.include "src/v6/v6_draw_text_mono.asm"
.include "src/v6/v6_draw_text_ex.asm"
.include "src/v6/sound/v6_sound.asm"
.include "src/v6/v6_draw_tile.asm"
.include "src/v6/v6_sprite.asm"
.include "src/v6/v6_sprite_to_scr.asm"
.include "src/v6/v6_sprite_to_backbuf.asm"
.include "src/v6/v6_draw_sprite.asm"
.include "src/v6/v6_draw_sprite_hit.asm"
.include "src/v6/v6_draw_sprite_invis.asm"
.include "build/build_includes.asm"

v6_main_init:
			lxi h, v6_main_reboot
			lxi d, interruption
			call v6_os_init
v6_main_reboot:
			
			call v6_init
			call game_start
			call v6_os_exit

; TODO: use .function to not worry about unused funcs
v6_init:
.if DEBUG
			;clear_ram_disk()
.endif
			ret