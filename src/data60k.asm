.org	0x00
main_start:
	//.memory "fill" 0, 0x400, 0xFF
.generate "bouncewave", $00, $ff, $1000, 1
.generate "bouncewave", $00, $7f, $1000, 1
.generate "bouncewave", $00, $4f, $1000, 1
.generate "bouncewave", $00, $2f, $1000, 1

.generate "bouncewave", $00, $ff, $1000, 1
.generate "bouncewave", $00, $7f, $1000, 1
.generate "bouncewave", $00, $4f, $1000, 1
.generate "bouncewave", $00, $2f, $1000, 1

.generate "bouncewave", $00, $ff, $1000, 1
.generate "bouncewave", $00, $7f, $1000, 1
