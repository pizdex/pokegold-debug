Clear_wc6e8::
	ld hl, wc6e8
	ld bc, $0018
	ld a, $00
	call ByteFill
	ret

CheckTriggers::
	push hl
	ld hl, wCurrentMapTriggerPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	or h
	ld a, [hl]
	jr nz, .asm_1f97
	ld a, $ff
.asm_1f97
	pop hl
	ret

GetCurrentMapTrigger::
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
	xor a
	ld [wCurrentMapTriggerPointer], a
	ld [wCurrentMapTriggerPointer + 1], a
	call GetMapTrigger
	ret c
	ld a, e
	ld [wCurrentMapTriggerPointer], a
	ld a, d
	ld [wCurrentMapTriggerPointer + 1], a
	xor a
	ret

GetMapTrigger:
	push bc
	ldh a, [hROMBank]
	push af
	ld a, $25
	rst Bankswitch
	ld hl, $4000
.asm_1fc0
	push hl
	ld a, [hli]
	cp $ff
	jr z, .asm_1fd6
	cp b
	jr nz, .asm_1fcf
	ld a, [hli]
	cp c
	jr nz, .asm_1fcf
	jr .asm_1fd9

.asm_1fcf
	pop hl
	ld de, 4
	add hl, de
	jr .asm_1fc0

.asm_1fd6
	scf
	jr .asm_1fdc

.asm_1fd9
	ld e, [hl]
	inc hl
	ld d, [hl]
.asm_1fdc
	pop hl
	pop bc
	ld a, b
	rst Bankswitch
	pop bc
	ret

OverworldTextModeSwitch::
	call LoadMapPart
	call SwapTextboxPalettes
	ret

LoadMapPart::
	ldh a, [hROMBank]
	push af
	ld a, [wTilesetBlocksBank]
	rst Bankswitch
	call LoadMetatiles
	ld a, $60
	ld hl, wTilemap
	ld bc, $168
	call ByteFill
	ld a, $5
	rst Bankswitch
	call $5301
	pop af
	rst Bankswitch
	ret

LoadMetatiles::
	; de <- wOverworldMapAnchor
	ld a, [wOverworldMapAnchor]
	ld e, a
	ld a, [wOverworldMapAnchor + 1]
	ld d, a
	ld hl, wMisc
	ld b, SURROUNDING_HEIGHT / METATILE_WIDTH ; 5

.row
	push de
	push hl
	ld c, SURROUNDING_WIDTH / METATILE_WIDTH ; 6

.col
	push de
	push hl
	; Load the current map block.
	; If the current map block is a border block, load the border block.
	ld a, [de]
	and a
	jr nz, .ok
	ld a, [wMapBorderBlock]

.ok
	; Load the current wMisc address into de.
	ld e, l
	ld d, h
	; Set hl to the address of the current metatile data ([TilesetBlocksAddress] + (a) tiles).
	add a
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	ld a, [wTilesetBlocksAddress]
	add l
	ld l, a
	ld a, [wTilesetBlocksAddress + 1]
	adc h
	ld h, a

	; copy the 4x4 metatile
rept METATILE_WIDTH + -1
rept METATILE_WIDTH
	ld a, [hli]
	ld [de], a
	inc de
endr
	ld a, e
	add SURROUNDING_WIDTH - METATILE_WIDTH
	ld e, a
	jr nc, .next\@
	inc d
.next\@
endr
rept METATILE_WIDTH
	ld a, [hli]
	ld [de], a
	inc de
endr
	; Next metatile
	pop hl
	ld de, 4
	add hl, de
	pop de
	inc de
	dec c
	jp nz, .col
	; Next metarow
	pop hl
	ld de, SURROUNDING_WIDTH * METATILE_WIDTH
	add hl, de
	pop de
	ld a, [wMapWidth]
	add 6
	add e
	ld e, a
	jr nc, .ok2
	inc d
.ok2
	dec b
	jp nz, .row
	ret

ReturnToMapFromSubmenu::
	ld a, $fa
	ldh [hMapEntryMethod], a
	ld a, 5
	ld hl, $53f8
	rst FarCall
	xor a
	ldh [hMapEntryMethod], a
	ret

Function20a7::
	call Clear_wc6e8
	call ResetMapBufferEventFlags
	call ResetFlashIfOutOfCave
	call GetCurrentMapTrigger
	call ResetBikeFlags
	ld a, 5
	call RunMapCallback
	ld a, $25
	ld hl, $7c8e
	rst FarCall
	ld a, 3
	call RunMapCallback
	call GetMapTimeOfDay
	ld [wMapTimeOfDay], a
	ret

Function20cd::
	ld a, 1
	ld [wSpriteUpdatesEnabled], a
	ld a, $23
	ld hl, $444c
	rst FarCall
	ld a, $23
	ld hl, $43b9
	rst FarCall
	call OverworldTextModeSwitch
	call Function20e8
	call Function2107
	ret

Function20e8::
	ld a, $98
	ld [wBGMapAnchor + 1], a
	xor a
	ld [wBGMapAnchor], a
	ldh [hSCY], a
	ldh [hSCX], a
	ld a, 1
	ld hl, $58cd
	rst FarCall
	ld a, $60
	ld bc, $400
	ld hl, vBGMap2
	call ByteFill
	ret

Function2107::
	decoord 0, 0
	call Function2118
	ldh a, [hCGB]
	and a
	ret z
	decoord 0, 0, wAttrmap
	ld a, 1
	ldh [rVBK], a
Function2118::
	ld hl, vBGMap2
	ld c, $14
	ld b, $12
.asm_211f
	push bc
.asm_2120
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .asm_2120
	ld bc, $c
	add hl, bc
	pop bc
	dec b
	jr nz, .asm_211f
	ld a, 0
	ldh [rVBK], a
	ret

Function2133::
	call LoadMapTileset
	call LoadTileset
	xor a
	ldh [hMapAnims], a
	xor a
	ldh [hTileAnimFrame], a
	ld a, 5
	ld hl, $413f
	rst FarCall
	call LoadFontsExtra
	ret

Function2149::
	ld b, 9
	jp $3596

Function214e::
	call ClearSprites
	call ResetBGWindow
	call GetMovementPermissions
	ld a, $01
	ld hl, $5738
	rst FarCall
	ld a, $05
	ld hl, $5586
	rst FarCall
	ld hl, wd174
	bit 6, [hl]
	jr nz, .asm_2172
	ld hl, wVramState
	set 0, [hl]
	call SafeUpdateSprites
.asm_2172
	xor a
	ld [wd174], a
	ret

Function2177::
	ld a, [wPlayerStepDirection]
	cp $ff
	ret z
	and a
	jr z, .asm_218e
	cp 1
	jr z, .asm_219d
	cp 2
	jr z, .asm_21a8
	cp 3
	jr z, .asm_21b3
	and a
	ret

.asm_218e
	ld a, [wPlayerStandingMapY]
	sub 4
	ld b, a
	ld a, [wd079]
	add a
	cp b
	jr z, .asm_21c2
	and a
	ret

.asm_219d
	ld a, [wPlayerStandingMapY]
	sub 4
	cp $ff
	jr z, .asm_21c2
	and a
	ret

.asm_21a8
	ld a, [wPlayerStandingMapX]
	sub 4
	cp $ff
	jr z, .asm_21c2
	and a
	ret

.asm_21b3
	ld a, [wPlayerStandingMapX]
	sub 4
	ld b, a
	ld a, [wMapWidth]
	add a
	cp b
	jr z, .asm_21c2
	and a
	ret

.asm_21c2
	scf
	ret

Function21c4::
	ld a, [wPlayerStepDirection]
	and a
	jp z, Function2284
	cp 1
	jp z, Function2253
	cp 2
	jp z, Function21db
	cp 3
	jp z, Function2217
	ret

Function21db::
	ld a, [wd09c]
	ld [wMapGroup], a
	ld a, [wd09d]
	ld [wMapNumber], a
	ld a, [wd0a5]
	ld [wXCoord], a
	ld a, [wd0a4]
	ld hl, wYCoord
	add [hl]
	ld [hl], a
	ld c, a
	ld hl, wd0a6
	ld a, [hli]
	ld h, [hl]
	ld l, a
	srl c
	jr z, .asm_220c
	ld a, [wd0a3]
	add 6
	ld e, a
	ld d, $00
.asm_2208
	add hl, de
	dec c
	jr nz, .asm_2208
.asm_220c
	ld a, l
	ld [wOverworldMapAnchor], a
	ld a, h
	ld [wOverworldMapAnchor + 1], a
	jp Function22b2

Function2217::
	ld a, [wd0a8]
	ld [wMapGroup], a
	ld a, [wd0a9]
	ld [wMapNumber], a
	ld a, [wd0b1]
	ld [wXCoord], a
	ld a, [wd0b0]
	ld hl, wYCoord
	add [hl]
	ld [hl], a
	ld c, a
	ld hl, wd0b2
	ld a, [hli]
	ld h, [hl]
	ld l, a
	srl c
	jr z, .asm_2248
	ld a, [wd0af]
	add 6
	ld e, a
	ld d, $00
.asm_2244:
	add hl, de
	dec c
	jr nz, .asm_2244
.asm_2248:
	ld a, l
	ld [wOverworldMapAnchor], a
	ld a, h
	ld [wOverworldMapAnchor + 1], a
	jp Function22b2

Function2253::
	ld a, [wd084]
	ld [wMapGroup], a
	ld a, [wd085]
	ld [wMapNumber], a
	ld a, [wd08c]
	ld [wYCoord], a
	ld a, [wd08d]
	ld hl, wXCoord
	add [hl]
	ld [hl], a
	ld c, a
	ld hl, wd08e
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld b, 0
	srl c
	add hl, bc
	ld a, l
	ld [wOverworldMapAnchor], a
	ld a, h
	ld [wOverworldMapAnchor + 1], a
	jp Function22b2

Function2284::
	ld a, [wd090]
	ld [wMapGroup], a
	ld a, [wd091]
	ld [wMapNumber], a
	ld a, [wd098]
	ld [wYCoord], a
	ld a, [wd099]
	ld hl, wXCoord
	add [hl]
	ld [hl], a
	ld c, a
	ld hl, wd09a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld b, 0
	srl c
	add hl, bc
	ld a, l
	ld [wOverworldMapAnchor], a
	ld a, h
	ld [wOverworldMapAnchor + 1], a
Function22b2::
	scf
	ret

Function22b4::
	call Function22ce
	ret nc
	push bc
	ld a, 5
	ld hl, $49ff
	rst FarCall
	pop bc
	ret nc
	call Function2323
	scf
	ret

Function22c6::
	call Function22ce
	ret nc
	call Function2323
	ret

Function22ce::
	ld a, 5
	ld hl, $49ea
	rst FarCall
	ret nc
	ldh a, [hROMBank]
	push af
	call SwitchToMapScriptsBank
	call Function22e2
	pop de
	ld a, d
	rst Bankswitch
	ret

Function22e2::
	ld a, [wPlayerStandingMapY]
	sub 4
	ld e, a
	ld a, [wPlayerStandingMapX]
	sub 4
	ld d, a
	ld a, [wCurMapWarpCount]
	and a
	ret z
	ld c, a
	ld hl, wCurMapWarpsPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
.asm_22fa
	push hl
	ld a, [hli]
	cp e
	jr nz, .asm_2305
	ld a, [hli]
	cp d
	jr nz, .asm_2305
	jr .asm_2312

.asm_2305
	pop hl
	ld a, 5
	add l
	ld l, a
	jr nc, .asm_230d
	inc h
.asm_230d
	dec c
	jr nz, .asm_22fa
	xor a
	ret

.asm_2312
	pop hl
	call Function231f
	ret nc
	ld a, [wCurMapWarpCount]
	inc a
	sub c
	ld c, a
	scf
	ret

Function231f::
	inc hl
	inc hl
	scf
	ret

Function2323::
	ldh a, [hROMBank]
	push af
	call SwitchToMapScriptsBank
	call Function2330
	pop af
	rst Bankswitch
	scf
	ret

Function2330::
	push bc
	ld hl, $d90c
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, c
	dec a
	ld bc, $0005
	call $3210
	ld bc, $0002
	add hl, bc
	ld a, [hli]
	cp $ff
	jr nz, .asm_234c
	ld hl, wBackupWarpNumber
	ld a, [hli]
.asm_234c
	pop bc
	ld [wNextWarpNumber], a
	ld a, [hli]
	ld [wNextMapGroup], a
	ld a, [hli]
	ld [wNextMapNumber], a
	ld a, c
	ld [wPrevWarpNumber], a
	ld a, [wMapGroup]
	ld [wPrevMapGroup], a
	ld a, [wMapNumber]
	ld [wPrevMapNumber], a
	scf
	ret

Function236a::
	call Function2383
	call Function23bc
	ld a, [wNextWarpNumber]
	ld [wd9c5], a
	ld a, [wNextMapGroup]
	ld [wMapGroup], a
	ld a, [wNextMapNumber]
	ld [wMapNumber], a
	ret

Function2383::
	call GetMapPermission
	call CheckOutdoorMap
	ret nz
	ld a, [wNextMapGroup]
	ld b, a
	ld a, [wNextMapNumber]
	ld c, a
	call GetAnyMapPermission
	call CheckIndoorMap
	ret nz
	ld a, [wPrevMapGroup]
	cp $f
	jr nz, .asm_23a9
	ld a, [wPrevMapNumber]
	cp $a
	ret z
	cp $c
	ret z
.asm_23a9
	ld a, [wPrevWarpNumber]
	ld [wDigWarpNumber], a
	ld a, [wPrevMapGroup]
	ld [wDigMapGroup], a
	ld a, [wPrevMapNumber]
	ld [wDigMapNumber], a
	ret

Function23bc::
	call GetMapPermission
	call CheckOutdoorMap
	ret nz
	ld a, [wNextMapGroup]
	ld b, a
	ld a, [wNextMapNumber]
	ld c, a
	call GetAnyMapPermission
	call CheckIndoorMap
	ret nz
	ld a, [wNextMapGroup]
	ld b, a
	ld a, [wNextMapNumber]
	ld c, a
	call GetAnyMapTileset
	ld a, c
	cp 6
	ret nz
	ld a, [wPrevMapGroup]
	ld [wd9c1], a
	ld a, [wPrevMapNumber]
	ld [wd9c2], a
	ret

CheckOutdoorMap::
	cp ROUTE
	ret z
	cp TOWN
	ret

CheckIndoorMap::
	cp INDOOR
	ret z
	cp CAVE
	ret z
	cp DUNGEON
	ret z
	cp GATE
	ret

CheckDungeonMap::
	cp INDOOR
	ret z
	cp GATE
	ret z
	cp ENVIRONMENT_5
	ret

LoadMapAttributes::
	call CopyMapHeaders
	call SwitchToMapScriptsBank
	call ReadMapScripts
	xor a
	call ReadMapEventHeader
	ret

LoadMapAttributes_SkipPeople::
	call CopyMapHeaders
	call SwitchToMapScriptsBank
	call ReadMapScripts
	ld a, 1
	call ReadMapEventHeader
	ret

CopyMapHeaders::
	call PartiallyCopyMapHeader
	call SwitchToMapBank
	call GetSecondaryMapHeaderPointer
	call CopySecondMapHeader
	call GetMapConnections
	ret

ReadMapEventHeader::
	push af
	ld hl, wd081
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	inc hl
	call ReadWarps
	call ReadCoordEvents
	call ReadSignposts
	pop af
	and a
	ret nz
	call ReadObjectEvents
	ret

ReadMapScripts::
	ld hl, wd07f
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call ReadMapTriggers
	call ReadMapCallbacks
	ret

CopySecondMapHeader:
	ld de, wMapBorderBlock
	ld c, $c
.asm_2461
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .asm_2461
	ret

GetMapConnections::
	ld a, $ff
	ld [wd084], a
	ld [wd090], a
	ld [wd09c], a
	ld [wd0a8], a

	ld a, [wd083]
	ld b, a
	bit 3, b
	jr z, .asm_2484
	ld de, wd084
	call GetMapConnection
.asm_2484
	bit 2, b
	jr z, .asm_248e
	ld de, wd090
	call GetMapConnection
.asm_248e
	bit 1, b
	jr z, .asm_2498
	ld de, wd09c
	call GetMapConnection
.asm_2498
	bit 0, b
	jr z, .asm_24a2
	ld de, wd0a8
	call GetMapConnection
.asm_24a2
	ret

GetMapConnection:
	ld c, $0c
.asm_24a5
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .asm_24a5
	ret

ReadMapTriggers::
	ld a, [hli]
	ld c, a
	ld [wd917], a
	ld a, l
	ld [wd918], a
	ld a, h
	ld [wd919], a
	ld a, c
	and a
	ret z
	ld bc, 4
	call $3210
	ret

ReadMapCallbacks::
	ld a, [hli]
	ld c, a
	ld [wd91a], a
	ld a, l
	ld [wd91b], a
	ld a, h
	ld [wd91c], a
	ld a, c
	and a
	ret z
	ld bc, 3
	call $3210
	ret

ReadWarps::
	ld a, [hli]
	ld c, a
	ld [wCurMapWarpCount], a
	ld a, l
	ld [wCurMapWarpsPointer], a
	ld a, h
	ld [wCurMapWarpsPointer + 1], a
	ld a, c
	and a
	ret z
	ld bc, 5
	call $3210
	ret

ReadCoordEvents::
	ld a, [hli]
	ld c, a
	ld [$d90e], a
	ld a, l
	ld [$d90f], a
	ld a, h
	ld [$d910], a
	ld a, c
	and a
	ret z
	ld bc, 8
	call $3210
	ret

ReadSignposts::
	ld a, [hli]
	ld c, a
	ld [$d911], a
	ld a, l
	ld [$d912], a
	ld a, h
	ld [$d913], a
	ld a, c
	and a
	ret z
	ld bc, 5
	call $3210
	ret

ReadObjectEvents::
	push hl
	call ClearObjectStructs
	pop de
	ld hl, wMap2Object
	ld a, [de]
	inc de
	ld [wd914], a
	ld a, e
	ld [wd915], a
	ld a, d
	ld [wd916], a
	ld a, [wd914]
	call CopyMapObjectHeaders
	ld a, [wd914]
	ld c, a
	ld a, $10
	sub c
	jr z, .asm_2554
	ld bc, 1
	add hl, bc
	ld bc, $10
.asm_254a
	ld [hl], 0
	inc hl
	ld [hl], $ff
	dec hl
	add hl, bc
	dec a
	jr nz, .asm_254a
.asm_2554
	ld h, d
	ld l, e
	ret

CopyMapObjectHeaders::
	and a
	ret z
	ld c, a
.asm_255a
	push bc
	push hl
	ld a, $ff
	ld [hli], a
	ld b, $d
.asm_2561
	ld a, [de]
	inc de
	ld [hli], a
	dec b
	jr nz, .asm_2561
	pop hl
	ld bc, $10
	add hl, bc
	pop bc
	dec c
	jr nz, .asm_255a
	ret

ClearObjectStructs::
	ld hl, wObject1Struct
	ld bc, $1e0
	xor a
	call ByteFill
	ld hl, wObject1Struct
	ld de, $28
	ld c, $c
	xor a
.asm_2584
	ld [hl], a
	add hl, de
	dec c
	jr nz, .asm_2584
	ret

RestoreFacingAfterWarp::
	call GetMapScriptsBank
	rst Bankswitch
	ld hl, wd081
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	inc hl
	inc hl
	ld a, [wd9c5]
	dec a
	ld c, a
	ld b, 0
	ld a, 5
	call $3210
	ld a, [hli]
	ld [wYCoord], a
	ld a, [hli]
	ld [wXCoord], a
	ld a, [hli]
	cp $ff
	jr nz, .asm_25b3
	call BackUpWarp
.asm_25b3
	call GetCoordOfUpperLeftCorner
	ret

BackUpWarp::
	ld a, [wPrevWarpNumber]
	ld [wBackupWarpNumber], a
	ld a, [wPrevMapGroup]
	ld [wBackupMapGroup], a
	ld a, [wPrevMapNumber]
	ld [wBackupMapNumber], a
	ret

GetCoordOfUpperLeftCorner::
	ld hl, wc700
	ld a, [wXCoord]
	bit 0, a
	jr nz, .asm_25da
	srl a
	add 1
	jr .asm_25de

.asm_25da
	add 1
	srl a
.asm_25de
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [wMapWidth]
	add 6
	ld c, a
	ld b, 0
	ld a, [wYCoord]
	bit 0, a
	jr nz, .asm_25f7
	srl a
	add 1
	jr .asm_25fb

.asm_25f7
	add 1
	srl a
.asm_25fb
	call $3210
	ld a, l
	ld [wOverworldMapAnchor], a
	ld a, h
	ld [wOverworldMapAnchor + 1], a
	ld a, [wYCoord]
	and 1
	ld [wd071], a
	ld a, [wXCoord]
	and 1
	ld [wd072], a
	ret

LoadBlockData::
	ld hl, wOverworldMapBlocks
	ld bc, wOverworldMapBlocksEnd - wOverworldMapBlocks
	ld a, 0
	call ByteFill
	call ChangeMap
	call FillMapConnections
	ld a, MAPCALLBACK_TILES
	call RunMapCallback
	ret

ChangeMap::
	ldh a, [hROMBank]
	push af

	ld hl, wOverworldMapBlocks
	ld a, [wMapWidth]
	ldh [hConnectedMapWidth], a
	add 6
	ldh [hConnectionStripLength], a
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	add hl, bc
	ld c, 3
	add hl, bc
	ld a, [wd07b]
	rst Bankswitch
	ld a, [wd07c]
	ld e, a
	ld a, [wd07d]
	ld d, a
	ld a, [wd079]
	ld b, a
.asm_2656
	push hl
	ldh a, [hObjectStructIndexBuffer]
	ld c, a
.asm_265a
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .asm_265a
	pop hl
	ldh a, [hMapObjectIndexBuffer]
	add l
	ld l, a
	jr nc, .asm_2668
	inc h
.asm_2668
	dec b
	jr nz, .asm_2656
	pop af
	rst Bankswitch
	ret

FillMapConnections::
	ld a, [wd084]
	cp $ff
	jr z, .asm_269a
	ld b, a
	ld a, [wd085]
	ld c, a
	call GetAnyMapBlockdataBank
	ld a, [wd086]
	ld l, a
	ld a, [wd087]
	ld h, a
	ld a, [wd088]
	ld e, a
	ld a, [wd089]
	ld d, a
	ld a, [wd08a]
	ldh [hMapObjectIndexBuffer], a
	ld a, [wd08b]
	ldh [hObjectStructIndexBuffer], a
	call FillNorthConnectionStrip
.asm_269a
	ld a, [wd090]
	cp $ff
	jr z, .asm_26c6
	ld b, a
	ld a, [wd091]
	ld c, a
	call GetAnyMapBlockdataBank
	ld a, [wd092]
	ld l, a
	ld a, [wd093]
	ld h, a
	ld a, [wd094]
	ld e, a
	ld a, [wd095]
	ld d, a
	ld a, [wd096]
	ldh [hMapObjectIndexBuffer], a
	ld a, [wd097]
	ldh [hObjectStructIndexBuffer], a
	call FillSouthConnectionStrip
.asm_26c6
	ld a, [wd09c]
	cp $ff
	jr z, .asm_26f1
	ld b, a
	ld a, [wd09d]
	ld c, a
	call GetAnyMapBlockdataBank
	ld a, [wd09e]
	ld l, a
	ld a, [wd09f]
	ld h, a
	ld a, [wd0a0]
	ld e, a
	ld a, [wd0a1]
	ld d, a
	ld a, [wd0a2]
	ld b, a
	ld a, [wd0a3]
	ldh [hConnectionStripLength], a
	call FillWestConnectionStrip
.asm_26f1
	ld a, [wd0a8]
	cp $ff
	jr z, .asm_271c
	ld b, a
	ld a, [wd0a9]
	ld c, a
	call GetAnyMapBlockdataBank
	ld a, [wd0aa]
	ld l, a
	ld a, [wd0ab]
	ld h, a
	ld a, [wd0ac]
	ld e, a
	ld a, [wd0ad]
	ld d, a
	ld a, [wd0ae]
	ld b, a
	ld a, [wd0af]
	ldh [hConnectionStripLength], a
	call FillEastConnectionStrip
.asm_271c
	ret

FillNorthConnectionStrip::
FillSouthConnectionStrip::
	ld c, 3
.asm_271f
	push de
	push hl
	ldh a, [hMapObjectIndexBuffer]
	ld b, a
.asm_2724
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .asm_2724
	pop hl
	ldh a, [hObjectStructIndexBuffer]
	ld e, a
	ld d, 0
	add hl, de
	pop de
	ld a, [wMapWidth]
	add 6
	add e
	ld e, a
	jr nc, .asm_273c
	inc d
.asm_273c:
	dec c
	jr nz, .asm_271f
	ret

FillWestConnectionStrip::
FillEastConnectionStrip::
	ld a, [wMapWidth]
	add 6
	ldh [hObjectStructIndexBuffer], a
	push de
	push hl
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	pop hl
	ldh a, [hMapObjectIndexBuffer]
	ld e, a
	ld d, 0
	add hl, de
	pop de
	ldh a, [hObjectStructIndexBuffer]
	add e
	ld e, a
	jr nc, .asm_2761
	inc d
.asm_2761
	dec b
	jr nz, FillWestConnectionStrip
	ret

LoadMapStatus::
	ld [wd14b], a
	ret

CallScript::
	ld [wScriptBank], a
	ld a, l
	ld [wd153], a
	ld a, h
	ld [wd154], a
	call Function27b1
	jp c, Function278b
	ld a, $ff
	ld [wd151], a
	scf
	ret

CallMapScript::
	ld a, [wd151]
	and a
	ret nz
	call GetMapScriptsBank
	jr CallScript

Function278b::
	ld a, $00
	ld [wScriptBank], a
	ld a, $a1
	ld [wd153], a
	ld a, $27
	ld [wd154], a
	ld a, $ff
	ld [wd151], a
	scf
	ret

.data ; 27a1
	db $52, $A4, $27, $00, $81, $3D, $AB, $93, $26, $7F, $B5, $B6, $BC, $B2, $E7, $58

Function27b1::
	ld a, h
	cp $80
	jr c, .asm_27be
	cp $a0
	jr c, .asm_27c0
	cp $e0
	jr nc, .asm_27c0
.asm_27be
	xor a
	ret
.asm_27c0
	scf
	ret

RunMapCallback::
	ld b, a
	ldh a, [hROMBank]
	push af
	call SwitchToMapScriptsBank
	call FindCallback
	jr nc, .asm_27d7
	call GetMapScriptsBank
	ld b, a
	ld d, h
	ld e, l
	call ExecuteCallbackScript
.asm_27d7
	pop af
	rst Bankswitch
	ret

FindCallback::
	ld a, [wd91a]
	ld c, a
	and a
	ret z
	ld hl, wd91b
	ld a, [hli]
	ld h, [hl]
	ld l, a
	or h
	ret z
	ld de, 3
.asm_27eb:
	ld a, [hl]
	cp b
	jr z, .asm_27f5
	add hl, de
	dec c
	jr nz, .asm_27eb
	xor a
	ret

.asm_27f5
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	scf
	ret

ExecuteCallbackScript::
	ld a, $25
	ld hl, $73b9
	rst FarCall
	ld a, [wd150]
	push af
	ld hl, wd14d
	ld a, [hl]
	push af
	set 1, [hl]
	ld a, $25
	ld hl, $6bb9
	rst FarCall
	ld a, $25
	ld hl, $6bc1
	rst FarCall
	pop af
	ld [wd14d], a
	pop af
	ld [wd150], a
	ret

MapTextbox::
	ldh a, [hROMBank]
	push af
	ld a, b
	rst Bankswitch
	call SetUpTextbox
	ld a, 1
	ldh [hOAMUpdate], a
	call PrintTextboxText
	xor a
	ldh [hOAMUpdate], a
	pop af
	rst Bankswitch
	ret

Call_a_de::
	ld [wBuffer], a
	ldh a, [hROMBank]
	push af
	ld a, [wBuffer]
	rst Bankswitch
	call .de
	pop af
	rst Bankswitch
	ret

.de
	push de
	ret

GetMovementData::
	ldh a, [hROMBank]
	push af
	ld a, b
	rst Bankswitch
	ld a, c
	call LoadMovementDataPointer
	pop hl
	ld a, h
	rst Bankswitch
	ret

GetScriptByte::
	push hl
	push bc
	ldh a, [hROMBank]
	push af
	ld a, [wScriptBank]
	rst Bankswitch
	ld hl, wd153
	ld c, [hl]
	inc hl
	ld b, [hl]
	ld a, [bc]
	inc bc
	ld [hl], b
	dec hl
	ld [hl], c
	ld b, a
	pop af
	rst Bankswitch
	ld a, b
	pop bc
	pop hl
	ret

ObjectEvent::
	jumptextfaceplayer ObjectEventText

ObjectEventText::
	db $00
	add h
	dec de
	dec bc
	db $eb
	add c
	dec a
	xor e
	sub e
	ld d, a

BGEvent::
	jumptext BGEventText

BGEventText::
	db $00
	ld a, [de]
	db $e3
	dec bc
	db $e3
	add c
	dec a
	xor e
	sub e
	ld d, a

CoordinatesEvent::
	jumptext CoordinatesEventText

CoordinatesEventText::
	db $00
	dec hl
	set 4, d
	or e
	add c
	dec a
	xor e
	sub e
	ld d, a

CheckObjectMask::
	ldh a, [hMapObjectIndexBuffer]
	ld e, a
	ld d, $0
	ld hl, wMapObjectsEnd
	add hl, de
	ld a, [hl]
	ret

MaskObject::
	ldh a, [hConnectionStripLength]
	ld e, a
	ld d, 0
	ld hl, wd538
	add hl, de
	ld [hl], $ff
	ret

UnmaskObject::
	ldh a, [hMapObjectIndexBuffer]
	ld e, a
	ld d, 0
	ld hl, wd538
	add hl, de
	ld [hl], 0
	ret

ScrollMapDown::
	hlcoord 0, 0
	ld de, wBGMapBuffer
	call BackupBGMapRow
	ld c, $28
	call ScrollBGMapPalettes
	ld a, [wBGMapAnchor]
	ld e, a
	ld a, [wBGMapAnchor + 1]
	ld d, a
	call UpdateBGMapRow
	ld a, 1
	ldh [hBGMapUpdate], a
	ret

ScrollMapUp::
	hlcoord 0, 16
	ld de, wBGMapBuffer
	call BackupBGMapRow
	ld c, $28
	call ScrollBGMapPalettes
	ld a, [wBGMapAnchor]
	ld l, a
	ld a, [wBGMapAnchor + 1]
	ld h, a
	ld bc, $200
	add hl, bc
	ld a, h
	and $3
	or $98
	ld e, l
	ld d, a
	call UpdateBGMapRow
	ld a, 1
	ldh [hBGMapUpdate], a
	ret

ScrollMapRight::
	hlcoord 0, 0
	ld de, wBGMapBuffer
	call BackupBGMapColumn
	ld c, $24
	call ScrollBGMapPalettes
	ld a, [wBGMapAnchor]
	ld e, a
	ld a, [wBGMapAnchor + 1]
	ld d, a
	call UpdateBGMapColumn
	ld a, 1
	ldh [hBGMapUpdate], a
	ret

ScrollMapLeft::
	hlcoord 18, 0
	ld de, wBGMapBuffer
	call BackupBGMapColumn
	ld c, $24
	call ScrollBGMapPalettes
	ld a, [wBGMapAnchor]
	ld e, a
	and $e0
	ld b, a
	ld a, e
	add $12
	and $1f
	or b
	ld e, a
	ld a, [wBGMapAnchor + 1]
	ld d, a
	call UpdateBGMapColumn
	ld a, 1
	ldh [hBGMapUpdate], a
	ret

BackupBGMapRow::
	ld c, $28
.asm_2949
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .asm_2949
	ret

BackupBGMapColumn::
	ld c, $12
.asm_2952:
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	inc de
	ld a, $13
	add l
	ld l, a
	jr nc, .asm_295f
	inc h
.asm_295f
	dec c
	jr nz, .asm_2952
	ret

UpdateBGMapRow::
	ld hl, wBGMapBufferPtrs
	push de
	call .iteration
	pop de
	ld a, $20
	add e
	ld e, a
.iteration
	ld c, $a
.asm_2971
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	ld a, e
	inc a
	inc a
	and $1f
	ld b, a
	ld a, e
	and $e0
	or b
	ld e, a
	dec c
	jr nz, .asm_2971
	ld a, $14
	ldh [hBGMapTileCount], a
	ret

UpdateBGMapColumn::
	ld hl, wBGMapBufferPtrs
	ld c, $12
.asm_298d
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	ld a, $20
	add e
	ld e, a
	jr nc, .asm_299e
	inc d
	ld a, d
	and 3
	or $98
	ld d, a
.asm_299e
	dec c
	jr nz, .asm_298d
	ld a, $12
	ldh [hBGMapTileCount], a
	ret

Function29a6::
	ld hl, wBGMapBuffer
	ld bc, $78
	xor a
	call ByteFill
	ret

LoadTileset::
	ld hl, wTilesetAddress
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, vTiles5
	ld a, [wTilesetBank]
	call FarDecompress
	ld a, [wd074]
	cp 1
	jr z, .asm_29cd
	cp 2
	jr z, .asm_29cd
	jr .asm_29d3

.asm_29cd
	ld a, 7
	ld hl, $4000
	rst FarCall
.asm_29d3
	xor a
	ldh [hTileAnimFrame], a
	ret

BufferScreen::
	ld hl, wOverworldMapAnchor
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wd9ca
	ld c, 5
	ld b, 6
.asm_29e4
	push bc
	push hl
.asm_29e6
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .asm_29e6
	pop hl
	ld a, [wMapWidth]
	add 6
	ld c, a
	ld b, $00
	add hl, bc
	pop bc
	dec c
	jr nz, .asm_29e4
	ret

SaveScreen::
	ld hl, wOverworldMapAnchor
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wd9ca
	ld a, [wMapWidth]
	add 6
	ldh [hConnectionStripLength], a
	ld a, [wPlayerStepDirection]
	and a
	jr z, .asm_2a29
	cp 1
	jr z, .asm_2a1e
	cp 2
	jr z, .asm_2a32
	cp 3
	jr z, .asm_2a38
	ret

.asm_2a1e
	ld de, wd9d0
	ldh a, [hConnectionStripLength]
	ld c, a
	ld b, $00
	add hl, bc
	jr .asm_2a2c

.asm_2a29
	ld de, wd9ca
.asm_2a2c
	ld b, 6
	ld c, 4
	jr SaveScreen_LoadNeighbor

.asm_2a32
	ld de, wd9cb
	inc hl
	jr .asm_2a3b

.asm_2a38
	ld de, wd9ca
.asm_2a3b
	ld b, 5
	ld c, 5
	jr SaveScreen_LoadNeighbor

LoadNeighboringBlockData::
	ld hl, wOverworldMapAnchor
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wMapWidth]
	add $06
	ldh [hMapObjectIndexBuffer], a
	ld de, wd9ca
	ld b, 6
	ld c, 5
SaveScreen_LoadNeighbor::
	push bc
	push hl
	push de
.asm_2a58
	ld a, [de]
	inc de
	ld [hli], a
	dec b
	jr nz, .asm_2a58
	pop de
	ld a, e
	add 6
	ld e, a
	jr nc, .asm_2a66
	inc d
.asm_2a66
	pop hl
	ldh a, [hMapObjectIndexBuffer]
	ld c, a
	ld b, $00
	add hl, bc
	pop bc
	dec c
	jr nz, SaveScreen_LoadNeighbor
	ret

GetMovementPermissions::
	xor a
	ld [wTilePermissions], a
	call .LeftRight
	call .UpDown
	ld a, [wPlayerStandingMapX]
	ld d, a
	ld a, [wPlayerStandingMapY]
	ld e, a
	call GetCoordTile
	ld [wPlayerStandingTile], a
	call .CheckHiNybble
	ret nz
	ld a, [wPlayerStandingTile]
	and $7
	ld hl, .MovementPermissionsData
	add l
	ld l, a
	ld a, $0
	adc h
	ld h, a
	ld a, [hl]
	ld hl, wTilePermissions
	or [hl]
	ld [hl], a
	ret

.MovementPermissionsData:
	db 1 << DOWN
	db 1 << UP
	db 1 << LEFT
	db 1 << RIGHT
	db (1 << DOWN) | (1 << RIGHT)
	db (1 << UP) | (1 << RIGHT)
	db (1 << DOWN) | (1 << LEFT)
	db (1 << UP) | (1 << LEFT)

.UpDown:
	ld a, [wPlayerStandingMapX]
	ld d, a
	ld a, [wPlayerStandingMapY]
	ld e, a
	push de
	inc e
	call GetCoordTile
	ld [wTileDown], a
	call .Down
	pop de
	dec e
	call GetCoordTile
	ld [wTileUp], a
	call .Up
	ret

.LeftRight:
	ld a, [wPlayerStandingMapX]
	ld d, a
	ld a, [wPlayerStandingMapY]
	ld e, a
	push de
	dec d
	call GetCoordTile
	ld [wTileLeft], a
	call .Left
	pop de
	inc d
	call GetCoordTile
	ld [wTileRight], a
	call .Right
	ret

.Down:
	call .CheckHiNybble
	ret nz
	ld a, [wTileDown]
	and 7
	cp 2
	jr z, .asm_2afd
	cp 6
	jr z, .asm_2afd
	cp 7
	ret nz
.asm_2afd
	ld hl, wTilePermissions
	set 3, [hl]
	ret

.Up:
	call .CheckHiNybble
	ret nz
	ld a, [wTileUp]
	and 7
	cp 3
	jr z, .asm_2b17
	cp 4
	jr z, .asm_2b17
	cp 5
	ret nz
.asm_2b17
	ld hl, wTilePermissions
	set 3, [hl]
	ret

.Right:
	call .CheckHiNybble
	ret nz
	ld a, [wTileRight]
	and 7
	cp 1
	jr z, .asm_2b31
	cp 5
	jr z, .asm_2b31
	cp 7
	ret nz
.asm_2b31
	ld hl, wTilePermissions
	set 3, [hl]
	ret

.Left:
	call .CheckHiNybble
	ret nz
	ld a, [wTileLeft]
	and 7
	cp 0
	jr z, .asm_2b4b
	cp 4
	jr z, .asm_2b4b
	cp 6
	ret nz
.asm_2b4b
	ld hl, wTilePermissions
	set 3, [hl]
	ret

.CheckHiNybble:
	and $f0
	cp $b0
	ret z
	cp $c0
	ret

GetFacingTileCoord::
	ld a, [wPlayerDirection]
	and $c
	srl a
	srl a
	ld l, a
	ld h, $0
	add hl, hl
	add hl, hl
	ld de, .Directions
	add hl, de
	ld d, [hl]
	inc hl
	ld e, [hl]
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wPlayerStandingMapX]
	add d
	ld d, a
	ld a, [wPlayerStandingMapY]
	add e
	ld e, a
	ld a, [hl]
	ret

.Directions:
	db  0,  1
	dw wTileDown
	db  0, -1
	dw wTileUp
	db -1,  0
	dw wTileLeft
	db  1,  0
	dw wTileRight

GetCoordTile::
	call GetBlockLocation
	ld a, [hl]
	and a
	jr z, .asm_2bb5
	ld l, a
	ld h, $00
	add hl, hl
	add hl, hl
	ld a, [wTilesetCollisionAddress]
	ld c, a
	ld a, [wTilesetCollisionAddress + 1]
	ld b, a
	add hl, bc
	rr d
	jr nc, .asm_2ba8
	inc hl
.asm_2ba8
	rr e
	jr nc, .asm_2bae
	inc hl
	inc hl
.asm_2bae
	ld a, [wTilesetCollisionBank]
	call GetFarByte
	ret

.asm_2bb5
	ld a, $ff
	ret

GetBlockLocation::
	ld a, [wMapWidth]
	add 6
	ld c, a
	ld b, $00
	ld hl, wc701
	add hl, bc
	ld a, e
	srl a
	jr z, .asm_2bd6
	and a
.asm_2bca
	srl a
	jr nc, .asm_2bcf
	add hl, bc
.asm_2bcf
	sla c
	rl b
	and a
	jr nz, .asm_2bca
.asm_2bd6
	ld c, d
	srl c
	ld b, 0
	add hl, bc
	ret

CheckFacingSign::
	call GetFacingTileCoord
	ld b, a
	ld a, d
	sub 4
	ld d, a
	ld a, e
	sub 4
	ld e, a
	ld a, [wd911]
	and a
	ret z
	ld c, a
	ldh a, [hROMBank]
	push af
	call SwitchToMapScriptsBank
	call CheckIfFacingTileCoordIsSign
	pop hl
	ld a, h
	rst Bankswitch
	ret

CheckIfFacingTileCoordIsSign::
	ld hl, wd912
	ld a, [hli]
	ld h, [hl]
	ld l, a
.asm_2c02
	push hl
	ld a, [hli]
	cp e
	jr nz, .asm_2c0d
	ld a, [hli]
	cp d
	jr nz, .asm_2c0d
	jr .asm_2c1a

.asm_2c0d
	pop hl
	ld a, 5
	add l
	ld l, a
	jr nc, .asm_2c15
	inc h
.asm_2c15
	dec c
	jr nz, .asm_2c02
	xor a
	ret

.asm_2c1a
	pop hl
	ld de, wcf53
	ld bc, 5
	call CopyBytes
	scf
	ret

CheckCurrentMapXYTriggers::
	ld a, [wd90e]
	and a
	ret z
	ld c, a
	ldh a, [hROMBank]
	push af
	call SwitchToMapScriptsBank
	call .TriggerCheck
	pop hl
	ld a, h
	rst Bankswitch
	ret

.TriggerCheck:
	ld hl, wd90f
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call CheckTriggers
	ld b, a
	ld a, [wPlayerStandingMapX]
	sub 4
	ld d, a
	ld a, [wPlayerStandingMapY]
	sub 4
	ld e, a
.asm_2c4f
	push hl
	ld a, [hli]
	cp b
	jr z, .asm_2c58
	cp $ff
	jr nz, .asm_2c62
.asm_2c58
	ld a, [hli]
	cp e
	jr nz, .asm_2c62
	ld a, [hli]
	cp d
	jr nz, .asm_2c62
	jr .asm_2c6f

.asm_2c62
	pop hl
	ld a, 8
	add l
	ld l, a
	jr nc, .asm_2c6a
	inc h
.asm_2c6a
	dec c
	jr nz, .asm_2c4f
	xor a
	ret

.asm_2c6f
	pop hl
	ld de, wcf53
	ld bc, 8
	call CopyBytes
	scf
	ret

FadeToMenu::
	xor a
	ldh [hBGMapMode], a
	call LoadStandardMenuHeader
	ld a, $23
	ld hl, $440e
	rst FarCall
	call ClearSprites
	call DisableSpriteUpdates
	ret

CloseSubmenu::
	call $345c
	call ReloadTilesetAndPalettes
	call UpdateSprites
	call Call_ExitMenu
	call Functiond13
	jr FinishExitMenu

ExitAllMenus::
	call $345c
	call Call_ExitMenu
	call ReloadTilesetAndPalettes
	call UpdateSprites
	call Functiond13
FinishExitMenu::
	ld b, 9
	call $3596
	call $3469
	ld a, $23
	ld hl, $4403
	rst FarCall
	call EnableSpriteUpdates
	ret

ReturnToMapWithSpeechTextbox::
	push af
	ld a, 1
	ld [wSpriteUpdatesEnabled], a
	call $345c
	call ClearSprites
	call ReloadTilesetAndPalettes
	hlcoord 0, 12
	lb bc, 4, 18
	call Textbox
	ld hl, wVramState
	set 0, [hl]
	call UpdateSprites
	call $3469
	ld b, 9
	call $3596
	call $0359
	call DelayFrame
	ld a, 1
	ldh [hMapAnims], a
	pop af
	ret

ReloadTilesetAndPalettes::
	call DisableLCD
	call ClearSprites
	ld a, $05
	ld hl, $411d
	rst FarCall
	call LoadStandardFont
	call LoadFontsExtra
	ldh a, [hROMBank]
	push af
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
	call SwitchToAnyMapBank
	ld a, $23
	ld hl, $43b9
	rst FarCall
	call OverworldTextModeSwitch
	call LoadTileset
	ld a, 8
	call $3e64
	pop af
	rst Bankswitch
	call EnableLCD
	ret

GetMapHeaderPointer::
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
GetAnyMapHeaderPointer::
	push bc
	dec b
	ld c, b
	ld b, $00
	ld hl, $40ed
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop bc
	dec c
	ld b, 0
	ld a, 9
	call $3210
	ret

GetMapHeaderMember::
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
GetAnyMapHeaderMember::
	ldh a, [hROMBank]
	push af
	ld a, $25
	rst Bankswitch
	call GetAnyMapHeaderPointer
	add hl, de
	ld c, [hl]
	inc hl
	ld b, [hl]
	pop af
	rst Bankswitch
	ret

SwitchToMapBank::
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
SwitchToAnyMapBank::
	call GetAnyMapBank
	rst Bankswitch
	ret

GetMapBank::
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
GetAnyMapBank::
	push hl
	push de
	ld de, 0
	call GetAnyMapHeaderMember
	ld a, c
	pop de
	pop hl
	ret

PartiallyCopyMapHeader::
	ldh a, [hROMBank]
	push af
	ld a, $25
	rst Bankswitch
	call GetMapHeaderPointer
	ld de, wd073
	ld bc, 5
	call CopyBytes
	pop af
	rst Bankswitch
	ret

SwitchToMapScriptsBank::
	ld a, [wd07e]
	rst Bankswitch
	ret

GetMapScriptsBank::
	ld a, [wd07e]
	ret

GetAnyMapBlockdataBank::
	push hl
	push de
	push bc
	push bc
	ld de, 3
	call GetAnyMapHeaderMember
	ld l, c
	ld h, b
	pop bc
	push hl
	ld de, 0
	call GetAnyMapHeaderMember
	pop hl
	ld de, 3
	add hl, de
	ld a, c
	call GetFarByte
	rst Bankswitch
	pop bc
	pop de
	pop hl
	ret

GetSecondaryMapHeaderPointer::
	push bc
	push de
	ld de, 3
	call GetMapHeaderMember
	ld l, c
	ld h, b
	pop de
	pop bc
	ret

GetMapPermission::
	push hl
	push de
	push bc
	ld de, 2
	call GetMapHeaderMember
	ld a, c
	pop bc
	pop de
	pop hl
	ret

Function2dde::
	ret

GetAnyMapPermission::
	push hl
	push de
	push bc
	ld de, 2
	call GetAnyMapHeaderMember
	ld a, c
	pop bc
	pop de
	pop hl
	ret

GetAnyMapTileset::
	ld de, 1
	call GetAnyMapHeaderMember
	ld a, c
	ret

GetWorldMapLocation::
	push hl
	push de
	push bc
	ld de, 5
	call GetAnyMapHeaderMember
	ld a, c
	pop bc
	pop de
	pop hl
	ret

GetMapMusic::
	push hl
	push bc
	ld de, MAP_MUSIC
	call GetMapHeaderMember
	ld a, c
	cp MUSIC_MAHOGANY_MART
	jr z, .mahoganymart
	bit RADIO_TOWER_MUSIC_F, c
	jr nz, .radiotower
	ld e, c
	ld d, 0
.done
	pop bc
	pop hl
	ret

.radiotower
	ld a, [wStatusFlags2]
	bit STATUSFLAGS2_ROCKETS_IN_RADIO_TOWER_F, a
	jr z, .clearedradiotower
	ld de, MUSIC_ROCKET_OVERTURE
	jr .done

.clearedradiotower
	; the rest of the byte
	ld a, c
	and RADIO_TOWER_MUSIC - 1
	ld e, a
	ld d, 0
	jr .done

.mahoganymart
	ld a, [wStatusFlags2]
	bit STATUSFLAGS2_ROCKETS_IN_MAHOGANY_F, a
	jr z, .clearedmahogany
	ld de, MUSIC_ROCKET_HIDEOUT
	jr .done

.clearedmahogany
	ld de, MUSIC_CHERRYGROVE_CITY
	jr .done

GetMapTimeOfDay::
	call GetPhoneServiceTimeOfDayByte
	and $f
	ret

GetMapPhoneService::
	call GetPhoneServiceTimeOfDayByte
	and $f0
	swap a
	ret

GetPhoneServiceTimeOfDayByte::
	push hl
	push bc
	ld de, 7
	call GetMapHeaderMember
	ld a, c
	pop bc
	pop hl
	ret

GetFishingGroup::
	push de
	push hl
	push bc
	ld de, 8
	call GetMapHeaderMember
	ld a, c
	pop bc
	pop hl
	pop de
	ret

LoadMapTileset::
	push hl
	push bc
	ld hl, $5632
	ld bc, $f
	ld a, [wd074]
	call AddNTimes
	ld de, wTilesetBank
	ld bc, $f
	ld a, 5
	call FarCopyBytes
	pop bc
	pop hl
	ret

InexplicablyEmptyFunction::
; Inexplicably empty.
; Seen in PredefPointers.
rept 16
	nop
endr
	ret