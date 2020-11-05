_NameRater:
; Introduce himself
	ld hl, NameRaterHelloText
	call PrintText
	call YesNoBox
	jp c, .cancel
; Select a Pokemon from your party
	ld hl, NameRaterWhichMonText
	call PrintText
	ld a, $14
	ld hl, $4000
	rst FarCall
	jr c, .cancel
; He can't rename an egg...
	ld a, [wCurPartySpecies]
	cp EGG
	jr z, .egg
; ... or a Pokemon you got from a trade.
	call GetCurNick
	call CheckIfMonIsYourOT
	jr c, .traded
; This name is good, but we can do better.  How about it?
	ld hl, NameRaterBetterNameText
	call PrintText
	call YesNoBox
	jr c, .cancel
; What name shall I give it then?
	ld hl, NameRaterWhatNameText
	call PrintText
; Load the new nickname into wStringBuffer2
	xor a ; PARTYMON
	ld [wMonType], a
	ld a, [wCurPartySpecies]
	ld [wNamedObjectIndexBuffer], a
	ld [wCurSpecies], a
	call GetBaseData
	ld b, NAME_MON
	ld de, wStringBuffer2
	farcall _NamingScreen
; If the new name is empty, treat it as unchanged.
	call IsNewNameEmpty
	ld hl, NameRaterSameNameText
	jr c, .samename
; If the new name is the same as the old name, treat it as unchanged.
	call CompareNewToOld
	ld hl, NameRaterSameNameText
	jr c, .samename
; Copy the new name from wStringBuffer2
	ld hl, wPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	ld a, [wCurPartyMon]
	call AddNTimes
	ld e, l
	ld d, h
	ld hl, wStringBuffer2
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	ld hl, NameRaterFinishedText

.samename
	push hl
	call GetCurNick
	ld hl, NameRaterNamedText
	call PrintText
	pop hl
	jr .done

.traded
	ld hl, NameRaterPerfectNameText
	jr .done

.cancel
	ld hl, NameRaterComeAgainText
	jr .done

.egg
	ld hl, NameRaterEggText

.done
	call PrintText
	ret

CheckIfMonIsYourOT:
; Checks to see if the partymon loaded in [wCurPartyMon] has the different OT as you.  Returns carry if not.
	ld hl, wPartyMonOT
	ld bc, NAME_LENGTH
	ld a, [wCurPartyMon]
	call AddNTimes
	ld de, wPlayerName
	ld c, NAME_LENGTH
	call .loop
	jr c, .nope

	ld hl, wPartyMon1ID
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wCurPartyMon]
	call AddNTimes
	ld de, wd1b3
	ld c, 2 ; number of bytes in which your ID is stored
.loop
	ld a, [de]
	cp [hl]
	jr nz, .nope
	inc hl
	inc de
	dec c
	jr nz, .loop
	and a
	ret

.nope
	scf
	ret

IsNewNameEmpty:
; Checks to see if the nickname loaded in wStringBuffer2 is empty.  If so, return carry.
	ld hl, wStringBuffer2
	ld c, MON_NAME_LENGTH - 1
.loop
	ld a, [hli]
	cp "@"
	jr z, .terminator
	cp " "
	jr nz, .nonspace
	dec c
	jr nz, .loop

.terminator
	scf
	ret

.nonspace
	and a
	ret

CompareNewToOld:
; Compares the nickname in wStringBuffer2 to the previous nickname.  If they are the same, return carry.
	ld hl, wPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	ld a, [wCurPartyMon]
	call AddNTimes
	push hl
	call GetNicknameLength
	ld b, c
	ld hl, wStringBuffer2
	call GetNicknameLength
	pop hl
	ld a, c
	cp b
	jr nz, .different
	ld de, wStringBuffer2
.loop
	ld a, [de]
	cp "@"
	jr z, .terminator
	cp [hl]
	jr nz, .different
	inc hl
	inc de
	jr .loop

.different
	and a
	ret

.terminator
	scf
	ret

GetNicknameLength:
; Gets the length of the name starting at hl and returns it in c.
	ld c, 0
.loop
	ld a, [hli]
	cp "@"
	ret z
	inc c
	ld a, c
	cp MON_NAME_LENGTH - 1
	jr nz, .loop
	ret

NameRaterHelloText:
	text "はい はい!"
	line "わたしは せいめい はんだんし"
	cont "いうなれば なまえの うらないです"

	para "はい あなたの #の"
	line "ニックネーム うらなって あげるよ"
	done

NameRaterWhichMonText:
	text "どの #の"
	line "ニックネームを うらなうかね?"
	prompt

NameRaterBetterNameText:
	text "うーむ @"
	text_ram $cf87 ; TEMP
	text "か<……>"
	line "なかなか"
	cont "いい ニックネームを つけたね"

	para "でもねー"
	line "もう すこしだけ いい なまえ"

	para "わたし<GA>つけて あげようか?"
	line "どうかな?"
	done

NameRaterWhatNameText:
	text "そうか では"
	line "どんな ニックネームに しようかな"
	prompt

NameRaterFinishedText:
	text "まえよリ いい なまえ じゃないか"
	line "よかったな!"
	done

NameRaterComeAgainText:
	text "そうか"
	line "わかった また きなさいよ"
	done

NameRaterPerfectNameText:
	text "うむ @"
	text_ram $cf87 ; TEMP
	text "か!"
	line "これは すばらしい ニックネームだ"
	cont "けちの つけようもない!"

	para "これからも @"
	text_ram $cf87 ; TEMP
	text "を"
	line "かわいがって あげなさいよ!"
	done

NameRaterEggText:
	text "おいおい……"
	line "それは タマゴじゃないか"
	done

NameRaterSameNameText:
	text "まえと おなじように みえるが"
	line "こっちの ほう<GA>だんぜん いいぞ!"
	cont "よかったな!"
	done

NameRaterNamedText:
	text "よし これから"
	line "この #は @"
	text_ram $cf87 ; TEMP
	text "だ!"
	prompt