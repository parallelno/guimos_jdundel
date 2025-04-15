jmp v6_main_init

memusage_v6_macros:
.include "asm/v6/v6_macros.asm"
memusage_v6_consts:
.include "asm/v6/v6_consts.asm"
memusage_v6_build_consts:
.include "build/build_consts.asm"
memusage_v6_os:
.include "asm/v6/v6_os.asm"
memusage_v6_utils:
.include "asm/v6/v6_utils.asm"
memusage_v6_controls:
.include "asm/v6/v6_controls.asm"
memusage_v6_interruption:
.include "asm/v6/v6_interruption.asm"
memusage_v6_text_mono_draw:
.include "asm/v6/v6_text_mono_draw.asm"
memusage_v6_text_ex_draw:
.include "asm/v6/v6_text_ex_draw.asm"
memusage_v6_sound:
.include "asm/v6/sound/v6_sound.asm"
memusage_v6_tile_draw:
.include "asm/v6/v6_tile_draw.asm"
memusage_v6_sprite:
.include "asm/v6/v6_sprite.asm"
memusage_v6_sprite_erase:
.include "asm/v6/v6_sprite_erase.asm"
memusage_v6_sprite_copy_to_scr:
.include "asm/v6/v6_sprite_copy_to_scr.asm"
memusage_v6_sprite_copy_to_backbuf:
.include "asm/v6/v6_sprite_copy_to_backbuf.asm"
memusage_v6_sprite_draw:
.include "asm/v6/v6_sprite_draw.asm"
memusage_v6_sprite_draw_hit:
.include "asm/v6/v6_sprite_draw_hit.asm"
memusage_v6_sprite_draw_invis:
.include "asm/v6/v6_sprite_draw_invis.asm"
memusage_v6_tiled_img_draw:
.include "asm/v6/v6_tiled_img_draw.asm"
memusage_v6_decal_draw:
.include "asm/v6/v6_decal_draw.asm"
memusage_v6_back_draw:
.include "asm/v6/v6_back_draw.asm"
memusage_v6_build_uncludes:
.include "build/build_includes.asm"

v6_main_init:
			lxi h, interruption
			call v6_os_init
			call app_start
			call v6_os_exit