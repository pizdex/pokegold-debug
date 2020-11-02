NPCTrade::
	ld a, e
	ld [wJumptableIndex], a
	call Trade_GetDialog
	ld b, CHECK_FLAG
	call TradeFlagAction
	ld a, TRADE_DIALOG_AFTER
	jr nz, .done

	ld a, TRADE_DIALOG_INTRO
	call PrintTradeText

	call YesNoBox
	ld a, TRADE_DIALOG_CANCEL
	jr c, .done

; Select givemon from party
	ld b, PARTYMENUACTION_GIVE_MON
	farcall SelectTradeOrDayCareMon
	ld a, TRADE_DIALOG_CANCEL
	jr c, .done

	ld e, NPCTRADE_GIVEMON
	call GetTradeAttribute
	ld a, [wCurPartySpecies]
	cp [hl]
	ld a, TRADE_DIALOG_WRONG
	jr nz, .done

	call CheckTradeGender
	ld a, TRADE_DIALOG_WRONG
	jr c, .done

	ld b, SET_FLAG
	call TradeFlagAction

	ld hl, NPCTradeCableText
	call PrintText

	call DoNPCTrade
	call .TradeAnimation
	call GetTradeMonNames

	ld hl, Text_NPCTraded
	call PrintText

	call RestartMapMusic

	ld a, TRADE_DIALOG_COMPLETE

.done
	call PrintTradeText
	ret

.TradeAnimation:
	call DisableSpriteUpdates
	ld a, [wJumptableIndex]
	push af
	ld a, [wce58]
	push af
	predef TradeAnimation
	pop af
	ld [wce58], a
	pop af
	ld [wJumptableIndex], a
	call ReturnToMapWithSpeechTextbox
	ret

CheckTradeGender:
	xor a
	ld [wMonType], a

	ld e, 15
	call GetTradeAttribute
	ld a, [hl]
	and a ; TRADE_GENDER_EITHER
	jr z, .matching
	cp TRADE_GENDER_MALE
	jr z, .check_male
	; TRADE_GENDER_FEMALE
	farcall GetGender
	jr nz, .not_matching
	jr .matching

.check_male
	farcall GetGender
	jr z, .not_matching

.matching
	and a
	ret

.not_matching
	scf
	ret

TradeFlagAction:
	ld hl, wTradeFlags
	ld a, [wJumptableIndex]
	ld c, a
	predef SmallFarFlagAction
	ld a, c
	and a
	ret

Trade_GetDialog:
	ld e, NPCTRADE_DIALOG
	call GetTradeAttribute
	ld a, [hl]
	ld [wce58], a
	ret

DoNPCTrade:
	ld e, $01
	call GetTradeAttribute
	ld a, [hl]
	ld [wc5d0], a

	ld e, $02
	call GetTradeAttribute
	ld a, [hl]
	ld [wc5ed], a

	ld a, [wc5d0]
	ld de, wc5d1
	call GetTradeMonName
	call CopyTradeName

	ld a, [wc5ed]
	ld de, wc5ee
	call GetTradeMonName
	call CopyTradeName

	ld hl, wPartyMonOT
	ld bc, NAME_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld de, wc5e3
	call CopyTradeName

	ld hl, wPlayerName
	ld de, wc5dd
	call CopyTradeName

	ld hl, wPartyMon1ID
	ld bc, $0030
	call Trade_GetAttributeOfCurrentPartymon
	ld de, wc5eb
	call Trade_CopyTwoBytes

	ld hl, wPartyMon1DVs
	ld bc, $0030
	call Trade_GetAttributeOfCurrentPartymon
	ld de, wc5e9
	call Trade_CopyTwoBytes

	ld hl, wPartyMon1Level
	ld bc, $0030
	call Trade_GetAttributeOfCurrentPartymon
	ld a, [hl]
	ld [wCurPartyLevel], a
	ld a, [wc5ed]
	ld [wCurPartySpecies], a
	xor a
	ld [wMonType], a
	ld [wPokemonWithdrawDepositParameter], a
	ld hl, $62e7
	ld a, $03
	rst $08
	ld a, $06
	call Predef

	ld e, $03
	call GetTradeAttribute
	ld de, wc5f4
	call Functionfeb6a

	ld hl, wPartyMon1Nickname
	ld bc, $0006
	call Trade_GetAttributeOfLastPartymon
	ld hl, wc5f4
	call CopyTradeName

	ld e, $0c
	call GetTradeAttribute
	push hl
	ld de, wc600
	call Functionfeb74
	pop hl
	ld de, wc5fa
	call Functionfeb74

	ld hl, wPartyMonOT
	ld bc, $0006
	call Trade_GetAttributeOfLastPartymon
	ld hl, wc600
	call CopyTradeName

	ld e, $07
	call GetTradeAttribute
	ld de, wc606
	call Trade_CopyTwoBytes

	ld hl, wPartyMon1DVs
	ld bc, $0030
	call Trade_GetAttributeOfLastPartymon
	ld hl, wc606
	call Trade_CopyTwoBytes

	ld e, $0a
	call GetTradeAttribute
	ld de, wc609
	call Trade_CopyTwoBytesReverseEndian

	ld hl, wPartyMon1ID
	ld bc, $0030
	call Trade_GetAttributeOfLastPartymon
	ld hl, wc608
	call Trade_CopyTwoBytes

	ld e, $09
	call GetTradeAttribute
	push hl
	ld hl, wPartyMon1Item
	ld bc, $0030
	call Trade_GetAttributeOfLastPartymon
	pop hl
	ld a, [hl]
	ld [de], a

	push af
	push bc
	push de
	push hl
	ld a, [wCurPartyMon]
	push af
	ld a, [wPartyCount]
	dec a
	ld [wCurPartyMon], a
	ld a, $03
	ld hl, $63e2
	rst $08
	pop af
	ld [wCurPartyMon], a
	pop hl
	pop de
	pop bc
	pop af
	ret

GetTradeAttribute:
	ld d, 0
	push de
	ld a, [wJumptableIndex]
	and $f
	swap a
	ld e, a
	ld d, 0
	ld hl, NPCTrades
	add hl, de
	pop de
	add hl, de
	ret

Trade_GetAttributeOfCurrentPartymon:
	ld a, [wCurPartyMon]
	call AddNTimes
	ret

Trade_GetAttributeOfLastPartymon:
	ld a, [wPartyCount]
	dec a
	call AddNTimes
	ld e, l
	ld d, h
	ret

GetTradeMonName:
	push de
	ld [wNamedObjectIndexBuffer], a
	call GetBasePokemonName
	ld hl, wStringBuffer1
	pop de
	ret

CopyTradeName:
	ld bc, NAME_LENGTH
	call CopyBytes
	ret

Functionfeb6a:
	ld bc, 4
	call CopyBytes
	ld a, "@"
	ld [de], a
	ret

Functionfeb74:
	ld bc, 3
	call CopyBytes
	ld a, "@"
	ld [de], a
	ret

Trade_CopyTwoBytes:
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	ret

Trade_CopyTwoBytesReverseEndian:
	ld a, [hli]
	ld [de], a
	dec de
	ld a, [hl]
	ld [de], a
	ret

GetTradeMonNames:
	ld e, NPCTRADE_GETMON
	call GetTradeAttribute
	ld a, [hl]
	call GetTradeMonName

	ld de, wStringBuffer2
	call CopyTradeName

	ld e, NPCTRADE_GIVEMON
	call GetTradeAttribute
	ld a, [hl]
	call GetTradeMonName

	ld de, wMonOrItemNameBuffer
	call CopyTradeName

	ld hl, wStringBuffer1
.loop
	ld a, [hli]
	cp "@"
	jr nz, .loop

	dec hl
	push hl
	ld e, NPCTRADE_GENDER
	call GetTradeAttribute
	ld a, [hl]
	pop hl
	and a ; TRADE_GENDER_EITHER
	ret z
	cp TRADE_GENDER_MALE
	ld a, "♂"
	jr z, .done
	; TRADE_GENDER_FEMALE
	ld a, "♀"
.done
	ld [hli], a
	ld [hl], "@"
	ret

INCLUDE "data/events/npc_trades.asm"

PrintTradeText:
	push af
	call GetTradeMonNames
	pop af
	ld e, a
	ld d, 0
	ld hl, TradeTexts
rept 6
	add hl, de
endr
	ld a, [wce58]
	ld e, a
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PrintText
	ret

TradeTexts:
; entries correspond to TRADE_DIALOG_* × TRADE_DIALOGSET_* constants
; TRADE_DIALOG_INTRO
	dw NPCTradeIntroText1
	dw NPCTradeIntroText2
	dw NPCTradeIntroText3
; TRADE_DIALOG_CANCEL
	dw NPCTradeCancelText1
	dw NPCTradeCancelText2
	dw NPCTradeCancelText3
; TRADE_DIALOG_WRONG
	dw NPCTradeWrongText1
	dw NPCTradeWrongText2
	dw NPCTradeWrongText3
; TRADE_DIALOG_COMPLETE
	dw NPCTradeCompleteText1
	dw NPCTradeCompleteText2
	dw NPCTradeCompleteText3
; TRADE_DIALOG_AFTER
	dw NPCTradeAfterText1
	dw NPCTradeAfterText2
	dw NPCTradeAfterText3

NPCTradeCableText::
	text "じゃあ"
	line "ケーブルを つないで<……>と"
	prompt

Text_NPCTraded:
	text "<PLAYER>は @"
	text_ram wMonOrItemNameBuffer
	text "と"
	line "@"
	text_ram wStringBuffer2
	text "を こうかんした!@"

TradedForText:
	; traded givemon for getmon
	text_asm
	ld de, MUSIC_NONE
	call PlayMusic
	call DelayFrame
	ld hl, .done
	ret

.done
	sound_dex_fanfare_80_109
	text_pause
	text_end

NPCTradeIntroText1:
	text "ボク # あつめてるんだ!"
	line "キミは @"
	text_ram wStringBuffer1
	text "を もってる?"

	para "ボクの @"
	text_ram wStringBuffer2
	text "と"
	line "こうかん しようよ?"
	done

NPCTradeCancelText1:
	text "とリかえて くれないの?"
	line "ちぇっ がっかリだなあ<……>"
	done

NPCTradeWrongText1:
	text "あれ<……>?"
	line "@"
	text_ram wStringBuffer1
	text "じゃ ないよ"
	cont "ちぇっ ざんねんだなあ<……>"
	done

NPCTradeCompleteText1:
	text "やったあ!"
	line "@"
	text_ram wStringBuffer1
	text "<GA>てにはいった!"
	cont "サンキュー!"
	done

NPCTradeAfterText1:
	text "やあっ!"
	line "ボクと とリかえた @"
	text_ram wStringBuffer2
	text ""
	cont "げんき?"
	done

NPCTradeIntroText2:
	text "なあ きみ<……>"
	line "さがしてる #<GA>いるんだ"

	para "もし @"
	text_ram wStringBuffer1
	text "を もってたら"
	line "わしの @"
	text_ram wStringBuffer2
	text "と"
	cont "こうかん してくれないか?"
	done

NPCTradeCancelText2:
	text "キミも もってないのか<……>"
	line "ざんねんだなあ<……>"
	done

NPCTradeWrongText2:
	text_ram wStringBuffer1
	text "を もってないのか?"
	line "じゃあ しょうがないね<……>"
	done

NPCTradeCompleteText2:
	text "おお!"
	line "あリがとう!"

	para "やっと @"
	text_ram wStringBuffer1
	text "が"
	line "てに はいったよ!"
	done

NPCTradeAfterText2:
	text "おお!"

	para "キミから もらった@"
	text_ram wMonOrItemNameBuffer
	text "は"
	line "すごく げんきだよ!"
	done

NPCTradeIntroText3:
	text_ram wMonOrItemNameBuffer
	text "って かわいいわよね!"
	line "でも わたし もってないの<……>"
	cont "あなた @"
	text_ram wStringBuffer1
	text " もってる?"

	para "わたしの @"
	text_ram wStringBuffer2
	text "と"
	line "こうかん しましょうよ!"
	done

NPCTradeCancelText3:
	text "こうかんして くれないの?"
	line "えーっ<……> がっかリ<……>"
	done

NPCTradeWrongText3:
	text_ram wStringBuffer1
	text "じゃ ないわよ それ"
	line "つかまえたら とリかえてね!"
	done

NPCTradeCompleteText3:
	text "わあ! あリがとうっ!"
	line "@"
	text_ram wMonOrItemNameBuffer
	text " ほしかったのっ!"
	done

NPCTradeAfterText3:
	text "こうかんした @"
	text_ram wStringBuffer2
	text " げんき?"
	line "@"
	text_ram wMonOrItemNameBuffer
	text "は すっごく かわいいわ!"
	done
