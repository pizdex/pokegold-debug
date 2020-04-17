INCBIN "baserom.gbc",$8000,$df7

_Sine::
	ld a, e
	and $3f
	cp $20
	jr nc, .negative
	call .GetSine
	ld a, h
	ret
.negative
	and $1f
	call .GetSine
	ld a, h
	xor $ff
	inc a
	ret

.GetSine:
	ld e, a
	ld a, d
	ld d, $0
	ld hl, .SineWave
	add hl, de
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, $0
.loop
	srl a
	jr nc, .no_add
	add hl, de
.no_add
	sla e
	rl d
	and a
	jr nz, .loop
	ret

.SineWave:
	sine_table $100

GetPredefPointer::
	dr $8e69, $bfff
