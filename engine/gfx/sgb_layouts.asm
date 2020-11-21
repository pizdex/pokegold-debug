LoadSGBLayout:
	call CheckCGB
	jp nz, LoadSGBLayoutCGB

	ld a, b
	cp SCGB_DEFAULT
	jr nz, .not_default
	ld a, [wDefaultSGBLayout]
.not_default
	cp SCGB_PARTY_MENU_HP_BARS
	jp z, SGB_ApplyPartyMenuHPPals
	ld l, a
	ld h, 0
	add hl, hl
	ld de, .Jumptable
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, _LoadSGBLayout_ReturnFromJumpTable
	push de
	jp hl

.Jumptable:
	dw .SGB_BattleGrayscale
	dw .SGB_BattleColors
	dw .SGB_PokegearPals
	dw .SGB_StatsScreenHPPals
	dw .SGB_Pokedex
	dw .SGB_SlotMachine
	dw .SGB_BetaTitleScreen
	dw .SGB_GSIntro
	dw .SGB_Diploma
	dw .SGB_MapPals
	dw .SGB_PartyMenu
	dw .SGB_Evolution
	dw .SGB_GSTitleScreen
	dw .SGB_Unused0D
	dw .SGB_MoveList
	dw .SGB_BetaPikachuMinigame
	dw .SGB_PokedexSearchOption
	dw .SGB_BetaPoker
	dw .SGB_Pokepic
	dw .SGB_MagnetTrain
	dw .SGB_PackPals
	dw .SGB_TrainerCard
	dw .SGB_PokedexUnownMode
	dw .SGB_BillsPC
	dw .SGB_UnownPuzzle
	dw .SGB_GamefreakLogo
	dw .SGB_PlayerOrMonFrontpicPals
	dw .SGB_TradeTube
	dw .SGB_TrainerOrMonFrontpicPals
	dw .SGB_MysteryGift
	dw .SGB_Unused1E

.SGB_BattleGrayscale:
	ld hl, $6389
	ld de, $61c9
	ret

.SGB_BattleColors:
	ld hl, $61c9
	call PushSGBPals

	ld hl, $6409
	ld de, wSGBPals
	ld bc, $0010
	call CopyBytes

	ld a, [wPlayerHPPal]
	ld l, a
	ld h, $00
	add hl, hl
	add hl, hl
	ld de, $6fe1
	add hl, de

	ld a, [hli]
	ld [wcca0], a
	ld a, [hli]
	ld [wcca1], a
	ld a, [hli]
	ld [wcca2], a
	ld a, [hl]
	ld [wcca3], a

	ld a, [wEnemyHPPal]
	ld l, a
	ld h, $00
	add hl, hl
	add hl, hl

	ld de, $6fe1
	add hl, de
	ld a, [hli]
	ld [wcca6], a
	ld a, [hli]
	ld [wcca7], a
	ld a, [hli]
	ld [wcca8], a
	ld a, [hl]
	ld [wcca9], a

	ld hl, $6419
	ld de, wSGBPals + PALPACKET_LENGTH
	ld bc, PALPACKET_LENGTH
	call CopyBytes

	call GetBattlemonBackpicPalettePointer

	ld a, [hli]
	ld [wSGBPals + 19], a
	ld a, [hli]
	ld [wSGBPals + 20], a
	ld a, [hli]
	ld [wSGBPals + 21], a
	ld a, [hl]
	ld [wSGBPals + 22], a
	call GetEnemyFrontpicPalettePointer
	ld a, [hli]
	ld [wSGBPals + 25], a
	ld a, [hli]
	ld [wSGBPals + 26], a
	ld a, [hli]
	ld [wSGBPals + 27], a
	ld a, [hl]
	ld [wSGBPals + 28], a

	ld hl, wSGBPals
	ld de, wSGBPals + PALPACKET_LENGTH
	ld a, SCGB_BATTLE_COLORS
	ld [wDefaultSGBLayout], a
	ret

.SGB_MoveList:
	ld hl, $62f9
	ld de, wSGBPals
	ld bc, $0010
	call CopyBytes

	ld hl, wSGBPals + 1
	ld [hl], $10
	inc hl
	inc hl

	ld a, [wPlayerHPPal]
	add PREDEFPAL_HP_GREEN
	ld [hl], a
	ld hl, wSGBPals
	ld de, $61f9
	ret

.SGB_PokegearPals:
	ld hl, $6399
	ld de, $61a9
	ret

.SGB_StatsScreenHPPals:
	ld hl, $6409
	ld de, wSGBPals
	ld bc, $0010
	call CopyBytes

	ld a, [wcc95]
	ld l, a
	ld h, $00
	add hl, hl
	add hl, hl
	ld de, $6fe1
	add hl, de

	ld a, [hli]
	ld [wcca0], a
	ld a, [hli]
	ld [wcca1], a
	ld a, [hli]
	ld [wcca2], a
	ld a, [hl]
	ld [wcca3], a

	ld a, [wCurPartySpecies]
	ld bc, wTempMonDVs
	call GetPlayerOrMonPalettePointer

	ld a, [hli]
	ld [wcca6], a
	ld a, [hli]
	ld [wcca7], a
	ld a, [hli]
	ld [wcca8], a
	ld a, [hl]
	ld [wcca9], a

	ld hl, wSGBPals
	ld de, $61e9
	ret

.SGB_PartyMenu:
	ld hl, $6379
	ld de, wSGBPals + 1
	ret

.SGB_Pokedex:
	ld hl, $6409
	ld de, wSGBPals
	ld bc, $0010
	call CopyBytes
	ld hl, wcca0
	ld [hl], $9f
	inc hl
	ld [hl], $2a
	inc hl
	ld [hl], $5a
	inc hl
	ld [hl], $19
	ld a, [wCurPartySpecies]
	call GetMonPalettePointer
	ld a, [hli]
	ld [wSGBPals + 9], a
	ld a, [hli]
	ld [wSGBPals + 10], a
	ld a, [hli]
	ld [wSGBPals + 11], a
	ld a, [hl]
	ld [wSGBPals + 12], a
	ld hl, wSGBPals
	ld de, $6209
	ret

.SGB_BillsPC:
	ld hl, $6409
	ld de, wSGBPals
	ld bc, $0010
	call CopyBytes
	ld hl, wcca0
	ld [hl], $9f
	inc hl
	ld [hl], $2a
	inc hl
	ld [hl], $5a
	inc hl
	ld [hl], $19
	ld a, [wCurPartySpecies]
	ld bc, wTempMonDVs
	call GetPlayerOrMonPalettePointer
	ld a, [hli]
	ld [wSGBPals + 9], a
	ld a, [hli]
	ld [wSGBPals + 10], a
	ld a, [hli]
	ld [wSGBPals + 11], a
	ld a, [hl]
	ld [wSGBPals + 12], a
	ld hl, wSGBPals
	ld de, $6209
	ret

.SGB_PokedexUnownMode:
	call .SGB_Pokedex
	ld de, $6219
	ret

.SGB_PokedexSearchOption:
	ld hl, $6409
	ld de, wSGBPals
	ld bc, $0010
	call CopyBytes
	ld hl, wcca0
	ld [hl], $9f
	inc hl
	ld [hl], $2a
	inc hl
	ld [hl], $5a
	inc hl
	ld [hl], $19
	ld hl, wSGBPals
	ld de, $61a9
	ret

.SGB_PackPals:
	ld hl, $6359
	ld de, $61a9
	ret

.SGB_SlotMachine:
	ld hl, $63b9
	ld de, $6229
	ret

.SGB_BetaTitleScreen:
	ld hl, $63c9
	ld de, $6299
	ret

.SGB_Diploma:
.SGB_MysteryGift:
	ld hl, $63d9
	ld de, $61a9
	ret

.SGB_GSIntro:
	ld b, 0
	ld hl, .BlkPacketTable_GSIntro
rept 4
	add hl, bc
endr
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

.BlkPacketTable_GSIntro:
	dr $9181, $918d

.SGB_GSTitleScreen:
	ld hl, $62b9
	ld de, $6279
	ld a, SCGB_DIPLOMA
	ld [wDefaultSGBLayout], a
	ret

.SGB_MagnetTrain:
	ld hl, $62c9
	ld de, $62a9
	ret

.SGB_BetaPikachuMinigame:
	ld hl, $6369
	ld de, $61a9
	ret

.SGB_BetaPoker:
	ld hl, $61a9
	ld de, wc602
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	ld hl, $62d9
	ld de, $61a9
	ret

.SGB_MapPals:
	ld hl, $62f9
	ld de, wSGBPals
	ld bc, $0010
	call CopyBytes
	call .GetMapPalsIndex
	ld hl, wSGBPals + 1
	ld [hld], a
	ld de, $61a9
	ld a, SCGB_MAPPALS
	ld [wDefaultSGBLayout], a
	ret

.SGB_Evolution:
	push bc
	ld hl, $6409
	ld de, wSGBPals
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	pop bc
	ld a, c
	and a
	jr z, .partymon
	; Egg
	ld hl, wSGBPals + 3
	ld [hl], LOW(palred 7 + palgreen 7 + palblue 7)
	inc hl
	ld [hl], HIGH(palred 7 + palgreen 7 + palblue 7)
	inc hl
	ld [hl], LOW(palred 2 + palgreen 3 + palblue 3)
	inc hl
	ld [hl], HIGH(palred 2 + palgreen 3 + palblue 3)
	jr .done

.partymon
	ld hl, wPartyMon1DVs
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wCurPartyMon]
	call AddNTimes
	ld c, l
	ld b, h
	ld a, [wPlayerHPPal]
	call GetPlayerOrMonPalettePointer
	ld a, [hli]
	ld [wSGBPals + 3], a
	ld a, [hli]
	ld [wSGBPals + 4], a
	ld a, [hli]
	ld [wSGBPals + 5], a
	ld a, [hl]
	ld [wSGBPals + 6], a

.done:
	ld hl, wSGBPals
	ld de, $61a9
	ret

.SGB_Unused0D:
.SGB_TrainerCard:
	ld hl, $63d9
	ld de, $61a9
	ret

.SGB_UnownPuzzle:
	ld hl, $62e9
	ld de, $61a9
	ret

.SGB_Pokepic:
	ld hl, $62f9
	ld de, wSGBPals
	ld bc, $0010
	call CopyBytes
	ld hl, $61a9
	ld de, wccad
	ld bc, $0010
	call CopyBytes
	call .GetMapPalsIndex
	ld hl, wSGBPals + 1
	ld [hl], a
	ld hl, wSGBPals + 3
	ld [hl], $2e
	ld hl, wSGBPals + $13
	ld a, 5
	ld [hli], a
	ld a, [wMenuBorderLeftCoord]
	ld [hli], a
	ld a, [wMenuBorderTopCoord]
	ld [hli], a
	ld a, [wMenuBorderRightCoord]
	ld [hli], a
	ld a, [wMenuBorderBottomCoord]
	ld [hl], a
	ld hl, wSGBPals
	ld de, wSGBPals + PALPACKET_LENGTH
	ret

.SGB_Unused1E:
	ld hl, $6409
	ld de, wSGBPals
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	ld a, [wCurPartySpecies]
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	ld de, unkData_002_6ff1
	add hl, de
	ld a, [wce59]
	and 3
	sla a
	sla a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hli]
	ld [wSGBPals + 3], a
	ld a, [hli]
	ld [wSGBPals + 4], a
	ld a, [hli]
	ld [wSGBPals + 5], a
	ld a, [hl]
	ld [wSGBPals + 6], a
	ld hl, wSGBPals
	ld de, $61a9
	ret

.SGB_GamefreakLogo:
	ld hl, $63f9
	ld de, $61a9
	ret

.SGB_PlayerOrMonFrontpicPals:
	ld hl, $6409
	ld de, wSGBPals
	ld bc, $0010
	call CopyBytes
	ld a, [wCurPartySpecies]
	ld bc, wTempMonDVs
	call GetPlayerOrMonPalettePointer
	ld a, [hli]
	ld [wcca0], a
	ld a, [hli]
	ld [wcca1], a
	ld a, [hli]
	ld [wcca2], a
	ld a, [hl]
	ld [wcca3], a
	ld hl, wSGBPals
	ld de, $61a9
	ret

.SGB_TradeTube:
	ld hl, $63e9
	ld de, $61a9
	ret

.SGB_TrainerOrMonFrontpicPals:
	ld hl, $6409
	ld de, wSGBPals
	ld bc, $0010
	call CopyBytes
	ld a, [wCurPartySpecies]
	ld bc, wTempMonDVs
	call GetFrontpicPalettePointer
	ld a, [hli]
	ld [wcca0], a
	ld a, [hli]
	ld [wcca1], a
	ld a, [hli]
	ld [wcca2], a
	ld a, [hl]
	ld [wcca3], a
	ld hl, wSGBPals
	ld de, $61a9
	ret

.GetMapPalsIndex:
	ld a, [wTimeOfDayPal]
	cp NITE_F
	jr c, .morn_day
	ld a, PREDEFPAL_NITE
	ret

.morn_day
	ld a, [wEnvironment]
	cp ROUTE
	jr z, .route
	cp CAVE
	jr z, .cave
	cp DUNGEON
	jr z, .cave
	cp ENVIRONMENT_5
	jr z, .env5
	cp GATE
	jr z, .gate
	ld a, [wMapGroup]
	ld e, a
	ld d, 0
	ld hl, MapGroupRoofSGBPalInds
	add hl, de
	ld a, [hl]
	ret

.route
	ld a, PREDEFPAL_ROUTES
	ret

.cave
	ld a, PREDEFPAL_DUNGEONS
	ret

.env5
	ld a, PREDEFPAL_VERMILION
	ret

.gate
	ld a, PREDEFPAL_PEWTER
	ret

INCLUDE "data/maps/sgb_roof_pal_inds.asm"

_LoadSGBLayout_ReturnFromJumpTable:
	push de
	call PushSGBPals
	pop hl
	jp PushSGBPals
