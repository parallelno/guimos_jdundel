.macro SYS_CALL_D(func_id, d_addr)
	    mvi c, func_id
		lxi d, d_addr
		call CPM_BDOS
.endmacro

.macro SYS_CALL(func_id)
	    mvi c, func_id
		call CPM_BDOS
.endmacro
