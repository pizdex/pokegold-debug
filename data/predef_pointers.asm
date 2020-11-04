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
	add_predef unk_003_5d1a
	add_predef TryAddMonToParty
	add_predef unk_003_5d43
	add_predef unk_003_5dec ; $8
	add_predef unk_003_611b
	add_predef unk_003_6239
	add_predef AnimateHPBar
	add_predef unk_003_6415
	add_predef unk_003_6429
	db $f6, $59, $04
	db $27, $5a, $04
	db $8e, $4d, $0a ; $10
	db $e3, $5c, $0b
	db $a5, $5d, $0f
	db $de, $7a, $11
	db $06, $57, $0f
	db $98, $5e, $0f
	db $d6, $73, $0f
	db $a5, $72, $0f
	db $52, $73, $0f ; $18
	db $91, $73, $0f
	db $25, $66, $10
	db $7f, $66, $10
	db $57, $63, $10
	db $28, $4e, $0a
	add_predef TradeAnimation
	db $70, $49, $14
	db $7a, $54, $14 ; $20
	db $3f, $54, $14
	db $fb, $53, $14
	db $7b, $53, $14
	db $08, $53, $14
	db $79, $4c, $14
	db $08, $4c, $14
	db $0c, $4c, $14
	db $b8, $52, $14 ; $28
	db $8a, $4a, $14
	db $60, $4a, $14
	db $79, $4a, $14
	db $33, $4a, $14
	db $4b, $57, $14
	db $06, $7c, $32
	db $e4, $40, $32
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
	db $b1, $6d, $04
	db $82, $57, $14
	db $f0, $57, $14
	db $8d, $58, $14
	db $e7, $58, $14
	db $28, $49, $0d ; $40
	db $24, $7a, $3e
	db $b9, $79, $3e
	dbw -1, $2e83
