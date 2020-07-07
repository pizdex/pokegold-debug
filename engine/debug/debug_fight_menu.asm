DebugFightMenu:
	ld a, 1
	ldh [hInMenu], a

	ld a, 1 << RISINGBADGE ; All pokemon will obey
	ld [wJohtoBadges], a

	ld hl, wNumKeyItems
	xor a
	ld [hli], a
	dec a
	ld [hl], a

	xor a
	ld hl, wNumBalls
	ld [hli], a
	dec a
	ld [hl], a

	ld hl, wNumItems
	xor a
	ld [hli], a
	dec a
	ld [hld], a

	ld de, DebugFight_ItemData
.load_items
	ld a, [de]
	cp $ff
	jr z, .ChoosePlayerParty
	inc de
	ld [wCurItem], a
	ld a, [de]
	inc de
	ld [wItemQuantityChangeBuffer], a
	push de
	call ReceiveItem
	pop de
	jr .load_items

.ChoosePlayerParty:
	callfar unk_03e_40a6
	call ClearTilemap
	call ClearSprites

	hlcoord 0, 0
	ld b, 1
	ld c, 18
	call Textbox

	hlcoord 6, 1
	ld de, DebugFight_TestFightText
	call PlaceString

	hlcoord 4, 4
	ld de, DebugFight_PlayerPartyHeaderText
	call PlaceString

	hlcoord 1, 6
	ld de, DebugFight_DefaultPlayerPartyText
	call PlaceString

	xor a
	ld [wCurPartyMon], a
	ld [wEnemyMon], a
	ld [wEnemyMonLevel], a
	ld [wTrainerClass], a
	ld [wdcb3], a
	ld b, a
	ld c, a
	ld hl, wDebugFightMonLevel
	call DebugFight_ResetParty
	ld hl, wPartyCount
	call DebugFight_ResetParty

	ld de, wPartySpecies
	hlcoord 4, 6

DebugFight_PlaceArrow:
	push hl
	push bc
	dec hl
	ld a, "▶"
	ld [hl], a
	ld bc, 11
	add hl, bc
	ld a, " "
	ld [hl], a
	push de ; Extra code?
	pop de
	pop bc
	pop hl

DebugFight_JoypadSpecies:
	push bc
	push de
	call DelayFrame
	call JoyTextDelay
	pop de
	pop bc

	ldh a, [hJoyLast]
	bit A_BUTTON_F, a
	jp nz, DebugFight_IncrementSpecies
	bit B_BUTTON_F, a
	jp nz, DebugFight_DecrementSpecies
	bit START_F, a
	jp nz, DebugFight_StartButton
	bit D_RIGHT_F, a
	jp nz, DebugFight_ChangeToLevelColumn
	bit D_UP_F, a
	jp nz, DebugFight_PreviousSpecies
	bit D_DOWN_F, a
	jp nz, DebugFight_NextSpecies
	bit SELECT_F, a
	jr z, DebugFight_JoypadSpecies

	ld hl, wDebugFlags
	res 0, [hl]
	ld a, 1
	jp Predef

DebugFight_ResetParty:
	xor a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ret

DebugFight_ItemData:
	db MASTER_BALL, 99
	db ULTRA_BALL, 99
	db GREAT_BALL, 99
	db POKE_BALL, 99
	db HEAVY_BALL, 99
	db LEVEL_BALL, 99
	db LURE_BALL , 99
	db FAST_BALL, 99
	db FRIEND_BALL, 99
	db MOON_BALL, 99
	db LOVE_BALL, 99

	db FULL_RESTORE, 99
	db REVIVE, 99
	db MAX_REVIVE, 99
	db X_ATTACK, 99
	db X_DEFEND, 99
	db X_SPEED, 99
	db X_SPECIAL, 99
	db ETHER, 99
	db MAX_ETHER, 99
	db ELIXER, 99
	db GUARD_SPEC, 99
	db POKE_DOLL, 99
	db X_ACCURACY, 99

	db FULL_HEAL, 99
	db SUPER_POTION, 99
	db ANTIDOTE, 99
	db BURN_HEAL, 99
	db ICE_HEAL, 99
	db AWAKENING, 99
	db PARLYZ_HEAL, 99
	db -1

DebugFight_IncrementSpecies:
	inc b
	ld a, b
	cp 254
	jr c, DebugFight_DisplaySpeciesID
	xor a
	ld b, a

DebugFight_DisplaySpeciesID:
; Display the Species ID of the current Pokemon and clear out the old name

	ld [de], a
	ld [wDeciramBuffer], a
	push bc
	push hl
	push de
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum

	inc hl
	push hl
	ld de, DebugFight_EmptyText
	call PlaceString

	ld bc, -20
	add hl, bc
	ld de, DebugFight_EmptyText
	call PlaceString

	pop hl
	ld a, [wDeciramBuffer]
	and a
	jr nz, .print_monstername
	ld de, DebugFight_ChouonpuText
	jr .dex_zero

.print_monstername
	call GetPokemonName

.dex_zero
	call PlaceString
	pop de
	pop hl
	pop bc
	jp DebugFight_JoypadSpecies

DebugFight_DecrementSpecies:
	dec b
	ld a, b
	cp 254
	jp c, DebugFight_DisplaySpeciesID
	ld a, 253
	ld b, a
	jp DebugFight_DisplaySpeciesID

DebugFight_PreviousSpecies:
	ld a, [wCurPartyMon]
	dec a
	cp $ff
	jp z, DebugFight_JoypadSpecies
	ld [wCurPartyMon], a
	dec de
	dec hl
	ld a, " "
	ld [hl], a
	push bc
	ld bc, -40
	add hl, bc
	pop bc
	ld a, "▶"
	ld [hl], a
	inc hl
	push hl
	call LoadSelectedSpecies
	pop hl
	jp DebugFight_JoypadSpecies

DebugFight_NextSpecies:
	ld a, [wCurPartyMon]
	inc a
	cp 6
	jp nc, DebugFight_JoypadSpecies
	ld [wCurPartyMon], a
	inc de
	dec hl
	ld a, " "
	ld [hl], a
	ld bc, 40
	add hl, bc
	ld a, "▶"
	ld [hl], a
	inc hl
	push hl
	call LoadSelectedSpecies
	pop hl
	jp DebugFight_JoypadSpecies

DebugFight_ChangeToLevelColumn:
	push hl
	push bc
	dec hl
	ld a, " "
	ld [hl], a
	ld bc, 11
	add hl, bc
	ld a, "▶"
	ld [hl], a
	pop bc
	pop hl

DebugFight_JoypadLevel:
	push bc
	push de
	call DelayFrame
	call JoyTextDelay
	pop de
	pop bc

	ldh a, [hJoyLast]
	bit A_BUTTON_F, a
	jp nz, DebugFight_IncrementLevel
	bit B_BUTTON_F, a
	jp nz, DebugFight_DecrementLevel
	bit START_F, a
	jp nz, DebugFight_StartButton
	bit D_LEFT_F, a
	jp nz, DebugFight_PlaceArrow
	bit D_UP_F, a
	jp nz, DebugFight_PeviousLevel
	bit D_DOWN_F, a
	jp nz, DebugFight_NextLevel
	jr DebugFight_JoypadLevel

DebugFight_IncrementLevel:
	inc c
	ld a, c
	cp MAX_LEVEL + 1
	jr c, DebugFight_DisplayLevel
	ld a, 1
	ld c, a

DebugFight_DisplayLevel:
	ld a, [wCurPartyMon]
	push de
	ld de, wDebugFightMonLevel ; dcc7
	add e
	ld e, a
	jr nc, .asm_50de
	inc d
.asm_50de
	ld a, c
	ld [de], a
	push bc
	push hl
	ld bc, 11
	add hl, bc
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	pop hl
	pop bc
	pop de
	jp DebugFight_JoypadLevel

DebugFight_DecrementLevel:
	dec c
	ld a, c
	cp MAX_LEVEL + 1
	jr nc, .level_100
	and a
	jp nz, DebugFight_DisplayLevel

.level_100
	ld a, 100
	ld c, a
	jp DebugFight_DisplayLevel

DebugFight_PeviousLevel:
	ld a, [wCurPartyMon]
	dec a
	cp $ff
	jp z, DebugFight_JoypadLevel

	ld [wCurPartyMon], a
	dec de

	push hl
	ld bc, 10
	add hl, bc
	ld a, " "
	ld [hl], a
	pop hl
	ld bc, hBGMapAddress
	add hl, bc

	push hl
	ld bc, 10
	add hl, bc
	ld a, "▶"
	ld [hl], a
	call LoadSelectedSpecies
	pop hl
	jp DebugFight_JoypadLevel

DebugFight_NextLevel:
	ld a, [wCurPartyMon]
	inc a
	cp 6
	jp nc, DebugFight_JoypadLevel

	ld [wCurPartyMon], a
	inc de
	push hl
	ld bc, 10
	add hl, bc
	ld a, " "
	ld [hl], a
	pop hl
	ld bc, 40
	add hl, bc
	push hl
	ld bc, 10
	add hl, bc
	ld a, "▶"
	ld [hl], a
	call LoadSelectedSpecies
	pop hl
	jp DebugFight_JoypadLevel

LoadSelectedSpecies:
	ld hl, wPartySpecies
	ld a, [wCurPartyMon]
	add l
	ld l, a
	jr nc, .enemy_species
	inc h
.enemy_species
	ld a, [hl]
	ld b, a
	ld hl, wDebugFightMonLevel
	ld a, [wCurPartyMon]
	add l
	ld l, a
	jr nc, .done
	inc h
.done
	ld a, [hl]
	ld c, a
	ret

DebugFight_StartButton:
	ld hl, wPartyCount
	ld de, wDebugFightMonLevel - 1
	xor a
	ld [hl], a
	inc hl
	ld a, [hli]
	ld b, a
	ld c, 6
	xor a
	ld [wBattleMode], a
.asm_5180:
	ld a, b
	ld [wCurPartySpecies], a
	ld a, [hl]
	ld b, a
	inc de
	ld a, [de]
	and a
	jr z, .asm_51a3
	ld [wCurPartyLevel], a
	xor a
	ld [wMonType], a
	ld a, [wCurPartySpecies]
	and a
	jr z, .asm_51a3
	push hl
	push de
	push bc
	ld a, 6
	call Predef
	pop bc
	pop de
	pop hl
.asm_51a3
	inc hl
	dec c
	jr nz, .asm_5180

	ld b, 7
	ld hl, wPartySpecies
	ld de, wDebugFightMonLevel - 1
.asm_51af:
	inc de
	dec b
	jp z, DebugFightMenu
	ld a, [hli]
	and a
	jr z, .asm_51af
	ld a, [de]
	and a
	jr z, .asm_51af

	ld hl, wTilemap + 60
	ld b, 15
	ld c, 20
	call ClearBox
	ld hl, wTilemap + 60
	ld b, 15
	ld c, 20
	call ClearBox
	ld hl, wTilemap + 60
	ld b, 15
	ld c, 20
	call ClearBox

	ld c, 20
	call DelayFrames

	ld a, 1
	ld [wBattleMode], a
	ld de, DebugFight_WildMonsterText
	ld a, [wdcb3]
	cp 101
	jr c, .asm_51f6
	ld a, 2
	ld [wBattleMode], a
	ld de, DebugFight_TrainerText
.asm_51f6:
	ld hl, wTilemap + 81
	call PlaceString

	ld hl, wTilemap + 121
	ld de, DebugFight_OpponentPartyHeaderText1
	call PlaceString

	ld hl, wTilemap + 180
	ld b, 9
	ld c, 20
	call ClearBox

	ld a, [wEnemyMon]
	ld b, a
	ld a, [wBattleMode]
	dec a
	jr z, .asm_524c

	ld a, [wTrainerClass]
	ld [wDeciramBuffer], a
	ld b, a
	ld de, wDeciramBuffer
	ld hl, wTilemap + 161
	push bc
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum

	ld hl, wTilemap + 165
	ld de, DebugFight_EmptyText2
	call PlaceString

	ld a, [wTrainerClass]
	ld c, a
	callfar unk_00e_5534

	ld hl, wTilemap + 165
	ld de, wcb2a
	call PlaceString
	pop bc
	jr .asm_5271

.asm_524c:
	ld a, b
	and a
	jr z, .asm_5271

	ld de, wDeciramBuffer
	ld [de], a
	ld hl, wTilemap + 161
	push bc
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum

	ld hl, wTilemap + 165
	ld de, DebugFight_EmptyText2
	call PlaceString
	call GetPokemonName
	ld hl, wTilemap + 165
	call PlaceString
	pop bc

.asm_5271:
	ld a, [wEnemyMonLevel]
	ld c, a
	ld de, wDeciramBuffer
	ld [de], a
	ld hl, wTilemap + 176
	push bc
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	pop bc

Jump_03f_5284:
	ld a, " "
	ldcoord_a 0, 8
	ldcoord_a 15, 8
	ld a, "▶"
	ldcoord_a 0, 4

Jump_03f_5291:
	push bc
	call DelayFrame
	call JoyTextDelay
	pop bc
	ldh a, [hJoyLast]
	bit 0, a
	jp nz, Jump_03f_52ac
	bit 3, a
	jp nz, Jump_03f_55df
	bit 7, a
	jp nz, Jump_03f_5307
	jr Jump_03f_5291

Jump_03f_52ac:
	hlcoord 1, 8
	ld de, DebugFight_OpponentPartyHeaderText2
	call PlaceString
	hlcoord 5, 7
	ld de, DebugFight_EmptyText2
	call PlaceString
	xor a
	ld b, a
	ld c, a
	ld a, [wBattleMode]
	dec a
	jr nz, .asm_52e7

	ld a, 2
	ld [wBattleMode], a
	ld a, " "
	ldcoord_a 4, 3
	hlcoord 1, 4
	ld de, DebugFight_TrainerText
	call PlaceString

	hlcoord 0, 9
	ld b, $09
	ld c, $14
	call ClearBox
	jp Jump_03f_5291

.asm_52e7:
	ld a, 1
	ld [wBattleMode], a
	ld a, " "
	ldcoord_a 1, 3
	hlcoord 1, 4
	ld de, DebugFight_WildMonsterText
	call PlaceString

	hlcoord 0, 9
	ld b, $09
	ld c, $14
	call ClearBox
	jp Jump_03f_5291

Jump_03f_5307:
	ld a, "▶"
	ldcoord_a 0, 8
	ld a, " "
	ldcoord_a 15, 8
	ldcoord_a 0, 4

Jump_03f_5314:
	push bc
	call DelayFrame
	call JoyTextDelay
	pop bc
	ldh a, [hJoyLast]
	bit 0, a
	jp nz, Jump_03f_533e
	bit 1, a
	jp nz, Jump_03f_53b4
	bit 3, a
	jp nz, Jump_03f_55df
	bit 4, a
	jp nz, Jump_03f_53ec
	bit 6, a
	jp nz, Jump_03f_5284
	bit 7, a
	jp nz, Jump_03f_54cd
	jr Jump_03f_5314

Jump_03f_533e:
	push bc
	ld hl, $c431
	ld de, DebugFight_EmptyText2
	call PlaceString
	ld hl, $c445
	ld de, DebugFight_EmptyText2
	call PlaceString
	pop bc
	ld a, [wBattleMode]
	dec a
	jr z, Function_03f_538b
	inc b
	ld a, b
	cp $43
	jr c, Jump_03f_5360
	ld b, 1

Jump_03f_5360:
	ld a, b
	ld [wDeciramBuffer], a
	ld de, wDeciramBuffer
	ld hl, $c441
	push bc
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	ld a, [wDeciramBuffer]
	ld [wTrainerClass], a
	ld c, a
	callfar unk_00e_5534
	ld hl, $c445
	ld de, wcb2a
	call PlaceString
	pop bc
	jp Jump_03f_5314

Function_03f_538b:
	inc b
	ld a, b
	cp $fe
	jr c, Jump_03f_5393
	ld b, 1

Jump_03f_5393:
	ld a, b
	ld [wDeciramBuffer], a
	ld de, wDeciramBuffer
	ld hl, $c441
	push bc
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	call GetPokemonName
	ld hl, $c445
	call PlaceString
	pop bc
	call Call_03f_544d
	jp Jump_03f_5314

Jump_03f_53b4:
	push bc
	ld hl, $c431
	ld de, DebugFight_EmptyText2
	call PlaceString
	ld hl, $c445
	ld de, DebugFight_EmptyText2
	call PlaceString
	pop bc
	ld a, [wBattleMode]
	dec a
	jr z, .asm_53dd
	dec b
	ld a, b
	cp $43
	jr nc, .asm_53d8
	and a
	jp nz, Jump_03f_5360

.asm_53d8
	ld b, $3d
	jp Jump_03f_5360

.asm_53dd
	dec b
	ld a, b
	cp $fe
	jr nc, .asm_53e7
	and a
	jp nz, Jump_03f_5393

.asm_53e7
	ld b, $fd
	jp Jump_03f_5393

Jump_03f_53ec:
	ld a, " "
	ld [$c440], a
	ld a, "▶"
	ld [$c44f], a

Jump_03f_53f6:
	push bc
	call DelayFrame
	call JoyTextDelay
	pop bc
	ldh a, [hJoyLast]
	bit 0, a
	jp nz, Jump_03f_5420
	bit 1, a
	jp nz, Jump_03f_543e
	bit 3, a
	jp nz, Jump_03f_55df
	bit 5, a
	jp nz, Jump_03f_5307
	bit 6, a
	jp nz, Jump_03f_5284
	bit 7, a
	jp nz, Jump_03f_54cd
	jr Jump_03f_53f6

Jump_03f_5420:
	inc c
	ld a, c
	cp $65
	jr c, .asm_5428
	ld c, $01
.asm_5428:
	ld hl, $c450
	ld a, c
	ld de, wCurPartyLevel
	ld [de], a
	push bc
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	pop bc
	call Call_03f_544d
	jp Jump_03f_53f6

Jump_03f_543e:
	dec c
	ld a, c
	cp $65
	jr nc, .asm_5448

	and a
	jp nz, Jump_03f_5420.asm_5428

.asm_5448:
	ld c, $64
	jp Jump_03f_5420.asm_5428

Call_03f_544d:
	ld a, [wBattleMode]
	dec a
	ret nz

	push bc
	ld a, b
	ld [wCurPartySpecies], a
	hlcoord 0, 9
	ld b, $09
	ld c, $14
	call ClearBox
	xor a
	ld [wd0c5], a
	ld hl, wListMoves_MoveIndicesBuffer
	ld bc, $0004
	call ByteFill
	ld de, wListMoves_MoveIndicesBuffer
	ld a, $1b
	call Predef
	ld a, $28
	ld [wd0c5], a
	ld hl, $c46d
	ld a, $20
	call Predef
	call Call_03f_55ce
	ld hl, $c469
	ld de, wListMoves_MoveIndicesBuffer
	ld b, $04

.asm_548e:
	ld a, [de]
	and a
	jr z, .asm_54cb

	push bc
	push hl
	push de
	push hl
	ld de, wStringBuffer1
	ld [de], a
	lb bc, $01, 3
	push af
	call PrintNum
	pop af
	dec a
	ld hl, $5c6c + 5
	ld bc, 7
	call AddNTimes
	ld a, $10
	call GetFarByte
	ld de, wStringBuffer1
	ld [de], a
	pop hl
	ld bc, $000f
	add hl, bc
	ld bc, $0103
	call PrintNum
	pop de
	pop hl
	inc de
	ld bc, $0028
	add hl, bc
	pop bc
	dec b
	jr nz, .asm_548e

.asm_54cb
	pop bc
	ret

Jump_03f_54cd:
	ld hl, $c440
	ld [hl], " "
	ld hl, $c44f
	ld [hl], " "
	ld a, [wBattleMode]
	dec a
	jp nz, Jump_03f_5307

	push bc
	ld hl, $c468
	ld [hl], "▶"
	ld de, wListMoves_MoveIndicesBuffer
	ld b, 1

Jump_03f_54e9:
	call DelayFrame
	call JoyTextDelay
	ldh a, [hJoyLast]
	bit 0, a
	jp nz, Jump_03f_550c
	bit 1, a
	jp nz, Jump_03f_5514
	bit 3, a
	jp nz, Jump_03f_55ca
	bit 6, a
	jp nz, Jump_03f_559b
	bit 7, a
	jp nz, Jump_03f_55ad
	jr Jump_03f_54e9

Jump_03f_550c:
	ld a, [de]
	inc a
	cp $fc
	jr c, Function_03f_553d
	jr Jump_03f_5514.asm_551e

Jump_03f_5514:
	ld a, [de]
	and a
	ld a, $fb
	jr z, Function_03f_553d
	ld a, [de]
	dec a
	jr nz, Function_03f_553d

.asm_551e:
	xor a
	ld [de], a
	push de
	push bc
	push hl
	ld bc, hClockResetTrigger
	add hl, bc
	ld bc, $020b
	call ClearBox
	pop hl
	push hl
	ld bc, $0011
	add hl, bc
	ld a, " "
	ld [hli], a
	ld [hl], a
	pop hl
	pop bc
	pop de
	jp Jump_03f_54e9

Function_03f_553d:
	ld [de], a
	ld [wCurSpecies], a
	push hl
	push de
	push bc
	push hl
	push hl
	ld bc, hClockResetTrigger
	add hl, bc
	ld bc, $020b
	call ClearBox
	pop hl
	push hl
	ld bc, $0011
	add hl, bc
	ld a, " "
	ld [hli], a
	ld [hl], a
	pop hl
	ld de, wCurSpecies
	ld bc, $0103
	inc hl
	call PrintNum
	ld a, $02
	ld [wNamedObjectTypeBuffer], a
	call GetName
	ld de, wStringBuffer1
	inc hl
	call PlaceString
	ld a, [wCurSpecies]
	dec a
	ld hl, $5c6c + 5
	ld bc, 7
	call AddNTimes
	ld a, $10
	call GetFarByte
	ld de, wStringBuffer1
	ld [de], a
	pop hl
	ld bc, $0010
	add hl, bc
	ld bc, $0103
	call PrintNum
	pop bc
	pop de
	pop hl
	jp Jump_03f_54e9

Jump_03f_559b:
	ld [hl], " "
	dec b
	jp z, Jump_03f_55c6
	dec de
	push bc
	ld bc, hBGMapAddress
	add hl, bc
	pop bc
	ld [hl], "▶"
	jp Jump_03f_54e9

Jump_03f_55ad:
	inc b
	ld a, b
	cp $05
	jr nc, .asm_55c1

	inc de
	ld [hl], " "
	push bc
	ld bc, $0028
	add hl, bc
	pop bc
	ld [hl], "▶"
	jp Jump_03f_54e9

.asm_55c1
	ld b, 4
	jp Jump_03f_54e9

Jump_03f_55c6:
	pop bc
	jp Jump_03f_5307

Jump_03f_55ca:
	pop bc
	jp Jump_03f_55df

Call_03f_55ce:
	ld hl, $c475
	ld de, $0027
	ld b, $04
	ld a, $3e
.asm_55d8
	ld [hli], a
	ld [hl], a
	add hl, de
	dec b
	jr nz, .asm_55d8
	ret

Jump_03f_55df:
	ld a, b
	and a
	jp z, Jump_03f_5284

	ld a, c
	and a
	jp z, Jump_03f_5284

	ld a, [wBattleMode]
	dec a
	jr z, .asm_55f9

	ld a, b
	ld [wOtherTrainerClass], a
	ld a, c
	ld [wd10d], a
	jr .asm_5601

.asm_55f9:
	ld a, c
	ld [wCurPartyLevel], a
	ld a, b
	ld [wd109], a

.asm_5601:
	call SetPalettes
	ld a, $80
	ld [wJohtoBadges], a
	ld hl, unkData_03f_57cf
	ld de, wPlayerName
	ld bc, 6
	call CopyBytes
	ld a, $16
	call Predef
	ld a, $01
	ldh [hBGMapMode], a
	ldh [hInMenu], a
	xor a
	ld [wd145], a
	ld hl, wPlayerSubStatus1
	ld bc, $0005
	call ByteFill
	ld hl, wEnemySubStatus1
	ld bc, $0005
	call ByteFill
	call LoadStandardFont
	ld hl, $40a6
	ld a, $3e
	rst $08
	call ClearTilemap
	call ClearSprites
	ld a, $e4
	call DmgToCgbBGPals
	ld de, $e4e4
	call DmgToCgbObjPals
	ld hl, wTilemap
	ld b, $01
	ld c, $12
	call Textbox
	ld hl, $c3ba
	ld de, DebugFight_TestFightText
	call PlaceString
	ld hl, $c3f4
	ld de, DebugFight_PlayerPartyHeaderText
	call PlaceString
	ld hl, $c419
	ld de, DebugFight_DefaultPlayerPartyText
	call PlaceString
	ld de, wPartyCount
	xor a
	ld [de], a
	ld [wCurPartyMon], a
	inc de
	ld hl, $c41c
	push de
	push hl

Jump_03f_5683:
	ld a, [wCurPartyMon]
	ld de, wPartySpecies
	add e
	ld e, a
	jr nc, .asm_568e
	inc d
.asm_568e:
	ld a, [de]
	cp $ff
	jp z, Jump_03f_56e9

	ld [wDeciramBuffer], a
	push hl
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	inc hl
	ld de, DebugFight_EmptyText
	call PlaceString
	call GetPokemonName
	call PlaceString
	pop hl
	push hl
	ld bc, $000b
	add hl, bc
	push hl
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Level
	ld bc, $0030
	call AddNTimes
	ld d, h
	ld e, l
	ld a, [de]
	ld [wCurPartyLevel], a
	pop hl
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	ld a, [wCurPartyMon]
	ld de, wDebugFightMonLevel
	add e
	ld e, a
	jr nc, .asm_56d6
	inc d
.asm_56d6:
	ld a, [wCurPartyLevel]
	ld [de], a
	pop hl
	ld a, [wCurPartyMon]
	inc a
	ld [wCurPartyMon], a
	ld bc, $0028
	add hl, bc
	jp Jump_03f_5683

Jump_03f_56e9:
	pop hl
	pop de
	ld a, [wPartyMon1]
	ld b, a
	ld a, [wPartyMon1Level]
	ld c, a
	xor a
	ld [wCurPartyMon], a
	jp DebugFight_PlaceArrow

DebugFight_TestFightText:
	db "テスト ファイト@" ; Test Fight

DebugFight_PlayerPartyHeaderText:
     ; No.  Name    LVL
	db "№．  なまえ    レべル@"

DebugFight_DefaultPlayerPartyText:
	db "1．▶000 ーーーーー  000<NEXT>"
	db "2． 000 ーーーーー  000<NEXT>"
	db "3． 000 ーーーーー  000<NEXT>"
	db "4． 000 ーーーーー  000<NEXT>"
	db "5． 000 ーーーーー  000<NEXT>"
	db "6． 000 ーーーーー  000@"

DebugFight_EmptyText:
	db "     @"

DebugFight_ChouonpuText:
	db "ーーーーー@"

DebugFight_WildMonsterText:
	db "ワイルドモンスター@" ; Wild Monster

DebugFight_TrainerText:
	db "ディーラー    @" ; Dealer (Trainer)

DebugFight_OpponentPartyHeaderText1:
     ; No.  Name        LVL
	db "№．  なまえ        レべル<NEXT>"
DebugFight_OpponentPartyHeaderText2:
	db "000 ーーーーーーーーーー 000@"

DebugFight_EmptyText2:
	db "          @"

unkData_03f_57cf:
	db "ゴールド@@" ; GOLD

unkData_03f_57d4:
	db $03, 99
	db $04, 99
	db $0B, 99
	db $10, 99
	db $11, 99
	db $12, 99
	db $13, 99
	db $14, 99
	db $FF

unk_03f_57e6:
	ld a, 1
	call OpenSRAM
	ld a, [s1_ad10]
	cp $1e
	call CloseSRAM
	jp nc, Jump_03f_5b51
	call ClearTilemap
	call UpdateSprites
	ld a, [wOptions]
	push af
	set 4, a
	ld [wOptions], a
	xor a
	ld hl, wddee
	ld [hli], a
	ld [hli], a
	ld [hl], a
	inc a
	ldh [hInMenu], a
	ld [wCurItem], a
	ld a, [wCurPartySpecies]
	cp $fc
	jr c, jr_03f_581e
	ld a, 1
	ld [wCurPartySpecies], a
jr_03f_581e:
	ld a, [wCurPartyLevel]
	dec a
	cp 100
	jr c, Jump_03f_582b
	ld a, 1
	ld [wCurPartyLevel], a
Jump_03f_582b:
	ld hl, $c3dc
	ld [hl], " "
	ld hl, $c3b4
	ld [hl], "▶"
	call Call_03f_5868
jr_03f_5838:
	call DelayFrame
	call JoyTextDelay
	ldh a, [hJoyLast]
	bit 0, a
	jp nz, Jump_03f_5851
	bit 1, a
	jp nz, Jump_03f_585e
	bit 7, a
	jp nz, Jump_03f_5897
	jr jr_03f_5838

Jump_03f_5851:
	ld hl, wCurPartySpecies
	inc [hl]
	ld a, [hl]
	cp $fc
	jr c, Jump_03f_582b
	ld [hl], 1
	jr Jump_03f_582b

Jump_03f_585e:
	ld hl, wCurPartySpecies
	dec [hl]
	jr nz, Jump_03f_582b
	ld [hl], $fb
	jr Jump_03f_582b

Call_03f_5868::
	hlcoord 1, 0
	ld b, 2
	ld c, 9
	call ClearBox
	hlcoord 1, 1
	ld de, wCurPartySpecies
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	inc hl
	push hl
	ld a, [wCurPartySpecies]
	ld [wTempSpecies], a
	call GetPokemonName
	pop hl
	call PlaceString
	ld a, [wTempSpecies]
	ld [wCurSpecies], a
	call GetBaseData
	ret

Jump_03f_5897:
	ld hl, $c3b4
	ld [hl], " "
	ld hl, $c3dc
	ld [hl], "▶"
	ld hl, $c404
	ld [hl], " "
	call Call_03f_58e3
	call Call_03f_58f0
jr_03f_58ac:
	call DelayFrame
	call JoyTextDelay
	ld hl, wCurPartyLevel
	ldh a, [hJoyLast]
	bit 0, a
	jp nz, Jump_03f_58d2
	bit 1, a
	jp nz, Jump_03f_58dc
	bit 3, a
	jp nz, Jump_03f_5ae4
	bit 6, a
	jp nz, Jump_03f_582b
	bit 7, a
	jp nz, Jump_03f_593e
	jr jr_03f_58ac

Jump_03f_58d2:
	inc [hl]
	ld a, [hl]
	cp 101
	jr c, Jump_03f_5897
	ld [hl], 1
	jr Jump_03f_5897

Jump_03f_58dc:
	dec [hl]
	jr nz, Jump_03f_5897
	ld [hl], 100
	jr Jump_03f_5897

Call_03f_58e3:
	hlcoord 1, 3
	ld de, wCurPartyLevel
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	ret

Call_03f_58f0:
	hlcoord 1, 4
	ld b, $08
	ld c, $0b
	call ClearBox
	ld hl, wListMoves_MoveIndicesBuffer
	ld bc, 4
	xor a
	call ByteFill
	xor a
	ld [wDebugClockCurrentOption], a
	ld de, wListMoves_MoveIndicesBuffer
	ld a, $1b
	call Predef
	ld hl, $c405
	ld de, wListMoves_MoveIndicesBuffer
	ld b, $04
jr_03f_5918:
	ld a, [de]
	inc de
	and a
	jr z, jr_03f_593d
	push de
	push bc
	push hl
	ld [wApplyStatLevelMultipliersToEnemy], a
	ld de, wApplyStatLevelMultipliersToEnemy
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	inc hl
	call GetMoveName
	call PlaceString
	pop hl
	ld bc, $28
	add hl, bc
	pop bc
	pop de
	dec b
	jr nz, jr_03f_5918

jr_03f_593d:
	ret

Jump_03f_593e:
	ld de, wListMoves_MoveIndicesBuffer
	ld hl, $c404
	ld b, $01

Jump_03f_5946:
jr_03f_5946:
	call Call_03f_59a3

jr_03f_5949:
	call DelayFrame
	push de
	push bc
	call JoyTextDelay
	pop bc
	pop de
	ldh a, [hJoyLast]
	bit 0, a
	jp nz, Jump_03f_5970
	bit 1, a
	jp nz, Jump_03f_597c
	bit 3, a
	jp nz, Jump_03f_5ae4
	bit 6, a
	jp nz, Jump_03f_5986
	bit 7, a
	jp nz, Jump_03f_5993
	jr jr_03f_5949

Jump_03f_5970:
	ld a, [de]
	inc a
	ld [de], a
	cp $fc
	jr c, jr_03f_5946
	ld a, $01
	ld [de], a
	jr jr_03f_5946

Jump_03f_597c:
	ld a, [de]
	dec a
	ld [de], a
	jr nz, jr_03f_5946

	ld a, $fb
	ld [de], a
	jr jr_03f_5946

Jump_03f_5986:
	dec de
	dec b
	jp z, Jump_03f_5897

	push bc
	ld bc, hBGMapAddress
	add hl, bc
	pop bc
	jr jr_03f_5946

Jump_03f_5993:
	inc de
	inc b
	ld a, b
	cp $05
	jp z, Jump_03f_59ee

	push bc
	ld bc, $0028
	add hl, bc
	pop bc
	jr jr_03f_5946

Call_03f_59a3:
	push hl
	push de
	push bc
	push hl
	push de
	ld bc, hClockResetTrigger
	add hl, bc
	ld bc, $020b
	call ClearBox
	pop de
	pop hl
	push hl
	ld [hl], "▶"
	ld bc, hBGMapAddress
	add hl, bc
	ld [hl], " "
	ld bc, $0050
	add hl, bc
	ld [hl], " "
	pop hl
	inc hl
	ld a, [de]
	ld de, wApplyStatLevelMultipliersToEnemy
	ld [de], a
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	ld a, [wApplyStatLevelMultipliersToEnemy]
	and a
	jr z, jr_03f_59e0

	call Call_03f_59e4
	inc hl
	call GetMoveName
	call PlaceString

jr_03f_59e0:
	pop bc
	pop de
	pop hl
	ret

Call_03f_59e4:
	push hl
	call Call_03f_5b65
	pop hl
	jr c, jr_03f_59ed
	ld [hl], $f1
jr_03f_59ed:
	ret

Jump_03f_59ee:
	ld de, wddee
	ld hl, $c4a4
	ld b, $01

jr_03f_59f6:
	call Call_03f_5a51
jr_03f_59f9:
	call DelayFrame
	push de
	push bc
	call JoyTextDelay
	pop bc
	pop de
	ldh a, [hJoyLast]
	bit 0, a
	jp nz, Jump_03f_5a20
	bit 1, a
	jp nz, Jump_03f_5a25
	bit 3, a
	jp nz, Jump_03f_5ae4
	bit 6, a
	jp nz, Jump_03f_5a2a
	bit 7, a
	jp nz, Jump_03f_5a42
	jr jr_03f_59f9

Jump_03f_5a20:
	ld a, [de]
	inc a
	ld [de], a
	jr jr_03f_59f6

Jump_03f_5a25:
	ld a, [de]
	dec a
	ld [de], a
	jr jr_03f_59f6

Jump_03f_5a2a:
	dec de
	dec b
	jp z, Jump_03f_5a37
	push bc
	ld bc, hBGMapAddress
	add hl, bc
	pop bc
	jr jr_03f_59f6

Jump_03f_5a37:
	ld de, $d13e
	ld hl, $c47c
	ld b, $04
	jp Jump_03f_5946

Jump_03f_5a42:
	ld a, b
	cp 3
	jr z, jr_03f_59f6
	inc b
	inc de
	push bc
	ld bc, $28
	add hl, bc
	pop bc
	jr jr_03f_59f6

Call_03f_5a51:
	push hl
	push de
	push bc
	push hl
	ld [hl], "▶"
	ld bc, hBGMapAddress
	add hl, bc
	ld [hl], " "
	ld bc, $50
	add hl, bc
	ld [hl], " "
	pop hl
	inc hl
	ld a, [de]
	ld de, wApplyStatLevelMultipliersToEnemy
	ld [de], a
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	call Call_03f_5a77
	pop bc
	pop de
	pop hl
	ret

Call_03f_5a77::
	hlcoord 12, 0
	ld b, 18
	ld c, 8
	call ClearBox
	hlcoord 13, 1
	ld de, unkData_03f_5ac9
	call PlaceString
	ld b, $a
	ld hl, wd010
	ld a, [wddf0]
.asm_5a92
	ld [hli], a
	dec b
	jr nz, .asm_5a92
	ld a, [wddee]
	ld [hli], a
	ld a, [wddef]
	ld [hl], a
	ld hl, wd00f
	ld de, wd029
	ld b, 1
	ld a, 12
	call Predef
	hlcoord 17, 1
	ld de, wd029
	ld b, 6
.asm_5ab3
	push bc
	push de
	push hl
	lb bc, PRINTNUM_LEADINGZEROS | 2, 3
	call PrintNum
	pop hl
	ld bc, $28
	add hl, bc
	pop de
	inc de
	inc de
	pop bc
	dec b
	jr nz, .asm_5ab3
	ret

unkData_03f_5ac9:
	db "たいリき"
	next "<KOUGEKI>"
	next "ぼうぎょ"
	next "すばやさ"
	next "とくこう"
	next "とくぼう@"

Jump_03f_5ae4:
	ld a, [wCurPartyLevel]
	ld [wEnemyMonLevel], a
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	call GetBaseData
	ld a, [wCurPartySpecies]
	ld [wEnemyMon], a
	ld hl, wEnemyMonHP
	ld a, [wd029]
	ld [hli], a
	ld a, [wd02a]
	ld [hli], a
	xor a
	ld [wEnemyMonStatus], a
	ld [$d0f0], a
	ld hl, wEnemyMonMoves
	ld a, [wListMoves_MoveIndicesBuffer]
	ld [hli], a
	ld a, [$d13c]
	ld [hli], a
	ld a, [$d13d]
	ld [hli], a
	ld a, [$d13e]
	ld [hl], a
	ld hl, wEnemyMonPP
	xor a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld a, [wddee]
	ld [wEnemyMonDVs], a
	ld a, [wddef]
	ld [$d0e8], a
	ld a, $09
	call Predef
	ld a, $01
	call OpenSRAM
	ld b, $0a
	ld hl, s1_ad3b
	ld a, [wddf0]

jr_03f_5b44:
	ld [hli], a
	dec b
	jr nz, jr_03f_5b44

	call CloseSRAM
	pop af
	ld [wOptions], a
	jr jr_03f_5b57

Jump_03f_5b51:
	ld hl, unkData_03f_5b58
	call PrintText

jr_03f_5b57:
	ret

unkData_03f_5b58:
; The BOX is full!
	text "ボックスが いっぱい!"
	done

Call_03f_5b65:
	ld a, [wCurPartySpecies]
	push af
	call Call_03f_5b99
	jr c, .asm_5b93
	ld a, $10
	ld hl, $692f
	rst FarCall
	jr nc, .asm_5b88
	call Call_03f_5b99
	jr c, .asm_5b93

	ld a, $10
	ld hl, $692f
	rst FarCall
	jr nc, .asm_5b88
	call Call_03f_5b99
	jr c, .asm_5b93

.asm_5b88:
	call Call_03f_5be8
	jr c, .asm_5b93
	pop af
	ld [wCurPartySpecies], a
	and a
	ret

.asm_5b93:
	pop af
	ld [wCurPartySpecies], a
	scf
	ret

Call_03f_5b99:
	ld a, [wApplyStatLevelMultipliersToEnemy]
	ld [wTMHMMove], a
	ld a, $0e
	call Predef
	ld a, c
	and a
	jr nz, .asm_5bc5
	ld a, [wApplyStatLevelMultipliersToEnemy]
	ld d, a
	call Call_03f_5c0e
.asm_5baf:
	ld a, $10
	call GetFarByte
	inc hl
	and a
	jr z, .asm_5bc3
	ld a, $10
	call GetFarByte
	inc hl
	cp d
	jr z, .asm_5bc5
	jr .asm_5baf

.asm_5bc3:
	and a
	ret

.asm_5bc5:
	scf
	ret

unkData_03f_5bc7:
	db 007, 009, 010, 014, 016, 020, 022, 028
	db 049, 066, 083, 089, 091, 099, 100, 103
	db 104, 105, 114, 125, 126, 139, 142, 149
	db 152, 154, 155, 178, 179, 180, 187, 190
	db -1

Call_03f_5be8:
	ld hl, $7b07
	ld a, [wCurPartySpecies]
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, $08
	call GetFarHalfword
.asm_5bf9:
	ld a, $08
	call GetFarByte
	inc hl
	cp $ff
	jr z, .asm_5c0c
	ld b, a
	ld a, [wApplyStatLevelMultipliersToEnemy]
	cp b
	jr nz, .asm_5bf9
	scf
	ret

.asm_5c0c:
	and a
	ret

Call_03f_5c0e:
	ld hl, $695f
	ld b, 0
	ld a, [wCurPartySpecies]
	dec a
	ld c, a
	add hl, bc
	add hl, bc
	ld a, $10
	call GetFarHalfword
.asm_5c1f:
	ld a, $10
	call GetFarByte
	inc hl
	and a
	jr nz, .asm_5c1f
	ret
