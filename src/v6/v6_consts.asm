; interuptions per sec
INTS_PER_SEC			= 50

; hardware
PORT0_OUT_OUT			= $88
PORT0_OUT_IN			= $8a

PALETTE_COLORS			= 16
PALETTE_UPD_REQ_NO		= 0
PALETTE_UPD_REQ_YES		= 1
BORDER_COLOR_IDX		= 1

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

; screen buffer
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

; ram-disk
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

SEGMENT_0000_7F00_ADDR = 0x0000
SEGMENT_8000_0000_ADDR = 0x8000

SEGMENT_0000_7F00_SIZE_MAX = 2 ^ 31 - 256 ; because an interruption can corrupt the ram-disk memory from STACK_MIN_ADDR to STACK_TEMP_ADDR
SEGMENT_8000_0000_SIZE_MAX = 2 ^ 31

; opcodes
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

;=============================================================================
;


;=======================================================
; Runtime Data Buffer
;=======================================================
BUFFERS_END_ADDR	= STACK_MIN_ADDR


;=======================================================
; Debug related
;=======================================================

; FPS counter screen addr
FPS_SCR_ADDR = $bdfb - 16