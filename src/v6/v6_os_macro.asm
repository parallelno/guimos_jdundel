.macro SYS_CALL(func_id, d_addr = 0)
	    mvi c, func_id
		.if d_addr > 0
			lxi d, d_addr
		.endif

		call CPM_BDOS
.endmacro
