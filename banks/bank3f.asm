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

INCLUDE "engine/debug/debug_sound_menu.asm"
INCLUDE "engine/tilesets/tileset_anims.asm"

Call_03f_68b4:
	ld a, [wEnteredMapFromContinue]
	bit 0, a
	ret z
	ld hl, wcebc
	ld bc, $0014
	ld a, $7f
	call ByteFill
	ld hl, wd55c
	bit 0, [hl]
	jr z, jr_03f_68e2
	ld hl, wXCoord
	ld de, wcec0
	ld c, $01
	call Call_03f_6927
	ld hl, wYCoord
	ld de, wcec4
	ld c, $01
	call Call_03f_6927
	ret

jr_03f_68e2:
	ld hl, wCurDay
	ld de, wcebc
	call Call_03f_6936
	ld a, $70
	ld [wcec0], a
	ld hl, hHours
	ld de, wcec1
	call Call_03f_6936
	ld a, $70
	ld [wcec3], a
	ld hl, hMinutes
	ld de, wcec4
	call Call_03f_6936
	ld hl, hSeconds
	ld de, wcec7
	call Call_03f_6936
	call GetWeekday
	add $71
	ld [wceca], a
	ld a, $78
	ld [wcecc], a
	inc a
	ld [wcecd], a
	ldh a, [hSeconds]
	and $01
	ret z
	ret

Call_03f_6927::
	ld a, [hli]
	ld b, a
	swap a
	call Call_03f_694b
	ld a, b
	call Call_03f_694b
	dec c
	jr nz, Call_03f_6927
	ret

Call_03f_6936:
	ld a, [hli]
	ld b, 0
.asm_6939:
	inc b
	sub 10
	jr nc, .asm_6939
	dec b
	add 10
	push af
	ld a, b
	call Call_03f_694b
	pop af
	call Call_03f_694b
	ret

Call_03f_694b:
	and $0f
	add $66
	ld [de], a
	inc de
	ret
