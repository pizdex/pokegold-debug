	const_def $6a
	const DEBUGTEST_TICKS_1 ; $6a
	const DEBUGTEST_TICKS_2 ; $6b
	const DEBUGTEST_WHITE   ; $6c
	const DEBUGTEST_LIGHT   ; $6d
	const DEBUGTEST_DARK    ; $6e
	const DEBUGTEST_BLACK   ; $6f
	const DEBUGTEST_0       ; $70
	const DEBUGTEST_1       ; $71
	const DEBUGTEST_2       ; $72
	const DEBUGTEST_3       ; $73
	const DEBUGTEST_4       ; $74
	const DEBUGTEST_5       ; $75
	const DEBUGTEST_6       ; $76
	const DEBUGTEST_7       ; $77
	const DEBUGTEST_8       ; $78
	const DEBUGTEST_9       ; $79
	const DEBUGTEST_A       ; $7a
	const DEBUGTEST_B       ; $7b
	const DEBUGTEST_C       ; $7c
	const DEBUGTEST_D       ; $7d
	const DEBUGTEST_E       ; $7e
	const DEBUGTEST_F       ; $7f

DebugColorPicker:
	ldh a, [hCGB]
	and a
	jr nz, .set

	ldh a, [hSGB]
	and a
	ret z
.set
	ldh a, [hInMenu]
	push af
	ld a, 1
	ldh [hInMenu], a

	call DisableLCD

	call DebugColor_InitVRAM
	call DebugColor_LoadGFX
	call DebugColor_InitPalettes
	call DebugColor_InitMonColor

	call EnableLCD

	ld de, MUSIC_NONE
	call PlayMusic

	xor a
	ld [wJumptableIndex], a
	ld [wce5a], a
	ld [wcf22], a

.loop:
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .exit

	call DebugColorMain
	call DebugColor_PlaceCursor
	call DelayFrame
	jr .loop

.exit
	pop af
	ldh [hInMenu], a
	ret

DebugColor_InitMonColor:
	ld a, [wcf21]
	and a
	jr nz, DebugColor_InitTrainerColor

	ld hl, $6ff1 ; PokemonPalettes
DebugColor_InitMonColor2:
	ld de, wOverworldMapBlocks
	ld c, NUM_POKEMON + 1
.loop:
	push bc
	push hl

	call DebugColor_InitColor

	pop hl
	ld bc, 8
	add hl, bc

	pop bc
	dec c
	jr nz, .loop
	ret

DebugColor_InitTrainerColor:
	ld hl, $77f1 ; TrainerPalettes
	ld de, wOverworldMapBlocks
	ld c, NUM_TRAINER_CLASSES
.loop
	push bc
	push hl

	call DebugColor_InitColor

	pop hl
	ld bc, 4
	add hl, bc

	pop bc
	dec c
	jr nz, .loop
	ret

DebugColor_InitColor:
	ld a, 2 ; BANK(PokemonPalettes)
	call GetFarByte
	ld [de], a
	inc de
	inc hl

	ld a, 2
	call GetFarByte
	ld [de], a
	inc de
	inc hl

	ld a, 2
	call GetFarByte
	ld [de], a
	inc de
	inc hl

	ld a, 2
	call GetFarByte
	ld [de], a
	inc de
	ret

DebugColor_InitVRAM:
	ld a, 1
	ldh [rVBK], a
	ld hl, vTiles0
	ld bc, sScratch - vTiles0
	xor a
	call ByteFill

	ld a, 0
	ldh [rVBK], a
	ld hl, vTiles0
	ld bc, sScratch - vTiles0
	xor a
	call ByteFill

	hlcoord 0, 0, wAttrmap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	xor a
	call ByteFill

	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	xor a
	call ByteFill

	call ClearSprites
	ret

DebugColor_LoadGFX:
	ld hl, DebugColor_GFX
	ld de, vTiles2 tile DEBUGTEST_TICKS_1
	ld bc, 22 tiles
	call CopyBytes

	ld hl, DebugColor_UpArrowGFX
	ld de, vTiles0
	ld bc, 1 tiles
	call CopyBytes

	call LoadStandardFont

	ld hl, vTiles1
	lb bc, 8, 0
.loop
	ld a, [hl]
	xor $ff
	ld [hli], a
	dec bc
	ld a, c
	or b
	jr nz, .loop
	ret

DebugColor_InitPalettes:
	ldh a, [hCGB]
	and a
	ret z

	ld hl, Palette_DebugBG
	ld de, wBGPals
	ld bc, 16 palettes
	call CopyBytes

	ld a, 1 << rBGPI_AUTO_INCREMENT
	ldh [rBGPI], a
	ld hl, Palette_DebugBG
	ld c, 8 palettes
	xor a
.loop1
	ldh [rBGPD], a
	dec c
	jr nz, .loop1

	ld a, 1 << rOBPI_AUTO_INCREMENT
	ldh [rOBPI], a
	ld hl, Palette_DebugOB
	ld c, 8 palettes
.loop2
	ld a, [hli]
	ldh [rOBPD], a
	dec c
	jr nz, .loop2

	ld a, $94
	ld [wc508], a
	ld a, $52
	ld [wc508 + 1], a
	ld a, $4a
	ld [wc508 + 2], a
	ld a, $29
	ld [wc508 + 3], a
	ret

Palette_DebugBG:
INCLUDE "gfx/debug/bg.pal"

Palette_DebugOB:
INCLUDE "gfx/debug/ob.pal"

DebugColorMain:
	call JoyTextDelay

	ld a, [wJumptableIndex]
	cp 4
	jr nc, .asm_766a

	ld hl, hJoyLast
	ld a, [hl]
	and SELECT
	jr nz, .NextMon
	ld a, [hl]
	and START
	jr nz, .PreviousMon

.asm_766a:
	ld a, [wJumptableIndex]
	ld e, a
	ld d, 0
	ld hl, Jumptable_03f_76ae
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.NextMon:
	call DebugColor_BackupSpriteColors

	call DebugColor_SetMaxNum
	ld e, a

	ld a, [wce5a]
	inc a
	cp e
	jr c, .SwitchMon
	xor a
	jr .SwitchMon

.PreviousMon:
	call DebugColor_BackupSpriteColors

	ld a, [wce5a]
	dec a
	cp -1
	jr nz, .SwitchMon

	call DebugColor_SetMaxNum
	dec a
.SwitchMon:
	ld [wce5a], a
	ld a, 0 ; ScreenInitNo
	ld [wJumptableIndex], a
	ret

DebugColor_SetMaxNum:
	ld a, [wcf21]
	and a
	jr nz, .trainer
.mon
	ld a, NUM_POKEMON
	ret
.trainer
	ld a, NUM_TRAINER_CLASSES - 1
	ret

Jumptable_03f_76ae:
	dw DebugColor_InitScreen
	dw unk_03f_77f7
	dw unk_03f_7812
	dw unk_03f_7897
	dw unk_03f_7963
	dw unk_03f_7984

DebugColor_InitScreen:
	xor a
	ldh [hBGMapMode], a

	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, DEBUGTEST_BLACK
	call ByteFill

	hlcoord 1, 3
	lb bc, 7, 18
	ld a, DEBUGTEST_WHITE
	call DebugColor_FillBoxWithByte
	hlcoord 11, 0
	lb bc, 2, 3
	ld a, DEBUGTEST_LIGHT
	call DebugColor_FillBoxWithByte
	hlcoord 16, 0
	lb bc, 2, 3
	ld a, DEBUGTEST_DARK
	call DebugColor_FillBoxWithByte

	call DebugColor_LoadRGBMeter
	call DebugColor_SetRGBMeter

	ld a, [wce5a]
	inc a
	ld [wCurPartySpecies], a
	ld [wDeciramBuffer], a

	hlcoord 0, 1
	ld de, wDeciramBuffer
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum

	ld a, [wMovementBufferCount]
	and a
	jr nz, .Trainer

.MonSpriteViewer:
	ld a, 1
	ld [wUnownLetter], a

	call GetPokemonName
	hlcoord 4, 1
	call PlaceString

	xor a
	ld [wBoxAlignment], a
	hlcoord 2, 3
	call _PrepMonFrontpic

	ld de, vTiles2 tile $31
	ld a, $3d
	call Predef

	ld a, $31
	ldh [hGraphicStartTile], a
	hlcoord 12, 4
	lb bc, 6, 6
	ld a, $13
	call Predef

	ld a, [wcf22]
	and a
	jr z, .load_normal_text

.load_shiny_text
	ld de, DebugColor_ShinyText
	jr .place_switch_text

.load_normal_text
	ld de, DebugColor_NormalText

.place_switch_text
	hlcoord 7, 17
	call PlaceString
	hlcoord 0, 17
	ld de, DebugColor_SwitchText
	call PlaceString
	jr .asm_7788

.Trainer:
	ld a, [wDeciramBuffer]
	ld [wTrainerClass], a
	ld hl, $555f
	ld a, $e
	rst FarCall
	ld de, wStringBuffer1
	hlcoord 4, 1
	call PlaceString

	ld de, vTiles2
	ld hl, $588d
	ld a, $14
	rst FarCall

	xor a
	ld [wTempEnemyMonSpecies], a
	ldh [hGraphicStartTile], a
	hlcoord 2, 3
	lb bc, 7, 7
	ld a, $13
	call Predef

.asm_7788
	ld a, 1
	ld [wJumptableIndex], a
	ret

DebugColor_ShinyText:
	db "レア", DEBUGTEST_BLACK, DEBUGTEST_BLACK, "@" ; Rare

DebugColor_NormalText:
	db "ノ-マル@" ; Normal

DebugColor_SwitchText:
	db DEBUGTEST_A, "きりかえ▶@" ; Switch

DebugColor_LoadRGBMeter:
	decoord 0, 11, wAttrmap
	hlcoord 2, 11
	ld a, 1
	call .asm_77bd

	decoord 0, 13, wAttrmap
	hlcoord 2, 13
	ld a, 2
	call .asm_77bd

	decoord 0, 15, wAttrmap
	hlcoord 2, 15
	ld a, 3

.asm_77bd:
	push af
	ld a, DEBUGTEST_TICKS_1
	ld [hli], a

	ld bc, 15
	ld a, DEBUGTEST_TICKS_2
	call ByteFill

	ld l, e
	ld h, d

	pop af
	ld bc, 20 * 2
	call ByteFill
	ret

DebugColor_SetRGBMeter:
	ld a, [wce5a]
	inc a
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	ld de, wOverworldMapBlocks
	add hl, de

	ld de, wc508
	ld bc, 4
	call CopyBytes

	xor a
	ld [wce58], a
	ld [wce59], a
	ld de, wc508
	call DebugColor_CalculateRGB
	ret

unk_03f_77f7:
	ldh a, [hCGB]
	and a
	jr z, .asm_7809

	ld a, 2
	ldh [hBGMapMode], a
	call DelayFrame
	call DelayFrame
	call DelayFrame

.asm_7809
	call WaitBGMap
	ld a, 2
	ld [wJumptableIndex], a
	ret

unk_03f_7812:
	ldh a, [hCGB]
	and a
	jr z, .SGB

.CGB:
	ld hl, wBGPals
	ld de, wc508
	ld c, 1
	call Call_03f_7ab8

	hlcoord 10, 2
	ld de, wc508
	call Call_03f_787c

	hlcoord 15, 2
	ld de, wc50a
	call Call_03f_787c

	ld a, 1
	ldh [hCGBPalUpdate], a

	ld a, 3
	ld [wJumptableIndex], a
	ret

.SGB:
	ld hl, wSGBPals
	ld a, 1
	ld [hli], a
	ld a, LOW(PALRGB_WHITE)
	ld [hli], a
	ld a, HIGH(PALRGB_WHITE)
	ld [hli], a
	ld a, [wc508]
	ld [hli], a
	ld a, [wc508 + 1]
	ld [hli], a
	ld a, [wc508 + 2]
	ld [hli], a
	ld a, [wc508 + 3]
	ld [hli], a
	xor a
	ld [hli], a
	ld [hli], a
	ld [hl], a

	ld hl, wSGBPals
	call Call_03f_7ae1

	hlcoord 10, 2
	ld de, wc508
	call Call_03f_787c

	hlcoord 15, 2
	ld de, wc508 + 2
	call Call_03f_787c

	ld a, 3
	ld [wJumptableIndex], a
	ret

Call_03f_787c:
	inc hl
	inc hl
	inc hl

	ld a, [de]
	call Call_03f_7891
	ld a, [de]
	swap a
	call Call_03f_7891

	inc de

	ld a, [de]
	call Call_03f_7891
	ld a, [de]
	swap a

Call_03f_7891:
	and $f
	add DEBUGTEST_0
	ld [hld], a
	ret

unk_03f_7897:
	ldh a, [hJoyLast]
	and B_BUTTON
	jr nz, .asm_78b4
	ldh a, [hJoyLast]
	and A_BUTTON
	jr nz, .asm_78ba

	ld a, [wce58]
	and 3
	ld e, a
	ld d, 0
	ld hl, $78d7
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.asm_78b4
	ld a, 4
	ld [wJumptableIndex], a
	ret

.asm_78ba:
	ld a, [wMovementBufferCount]
	and a
	ret nz

	ld a, [wcf22]
	xor 4
	ld [wcf22], a
	ld c, a
	ld b, 0
	ld hl, $6ff1
	add hl, bc
	call DebugColor_InitMonColor2
	ld a, 0
	ld [wJumptableIndex], a
	ret

Jumptable_03f_78d7:
	dw DebugColor_SelectColorBox
	dw DebugColor_ChangeRedValue
	dw DebugColor_ChangeGreenValue
	dw DebugColor_ChangeBlueValue

DebugColor_SelectColorBox:
	ld hl, hJoyLast
	ld a, [hl]
	and D_DOWN
	jr nz, DebugColor_NextRGBColor

	ld a, [hl]
	and D_LEFT
	jr nz, .lightcolor
	ld a, [hl]
	and D_RIGHT
	jr nz, .darkcolor
	ret

.lightcolor:
	xor a
	ld [wce59], a
	ld de, wc508
	call DebugColor_CalculateRGB
	ret

.darkcolor:
	ld a, 1
	ld [wce59], a
	ld de, wc50a
	call DebugColor_CalculateRGB
	ret

DebugColor_ChangeRedValue:
	ld hl, hJoyLast
	ld a, [hl]
	and D_DOWN
	jr nz, DebugColor_NextRGBColor
	ld a, [hl]
	and D_UP
	jr nz, DebugColor_PreviousRGBColor

	ld hl, wc512
	jr DebugColor_UpdateSpriteColor

DebugColor_ChangeGreenValue:
	ld hl, hJoyLast
	ld a, [hl]
	and D_DOWN
	jr nz, DebugColor_NextRGBColor
	ld a, [hl]
	and D_UP
	jr nz, DebugColor_PreviousRGBColor

	ld hl, wc513
	jr DebugColor_UpdateSpriteColor

DebugColor_ChangeBlueValue:
	ld hl, hJoyLast
	ld a, [hl]
	and D_UP
	jr nz, DebugColor_PreviousRGBColor

	ld hl, wc514
DebugColor_UpdateSpriteColor:
	ldh a, [hJoyLast]
	and D_RIGHT
	jr nz, .increment_color_value
	ldh a, [hJoyLast]
	and D_LEFT
	jr nz, .decrement_color_value
	ret

.increment_color_value:
	ld a, [hl]
	cp $1f
	ret nc
	inc [hl]
	jr .asm_7950

.decrement_color_value:
	ld a, [hl]
	and a
	ret z
	dec [hl]

.asm_7950
	call DebugColor_CalculatePalette
	ld a, 2
	ld [wJumptableIndex], a
	ret

DebugColor_PreviousRGBColor:
	ld hl, wce58
	dec [hl]
	ret

DebugColor_NextRGBColor:
	ld hl, wce58
	inc [hl]
	ret

unk_03f_7963:
	hlcoord 0, 10
	ld bc, 20 * 8
	ld a, DEBUGTEST_BLACK
	call ByteFill

	hlcoord 2, 12
	ld de, unkData_03f_7ba2
	call PlaceString

	xor a
	ld [wcf23], a
	call Call_03f_79c9

	ld a, 5
	ld [wJumptableIndex], a
	ret

unk_03f_7984:
	ld hl, hJoyPressed
	ld a, [hl]
	and B_BUTTON
	jr nz, .cancel
;	ld a,(hl)
;	and A_BUTTON
;	jr nz, .exit
	call DebugColor_TMHMJoypad
	ret

.cancel
	ld a, 0
	ld [wJumptableIndex], a
	ret

.exit
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

DebugColor_TMHMJoypad:
	ld hl, hJoyLast
	ld a, [hl]
	and D_UP
	jr nz, .asm_79aa
	ld a, [hl]
	and D_DOWN
	jr nz, .asm_79b7
	ret

.asm_79aa
	ld a, [wcf23]
	cp 56
	jr z, .asm_79b4
	inc a
	jr .asm_79c2

.asm_79b4
	xor a
	jr .asm_79c2

.asm_79b7
	ld a, [wcf23]
	and a
	jr z, .asm_79c0
	dec a
	jr .asm_79c2

.asm_79c0
	ld a, 56

.asm_79c2
	ld [wcf23], a
	call Call_03f_79c9
	ret

Call_03f_79c9:
	hlcoord 10, 11
	call Call_03f_7a33
	hlcoord 10, 12
	call Call_03f_7a33
	hlcoord 10, 13
	call Call_03f_7a33
	hlcoord 10, 14
	call Call_03f_7a33

	ld a, [wcf23]
	inc a
	ld [wTempTMHM], a
	ld a, $f
	call Predef
	ld a, [wTempTMHM]
	ld [wTMHMMove], a
	call GetMoveName
	hlcoord 10, 12
	call PlaceString

	ld a, [wcf23]
	call Call_03f_7a2a
	ld [wCurItem], a

	ld a, $e
	call Predef

	ld a, c
	and a
	ld de, DebugColor_AbleText
	jr nz, jr_03f_7a14

unk_03f_7a11:
	ld de, DebugColor_NotAbleText

jr_03f_7a14:
	ld hl, $c4c2
	call PlaceString
	ret

DebugColor_AbleText:
	db "おぼえられる@" ; Learnable

DebugColor_NotAbleText:
	db "おぼえられない@" ; Not learnable

Call_03f_7a2a:
	cp NUM_TMS
	jr c, .TM
.HM
	inc a
	inc a
.TM
	add TM01
	ret

Call_03f_7a33:
	ld bc, 10
	ld a, DEBUGTEST_BLACK
	call ByteFill
	ret

DebugColor_CalculatePalette:
	ld a, [wc512]
	and $1f
	ld e, a
	ld a, [wc513]
	and 7
	sla a
	swap a
	or e
	ld e, a

	ld a, [wc513]
	and $18
	sla a
	swap a
	ld d, a
	ld a, [wc514]
	and $1f
	sla a
	sla a
	or d
	ld d, a

	ld a, [wce59]
	and a
	jr z, .LightPalette

.DarkPalette
	ld a, e
	ld [wc50a], a
	ld a, d
	ld [wc50a + 1], a
	ret

.LightPalette
	ld a, e
	ld [wc508], a
	ld a, d
	ld [wc508 + 1], a
	ret

DebugColor_CalculateRGB:
	ld a, [de]
	and $1f
	ld [wc512], a

	ld a, [de]
	and $e0
	swap a
	srl a
	ld b, a
	inc de
	ld a, [de]
	and 3
	swap a
	srl a
	or b
	ld [wc513], a

	ld a, [de]
	and $7c
	srl a
	srl a
	ld [wc514], a
	ret

DebugColor_BackupSpriteColors:
	ld a, [wce5a]
	inc a
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	ld de, wOverworldMapBlocks ; MonPalette
	add hl, de
	ld e, l
	ld d, h
	ld hl, wc508
	ld bc, 4
	call CopyBytes
	ret

Call_03f_7ab8:
; Set palette buffer

	ld a, LOW(PALRGB_WHITE)
	ld [hli], a
	ld a, HIGH(PALRGB_WHITE)
	ld [hli], a

	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	inc de
	ld [hli], a

	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	inc de
	ld [hli], a

	xor a
	ld [hli], a
	ld [hli], a

	dec c
	jr nz, Call_03f_7ab8
	ret

DebugColor_FillBoxWithByte:
; For some reason, we have another copy of FillBoxWithByte here
.row
	push bc
	push hl
.col
	ld [hli], a
	dec c
	jr nz, .col
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .row
	ret

Call_03f_7ae1:
; SGB Related

	ld a, [wd8ad]
	push af
	set 7, a
	ld [wd8ad], a

	call Call_03f_7af2

	pop af
	ld [wd8ad], a
	ret

Call_03f_7af2:
	ld a, [hl]
	and 7
	ret z
	ld b, a

.asm_7af7:
	push bc
	xor a
	ldh [rJOYP], a

	ld a, $30
	ldh [rJOYP], a
	ld b, $10
.asm_7b01
	ld e, 8
	ld a, [hli]
	ld d, a
.asm_7b05
	bit 0, d
	ld a, $10
	jr nz, .asm_7b0d
	ld a, $20
.asm_7b0d:
	ldh [rJOYP], a
	ld a, $30
	ldh [rJOYP], a
	rr d
	dec e
	jr nz, .asm_7b05
	dec b
	jr nz, .asm_7b01

	ld a, $20
	ldh [rJOYP], a
	ld a, $30
	ldh [rJOYP], a

	ld de, 7000
.wait:
	nop
	nop
	nop
	dec de
	ld a, d
	or e
	jr nz, .wait

	pop bc
	dec b
	jr nz, .asm_7af7
	ret

DebugColor_PlaceCursor:
	ld a, DEBUGTEST_BLACK
	hlcoord 10, 0
	ld [hl], a
	hlcoord 15, 0
	ld [hl], a
	hlcoord 1, 11
	ld [hl], a
	hlcoord 1, 13
	ld [hl], a
	hlcoord 1, 15
	ld [hl], a

	ld a, [wJumptableIndex]
	cp 3
	jr nz, .clearsprites

	ld a, [wce58]
	and a
	jr z, .asm_7b62

	dec a
	hlcoord 1, 11
	ld bc, 2 * SCREEN_WIDTH
	call AddNTimes
	ld [hl], "▶"

.asm_7b62
	ld a, [wce59]
	and a
	jr z, .lightcolor

.darkcolor
	hlcoord 15, 0
	jr .place

.lightcolor
	hlcoord 10, 0

.place
	ld [hl], "▶"
	ld b, $70
	ld c, 5

	ld hl, wVirtualOAMSprite00YCoord
	ld de, wc512
	call .PlaceSprites
	ld de, wc513
	call .PlaceSprites
	ld de, wc514
	call .PlaceSprites
	ret

.PlaceSprites:
	ld a, b
	ld [hli], a ; y
	ld a, [de]
	add a
	add a
	add 3 * TILE_WIDTH
	ld [hli], a ; x
	xor a
	ld [hli], a ; tile id
	ld a, c
	ld [hli], a ; attributes

	ld a, 2 * TILE_WIDTH
	add b
	ld b, a

	inc c
	ret

.clearsprites
	call ClearSprites
	ret

unkData_03f_7ba2:
	db   "おわりますか？" ; Are you finished?
	next "はい...", DEBUGTEST_A	; YES...(A)
	next "いいえ..", DEBUGTEST_B	; NO..(B)
	db   "@"

DebugColor_UpArrowGFX:
INCBIN "gfx/debug/up_arrow.2bpp"

DebugColor_GFX:
INCBIN "gfx/debug/color_test.2bpp"

DebugColor_Dummy7d28:
	ret

DebugColor_Init2:
	xor a
	ld [wJumptableIndex], a
	ld [wce58], a
	ld [wce59], a
	ld [wce5a], a
	ldh [hMapAnims], a
	call ClearSprites

	call OverworldTextModeSwitch
	call WaitBGMap2
	xor a
	ldh [hBGMapMode], a

	ld de, DebugColor_GFX
	ld hl, vTiles2 tile DEBUGTEST_TICKS_1
	lb bc, BANK(DebugColor_GFX), 22
	call Request2bpp

	ld de, DebugColor_UpArrowGFX
	ld hl, vTiles1
	lb bc, BANK(DebugColor_UpArrowGFX), 1
	call Request2bpp

	ld a, HIGH(vBGMap1)
	ldh [hBGMapAddress + 1], a

	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, DEBUGTEST_BLACK
	call ByteFill

	hlcoord 0, 0, wAttrmap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, 7
	call ByteFill

	ld de, $15
	ld a, DEBUGTEST_WHITE
	call Call_03f_7da7

	ld de, $1a
	ld a, DEBUGTEST_LIGHT
	call Call_03f_7da7

	ld de, $1f
	ld a, DEBUGTEST_DARK
	call Call_03f_7da7

	ld de, $24
	ld a, DEBUGTEST_BLACK
	call Call_03f_7da7

	call Call_03f_7dc9
	call Call_03f_7de4

	call WaitBGMap2
	ld [wJumptableIndex], a

	ld a, $40
	ldh [hWY], a
	ret

Call_03f_7da7:
	hlcoord 0, 0
	call Call_03f_7db3

Call_03f_7dad:
	ld a, [wce58]
	hlcoord 0, 0, wAttrmap

Call_03f_7db3:
	add hl, de
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld bc, 16
	add hl, bc
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld bc, 16
	add hl, bc
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ret

Call_03f_7dc9:
	hlcoord 2, 4
	call .place

	hlcoord 2, 6
	call .place

	hlcoord 2, 8
.place:
	ld a, DEBUGTEST_TICKS_1
	ld [hli], a
	ld bc, 15
	ld a, DEBUGTEST_TICKS_2
	call ByteFill
	ret

Call_03f_7de4:
	ld a, [wce58]
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	ld de, wTempBGPals
	add hl, de
	ld de, wc508
	ld bc, 8
	call CopyBytes
	ld de, wc508
	call DebugColor_CalculateRGB
	ret

DebugColorMain2:
	ld hl, hJoyLast
	ld a, [hl]
	and SELECT
	jr nz, .asm_7e12
	ld a, [hl]
	and B_BUTTON
	jr nz, .asm_7e5a

	call Call_03f_7ea7
	ret

.asm_7e12:
	ld hl, wce58
	ld a, [hl]
	inc a
	and 7
	cp 7
	jr nz, .asm_7e1e
	xor a

.asm_7e1e
	ld [hl], a

	ld de, $15
	call Call_03f_7dad
	ld de, $1a
	call Call_03f_7dad
	ld de, $1f
	call Call_03f_7dad
	ld de, $24
	call Call_03f_7dad

	ld hl, wBGPals
	ld a, [wce58]
	ld bc, 8
	call AddNTimes
	ld de, wc508
	ld bc, 8
	call CopyBytes

	ld a, 2
	ldh [hBGMapMode], a
	ld c, 3
	call DelayFrames
	ld a, 1
	ldh [hBGMapMode], a
	ret

.asm_7e5a
	call ClearSprites
	ldh a, [hWY]
	xor $d0
	ldh [hWY], a
	ret

Call_03f_7e64:
	ld hl, wBGPals
	ld a, [wce58]
	ld bc, 1 palettes
	call AddNTimes
	ld e, l
	ld d, h
	ld hl, wc508
	ld bc, 1 palettes
	call CopyBytes

	hlcoord 1, 0
	ld de, wc508
	call Call_03f_787c

	hlcoord 6, 0
	ld de, wc50a
	call Call_03f_787c

	hlcoord 11, 0
	ld de, wc50c
	call Call_03f_787c

	hlcoord 16, 0
	ld de, wc50e
	call Call_03f_787c

	ld a, 1
	ldh [hCGBPalUpdate], a
	call DelayFrame
	ret

Call_03f_7ea7:
	ld a, [wce59]
	and 3
	ld e, a
	ld d, 0
	ld hl, .PointerTable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.PointerTable:
	dw DebugColor_SelectColorBox2
	dw unk_03f_7ef0 ; Red
	dw unk_03f_7f02 ; Green
	dw unk_03f_7f14 ; Blue

DebugColor_SelectColorBox2:
	ld hl, hJoyLast
	ld a, [hl]
	and D_DOWN
	jr nz, jr_03f_7f43

	ld a, [hl]
	and D_LEFT
	jr nz, .asm_7ed3
	ld a, [hl]
	and D_RIGHT
	jr nz, .asm_7ed9
	ret

.asm_7ed3
	ld a, [wce5a]
	dec a
	jr .asm_7edd

.asm_7ed9
	ld a, [wce5a]
	inc a

.asm_7edd
	and 3
	ld [wce5a], a

	ld e, a
	ld d, 0
	ld hl, wc508
	add hl, de
	add hl, de
	ld e, l
	ld d, h
	call DebugColor_CalculateRGB
	ret

unk_03f_7ef0:
	ld hl, hJoyLast
	ld a, [hl]
	and D_DOWN
	jr nz, jr_03f_7f43
	ld a, [hl]
	and D_UP
	jr nz, unk_03f_7f3e

	ld hl, wc512
	jr unk_03f_7f1f

unk_03f_7f02:
	ld hl, hJoyLast
	ld a, [hl]
	and D_DOWN
	jr nz, jr_03f_7f43
	ld a, [hl]
	and D_UP
	jr nz, unk_03f_7f3e

	ld hl, wc513
	jr unk_03f_7f1f

unk_03f_7f14:
	ld hl, hJoyLast
	ld a, [hl]
	and D_UP
	jr nz, unk_03f_7f3e

	ld hl, wc514
unk_03f_7f1f:
	ldh a, [hJoyLast]
	and D_RIGHT
	jr nz, .asm_7f2c
	ldh a, [hJoyLast]
	and D_LEFT
	jr nz, .asm_7f33
	ret

.asm_7f2c
	ld a, [hl]
	cp $1f
	ret nc
	inc [hl]
	jr .asm_7f37

.asm_7f33
	ld a, [hl]
	and a
	ret z
	dec [hl]

.asm_7f37
	call Call_03f_7f48
	call Call_03f_7e64
	ret

unk_03f_7f3e:
	ld hl, wce59
	dec [hl]
	ret

jr_03f_7f43:
	ld hl, wce59
	inc [hl]
	ret

Call_03f_7f48:
	ld a, [wc512]
	and $1f
	ld e, a
	ld a, [wc513]
	and 7
	sla a
	swap a
	or e
	ld e, a

	ld a, [wc513]
	and $18
	sla a
	swap a
	ld d, a
	ld a, [wc514]
	and $1f
	sla a
	sla a
	or d
	ld d, a

	ld a, [wce5a]
	ld c, a
	ld b, 0
	ld hl, wc508
	add hl, bc
	add hl, bc
	ld a, e
	ld [hli], a
	ld [hl], d
	ret

DebugColor_PlaceCursor2:
	ld a, DEBUGTEST_BLACK
	hlcoord 0, 4
	ld [hl], a
	hlcoord 0, 6
	ld [hl], a
	hlcoord 0, 8
	ld [hl], a
	hlcoord 0, 2
	ld [hl], a
	hlcoord 5, 2
	ld [hl], a
	hlcoord 10, 2
	ld [hl], a
	hlcoord 15, 2
	ld [hl], a

	ld a, [wce59]
	and a
	jr z, .asm_7fad

	dec a
	hlcoord 0, 4
	ld bc, 40
	call AddNTimes
	ld [hl], "▶"

.asm_7fad:
	ld a, [wce5a]
	hlcoord 0, 2
	ld bc, 5
	call AddNTimes
	ld [hl], "▶"

	ld b, $78
	ld hl, wVirtualOAMSprite00YCoord
	ld de, wc512
	call .PlaceSprites
	ld de, wc513
	call .PlaceSprites
	ld de, wc514
	call .PlaceSprites
	ret

.PlaceSprites:
	ld a, b
	ld [hli], a ; y
	ld a, [de]
	add a
	add a
	add 3 * TILE_WIDTH
	ld [hli], a ; x
	ld a, $80
	ld [hli], a ; tile id
	ld a, 5
	ld [hli], a ; attributes

	ld a, 2 * TILE_WIDTH
	add b
	ld b, a

	inc c
	ret

.clearsprites
	call ClearSprites
	ret

DebugColor_Dummy7feb:
	ret
