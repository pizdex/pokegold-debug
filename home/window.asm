RefreshScreen::
	call $1df6
	ldh a, [hROMBank]
	push af
	ld a, 1 ; aka BANK(LoadFonts_NoOAMUpdate)
	rst Bankswitch

	call $6779
	call $2f50
	call $67f3

	pop af
	rst Bankswitch
	ret

CloseText::
	ldh a, [hOAMUpdate]
	push af
	ld a, 1
	ldh [hOAMUpdate], a

	call .CloseText

	pop af
	ldh [hOAMUpdate], a
	ret

.CloseText:
	call $1df6
	xor a
	ldh [$d6], a
	call $1fe2
	call $2f50
	xor a
	ldh [$d6], a
	call $2f5e
	ld a, $90
	ldh [$d4], a
	ld a, $05
	ld hl, $412e
	rst $08
	call $0d80
	ld hl, $d558
	res 7, [hl]
	call $1e8f
	ret

OpenText::
	call $1df6
	ldh a, [hROMBank]
	push af
	ld a, 1 ; aka BANK(LoadFonts_NoOAMUpdate)
	rst Bankswitch

	call $6779 ; clear bgmap
	call $0f17
	call _OpenAndCloseMenu_HDMATransferTilemapAndAttrmap ; anchor bgmap
	call $67f3 ; load font
	pop af
	rst Bankswitch

	ret

_OpenAndCloseMenu_HDMATransferTilemapAndAttrmap::
	ldh a, [hOAMUpdate]
	push af
	ld a, 1
	ldh [hOAMUpdate], a

	call $34a1

	pop af
	ldh [hOAMUpdate], a
	ret

SafeUpdateSprites::
	ldh a, [hOAMUpdate]
	push af
	ldh a, [hBGMapMode]
	push af
	xor a
	ldh [hBGMapMode], a
	ld a, 1
	ldh [hOAMUpdate], a

	call $193c

	xor a
	ldh [hOAMUpdate], a
	call DelayFrame
	pop af
	ldh [hBGMapMode], a
	pop af
	ldh [hOAMUpdate], a
	ret

; unused
	scf
	ret
