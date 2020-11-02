Reset::
    call $3d21
    xor a
    ldh [hMapAnims], a
    call $3577
    ei

    ld hl, wd8ad
	set 7, [hl]

	ld c, 32
	call DelayFrames

	jr Init

_Start::
	cp $11
	jr z, .cgb
	xor a
	jr .load

.cgb
	ld a, 1

.load
	ldh [hCGB], a

Init::
	di

	xor a
	ldh [rIF], a
	ldh [rIE], a
	ldh [rRP], a
	ldh [rSCX], a
	ldh [rSCY], a
	ldh [rSB], a
	ldh [rSC], a
	ldh [rWX], a
	ldh [rWY], a
	ldh [rBGP], a
	ldh [rOBP0], a
	ldh [rOBP1], a
	ldh [rTMA], a
	ldh [rTAC], a
    ld [wcf1f], a

	ld a, %100 ; Start timer at 4096Hz
	ldh [rTAC], a

.wait
	ldh a, [rLY]
	cp LY_VBLANK + 1
	jr nz, .wait

	xor a
	ldh [rLCDC], a

; Clear WRAM bank 0
	ld hl, WRAM0_Begin
	ld bc, $2000
.ByteFill:
	ld [hl], 0
	inc hl
	dec bc
	ld a, b
	or c
	jr nz, .ByteFill

    ld sp, wdfff

	call ClearVRAM
	ldh a, [hCGB]
	push af
	xor a
	ld hl, HRAM_Begin
	ld bc, HRAM_End - HRAM_Begin
	call $31b9
	pop af
	ldh [hCGB], a

    call $316c

    ld a, $01
    rst $10

    call $403a

	xor a
	ldh [hMapAnims], a
	ldh [hSCX], a
	ldh [hSCY], a
	ldh [rJOYP], a

	ld a, $8 ; HBlank int enable
	ldh [rSTAT], a

	ld a, $90
	ldh [hWY], a
	ldh [rWY], a

	ld a, 7
	ldh [hWX], a
	ldh [rWX], a

	ld a, CONNECTION_NOT_ESTABLISHED
	ldh [hLinkPlayerNumber], a

    ld h, $98
    call $0698
    ld h, $9c
    call $0698

    ld hl, $5fc1
    ld a, $02
    rst $08

    ld a, $9c
    ldh [$d9], a
    xor a
    ldh [hBGMapAddress], a

    ld a, $05
    ld hl, $4089
    rst $08

	ld a, SRAM_ENABLE
	ld [MBC3SRamEnable], a
	ld a, SRAM_DISABLE
	ld [MBC3LatchClock], a
	ld [MBC3SRamEnable], a

	ld a, LCDC_DEFAULT ; %11100011
	; LCD on
	; Win tilemap 1
	; Win on
	; BG/Win tiledata 0
	; BG Tilemap 0
	; OBJ 8x8
	; OBJ on
	; BG on
	ldh [rLCDC], a

	ld a, $1f
	ldh [rIE], a
	ei

	call DelayFrame

    ld a, $30
    call Predef

    call $3d21
    xor a
    ld [wMapMusic], a
    jp $676d

ClearVRAM::
	ld hl, VRAM_Begin
	ld bc, VRAM_End - VRAM_Begin
	xor a
    call $31b9
    ret

BlankBGMap::
	ld a, $7f
	jr FillBGMap.asm_69e

FillBGMap::
	ld a, l
.asm_69e
	ld de, $0400
	ld l, e
.loop
	ld [hli], a
	dec e
	jr nz, .loop
	dec d
	jr nz, .loop
	ret
