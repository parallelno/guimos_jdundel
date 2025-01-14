.org	$100
jmp main_init

.include "v6/v6_macro.asm"
.include "v6/v6_consts.asm"
.include "v6/v6_debug.asm" ; has to be included after v6_consts.asm
.include "v6/v6_os.asm"
.include "v6/v6_utils.asm"
.include "v6/v6_controls.asm"
.include "v6/v6_interruption.asm"
.include "v6/v6_mono_text.asm"

main_init:
			lxi h, @reboot
			lxi d, interruption
			call v6_os_init
@reboot:
			call v6_init
			call game_init
			call v6_os_exit

; TODO: use .function to not worry about unused funcs
; TODO: add a script that removes ret command that .function adds
v6_init:
			ret