_LoadStandardFont::
	ld de, Font
	ld hl, vTiles1
	lb bc, BANK(Font), 128
    jp Get1bpp

_LoadFontsExtra::
    ld de, $518a
	ld hl, vTiles2 tile $60
    ld bc, $3e02
    call Get1bpp
    ld de, $4ea2
    ld hl, $9620
    ld bc, $3e01
    call Get2bpp
    ld de, $4122
	ld hl, vTiles2 tile $63
    ld bc, $3e16
    call Get2bpp
    jr LoadFrame

_LoadFontsBattleExtra::
    ld de, $46f2
	ld hl, vTiles2 tile $60
    ld bc, $3e19
    call Get2bpp
    jr LoadFrame

LoadFrame:
    ld a, [wTextboxFrame]
    and $07
	ld bc, 6 * LEN_1BPP_TILE
    ld hl, $48f2
    call AddNTimes
	ld d, h
	ld e, l
	ld hl, vTiles2 tile "┌" ; $79
    ld bc, $3e06
    call Get1bpp
	ld hl, vTiles2 tile " " ; $7f
    ld de, $5182
    ld bc, $3e01
    call Get1bpp
    ret

unk_03e_4066:
    ld de, $46f2
    ld hl, $9600
    ld bc, $3e0c
    call Get2bpp
    ld hl, $9700
    ld de, $47f2
    ld bc, $3e03
    call Get2bpp
    call LoadFrame
    ld de, $4bb2
    ld hl, $96c0
    ld bc, $3e04
    call Get1bpp
    ld de, $4bd2
    ld hl, $9730
    ld bc, $3e06
    call Get1bpp
    ld de, $4c02
    ld hl, $9550
    ld bc, $3e09
    call Get2bpp
    ret

unk_03e_40a6:
    call _LoadFontsBattleExtra
    ld de, $4bb2
    ld hl, $96c0
    ld bc, $3e04
    call Get1bpp
    ld de, $4bd2
    ld hl, $9780
    ld bc, $3e01
    call Get1bpp
    ld de, $4bea
    ld hl, $9760
    ld bc, $3e02
    call Get1bpp
    ld de, $4c02
    ld hl, $9550
    ld bc, $3e08
    call Get2bpp
    ld de, $4aa2
    ld hl, $9310
    ld bc, $3e11
    call Get2bpp
    ret

unk_03e_40e6:
    ld de, $47d2
    ld hl, $96e0
    ld bc, $3e01
    jp Get2bpp

INCLUDE "gfx/font.asm"

unk_03e_744a:
    call LoadFrame
    ld hl, wd55c
    bit 0, [hl]
    jr z, jr_03e_746d

    ld hl, vTiles2 tile $66
    ld de, $46a2
    ld bc, $3e0a
    call Get1bpp

    ld hl, vTiles2 tile $70
    ld de, $40f2
    ld bc, $3e06
    call Get2bpp
    ret

jr_03e_746d:
    ld hl,vTiles2 tile $66
    ld de, $46a2
    ld bc, $3e0a
    call Get1bpp

    ld hl, vTiles2 tile $70
    ld de, $7492
    ld bc, $3e01
    call Get1bpp

    ld hl, vTiles2 tile $71
    ld de, $4e22
    ld bc, $3e09
    call Get2bpp
    ret

unkData_03e_7492:
	dr $fb492,$fc000
