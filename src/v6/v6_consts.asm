;=======================================================
; Ports
;=======================================================
PORT0_OUT_OUT			= $88
PORT0_OUT_IN			= $8a

PORT_TIMER				= $08
TIMER_INIT_CH0			= $36
TIMER_INIT_CH1			= $76
TIMER_INIT_CH2			= $B6
TIMER_PORT_CH0			= $0b
TIMER_PORT_CH1			= $0a
TIMER_PORT_CH2			= $09

PORT_AY_REG				= $15
PORT_AY_DATA			= $14

;=======================================================
; Color
;=======================================================
PALETTE_COLORS			= 16
PALETTE_UPD_REQ_NO		= 0
PALETTE_UPD_REQ_YES		= 1
BORDER_COLOR_IDX		= 1

;=======================================================
; Screen Buffer
;=======================================================
SCR_VERTICAL_OFFSET_DEFAULT = 255

SCR_ADDR				= $8000
SCR_BUFF0_ADDR			= $8000
SCR_BUFF1_ADDR			= $A000
SCR_BUFF2_ADDR			= $C000
SCR_BUFF3_ADDR			= $E000
SCR_BUFF_LEN            = $2000
SCR_BUFFS_LEN			= SCR_BUFF_LEN * 4
BACK_BUFF_ADDR          = $A000
BACK_BUFF2_ADDR         = $A000

;=======================================================
; Ram-disk
;=======================================================
/*
The ram-disk mapping into the RAM memory space
RAM mapping is applied if:
	- RAM mapping is enabled
	- The RAM is accessed via non-stack instructions
	- The address falls within the RAM mapping range associated with the current RAM mapping

Stack mapping is applied if:
	- Stack mapping is enabled
	- The RAM is accessed via stack-related instructions:
		Push, Pop, XTHL, Call, Ret, conditional calls/returns, or RST

Special case:
	If stack mapping is disabled but RAM mapping is enabled, RAM mapping applies to stack operations 
	if the stack address falls within the RAM mapping range.

The ram-disk activation command is E8ASssMM:
	MM: The index of the Ram-Disk 64k page accessed via non-stack instructions (all instructions except mentioned below)
	ss: The index of the RAM-Disk 64k page accessed via stack instructions (Push, Pop, XTHL, Call, Ret, C*, R*, RST)
	S : Enable stack mapping
	A : Enable RAM mapping for range [0xA000-0xDFFF]
	8 : Enable RAM mapping for range [0x8000-0x9FFF]
	E : Enable RAM mapping for range [0xE000-0xFFFF]
	
*/
RAM_DISK0_PORT = 0x10
RAM_DISK1_PORT = 0x11
RAM_DISK2_PORT = 0x20
RAM_DISK3_PORT = 0x21
RAM_DISK4_PORT = 0x40
RAM_DISK5_PORT = 0x41
RAM_DISK6_PORT = 0x80
RAM_DISK7_PORT = 0x81

RAM_DISK_PORT = RAM_DISK1_PORT ; ram-disk1 by default because the ram-disk0 is reserved by the OS

RAM_DISK_OFF_CMD = 0
RAM_DISK_S0 = %00010000
RAM_DISK_S1 = %00010100
RAM_DISK_S2 = %00011000
RAM_DISK_S3 = %00011100

RAM_DISK_M0 = %00000000
RAM_DISK_M1 = %00000001
RAM_DISK_M2 = %00000010
RAM_DISK_M3 = %00000011

RAM_DISK_M_89 = %01000000
RAM_DISK_M_AD = %00100000
RAM_DISK_M_EF = %10000000
RAM_DISK_M_8F = RAM_DISK_M_89 | RAM_DISK_M_AD | RAM_DISK_M_EF
RAM_DISK_M_AF = RAM_DISK_M_AD | RAM_DISK_M_EF

;=======================================================
; Op-codes
;=======================================================
OPCODE_NOP  = 0
OPCODE_XCHG = $eb
OPCODE_RET  = $c9
OPCODE_RC	= $d8
OPCODE_RNC  = $d0
OPCODE_JMP	= $c3
OPCODE_JNZ	= $c2
OPCODE_JC	= $dA
OPCODE_JNC	= $d2
OPCODE_MOV_E_M = $5e
OPCODE_MOV_E_A = $5f
OPCODE_MOV_D_B = $50
OPCODE_MOV_D_M = $56
OPCODE_MOV_D_A = $57
OPCODE_MOV_M_B = $70
OPCODE_MOV_M_A = $77
OPCODE_POP_B = $c1
OPCODE_STC	= $37
OPCODE_INX_D = $13
OPCODE_LXI_H = $21

;=======================================================
; AY-3-8910 sound chip consts
;=======================================================
; regs
AY_REG_TONE_FDIV_CHA_L	= 0 ; LLLLLLLL, channel A tone frequency divider low, FDIV = HHHH * 256 + LLLLLLLL, frq = 1.7734MHz / 16 / FDIV
AY_REG_TONE_FDIV_CHA_H	= 1 ; ----HHHH, channel A tone frequency divider high 
AY_REG_TONE_FDIV_CHB_L	= 2 ; LLLLLLLL, channel B tone frequency divider low 
AY_REG_TONE_FDIV_CHB_H	= 3 ; ----HHHH, channel B tone frequency divider high 
AY_REG_TONE_FDIV_CHC_L	= 4 ; LLLLLLLL, channel C tone frequency divider low 
AY_REG_TONE_FDIV_CHC_H	= 5 ; ----HHHH, channel C tone frequency divider high 
AY_REG_NOISE_FDIV		= 6 ; ---NNNNN, noise frequency divider, FDIV = NNNNN, frq = 1.7734MHz / 16 / FDIV
AY_REG_MIXER			= 7 ; --CBAcba, cba - to mute tone channels, CBA - to mute noise channels, (1 = muted)
AY_REG_VOL_CHA			= 8 ; ---EVVVV, E - envelope (1=enabled), VVVV - master volune
AY_REG_VOL_CHB			= 9 ; ---EVVVV, E - envelope (1=enabled), VVVV - master volune
AY_REG_VOL_CHC			= 10; ---EVVVV, E - envelope (1=enabled), VVVV - master volune
AY_REG_ENV_FDIV_L		= 11; LLLLLLLL, envelope period low, to set the envelope lifetime. the larger the number, the longer the envelope
AY_REG_ENV_FDIV_H		= 12; HHHHHHHH, envelope period high, FDIV = FDIV_H * 256 + FDIV_L
AY_REG_ENV				= 13; ----EEEH, envelope type = EEE, H = 1 means hold
;							envelope type = 0: \_____________, single decay then off
;							envelope type = 1: /|____________, single attack then off
;							envelope type = 2: \|------------, single decay then hold
;							envelope type = 3: /-------------, single attack then hold
;							envelope type = 4: \|\|\|\|\|\|\|, repeated decay
;							envelope type = 5: /|/|/|/|/|/|/|, repeated attack
;							envelope type = 6: /\/\/\/\/\/\/\, repeated attack-decay
;							envelope type = 7: \/\/\/\/\/\/\/, repeated decay-attack 
; mixer masks
AY_REG_MIXER_T_MUTE_CHA = %00000001 ; to mute tone channel A
AY_REG_MIXER_T_MUTE_CHB = %00000010 ; to mute tone channel B
AY_REG_MIXER_T_MUTE_CHC = %00000100 ; to mute tone channel C
AY_REG_MIXER_N_MUTE_CHA = %00001000 ; to mute noise channel A
AY_REG_MIXER_N_MUTE_CHB = %00010000 ; to mute noise channel B
AY_REG_MIXER_N_MUTE_CHC = %00100000 ; to mute noise channel C
; master volume masks
AY_REG_VOL_MASK			= %00001111
AY_REG_VOL_ENV_MASK		= %00010000

;=======================================================
; V6 Engine
;=======================================================
RESTART_ADDR 			= $0000
INT_ADDR	 			= $0038

STACK_LEN				= 32
STACK_MAIN_PROGRAM_ADDR	= 0x8000 - 2 ; because erase funcs can let the interruption call corrupt $7ffe, @7fff bytes.
STACK_INTERRUPTION_ADDR	= STACK_MAIN_PROGRAM_ADDR - STACK_LEN ; it is used by the iterruption func
STACK_MIN_ADDR			= STACK_INTERRUPTION_ADDR - STACK_LEN

BYTE_LEN	= 1
WORD_LEN	= 2
ADDR_LEN	= 2
JMP_4_LEN	= 4

TEMP_BYTE	= $00
TEMP_WORD	= $0000
TEMP_ADDR	= $0000
NULL		= $0
NULL_PTR	= $0

INTS_PER_SEC			= 50 ; Interuptions per sec

; settings
SETTING_OFF	= 0
SETTING_ON	= $ff

;=======================================================
; V6 Runtime Data Buffer
;=======================================================
BUFFERS_END_ADDR	= STACK_MIN_ADDR

;=======================================================
; V6 Debug
;=======================================================

; FPS counter screen addr
FPS_SCR_ADDR = $bdfb - 16
