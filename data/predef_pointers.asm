; Predef routines can be used with the "predef" and "predef_jump" macros.
; This preserves registers bc, de, hl and f.

add_predef: MACRO
\1Predef::
	dab \1
ENDM

PredefPointers::
	add_predef LearnMove ; $0
	add_predef DebugMenu
	add_predef HealParty
	add_predef SmallFarFlagAction
	add_predef ComputeHPBarPixels
	add_predef FillPP
	add_predef TryAddMonToParty
	add_predef AddTempmonToParty
	add_predef SendGetMonIntoFromBox ; $8
	add_predef SendMonIntoBox
	add_predef GiveEgg
	add_predef AnimateHPBar
	add_predef CalcMonStats
	add_predef CalcMonStatC
	add_predef CanLearnTMHMMove
	dwb $5a27, $04
	dwb $4d8e, $0a ; $10
	dwb $5ce3, $0b
	dwb $5da5, $0f
	dwb $7ade, $11
	dwb $5706, $0f
	dwb $5e98, $0f
	dwb $73d6, $0f
	dwb $72a5, $0f
	dwb $7352, $0f ; $18
	dwb $7391, $0f
	dwb $6625, $10
	add_predef FillMoves
	dwb $6357, $10
	dwb $4e28, $0a
	add_predef TradeAnimation
	add_predef CopyMonToTempMon
	add_predef unk_014_547a ; $20
	dwb $543f, $14
	dwb $53fb, $14
	dwb $537b, $14
	dwb $5308, $14
	dwb $4c79, $14
	dwb $4c08, $14
	dwb $4c0c, $14
	dwb $52b8, $14 ; $28
	dwb $4a8a, $14
	dwb $4a60, $14
	dwb $4a79, $14
	dwb $4a33, $14
	add_predef GetUnownLetter
	dwb $7c06, $32
	dwb $40e4, $32
	add_predef unk_002_5f84 ; $30
	add_predef LoadSGBLayout
	add_predef unk_024_5da5
	add_predef unk_002_5391
	add_predef unk_023_4576
	add_predef DummyPredef35
	add_predef DummyPredef36
	add_predef unk_033_40e5
	add_predef DummyPredef38 ; $38
	add_predef DummyPredef39
	add_predef DebugFightMenu
	dwb $6db1, $04
	dwb $5782, $14
	dwb $57f0, $14
	dwb $588d, $14
	dwb $58e7, $14
	dwb $4928, $0d ; $40
	dwb $7a24, $3e
	dwb $79b9, $3e
	dbw -1, $2e83
