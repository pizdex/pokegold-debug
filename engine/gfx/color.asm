INCLUDE "engine/gfx/sgb_layouts.asm"

SHINY_ATK_BIT EQU 5
SHINY_DEF_VAL EQU 10
SHINY_SPD_VAL EQU 10
SHINY_SPC_VAL EQU 10

unk_002_5371:
	dr $9371, $9391

unk_002_5391:
	dr $9391, $93f8

SGB_ApplyPartyMenuHPPals:
	dr $93f8, $9630

CheckCGB:
	dr $9630, $9634

LoadSGBLayoutCGB:
	dr $9634, $9e6d

GetBattlemonBackpicPalettePointer:
	dr $9e6d, $9e7e

GetEnemyFrontpicPalettePointer:
	dr $9e7e, $9e8f

GetPlayerOrMonPalettePointer:
	dr $9e8f, $9e97

GetFrontpicPalettePointer:
	dr $9e97, $9ea8

GetMonPalettePointer:
	dr $9ea8, $9f3a

PushSGBPals:
	dr $9f3a, $9f84

unk_002_5f84:
	dr $9f84, $aff1

unkData_002_6ff1:
	dr $aff1, $b7f1

unkData_002_77f1:
	dr $b7f1, $b8fd

LoadMapPals:
	; Which palette group is based on whether we're outside or inside
	ld a, [wEnvironment]
	and 7
	ld e, a
	ld d, 0
	ld hl, $7982
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	; Futher refine by time of day
	ld a, [wTimeOfDayPal]
	maskbits NUM_DAYTIMES
	add a
	add a
	add a
	ld e, a
	ld d, 0
	add hl, de
	ld e, l
	ld d, h
	ld hl, wBGPals1
	ld b, 8
.outer_loop
	ld a, [de] ; lookup index for TilesetBGPalette
	push de
	push hl
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	ld de, $7a12
	add hl, de
	ld e, l
	ld d, h
	pop hl
	ld c, 1 palettes
.inner_loop
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .inner_loop
	pop de
	inc de
	dec b
	jr nz, .outer_loop
	ld a, [wTimeOfDayPal]
	maskbits NUM_DAYTIMES
	ld bc, 8 palettes
	ld hl, $7b62
	call AddNTimes
	ld de, wOBPals1
	ld bc, 8 palettes
	call CopyBytes

	ld a, [wEnvironment]
	cp TOWN
	jr z, .outside
	cp ROUTE
	ret nz
.outside
	ld a, [wMapGroup]
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	ld de, $7c62
	add hl, de
	ld a, [wTimeOfDayPal]
	maskbits NUM_DAYTIMES
	cp NITE_F
	jr c, .morn_day
rept 4
	inc hl
endr
.morn_day
	ld de, wBGPals1 palette PAL_BG_ROOF color 1
	ld bc, 4
	call CopyBytes
	ret

unkData_002_7982:
	dr $b982, $c000
