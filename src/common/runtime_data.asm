;==================================================
; Gobal runtime data
;==================================================

; contains the current RAM-disk mode
; to restore by the interrupt routine after its execution
ram_disk_mode:
    .byte 0

; temporally contains the disk number to restore it before returning to os
; RDS_DISK in os_consts.asm for more details
os_disk_tmp:
    .byte 0

;==================================================
; Game runtime data
;==================================================
.include "game_vars.asm"