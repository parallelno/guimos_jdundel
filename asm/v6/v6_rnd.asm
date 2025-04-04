
; 16-bit xorshift pseudorandom number generator
; http://www.retroprogramming.com/2017/07/xorshift-pseudorandom-numbers-in-z80.html?m=1

; out:   
; hl - 16-bit pseudo-random number
; a = h
; cc - 116
; TODO: optimization. check if the faster rnd solutions gives good enough result.
random:
			lxi h, 1       ; seed must not be 0
			mov a, h
			rar
			mov a, l
			rar
			xra h
			mov h, a
			mov a, l
			rar
			mov a, h
			rar
			xra l
			mov l, a
			xra h
			mov h, a
			shld random+1
			ret

/*
; 8-bit pseudo rnd. it uses 256 bytes of a main program as a seed.
; use:
; hl
; out:
; a - random number
; cc - 84
random:
@mainCodeAddr:
			lxi h, $100
@rnd:
			sbi 1
			rrc
			xra m
			inr l
			sbb m
			shld @mainCodeAddr+1
			sta @rnd+1
			ret
*/

/*
; An 8-bit pseudo-random number generator,
; R = random number seed an integer in the range [1, 256]
; R -> (33*R) mod 257
; S = R - 1
; an 8-bit unsigned integer. 256 period
; http://www.z80.info/pseudo-random.txt
; cc - 60
RndVal		.byte 34
random:
			lxi	h, RndVal
			mov a, m
			rrc
			rrc
			rrc
			xri $1f
			add m
			sbi 255
			mov m, a
			ret
*/
/*
; Highway Encounter game 8-bit pseudo random number. 
; 256 period: X[1] = X[0] * 5 + 7
; I: -
; O: A=RND
; M: HL, AF
; cc - 52
RndVal		.byte 1
random:
			lxi	h, RndVal
			mov	a, m
			add	a
			add	a
			add	m
			adi	7
			mov	m, a
			ret            
*/
