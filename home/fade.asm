; Functions to fade the screen in and out.

Unreferenced_Function360::
; TimeOfDayFade
	ld a, [$d55b]
	ld b, a
	ld hl, IncGradGBPalTable_11
	ld a, l
	sub b
	ld l, a
	jr nc, .okay
	dec h

.okay
	ld a, [hli]
	ldh [rBGP], a
	ld a, [hli]
	ldh [rOBP0], a
	ld a, [hli]
	ldh [rOBP1], a
	ret

RotateFourPalettesRight::
	ldh a, [hCGB]
	and a
	jr z, .dmg
	ld hl, IncGradGBPalTable_00
	ld b, 4
	jr RotatePalettesRight

.dmg
	ld hl, IncGradGBPalTable_08
	ld b, 4
	jr RotatePalettesRight

RotateThreePalettesRight::
	ldh a, [hCGB]
	and a
	jr z, .dmg
	ld hl, IncGradGBPalTable_05
	ld b, 3
	jr RotatePalettesRight

.dmg
	ld hl, IncGradGBPalTable_13
	ld b, 3

RotatePalettesRight::
; Rotate palettes to the right and fill with loaded colors from the left
; If we're already at the leftmost color, fill with the leftmost color
	push de
	ld a, [hli]
	call $0c4a
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	call $0c6c
	ld c, $08
	call $033c
	pop de
	dec b
	jr nz, RotatePalettesRight

	ret

RotateFourPalettesLeft::
	ldh a, [$e8]
	and a
	jr z, jr_000_03bd

	ld hl, $03f6
	ld b, $04
	jr RotatePalettesLeft

jr_000_03bd:
	ld hl, $040e
	ld b, $04
	jr RotatePalettesLeft

RotateThreePalettesLeft::
	ldh a, [$e8]
	and a
	jr z, jr_000_03d0

	ld hl, $03ff
	ld b, $03
	jr RotatePalettesLeft

jr_000_03d0:
	ld hl, $0417
	ld b, $03

RotatePalettesLeft::
; Rotate palettes to the left and fill with loaded colors from the right
; If we're already at the rightmost color, fill with the rightmost color
	push de
	ld a, [hld]
	ld d, a
	ld a, [hld]
	ld e, a
	call $0c6c
	ld a, [hld]
	call $0c4a
	ld c, $08
	call $033c
	pop de
	dec b
	jr nz, RotatePalettesLeft
	ret


IncGradGBPalTable_00:: dc 3,3,3,3, 3,3,3,3, 3,3,3,3
IncGradGBPalTable_01:: dc 3,3,3,2, 3,3,3,2, 3,3,3,2
IncGradGBPalTable_02:: dc 3,3,2,1, 3,3,2,1, 3,3,2,1
IncGradGBPalTable_03:: dc 3,2,1,0, 3,2,1,0, 3,2,1,0

IncGradGBPalTable_04:: dc 3,2,1,0, 3,2,1,0, 3,2,1,0
IncGradGBPalTable_05:: dc 2,1,0,0, 2,1,0,0, 2,1,0,0
IncGradGBPalTable_06:: dc 1,0,0,0, 1,0,0,0, 1,0,0,0

IncGradGBPalTable_07:: dc 0,0,0,0, 0,0,0,0, 0,0,0,0
;                           bgp      obp1     obp2
IncGradGBPalTable_08:: dc 3,3,3,3, 3,3,3,3, 3,3,3,3
IncGradGBPalTable_09:: dc 3,3,3,2, 3,3,3,2, 3,3,2,0
IncGradGBPalTable_10:: dc 3,3,2,1, 3,2,1,0, 3,2,1,0
IncGradGBPalTable_11:: dc 3,2,1,0, 3,1,0,0, 3,2,0,0

IncGradGBPalTable_12:: dc 3,2,1,0, 3,1,0,0, 3,2,0,0
IncGradGBPalTable_13:: dc 2,1,0,0, 2,0,0,0, 2,1,0,0
IncGradGBPalTable_14:: dc 1,0,0,0, 1,0,0,0, 1,0,0,0

IncGradGBPalTable_15:: dc 0,0,0,0, 0,0,0,0, 0,0,0,0