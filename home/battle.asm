GetPartyParamLocation::
; Get the location of parameter a from wCurPartyMon in hl
	push bc
	ld hl, wPartyMons
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [wCurPartyMon]
	call GetPartyLocation
	pop bc
	ret

GetPartyLocation::
; Add the length of a PartyMon struct to hl a times.
    ld bc, $0030
    jp $3210

Unreferenced_GetDexNumber::
; Probably used in gen 1 to convert index number to dex number
; Not required in gen 2 because index number == dex number
	push hl
	ld a, b
	dec a
	ld b, 0
	add hl, bc
    ld hl, $5aac
	ld bc, BASE_DATA_SIZE
    call $3210
	pop bc
    ld a, $14
	call GetFarHalfword
	ld b, l
	ld c, h
	pop hl
	ret

UserPartyAttr::
	push af
	ldh a, [hBattleTurn]
	and a
	jr nz, .ot
	pop af
	jr BattlePartyAttr
.ot
	pop af
	jr OTPartyAttr

OpponentPartyAttr::
	push af
	ldh a, [hBattleTurn]
	and a
	jr z, .ot
	pop af
	jr BattlePartyAttr
.ot
	pop af
	jr OTPartyAttr

BattlePartyAttr::
; Get attribute a from the party struct of the active battle mon.
	push bc
	ld c, a
	ld b, 0
	ld hl, wPartyMons
	add hl, bc
	ld a, [wCurBattleMon]
	call GetPartyLocation
	pop bc
	ret

OTPartyAttr::
; Get attribute a from the party struct of the active enemy mon.
	push bc
	ld c, a
	ld b, 0
	ld hl, wOTPartyMon1Species
	add hl, bc
	ld a, [wCurOTMon]
	call GetPartyLocation
	pop bc
	ret

ResetDamage::
	xor a
	ld [wCurDamage], a
	ld [wCurDamage + 1], a
	ret

SetPlayerTurn::
	xor a
	ldh [hBattleTurn], a
	ret

SetEnemyTurn::
	ld a, 1
	ldh [hBattleTurn], a
	ret

UpdateOpponentInParty::
	ldh a, [hBattleTurn]
	and a
	jr z, UpdateEnemyMonInParty
	jr UpdateBattleMonInParty

UpdateUserInParty::
	ldh a, [hBattleTurn]
	and a
	jr z, UpdateBattleMonInParty
	jr UpdateEnemyMonInParty

UpdateBattleMonInParty::
; Update level, status, current HP

	ld a, [wCurBattleMon]

UpdateBattleMon::
	ld hl, wPartyMon1Level
	call GetPartyLocation

	ld d, h
	ld e, l
	ld hl, wBattleMonLevel
    ld bc, $0005
    jp CopyBytes

UpdateEnemyMonInParty::
; Update level, status, current HP

; No wildmons.
	ld a, [wBattleMode]
	dec a
	ret z

	ld a, [wCurOTMon]
	ld hl, wOTPartyMon1Level
	call GetPartyLocation

	ld d, h
	ld e, l
	ld hl, wEnemyMonLevel
	ld bc, wEnemyMonMaxHP - wEnemyMonLevel
	jp CopyBytes

RefreshBattleHuds::
	call UpdateBattleHuds
	ld c, 3
	call DelayFrames
	jp WaitBGMap

UpdateBattleHuds::
    ld a, $f
    ld hl, $5da5
    rst FarCall
    ld a, $f
    ld hl, $5e98
    rst FarCall
    ret

GetBattleVar::
; Preserves hl.
	push hl
	call GetBattleVarAddr
	pop hl
	ret

GetBattleVarAddr::
; Get variable from pair a, depending on whose turn it is.
; There are 21 variable pairs.

	push bc

	ld hl, BattleVarPairs
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc

	ld a, [hli]
	ld h, [hl]
	ld l, a

; Enemy turn uses the second byte instead.
; This lets battle variable calls be side-neutral.
	ldh a, [hBattleTurn]
	and a
	jr z, .getvar
	inc hl

.getvar
; var id
	ld a, [hl]
	ld c, a
	ld b, 0

	ld hl, $3c74
	add hl, bc
	add hl, bc

	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld a, [hl]

	pop bc
	ret

BattleVarPairs:
; entries correspond to BATTLE_VARS_* constants
	dw .Substatus1
	dw .Substatus2
	dw .Substatus3
	dw .Substatus4
	dw .Substatus5
	dw .Substatus1Opp
	dw .Substatus2Opp
	dw .Substatus3Opp
	dw .Substatus4Opp
	dw .Substatus5Opp
	dw .Status
	dw .StatusOpp
	dw .MoveAnim
	dw .MoveEffect
	dw .MovePower
	dw .MoveType
	dw .CurMove
	dw .LastCounter
	dw .LastCounterOpp
	dw .LastMove
	dw .LastMoveOpp

;                   player                 enemy
.Substatus1:     db PLAYER_SUBSTATUS_1,    ENEMY_SUBSTATUS_1
.Substatus1Opp:  db ENEMY_SUBSTATUS_1,     PLAYER_SUBSTATUS_1
.Substatus2:     db PLAYER_SUBSTATUS_2,    ENEMY_SUBSTATUS_2
.Substatus2Opp:  db ENEMY_SUBSTATUS_2,     PLAYER_SUBSTATUS_2
.Substatus3:     db PLAYER_SUBSTATUS_3,    ENEMY_SUBSTATUS_3
.Substatus3Opp:  db ENEMY_SUBSTATUS_3,     PLAYER_SUBSTATUS_3
.Substatus4:     db PLAYER_SUBSTATUS_4,    ENEMY_SUBSTATUS_4
.Substatus4Opp:  db ENEMY_SUBSTATUS_4,     PLAYER_SUBSTATUS_4
.Substatus5:     db PLAYER_SUBSTATUS_5,    ENEMY_SUBSTATUS_5
.Substatus5Opp:  db ENEMY_SUBSTATUS_5,     PLAYER_SUBSTATUS_5
.Status:         db PLAYER_STATUS,         ENEMY_STATUS
.StatusOpp:      db ENEMY_STATUS,          PLAYER_STATUS
.MoveAnim:       db PLAYER_MOVE_ANIMATION, ENEMY_MOVE_ANIMATION
.MoveEffect:     db PLAYER_MOVE_EFFECT,    ENEMY_MOVE_EFFECT
.MovePower:      db PLAYER_MOVE_POWER,     ENEMY_MOVE_POWER
.MoveType:       db PLAYER_MOVE_TYPE,      ENEMY_MOVE_TYPE
.CurMove:        db PLAYER_CUR_MOVE,       ENEMY_CUR_MOVE
.LastCounter:    db PLAYER_COUNTER_MOVE,   ENEMY_COUNTER_MOVE
.LastCounterOpp: db ENEMY_COUNTER_MOVE,    PLAYER_COUNTER_MOVE
.LastMove:       db PLAYER_LAST_MOVE,      ENEMY_LAST_MOVE
.LastMoveOpp:    db ENEMY_LAST_MOVE,       PLAYER_LAST_MOVE

BattleVarLocations:
; entries correspond to PLAYER_* and ENEMY_* constants
	dw wPlayerSubStatus1,            wEnemySubStatus1
	dw wPlayerSubStatus2,            wEnemySubStatus2
	dw wPlayerSubStatus3,            wEnemySubStatus3
	dw wPlayerSubStatus4,            wEnemySubStatus4
	dw wPlayerSubStatus5,            wEnemySubStatus5
	dw wBattleMonStatus,             wEnemyMonStatus
	dw wPlayerMoveStructAnimation,   wEnemyMoveStructAnimation
	dw wPlayerMoveStructEffect,      wEnemyMoveStructEffect
	dw wPlayerMoveStructPower,       wEnemyMoveStructPower
	dw wPlayerMoveStructType,        wEnemyMoveStructType
	dw wCurPlayerMove,               wCurEnemyMove
	dw wLastEnemyCounterMove,        wLastPlayerCounterMove
	dw wLastPlayerMove,              wLastEnemyMove

StdBattleTextbox::
; Open a textbox and print battle text at 20:hl.

	ldh a, [hROMBank]
    push af

    ld a, $0e
    rst $10

    call PrintText

    pop af
    rst $10
    ret

GetBattleAnimPointer::
    ld a, $32
    rst $10

	ld a, [hli]
	ld [wca10], a
	ld a, [hl]
	ld [wca11], a

	ld a, $33
	rst Bankswitch

	ret

GetBattleAnimByte::
	push hl
	push de

	ld hl, wca10
	ld e, [hl]
	inc hl
	ld d, [hl]

    ld a, $32
    rst $10

    ld a, [de]
    ld [wca17], a
    inc de

    ld a, $33
    rst $10

	ld [hl], d
	dec hl
	ld [hl], e

	pop de
	pop hl

	ld a, [wca17]
	ret

PushLYOverrides::
	ldh a, [hLCDCPointer]
	and a
	ret z

	ld a, LOW(wLYOverridesBackup)
	ld [wRequested2bppSource], a
	ld a, HIGH(wLYOverridesBackup)
	ld [wRequested2bppSource + 1], a

	ld a, LOW(wLYOverrides)
	ld [wRequested2bppDest], a
	ld a, HIGH(wLYOverrides)
	ld [wRequested2bppDest + 1], a

	ld a, (wLYOverridesEnd - wLYOverrides) / 28
	ld [wRequested2bpp], a
	ret
