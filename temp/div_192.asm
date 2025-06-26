
/*
; this divisions can be used to determin what CRT scanline is shown
; context:
; svofski:
; таймер 1.5мгц тактовая, проц 3. значит таймер заряжаешь 59904/2 и у тебя будет по 96 отсчетов на строку
.function div_192_0()
			// division of the value in a range [0,29951] by 96*2
			//int s = n>>8;
    		//int res = (( (s + (s>>2) + (s>>4) + (s>>6))+2)<<1); // error: -2, 3
			mvi b, 0b00111111
			mov d, a
			rrc \ rrc \ ana b
			mov e, a
			rrc \ rrc \ ana b
			mov c, a
			rrc \ rrc \ ana b
			add d
			add e
			add c
			adi 2
			; 22*4=88
.endf

.function div_192_1()
			// division of the value in a range [0,29951] by 96*2
			// int s = n>>8;
    		// int res = (((s + ((s<<2) + (s<<4) + (s<<6))>>4)+4)>>1); // error: -1, 2
			mov e, a
			add a \ add a
			mov c, a
			add a \ add a
			add c
			mov l, a
			adc e
			sub l
			mov h, a

			mvi a, 0x111100
			ani e
			rrc \ rrc
			mov d, a
			rrc \ rrc \ 
			ani 0x00001111

			add d
			add h
			; 28*4=112
.endf
*/