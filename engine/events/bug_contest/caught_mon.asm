BugContest_SetCaughtContestMon:
    ld a, [wContestMon]
    and a
    jr z, .firstcatch
    ld [wNamedObjectIndexBuffer], a
    ld a, $33
    ld hl, $40c5
    rst FarCall
    ld a, $33
    ld hl, $4000
    rst FarCall
    ld bc, $0e0c
    call PlaceYesNoBox
    ret c

.firstcatch
	call .generatestats
	ld a, [wTempEnemyMonSpecies]
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName
	ld hl, .ContestCaughtMonText
	call PrintText
	ret

.generatestats
	ld a, [wTempEnemyMonSpecies]
	ld [wCurSpecies], a
	ld [wCurPartySpecies], a
	call GetBaseData
	xor a
	ld bc, PARTYMON_STRUCT_LENGTH
	ld hl, wContestMon
	call ByteFill
	xor a
	ld [wMonType], a
	ld hl, wContestMon
	jp GeneratePartyMonStats

.ContestCaughtMonText:
	text_ram wStringBuffer1
	text "を つかまえた！"
	prompt
