Special::
; Run script special de.
	ld hl, SpecialsPointers
	add hl, de
	add hl, de
	add hl, de
	ld b, [hl]
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, b
	rst FarCall
	ret

INCLUDE "data/events/special_pointers.asm"

UnusedDummySpecial:
	ret

GameCornerPrizeMonCheckDex:
	call FadeToMenu
	ld a, [wScriptVar]
	ld [wApplyStatLevelMultipliersToEnemy], a
	ld a, $3e
	ld hl, $79b9
	rst FarCall
	call ExitAllMenus
	ret

UnusedSetSeenMon:
	ld a, [wScriptVar]
	dec a
	call SetSeenMon
	ret

FindPartyMonAboveLevel:
	ld a, [wScriptVar]
	ld b, a
	ld a, $03
	ld hl, $69a9
	rst FarCall
	jr z, FoundNone
	jr FoundOne

FindPartyMonAtLeastThatHappy:
	ld a, [wScriptVar]
	ld b, a
	ld a, $03
	ld hl, $69b0
	rst FarCall
	jr z, FoundNone
	jr FoundOne

FindPartyMonThatSpecies:
	ld a, [wScriptVar]
	ld b, a
	ld a, $03
	ld hl, $69b7
	rst FarCall
	jr z, FoundNone
	jr FoundOne

FindPartyMonThatSpeciesYourTrainerID:
	ld a, [wScriptVar]
	ld b, a
	ld a, $03
	ld hl, $69bd
	rst FarCall
	jr z, FoundNone
	jr FoundOne

FoundOne:
	ld a, $01
	ld [wScriptVar], a
	ret

FoundNone:
	xor a
	ld [wScriptVar], a
	ret

NameRival:
	ld b, $02
	ld de, wRivalName
	ld a, $04
	ld hl, $5a74
	rst FarCall
	ld hl, wRivalName
	ld de, .DefaultName
	call InitName
	ret

.DefaultName:
	adc e
	and [hl]
	add hl, de
	db $e3
	ld d, b

NameRater:
	ld a, $3e
	ld hl, $76d3
	rst FarCall
	ret

OverworldTownMap:
	call FadeToMenu
	ld a, $24
	ld hl, $59e1
	rst FarCall
	call ExitAllMenus
	ret

UnownPrinter:
	call FadeToMenu
	ld a, $05
	ld hl, $750a
	rst FarCall
	call ExitAllMenus
	ret

DisplayLinkRecord:
	call FadeToMenu
	ld a, $0f
	ld hl, $767d
	rst FarCall
	call ExitAllMenus
	ret

PlayersHousePC:
	xor a
	ld [wScriptVar], a
	ld a, $05
	ld hl, $5933
	rst FarCall
	ld a, c
	ld [wScriptVar], a
	ret

CheckMysteryGift:
	ld a, $00
	call OpenSRAM
	ld a, [s1_ab50]
	and a
	jr z, .no
	inc a

.no
	ld [wScriptVar], a
	call CloseSRAM
	ret

GetMysteryGiftItem:
	ld a, $00
	call OpenSRAM
	ld a, [s1_ab50]
	ld [wCurItem], a
	ld a, $01
	ld [wItemQuantityChangeBuffer], a
	ld hl, wNumItems
	call ReceiveItem
	jr nc, .no_room
	xor a
	ld [s1_ab50], a
	call CloseSRAM
	ld a, [wCurItem]
	ld [wApplyStatLevelMultipliersToEnemy], a
	call GetItemName
	ld hl, $4485
	call PrintText
	ld a, $01
	ld [wScriptVar], a
	ret

.no_room
	call CloseSRAM
	xor a
	ld [wScriptVar], a
	ret

.ReceiveItemText:
	ld bc, wPlayerName
	nop
	jp z, $ca7f
	or d
	ret nz
	jp nz, $deb2
	or [hl]
	rst $10
	ld c, a
	ld d, b
	ld bc, wStringBuffer1
	nop
	db $dd
	ld a, a
	db $d3
	rst $10
	rst $18
	ret nz
	rst $20
	ld d, b
	rrca
	ld b, $50

BugContestJudging:
	ld a, $04
	ld hl, $7b54
	rst FarCall
	ld a, b
	ld [wScriptVar], a
	ret

MapRadio:
	ld a, [wScriptVar]
	ld e, a
	ld a, $24
	ld hl, $5ae9
	rst FarCall
	ret

UnownPuzzle:
	call FadeToMenu
	ld a, $38
	ld hl, $5995
	rst FarCall
	ld a, [wcfde]
	ld [wScriptVar], a
	call ExitAllMenus
	ret

SlotMachine:
	call CheckCoinsAndCoinCase
	ret c
	ld a, $24
	ld hl, $6b85
	call StartGameCornerGame
	ret

CardFlip:
	call CheckCoinsAndCoinCase
	ret c
	ld a, $38
	ld hl, $48bd
	call StartGameCornerGame
	ret

UnusedDummyGame:
	call CheckCoinsAndCoinCase
	ret c
	ld a, $38
	ld hl, $667a
	call StartGameCornerGame
	ret

StartGameCornerGame:
	call FarQueueScript
	call FadeToMenu
	ld hl, wQueuedScriptBank
	ld a, [hli]
	push af
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop af
	rst FarCall
	call ExitAllMenus
	ret

CheckCoinsAndCoinCase:
	ld hl, wCoins
	ld a, [hli]
	or [hl]
	jr z, .no_coins
	ld a, $36
	ld [wCurItem], a
	ld hl, wNumItems
	call CheckItem
	jr nc, .no_coin_case
	and a
	ret

.no_coins
	ld hl, .NoCoinsText
	jr .print

.no_coin_case
	ld hl, .NoCoinCaseText

.print
	call PrintText
	scf
	ret

.NoCoinsText:
	dr $c52b, $c53a

.NoCoinCaseText:
	dr $c53a, $c54b

ClearBGPalettesBufferScreen:
	call ClearBGPalettes
	call BufferScreen
	ret

ScriptReturnCarry:
	jr c, .carry
	xor a
	ld [wScriptVar], a
	ret

.carry
	ld a, $01
	ld [wScriptVar], a
	ret

UnusedCheckUnusedTwoDayTimer:
	ld a, $04
	ld hl, $58c9
	rst FarCall
	ld a, [wd94a]
	ld [wScriptVar], a
	ret

ActivateFishingSwarm:
	ld a, [wScriptVar]
	ld [wdc8f], a
	jr SetSwarmFlag

StoreSwarmMapIndices::
	ld a, d
	ld [wdc8d], a
	ld a, e
	ld [wdc8e], a

SetSwarmFlag:
	ld hl, wDailyFlags1
	set 2, [hl]
	ret

CheckSwarmFlag::
	ld hl, wDailyFlags1
	bit 2, [hl]
	jr z, .clear_swarm
	xor a
	ld [wScriptVar], a
	ret

.clear_swarm
	ld a, $01
	ld [wScriptVar], a
	xor a
	ld [wdc8f], a
	ld [wdc8d], a
	ld [wdc8e], a
	ret

CheckPokerus:
; Check if a monster in your party has Pokerus
	ld a, $31
	ld hl, $7a40
	rst FarCall
	jp ScriptReturnCarry

ResetLuckyNumberShowFlag:
	ld a, $04
	ld hl, $58e8
	rst FarCall
	ld hl, wd9ad
	res 0, [hl]
	ld a, $01
	ld hl, $5de5
	rst FarCall
	ret

CheckLuckyNumberShowFlag:
	ld a, $04
	ld hl, $58ff
	rst FarCall
	jp ScriptReturnCarry

CountUnown:
	ld hl, wdbb8
	ld b, 0
.loop
	ld a, [hli]
	and a
	ret z
	inc b
	ld a, b
	cp NUM_UNOWN
	jr c, .loop
	ret

SelectApricornForKurt:
	ld a, $09
	ld hl, $4bf2
	rst FarCall
	ld a, c
	ld [wScriptVar], a
	and a
	ret z
	ld [wCurItem], a
	ld a, $01
	ld [wItemQuantityChangeBuffer], a
	ld hl, wNumItems
	call TossItem
	ret

SnorlaxAwake:
; Check if the Poké Flute channel is playing, and if the player is standing
; next to Snorlax.

; outputs:
; wScriptVar is 1 if the conditions are met, otherwise 0.

; check background music
	ld a, [wMapMusic]
	cp MUSIC_POKE_FLUTE_CHANNEL
	jr nz, .nope

	ld a, [wXCoord]
	ld b, a
	ld a, [wYCoord]
	ld c, a

	ld hl, .ProximityCoords
.loop
	ld a, [hli]
	cp -1
	jr z, .nope
	cp b
	jr nz, .nextcoord
	ld a, [hli]
	cp c
	jr nz, .loop

	ld a, TRUE
	jr .done

.nextcoord
	inc hl
	jr .loop

.nope
	xor a
.done
	ld [wScriptVar], a
	ret

.ProximityCoords:
	;   x,  y
	db 33,  8 ; left
	db 34, 10 ; below
	db 35, 10 ; below
	db 36,  8 ; right
	db 36,  9 ; right
	db -1

PlayCurMonCry:
	ld a, [wCurPartySpecies]
	jp PlayMonCry

GameboyCheck:
	ldh a, [hCGB]
	and a
	jr nz, .cgb
	ldh a, [hSGB]
	and a
	jr nz, .sgb
; gb
	xor a ; GBCHECK_GB
	jr .done

.sgb
	ld a, GBCHECK_SGB
	jr .done

.cgb
	ld a, GBCHECK_CGB
.done
	ld [wScriptVar], a
	ret

FadeOutMusic:
	ld a, LOW(MUSIC_NONE)
	ld [wMusicFadeID], a
	ld a, HIGH(MUSIC_NONE)
	ld [wMusicFadeID + 1], a
	ld a, $2
	ld [wMusicFade], a
	ret

Diploma:
	call FadeToMenu
	ld a, $38
	ld hl, $4002
	rst FarCall
	call ExitAllMenus
	ret

PrintDiploma:
	call FadeToMenu
	ld a, $21
	ld hl, $45fc
	rst FarCall
	call ExitAllMenus
	ret

TrainerHouse:
	ld a, $00
	call OpenSRAM
	ld a, [s1_ab6b]
	ld [wScriptVar], a
	jp CloseSRAM

	nop ; unused
