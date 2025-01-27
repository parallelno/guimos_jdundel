	; this line for VSCode proper formating


.align GC_BUFFER_SIZE
; these are GC_TASKS buffers GC_BUFFER_SIZE bytes long
; MAST BE ALIGNED by 0x100
v6_gc_buffer:
			.storage GC_BUFFER_SIZE * GC_TASKS
v6_gc_buffer_end:

; task stacks. GC_STACK_SIZE bytes stack long for each tasks
v6_gc_task_stack:
			.storage GC_STACK_SIZE * GC_TASKS
v6_gc_task_stack_end:

; array of task stack pointers. v6_gc_task_sps[i] = taskSP
v6_gc_task_sps:
			.storage GC_TASKS * WORD_LEN
v6_gc_task_sps_end:
 
; points to a current task sp. 
; *v6_gc_current_task_spp = v6_gc_task_sps[current_task]
v6_gc_current_task_spp: 
			.word TEMP_ADDR
			
; bufferN[buffer_idx] data will be send to AY for each register accordingly
v6_gc_buffer_idx:
			.byte TEMP_BYTE
v6_gc_task_id:
			.byte TEMP_BYTE

v6_song_reg_data_ptrs_end: ; contains the end of the array of ptrs to the song reg data
			.word TEMP_ADDR