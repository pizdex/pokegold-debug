MANIA_OT_ID EQU 00518

GiveShuckle:
; Adding to the party.
	xor a
	ld [wMonType], a

; Level 15 Shuckle.
	ld a, SHUCKLE
	ld [wCurPartySpecies], a
	ld a, 15
	ld [wCurPartyLevel], a

	predef TryAddMonToParty
	jr nc, .NotGiven

; Holding a Berry.
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wPartyCount]
	dec a
	push af
	push bc
	ld hl, wPartyMon1Item
	call AddNTimes
	ld [hl], BERRY
	pop bc
	pop af

; OT ID.
	ld hl, wPartyMon1ID
	call AddNTimes
	ld a, HIGH(MANIA_OT_ID)
	ld [hli], a
	ld [hl], LOW(MANIA_OT_ID)

; Nickname.
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMonNicknames
	call SkipNames
	ld a, "ネ"
	ld [hli], a
	ld a, "ッ"
	ld [hli], a
	ld a, "シ"
	ld [hli], a
	ld a, "ー"
	ld [hli], a
	ld a, "@"
	ld [hl], a

; OT.
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMon6StatsEnd
	call SkipNames
	ld a, "マ"
	ld [hli], a
	ld a, "ニ"
	ld [hli], a
	ld a, "ア"
	ld [hli], a
	ld a, "@"
	ld [hl], a

; Engine flag for this event.
	ld hl, wDailyFlags1
	set 5, [hl]
	ld a, 1
	ld [wScriptVar], a
	ret

.NotGiven:
	xor a
	ld [wScriptVar], a
	ret

ReturnShuckle:
	ld a, $14
	ld hl, $4000
	rst FarCall
	jr c, .refused

	ld a, [wCurPartySpecies]
	cp SHUCKLE
	jr nz, .DontReturn

	ld a, [wCurPartyMon]
	ld hl, wPartyMon1ID
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes

; OT ID
	ld a, [hli]
	cp HIGH(MANIA_OT_ID)
	jr nz, .DontReturn
	ld a, [hl]
	cp LOW(MANIA_OT_ID)
	jr nz, .DontReturn

; OT
	ld a, [wCurPartyMon]
	ld hl, wPartyMonOT
	call SkipNames

	ld a, [hli]
	cp "マ"
	jr nz, .DontReturn
	ld a, [hli]
	cp "ニ"
	jr nz, .DontReturn
	ld a, [hli]
	cp "ア"
	jr nz, .DontReturn
	ld a, [hli]
	cp "@"
	jr nz, .DontReturn

	ld a, 3
	ld hl, $680d
	rst FarCall
	jr c, .fainted
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Happiness
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld a, [hl]
	cp 150
	ld a, SHUCKIE_HAPPY
	jr nc, .HappyToStayWithYou
	xor a ; REMOVE_PARTY
	ld [wPokemonWithdrawDepositParameter], a
	ld hl, $62e7
	ld a, 3
	rst FarCall
	ld a, SHUCKIE_RETURNED
.HappyToStayWithYou:
	ld [wScriptVar], a
	ret

.refused
	ld a, SHUCKIE_REFUSED
	ld [wScriptVar], a
	ret

.DontReturn:
	xor a ; SHUCKIE_WRONG_MON
	ld [wScriptVar], a
	ret

.fainted
	ld a, SHUCKIE_FAINTED
	ld [wScriptVar], a
	ret
