FieldMoveJumptableReset:
	xor a
	ld hl, wFieldMoveData
	ld bc, wFieldMoveDataEnd - wFieldMoveData
	call ByteFill
	ret

FieldMoveJumptable:
	ld a, [wFieldMoveJumptableIndex]
	rst JumpTable
	ld [wFieldMoveJumptableIndex], a
	bit 7, a
	jr nz, .okay
	and a
	ret

.okay
	and $7f
	scf
	ret

GetPartyNick:
; write wCurPartyMon nickname to wStringBuffer1-3
	ld hl, wPartyMonNicknames
	ld a, BOXMON
	ld [wMonType], a
	ld a, [wCurPartyMon]
	call GetNick
	call CopyName1
; copy text from wStringBuffer2 to wStringBuffer3
	ld de, wStringBuffer2
	ld hl, wStringBuffer3
	call CopyName2
	ret

CheckEngineFlag:
; Check engine flag de
; Return carry if flag is not set
	call CheckFieldDebug
	jr nz, .isset

	ld b, CHECK_FLAG
	farcall EngineFlagAction
	ld a, c
	and a
	jr nz, .isset
	scf
	ret

.isset
	xor a
	ret

Call_003_4791:
	call CheckEngineFlag
	ret nc

	ld hl, $479d
	call MenuTextboxBackup
	scf
	ret

.CantUseItemText:
	text "あたらしい バッジを てにするまで"
	line "まだ つかえません!"
	prompt

CheckPartyMove:
	dr $c7bb, $c86f

CheckMapForSomethingToCut:
	dr $c86f, $c8a3

Script_Cut:
	dr $c8a3, $cfb1

Call_003_4fb1:
	dr $cfb1, $d439

TryCutOW::
	ld d, CUT
	call CheckPartyMove
	jr c, .cant_cut

	ld de, ENGINE_HIVEBADGE
	call CheckEngineFlag
	jr c, .cant_cut

	ld a, BANK(AskCutScript)
	ld hl, AskCutScript
	call CallScript
	scf
	ret

.cant_cut
	ld a, BANK(CantCutScript)
	ld hl, CantCutScript
	call CallScript
	scf
	ret

AskCutScript:
	opentext
	writetext AskCutText
	yesorno
	iffalse .declined
	callasm .CheckMap
	iftrue Script_Cut
.declined
	closetext
	end

.CheckMap:
	xor a
	ld [wScriptVar], a
	call CheckMapForSomethingToCut
	ret c
	ld a, TRUE
	ld [wScriptVar], a
	ret

AskCutText:
	text "<……>このきは なんだか"
	line "きれそうだ!"

	para "いあいぎリで きリますか?"
	done

CantCutScript:
	jumptext CanCutText

CanCutText:
	text "このきは なんだか"
	line "きれそうだ!"
	done
