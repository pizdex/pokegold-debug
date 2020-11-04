InitSpriteAnimStruct::
	ld [wAnimatedObjectStructIDBuffer], a
	ldh a, [hROMBank]
	push af

	ld a, $23
	rst Bankswitch
	ld a, [wAnimatedObjectStructIDBuffer]

	call $525a

	pop af
	rst Bankswitch

	ret

ReinitSpriteAnimFrame::
	ld [wAnimatedObjectStructIDBuffer], a
	ldh a, [hROMBank]
	push af

	ld a, $23
	rst Bankswitch
	ld a, [wAnimatedObjectStructIDBuffer]

	call $5395

	pop af
	rst Bankswitch

	ret
