DoItemEffect::
	ld a, $03
	ld hl, $6aae
	rst FarCall
	ret

CheckTossableItem::
	push hl
	push de
	push bc
	ld a, $03
	ld hl, $5703
	rst FarCall
	pop bc
	pop de
	pop hl
	ret

TossItem::
	push hl
	push de
	push bc
	ldh a, [hROMBank]
	push af
	ld a, $03
	rst Bankswitch
	call $54e9
	pop bc
	ld a, b
	rst Bankswitch
	pop bc
	pop de
	pop hl
	ret

ReceiveItem::
	push bc
	ldh a, [hROMBank]
	push af
	ld a, $03
	rst Bankswitch
	push hl
	push de
	call $54b1
	pop de
	pop hl
	pop bc
	ld a, b
	rst Bankswitch
	pop bc
	ret

CheckItem::
	push hl
	push de
	push bc
	ldh a, [hROMBank]
	push af
	ld a, $03
	rst Bankswitch
	call $5520
	pop bc
	ld a, b
	rst Bankswitch
	pop bc
	pop de
	pop hl
	ret
