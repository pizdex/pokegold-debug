INCLUDE "engine/debug/debug_fight_menu.asm"

Call_03f_5b65:
	ld a, [wCurPartySpecies]
	push af
	call Call_03f_5b99
	jr c, .asm_5b93
	ld a, $10
	ld hl, $692f
	rst FarCall
	jr nc, .asm_5b88
	call Call_03f_5b99
	jr c, .asm_5b93

	ld a, $10
	ld hl, $692f
	rst FarCall
	jr nc, .asm_5b88
	call Call_03f_5b99
	jr c, .asm_5b93

.asm_5b88:
	call Call_03f_5be8
	jr c, .asm_5b93
	pop af
	ld [wCurPartySpecies], a
	and a
	ret

.asm_5b93:
	pop af
	ld [wCurPartySpecies], a
	scf
	ret

Call_03f_5b99:
	ld a, [wApplyStatLevelMultipliersToEnemy]
	ld [wTMHMMove], a
	ld a, $0e
	call Predef
	ld a, c
	and a
	jr nz, .asm_5bc5
	ld a, [wApplyStatLevelMultipliersToEnemy]
	ld d, a
	call Call_03f_5c0e
.asm_5baf:
	ld a, $10
	call GetFarByte
	inc hl
	and a
	jr z, .asm_5bc3
	ld a, $10
	call GetFarByte
	inc hl
	cp d
	jr z, .asm_5bc5
	jr .asm_5baf

.asm_5bc3:
	and a
	ret

.asm_5bc5:
	scf
	ret

unkData_03f_5bc7:
	db 007, 009, 010, 014, 016, 020, 022, 028
	db 049, 066, 083, 089, 091, 099, 100, 103
	db 104, 105, 114, 125, 126, 139, 142, 149
	db 152, 154, 155, 178, 179, 180, 187, 190
	db -1

Call_03f_5be8:
	ld hl, $7b07
	ld a, [wCurPartySpecies]
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, $08
	call GetFarHalfword
.asm_5bf9:
	ld a, $08
	call GetFarByte
	inc hl
	cp $ff
	jr z, .asm_5c0c
	ld b, a
	ld a, [wApplyStatLevelMultipliersToEnemy]
	cp b
	jr nz, .asm_5bf9
	scf
	ret

.asm_5c0c:
	and a
	ret

Call_03f_5c0e:
	ld hl, $695f
	ld b, 0
	ld a, [wCurPartySpecies]
	dec a
	ld c, a
	add hl, bc
	add hl, bc
	ld a, $10
	call GetFarHalfword
.asm_5c1f:
	ld a, $10
	call GetFarByte
	inc hl
	and a
	jr nz, .asm_5c1f
	ret
