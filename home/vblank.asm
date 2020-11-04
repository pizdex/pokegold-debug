; VBlank is the interrupt responsible for updating VRAM.

VBlank::
	push af
	push bc
	push de
	push hl

	ldh a, [hVBlank]
	and 7

	ld e, a
	ld d, 0
	ld hl, .VBlanks
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld de, .return
	push de
	jp hl

.return:
	call GameTimer

	pop hl
	pop de
	pop bc
	pop af
	reti

.VBlanks:
	dw VBlank0
	dw VBlank1
	dw VBlank2
	dw VBlank3
	dw VBlank4
	dw VBlank5
	dw VBlank0
	dw VBlank0 ; just in case

VBlank0::
; normal operation

; rng
; scx, scy, wy, wx
; bg map buffer
; palettes
; dma transfer
; bg map
; tiles
; oam
; joypad
; sound

	; inc frame counter
	ld hl, hVBlankCounter
	inc [hl]

	; advance random variables
	ldh a, [rDIV]
	ld b, a
	ldh a, [hRandomAdd]
	adc b
	ldh [hRandomAdd], a

	ldh a, [rDIV]
	ld b, a
	ldh a, [hRandomSub]
	sbc b
	ldh [hRandomSub], a

	ldh a, [hROMBank]
	ld [$d147], a

	ldh a, [hSCX]
	ldh [rSCX], a
	ldh a, [hSCY]
	ldh [rSCY], a
	ldh a, [hWY]
	ldh [rWY], a
	ldh a, [hWX]
	ldh [rWX], a

	; There's only time to call one of these in one vblank.
	; Calls are in order of priority.

	call $142d
	jr c, .done
	call $0bc8
	jr c, .done

	call $1490
	call $157d
	call $1526
	call $15d8
	call $160f

.done
	ldh a, [hOAMUpdate]
	and a
	jr nz, .done_oam
	call hTransferVirtualOAM

.done_oam
	; vblank-sensitive operations are done

	xor a
	ld [$cf1e], a

	ld a, [$cf1c]
	and a
	jr z, .ok
	dec a
	ld [$cf1c], a

.ok
	ld a, [$cf1d]
	and a
	jr z, .ok2
	dec a
	ld [$cf1d], a

.ok2
	call $08e5

	ld a, $3a
	rst Bankswitch
	call $405c
	ld a, [$d147]
	rst Bankswitch

	ldh a, [hSeconds]
	ldh [hSecondsBackup], a

	ret

VBlank1::
; scx, scy
; palettes
; bg map
; tiles
; oam
; sound / lcd stat
	ldh a, [$9f]
	ld [$d147], a
	ldh a, [$d1]
	ldh [rSCX], a
	ldh a, [$d2]
	ldh [rSCY], a
	call $023e
	jr c, jr_000_020f

	call $1490
	call $157d
	call $ff80

jr_000_020f:
	xor a
	ld [$cf1e], a
	ldh a, [rIF]
	ld b, a
	xor a
	ldh [rIF], a
	ld a, $02
	ldh [rIE], a
	ld a, b
	and $08
	or $02
	ldh [rIF], a
	ei
	ld a, $3a
	rst $10
	call $405c
	ld a, [$d147]
	rst $10
	di
	ldh a, [rIF]
	ld b, a
	xor a
	ldh [rIF], a
	ld a, $1f
	ldh [rIE], a
	ld a, b
	ldh [rIF], a
	ret

UpdatePals::
; update pals for either dmg or cgb
	ldh a, [$e8]
	and a
	jp nz, $0bcc

	ld a, [$cf6d]
	ldh [rBGP], a
	ld a, [$cf6e]
	ldh [rOBP0], a
	ld a, [$cf6f]
	ldh [rOBP1], a
	and a
	ret

VBlank4::
; bg map
; tiles
; oam
; joypad
; serial
; sound

	ldh a, [$9f]
	ld [$d147], a
	call $1490
	call $157d
	call $ff80
	call $08e5
	xor a
	ld [$cf1e], a
	call $1ee0
	ld a, $3a
	rst $10
	call $405c
	ld a, [$d147]
	rst $10
	ret


VBlank5::
; scx
; palettes
; bg map
; tiles
; joypad

	ldh a, [$9f]
	ld [$d147], a
	ldh a, [$d1]
	ldh [rSCX], a
	call $0bc8
	jr c, jr_000_028c

	call $1490
	call $157d

jr_000_028c:
	xor a
	ld [$cf1e], a
	call $08e5
	xor a
	ldh [rIF], a
	ld a, $02
	ldh [rIE], a
	ldh [rIF], a
	ei
	ld a, $3a
	rst $10
	call $405c
	ld a, [$d147]
	rst $10
	di
	xor a
	ldh [rIF], a
	ld a, $1f
	ldh [rIE], a
	ret

VBlank2::
; sound only

	ldh a, [$9f]
	ld [$d147], a
	ld a, $3a
	rst $10
	call $405c
	ld a, [$d147]
	rst $10
	xor a
	ld [$cf1e], a
	ret

VBlank3::
; scx, scy
; palettes
; bg map
; tiles
; oam
; sound / lcd stat

	ldh a, [$9d]
	inc a
	ldh [$9d], a
	ldh a, [rDIV]
	ld b, a
	ldh a, [$e3]
	adc b
	ldh [$e3], a
	ldh a, [rDIV]
	ld b, a
	ldh a, [$e4]
	sbc b
	ldh [$e4], a
	call $08e5
	ldh a, [$9f]
	ld [$d147], a
	ldh a, [$d1]
	ldh [rSCX], a
	ldh a, [$d2]
	ldh [rSCY], a
	ldh a, [$d4]
	ldh [rWY], a
	ldh a, [$d3]
	ldh [rWX], a
	call $1490
	call $142d
	call $157d
	call $1526
	call $15d8
	call $ff80
	xor a
	ld [$cf1e], a
	ld a, [$cf1d]
	and a
	jr z, jr_000_0311

	dec a
	ld [$cf1d], a

jr_000_0311:
	xor a
	ldh [rIF], a
	ld a, $02
	ldh [rIE], a
	ldh [rIF], a
	ei
	ld a, $3a
	rst $10
	call $405c
	ld a, [$d147]
	rst $10
	di
	xor a
	ldh [rIF], a
	ld a, $1f
	ldh [rIE], a
	ret