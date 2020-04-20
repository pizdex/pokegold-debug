unk_002_4000:
	dr $8000,$8df7

_Sine::
	ld a, e
	and $3f
	cp $20
	jr nc, .negative
	call .GetSine
	ld a, h
	ret
.negative
	and $1f
	call .GetSine
	ld a, h
	xor $ff
	inc a
	ret

.GetSine:
	ld e, a
	ld a, d
	ld d, $0
	ld hl, .SineWave
	add hl, de
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, $0
.loop
	srl a
	jr nc, .no_add
	add hl, de
.no_add
	sla e
	rl d
	and a
	jr nz, .loop
	ret

.SineWave:
	sine_table $100

GetPredefPointer::
    ld a, h
    ld [wPredefTemp], a
    ld a, l
    ld [$cfd7], a
    push de
    ld a, [wPredefID]
    ld e, a
    ld d, $00
    ld hl, $4e89
    add hl, de
    add hl, de
    add hl, de
    pop de
    ld a, [hl+]
    ld [$cfd9], a
    ld a, [hl+]
    ld [wPredefAddress], a
    ld a, [hl]
    ret

; Predef routines can be used with the "predef" and "predef_jump" macros.
; This preserves registers bc, de, hl and f.

add_predef: MACRO
\1Predef::
	dab \1
ENDM

PredefPointers::
	db $0F, $68, $01 ; $0
	db $31, $40, $01
	db $B3, $46, $03
	db $77, $46, $03
	db $F4, $46, $03
	db $1A, $5D, $03
	db $39, $5B, $03
	db $43, $5D, $03
	db $EC, $5D, $03 ; $8
	db $1B, $61, $03
	db $39, $62, $03
	db $3B, $47, $03
	db $15, $64, $03
	db $29, $64, $03
	db $F6, $59, $04
	db $27, $5A, $04
	db $8E, $4D, $0A ; $10
	db $E3, $5C, $0B
	db $A5, $5D, $0F
	db $DE, $7A, $11
	db $06, $57, $0F
	db $98, $5E, $0F
	db $D6, $73, $0F
	db $A5, $72, $0F
	db $52, $73, $0F ; $18
	db $91, $73, $0F
	db $25, $66, $10
	db $7F, $66, $10
	db $57, $63, $10
	db $28, $4E, $0A
	db $F0, $4D, $0A
	db $70, $49, $14
	db $7A, $54, $14 ; $20
	db $3F, $54, $14
	db $FB, $53, $14
	db $7B, $53, $14
	db $08, $53, $14
	db $79, $4C, $14
	db $08, $4C, $14
	db $0C, $4C, $14
	db $B8, $52, $14 ; $28
	db $8A, $4A, $14
	db $60, $4A, $14
	db $79, $4A, $14
	db $33, $4A, $14
	db $4B, $57, $14
	db $06, $7C, $32
	db $E4, $40, $32
	db $84, $5F, $02 ; $30
	db $55, $4F, $02
	db $A5, $5D, $24
	db $91, $53, $02
	db $76, $45, $23
	db $B8, $43, $23
	db $B8, $43, $23
	db $E5, $40, $33
	db $E4, $40, $33 ; $38
	db $E4, $40, $33
	add_predef DebugFightMenu
	db $B1, $6D, $04
	db $82, $57, $14
	db $F0, $57, $14
	db $8D, $58, $14
	db $E7, $58, $14
	db $28, $49, $0D ; $40
	db $24, $7A, $3E
	db $B9, $79, $3E
	db -1, $83, $2E

unk_002_4f55:
	dr $8f55, $8fbd

unk_002_4fbd:
	dr $8fbd, $c000
