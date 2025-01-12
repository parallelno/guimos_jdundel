			.org	$100
			.include "common/os.asm"
main_init:
			RAM_DISK_OFF()
			 mvi a, OPCODE_JMP
			// sta RESTART_ADDR 			; dissabled besause it was set by the system
			sta INT_ADDR

			lxi h, main_start
			shld RESTART_ADDR + 1
			lxi h, interruption
			shld INT_ADDR + 1
			lxi sp, STACK_MAIN_PROGRAM_ADDR
			
			ei
			jmp main_start