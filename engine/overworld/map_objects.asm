INCLUDE "data/sprites/facings.asm"
INCLUDE "data/sprites/map_objects.asm"

DeleteMapObject:
	push bc
	ld hl, 1
	add hl, bc
	ld a, [hl]
Jump_001_4366:
	push af
	ld h, b
	ld l, c
	ld bc, $28
	xor a
	call ByteFill
	pop af
	cp $ff
	jr z, .asm_4382
	bit 7, a
	jr nz, .asm_4382
	call $173c
	ld hl, 0
	add hl, bc
	ld [hl], $ff
.asm_4382
	pop bc
	ret

Function4384:
	call .CheckObjectStillVisible
	ret c
	call .HandleStepType
	call .HandleObjectAction
	ret

.CheckObjectStillVisible:
	ld hl, 5
	add hl, bc
	res 6, [hl]
	ld a, [wXCoord]
	ld e, a
	ld hl, $10
	add hl, bc
	ld a, [hl]
	add 1
	sub e
	jr c, .asm_43bb

	cp $c
	jr nc, .asm_43bb

	ld a, [wYCoord]
	ld e, a
	ld hl, $11
	add hl, bc
	ld a, [hl]
	add 1
	sub e
	jr c, .asm_43bb

	cp $b
	jr nc, .asm_43bb
	jr .asm_43e5

.asm_43bb
	ld hl, 5
	add hl, bc
	set 6, [hl]
	ld a, [wXCoord]
	ld e, a
	ld hl, $14
	add hl, bc
	ld a, [hl]
	add 1
	sub e
	jr c, .asm_43e7

	cp $c
	jr nc, .asm_43e7

	ld a, [wYCoord]
	ld e, a
	ld hl, $15
	add hl, bc
	ld a, [hl]
	add 1
	sub e
	jr c, .asm_43e7
	cp $b
	jr nc, .asm_43e7
.asm_43e5
	and a
	ret

.asm_43e7
	ld hl, 4
	add hl, bc
	bit 1, [hl]
	jr nz, .asm_43f4
	call DeleteMapObject
	scf
	ret

.asm_43f4
	ld hl, 5
	add hl, bc
	set 6, [hl]
	and a
	ret

.HandleStepType:
	ld hl, 9
	add hl, bc
	ld a, [hl]
	and a
	jr z, .asm_4412

	ld hl, 5
	add hl, bc
	bit 5, [hl]
	jr nz, .asm_442f

	cp 1
	jr z, .asm_441d
	jr .asm_442a

.asm_4412
	call ObjectMovementReset
	ld hl, 5
	add hl, bc
	bit 5, [hl]
	jr nz, .asm_442f

.asm_441d
	call MapObjectMovementPattern
	ld hl, 9
	add hl, bc
	ld a, [hl]
	and a
	ret z

	cp 1
	ret z

.asm_442a
	ld hl, $4b26
	rst $28
	ret

.asm_442f
	ret

.HandleObjectAction:
	ld hl, 4
	add hl, bc
	bit 0, [hl]
	jr nz, Function44a8

	ld hl, 5
	add hl, bc
	bit 6, [hl]
	jr nz, Function44a8

	bit 5, [hl]
	jr nz, .asm_4451

	ld de, $4468
	jr jr_001_4456

.asm_4449
	ld hl, 4
	add hl, bc
	bit 0, [hl]
	jr nz, Function44a8
.asm_4451
	ld de, $446a
	jr jr_001_4456

jr_001_4456:
	ld hl, $b
	add hl, bc
	ld a, [hl]
	ld l, a
	ld h, $00
	add hl, hl
	add hl, hl
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call _hl_
	ret

Pointers4468:
	xor b
	ld b, h
	xor b
	ld b, h
	cp d
	ld b, h
	xor a
	ld b, h
	add $44
	xor a
	ld b, h
	jp hl


	ld b, h
	xor a
	ld b, h
	ld a, [bc]
	ld b, l
	xor a
	ld b, h
	ld a, [de]
	ld b, l
	xor b
	ld b, h
	ld c, a
	ld b, l
	ld c, a
	ld b, l
	ld e, h
	ld b, l
	xor b
	ld b, h
	ld h, e
	ld b, l
	ld h, e
	ld b, l
	ld l, d
	ld b, l
	ld l, d
	ld b, l
	ld [hl], c
	ld b, l
	add l
	ld b, l
	adc h
	ld b, l
	xor a
	ld b, h
	sbc a
	ld b, l
	sbc a
	ld b, l
	and [hl]
	ld b, l
	and [hl]
	ld b, l
	cp e
	ld b, l
	xor b
	ld b, h
	adc $45
	xor b
	ld b, h

Function44a8:
	ld hl, $000d
	add hl, bc
	ld [hl], $ff
	ret

Function44af:
	call $1971
	or 0
	ld hl, $000d
	add hl, bc
	ld [hl], a
	ret

Function44ba:
	ld hl, $000d
	add hl, bc
	ld a, [hl]
	and 1
	jr nz, Function44c6
	jp Function44af

Function44c6:
	ld hl, $0004
	add hl, bc
	bit 3, [hl]
	jp nz, Function44af

	ld hl, $c
	add hl, bc
	ld a, [hl]
	inc a
	and $0f
	ld [hl], a
	rrca
	rrca
	and $03
	ld d, a
	call $1971
	or $00
	or d
	ld hl, $000d
	add hl, bc
	ld [hl], a
	ret

Function44e9:
	ld hl, $0004
	add hl, bc
	bit 3, [hl]
	jp nz, Function44af

	ld hl, $000c
	add hl, bc
	inc [hl]
	ld a, [hl]
	rrca
	rrca
	rrca
	and $03
	ld d, a
	call $1971
	or $00
	or d
	ld hl, $000d
	add hl, bc
	ld [hl], a
	ret

Function450a:
	call Function4520
	ld hl, $0008
	add hl, bc
	ld a, [hl]
	or $00
	ld hl, $000d
	add hl, bc
	ld [hl], a
	ret

Function451a:
	call Function4520
	jp Function44a8

Function4520:
	ld hl, $000c
	add hl, bc
	ld a, [hl]
	and $f0
	ld e, a
	ld a, [hl]
	inc a
	and $0f
	ld d, a
	cp $04
	jr c, .asm_4539

	ld d, $00
	ld a, e
	add $10
	and $30
	ld e, a
.asm_4539
	ld a, d
	or e
	ld [hl], a
	swap e
	ld d, $00
	ld hl, $454b
	add hl, de
	ld a, [hl]
	ld hl, $0008
	add hl, bc
	ld [hl], a
	ret

.directions
	db OW_DOWN, OW_RIGHT, OW_UP, OW_LEFT

Function454f:
	call $1971
	rrca
	rrca
	add $10
	ld hl, $000d
	add hl, bc
	ld [hl], a
	ret

Function455c:
	ld hl, $000d
	add hl, bc
	ld [hl], $15
	ret

Function4563:
	ld hl, $000d
	add hl, bc
	ld [hl], $14
	ret

Function456a:
	ld hl, $000d
	add hl, bc
	ld [hl], $17
	ret

Function4571:
	ld hl, $000c
	add hl, bc
	ld a, [hl]
	inc a
	and $0f
	ld [hl], a
	and $08
	jr z, Function4585

	ld hl, $000d
	add hl, bc
	ld [hl], $04
	ret

Function4585:
	ld hl, $000d
	add hl, bc
	ld [hl], $00
	ret

Function458c:
	ld hl, $000c
	add hl, bc
	ld a, [hl]
	inc a
	ld [hl], a
	and $0c
	rrca
	rrca
	add $18
	ld hl, $000d
	add hl, bc
	ld [hl], a
	ret

Function459f:
	ld hl, $000d
	add hl, bc
	ld [hl], $16
	ret

Function45a6:
	ld a, [wd54b]
	ld d, $17
	cp $33
	jr z, .asm_45b5

	cp $47
	jr z, .asm_45b5

	ld d, $16
.asm_45b5
	ld hl, $000d
	add hl, bc
	ld [hl], d
	ret

Function45bb:
	ld hl, $000c
	add hl, bc
	inc [hl]
	ld a, [hl]
	ld hl, $000d
	add hl, bc
	and $02
	ld a, $1c
	jr z, .asm_45cc
	inc a
.asm_45cc
	ld [hl], a
	ret

Function45ce:
	ld hl, $000c
	add hl, bc
	inc [hl]
	ld a, [hl]
	ld hl, $000d
	add hl, bc
	and $04
	ld a, $1e
	jr z, .asm_45df
	inc a
.asm_45df
	ld [hl], a
	ret

CopyNextCoordsTileToStandingCoordsTile:
	ld hl, $10
	add hl, bc
	ld a, [hl]
	ld hl, $12
	add hl, bc
	ld [hl], a
	ld hl, $11
	add hl, bc
	ld a, [hl]
	ld hl, $13
	add hl, bc
	ld [hl], a
	ld hl, $e
	add hl, bc
	ld a, [hl]
	ld hl, $f
	add hl, bc
	ld [hl], a
	call SetGrassPriority
	ld hl, $e
	add hl, bc
	ld a, [hl]
	call UselessAndA
	ret

Function460b:
	ld hl, $12
	add hl, bc
	ld a, [hl]
	ld hl, $10
	add hl, bc
	ld [hl], a
	ld hl, $13
	add hl, bc
	ld a, [hl]
	ld hl, $11
	add hl, bc
	ld [hl], a
	ret

UpdateGrassPriority:
	ld hl, 5
	add hl, bc
	bit 3, [hl]
	jr z, .asm_4630

	ld hl, $e
	add hl, bc
	ld a, [hl]
	call SetGrassPriority
.asm_4630
	ld hl, $e
	add hl, bc
	ld a, [hl]
	call UselessAndA
	ret c

	ld hl, $f
	add hl, bc
	ld a, [hl]
	call UselessAndA
	ret

SetGrassPriority:
	call $16f8
	jr z, .asm_464c
	call $16df
	jr c, .asm_4653
.asm_464c
	ld hl, 5
	add hl, bc
	set 3, [hl]
	ret

.asm_4653
	ld hl, 5
	add hl, bc
	res 3, [hl]
	ret

UselessAndA:
	and a
	ret

EndSpriteMovement:
	xor a
	ld hl, $c
	add hl, bc
	ld [hl], a
	ld hl, $1b
	add hl, bc
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld hl, $7
	add hl, bc
	ld [hl], $ff
	ret

InitStep:
	ld hl, $7
	add hl, bc
	ld [hl], a
	ld hl, $4
	add hl, bc
	bit 2, [hl]
	jr nz, GetNextTile

	add a
	add a
	and $c
	ld hl, $8
	add hl, bc
	ld [hl], a

GetNextTile:
	call GetStepVector
	ld hl, $a
	add hl, bc
	ld [hl], a
	ld a, d
	call GetStepVectorSign
	ld hl, $12
	add hl, bc
	add [hl]
	ld hl, $10
	add hl, bc
	ld [hl], a
	ld d, a
	ld a, e
	call GetStepVectorSign
	ld hl, $13
	add hl, bc
	add [hl]
	ld hl, $11
	add hl, bc
	ld [hl], a
	ld e, a
	push bc
	call $2b8e
	pop bc
	ld hl, $e
	add hl, bc
	ld [hl], a
	ret

AddStepVector:
	call GetStepVector
	ld hl, $17
	add hl, bc
	ld a, [hl]
	add d
	ld [hl], a
	ld hl, $18
	add hl, bc
	ld a, [hl]
	add e
	ld [hl], a
	ret

GetStepVector:
	ld hl, $0007
	add hl, bc
	ld a, [hl]
	and $0f
	add a
	add a
	ld l, a
	ld h, $00
	ld de, $46e1
	add hl, de
	ld d, [hl]
	inc hl
	ld e, [hl]
	inc hl
	ld a, [hl+]
	ld h, [hl]
	ret

StepVectors:
; x,  y, duration, speed

	; slow
	db  0,  1, 16, 1
	db  0, -1, 16, 1
	db -1,  0, 16, 1
	db  1,  0, 16, 1
	; normal
	db  0,  2,  8, 2
	db  0, -2,  8, 2
	db -2,  0,  8, 2
	db  2,  0,  8, 2
	; fast
	db  0,  4,  4, 4
	db  0, -4,  4, 4
	db -4,  0,  4, 4
	db  4,  0,  4, 4

GetStepVectorSign:
	add a
	ret z
	ld a, 1
	ret nc
	ld a, $ff
	ret

UpdatePlayerStep:
	ld hl, 7
	add hl, bc
	ld a, [hl]
	and 3
	ld [$ce7a], a
	call AddStepVector
	ld a, [$ce77]
	add d
	ld [$ce77], a
	ld a, [$ce78]
	add e
	ld [$ce78], a
	ld hl, $ce79
	set 5, [hl]
	ret

Function473a:
	push bc
	ld e, a
	ld d, $00
	ld hl, 1
	add hl, bc
	ld a, [hl]
	call $173c
	add hl, de
	ld a, [hl]
	pop bc
	ret

RestoreDefaultMovement:
	ld hl, 1
	add hl, bc
	ld a, [hl]
	cp $ff
	jr z, .asm_475e

	push bc
	call $173c
	ld hl, 4
	add hl, bc
	ld a, [hl]
	pop bc
	ret

.asm_475e
	ld a, 6
	ret

ClearObjectMovementByteIndex:
	ld hl, $1b
	add hl, bc
	ld [hl], $0
	ret

IncrementObjectMovementByteIndex:
	ld hl, $1b
	add hl, bc
	inc [hl]
	ret

DecrementObjectMovementByteIndex:
	ld hl, $1b
	add hl, bc
	dec [hl]
	ret

MovementAnonymousJumptable:
	ld hl, $1b
	add hl, bc
	ld a, [hl]
	pop hl
	rst JumpTable
	ret

ClearObjectStructField28:
	ld hl, $1c
	add hl, bc
	ld [hl], $0
	ret

IncrementObjectStructField28:
	ld hl, $1c
	add hl, bc
	inc [hl]
	ret

Object28AnonymousJumptable:
	ld hl, $1c
	add hl, bc
	ld a, [hl]
	pop hl
	rst JumpTable
	ret

GetValueObjectStructField28:
	ld hl, $1c
	add hl, bc
	ld a, [hl]
	ret

SetValueObjectStructField28:
	ld hl, $1c
	add hl, bc
	ld [hl], a
	ret

ObjectMovementReset:
	ld hl, $10
	add hl, bc
	ld d, [hl]
	ld hl, $11
	add hl, bc
	ld e, [hl]
	push bc
	call $2b8e
	pop bc
	ld hl, $e
	add hl, bc
	ld [hl], a
	call CopyNextCoordsTileToStandingCoordsTile
	call EndSpriteMovement
	ld hl, $9
	add hl, bc
	ld [hl], $1
	ret

MapObjectMovementPattern:
	call ClearObjectStructField28
	call $1899
	ld a, [hl]
	ld hl, .Pointers
	rst JumpTable
	ret

.Pointers:
	dw Function4802
	dw Function4803
	dw Function480d
	dw Function4819
	dw Function4823
	dw Function4832
	dw Function484a
	dw Function485d
	dw Function4863
	dw Function4869
	dw Function486f
	dw Function4872
	dw Function4875
	dw Function4878
	dw Function487e
	dw Function4881
	dw Function4887
	dw Function488d
	dw Function48e0
	dw Function49c6
	dw Function4a02
	dw Function4939
	dw Function494f
	dw Function4a9d
	dw Function496e
	dw Function4965
	dw Function4a27
	dw Function4a6a

Function4802:
	ret

Function4803:
	call $310f
	ldh a, [$e3]
	and $01
	jp Function4ad1

Function480d:
	call $310f
	ldh a, [$e3]
	and $01
	or $02
	jp Function4ad1

Function4819:
	call $310f
	ldh a, [$e3]
	and $03
	jp Function4ad1

Function4823:
	call $310f
	ldh a, [$e3]
	and $0c
	ld hl, $0008
	add hl, bc
	ld [hl], a
	jp Function4afe

Function4832:
	ld hl, $0008
	add hl, bc
	ld a, [hl]
	and $0c
	ld d, a
	call $310f
	ldh a, [$e3]
	and $0c
	cp d
	jr nz, .asm_4846
	xor $0c
.asm_4846
	ld [hl], a
	jp Function4b07

Function484a:
	call Function460b
	call EndSpriteMovement
	ld hl, $000b
	add hl, bc
	ld [hl], $01
	ld hl, $0009
	add hl, bc
	ld [hl], $05
	ret

Function485d:
	ld hl, $4fb0
	jp $4ff1

Function4863:
	ld hl, $4fc5
	jp $4ff1

Function4869:
	ld hl, $4fd6
	jp $4ff1

Function486f:
	jp Function4fe7

Function4872:
	jp Function4fe7

Function4875:
	jp Function4fe7

Function4878:
	ld hl, $4fb0
	jp $4ff1

Function487e:
	jp Function4fe7

Function4881:
	ld hl, $548d
	jp $4ff1

Function4887:
	ld hl, $4fbe
	jp $4ff1

Function488d:
	call MovementAnonymousJumptable
	sub h
	ld c, b
	reti

	ld c, b
	ld hl, $000e
	add hl, bc
	ld a, [hl]
	call $1710
	jr z, .asm_48d6

	ld hl, $0005
	add hl, bc
	bit 2, [hl]
	res 2, [hl]
	jr z, .asm_48cf

	ld hl, $0020
	add hl, bc
	ld a, [hl]
	and $03
	or $00
	call InitStep
	call $7a11
	jr c, .asm_48cc

	ld de, $001b
	call $3df6
	call $54df
	call UpdateGrassPriority
	ld hl, $0009
	add hl, bc
	ld [hl], $0f
	ret

.asm_48cc
	call Function460b

.asm_48cf
	ld hl, 7
	add hl, bc
	ld [hl], $ff
	ret

.asm_48d6
	call IncrementObjectMovementByteIndex
	ld hl, 7
	add hl, bc
	ld [hl], $ff
	ret

Function48e0:
	ld hl, $0010
	add hl, bc
	ld d, [hl]
	ld hl, $0011
	add hl, bc
	ld e, [hl]
	ld hl, $0020
	add hl, bc
	ld a, [hl]
	push bc
	call $194f
	ld hl, $0007
	add hl, bc
	ld a, [hl]
	cp $ff
	jr z, .asm_492b

	ld hl, $0012
	add hl, bc
	ld a, [hl]
	cp d
	jr z, .asm_490e

	jr c, .asm_490a

	ld a, 3
	jr .asm_491e

.asm_490a
	ld a, 2
	jr .asm_491e

.asm_490e
	ld hl, $13
	add hl, bc
	ld a, [hl]
	cp e
	jr z, .asm_492b
	jr c, .asm_491c
	ld a, 0
	jr .asm_491e

.asm_491c
	ld a, 1

.asm_491e
	ld d, a
	ld hl, 7
	add hl, bc
	ld a, [hl]
	and $c
	or d
	pop bc
	jp $53b9

.asm_492b
	pop bc
	ld hl, $0007
	add hl, bc
	ld [hl], $ff
	ld hl, $000b
	add hl, bc
	ld [hl], 1
	ret

Function4939:
	call EndSpriteMovement
	ld hl, 7
	add hl, bc
	ld [hl], $ff
	ld hl, $b
	add hl, bc
	ld [hl], 9
	ld hl, 9
	add hl, bc
	ld [hl], 4
	ret

Function494f:
	call EndSpriteMovement
	ld hl, 7
	add hl, bc
	ld [hl], $ff
	ld hl, $b
	add hl, bc
	ld [hl], $a
	ld hl, 9
	add hl, bc
	ld [hl], 4
	ret

Function4965:
	call MovementAnonymousJumptable
	ld [hl], a
	ld c, c
	ld a, l
	ld c, c
	sbc c
	ld c, c

Function496e:
	call MovementAnonymousJumptable
	dw Function4977
	dw Function497d
	dw Function49a5

Function4977:
	call EndSpriteMovement
	call IncrementObjectMovementByteIndex

Function497d:
	ld hl, $b
	add hl, bc
	ld [hl], 1
	ld hl, $20
	add hl, bc
	ld a, [hl]
	ld a, $10
	ld hl, $a
	add hl, bc
	ld [hl], a
	ld hl, 9
	add hl, bc
	ld [hl], 3
	call IncrementObjectMovementByteIndex
	ret

Function4999:
	ld de, .data
	call Function49b1
	jr Function4965
.data
	db OW_RIGHT, OW_LEFT, OW_DOWN, OW_UP

Function49a5:
	ld de, .data
	call Function49b1
	jr Function496e
.data
	db OW_LEFT, OW_RIGHT, OW_UP, OW_DOWN

Function49b1:
	ld hl, 8
	add hl, bc
	ld a, [hl]
	and $c
	rrca
	rrca
	push hl
	ld l, a
	ld h, 0
	add hl, de
	ld a, [hl]
	pop hl
	ld [hl], a
	call DecrementObjectMovementByteIndex
	ret

Function49c6:
	call Function4a89
	ld hl, $000b
	add hl, bc
	ld [hl], $07
	ld hl, $000a
	add hl, de
	ld a, [hl]
	inc a
	add a
	add 0
	ld hl, $000a
	add hl, bc
	ld [hl], a
	ld hl, $0007
	add hl, de
	ld a, [hl]
	and 3
	ld d, $e
	cp 0
	jr z, .asm_49f0
	cp 1
	jr z, .asm_49f0
	ld d, $c
.asm_49f0
	ld hl, $1a
	add hl, bc
	ld [hl], d
	ld hl, $19
	add hl, bc
	ld [hl], 0
	ld hl, 9
	add hl, bc
	ld [hl], $13
	ret

Function4a02:
	call EndSpriteMovement
	call Function4a89
	ld hl, $000b
	add hl, bc
	ld [hl], $08
	ld hl, $000a
	add hl, bc
	ld [hl], $00
	ld hl, $001a
	add hl, bc
	ld [hl], $f0
	ld hl, $0019
	add hl, bc
	ld [hl], $00
	ld hl, $0009
	add hl, bc
	ld [hl], $13
	ret

Function4a27:
	call EndSpriteMovement
	call Function4a89
	ld hl, $b
	add hl, bc
	ld [hl], $e
	ld hl, $a
	add hl, de
	ld a, [hl]
	inc a
	add a
	ld hl, $a
	add hl, bc
	ld [hl], a
	ld hl, 7
	add hl, de
	ld a, [hl]
	and 3
	ld e, a
	ld d, 0
	ld hl, .data
	add hl, de
	add hl, de
	ld d, [hl]
	inc hl
	ld e, [hl]
	ld hl, $19
	add hl, bc
	ld [hl], d
	ld hl, $1a
	add hl, bc
	ld [hl], e
	ld hl, 9
	add hl, bc
	ld [hl], $13
	ret

.data
	;   x,  y
	db  0, -4
	db  0,  8
	db  6,  2
	db -6,  2

Function4a6a:
	call EndSpriteMovement
	call Function4a89
	ld hl, $000b
	add hl, bc
	ld [hl], $0f
	ld hl, $000a
	add hl, de
	ld a, [hl]
	add $ff
	ld hl, $000a
	add hl, bc
	ld [hl], a
	ld hl, $0009
	add hl, bc
	ld [hl], $13
	ret

Function4a89:
	ld hl, $0020
	add hl, bc
	ld a, [hl]
	push bc
	call $194f
	ld d, b
	ld e, c
	pop bc
	ld hl, $001d
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	ret

Function4a9d:
	call EndSpriteMovement
	ld hl, $000b
	add hl, bc
	ld [hl], $00
	ld hl, $0020
	add hl, bc
	ld a, [hl]
	call Function4abf
	ld hl, $000a
	add hl, bc
	ld [hl], e
	ld hl, $001e
	add hl, bc
	ld [hl], a
	ld hl, $0009
	add hl, bc
	ld [hl], $15
	ret

Function4abf:
	ld d, a
	and $3f
	ld e, a
	ld a, d
	rlca
	rlca
	and 3
	ld d, a
	inc d
	ld a, 1
.asm_4acc
	dec d
	ret z
	add a
	jr .asm_4acc

Function4ad1:
	call InitStep
	call $7a11
	jr c, .asm_4af8

	call UpdateGrassPriority
	ld hl, $b
	add hl, bc
	ld [hl], 2
	ld hl, wd1e9
	ldh a, [$b1]
	cp [hl]
	jr z, .asm_4af1

	ld hl, $9
	add hl, bc
	ld [hl], 7
	ret

.asm_4af1:
	ld hl, $9
	add hl, bc
	ld [hl], 6
	ret

.asm_4af8
	call EndSpriteMovement
	call Function460b

Function4afe:
	call $310f
	ldh a, [hRandom]
	and $7f
	jr Function4b0e

Function4b07:
	call $310f
	ldh a, [hRandomAdd]
	and $1f

Function4b0e:
	ld hl, $a
	add hl, bc
	ld [hl], a
	ld hl, $7
	add hl, bc
	ld [hl], $ff
	ld hl, $b
	add hl, bc
	ld [hl], $1
	ld hl, $9
	add hl, bc
	ld [hl], $3
	ret

StepTypesJumptable:
	db $9D, $47
	db $BE, $47
	db $0A, $4E
	db $BC, $4D
	db $00, $4E
	db $EB, $4D
	db $35, $4E
	db $26, $4E
	db $65, $4B
	db $9E, $4B
	db $62, $4E
	db $DE, $4D
	db $F7, $4B
	db $68, $4C
	db $F3, $4C
	db $AC, $4E
	db $5D, $4D
	db $8E, $4D
	db $A7, $4D
	db $E3, $4E
	db $12, $4F
	db $12, $4F
	db $56, $4F
	db $59, $4F
	db $CF, $4D

Function4b58:
	ld hl, $000a
	add hl, bc
	dec [hl]
	ret nz

	ld hl, $0009
	add hl, bc
	ld [hl], $01
	ret

Function4b65:
	call Object28AnonymousJumptable
	ld l, h
	ld c, e
	adc b
	ld c, e

Function4b6c:
	call AddStepVector
	call Function4f85
	ld hl, $000a
	add hl, bc
	dec [hl]
	ret nz

	call CopyNextCoordsTileToStandingCoordsTile
	call GetNextTile
	ld hl, $0005
	add hl, bc
	res 3, [hl]
	call IncrementObjectStructField28
	ret

Function4b88:
	call AddStepVector
	call Function4f85
	ld hl, $000a
	add hl, bc
	dec [hl]
	ret nz

	call CopyNextCoordsTileToStandingCoordsTile
	ld hl, $0009
	add hl, bc
	ld [hl], $01
	ret

Function4b9e:
	call Object28AnonymousJumptable

	xor c
	ld c, e
	or c
	ld c, e
	pop de
	ld c, e
	db $dc, $4b

Function4ba9:
	ld hl, $ce79
	set 7, [hl]
	call IncrementObjectStructField28

Function4bb1:
	call Function4f85
	call UpdatePlayerStep
	ld hl, $000a
	add hl, bc
	dec [hl]
	ret nz

	call CopyNextCoordsTileToStandingCoordsTile
	ld hl, $0005
	add hl, bc
	res 3, [hl]
	ld hl, $ce79
	set 6, [hl]
	set 4, [hl]
	call IncrementObjectStructField28
	ret

Function4bd1:
	call GetNextTile
	ld hl, $ce79
	set 7, [hl]
	call IncrementObjectStructField28

Function4bdc:
	call Function4f85
	call UpdatePlayerStep
	ld hl, $000a
	add hl, bc
	dec [hl]
	ret nz

	ld hl, $ce79
	set 6, [hl]
	call CopyNextCoordsTileToStandingCoordsTile
	ld hl, $0009
	add hl, bc
	ld [hl], $01
	ret

Function4bf7:
	call Object28AnonymousJumptable

	ld [bc], a
	ld c, h
	ld de, $214c
	ld c, h
	inc a
	ld c, h

Function4c02:
	ld hl, $000c
	add hl, bc
	ld [hl], $00
	ld hl, $000a
	add hl, bc
	ld [hl], $10
	call IncrementObjectStructField28

Function4c11:
	ld hl, $000b
	add hl, bc
	ld [hl], $04
	ld hl, $000a
	add hl, bc
	dec [hl]
	ret nz

	call IncrementObjectStructField28
	ret

Function4c21:
	ld hl, $000c
	add hl, bc
	ld [hl], $00
	ld hl, $001f
	add hl, bc
	ld [hl], $10
	ld hl, $000a
	add hl, bc
	ld [hl], $10
	ld hl, $0005
	add hl, bc
	res 3, [hl]
	call IncrementObjectStructField28

Function4c3c:
	ld hl, $000b
	add hl, bc
	ld [hl], $04
	ld hl, $001f
	add hl, bc
	inc [hl]
	ld a, [hl]
	ld d, $60
	call $197b
	ld a, h
	sub $60
	ld hl, $001a
	add hl, bc
	ld [hl], a
	ld hl, $000a
	add hl, bc
	dec [hl]
	ret nz

	ld hl, $000c
	add hl, bc
	ld [hl], $00
	ld hl, $0009
	add hl, bc
	ld [hl], $01
	ret

Function4c68:
	call Object28AnonymousJumptable

	ld a, c
	ld c, h
	adc c
	ld c, h
	sub d
	ld c, h
	xor b
	ld c, h
	jp z, $d44c
	ld c, h
	ldh [$4c], a

Function4c79:
	ld hl, $000b
	add hl, bc
	ld [hl], $00
	ld hl, $000a
	add hl, bc
	ld [hl], $10
	call IncrementObjectStructField28
	ret

Function4c89:
	ld hl, $000a
	add hl, bc
	dec [hl]
	ret nz
	call IncrementObjectStructField28

Function4c92:
	ld hl, $000c
	add hl, bc
	ld [hl], $00
	ld hl, $001f
	add hl, bc
	ld [hl], $00
	ld hl, $000a
	add hl, bc
	ld [hl], $10
	call IncrementObjectStructField28
	ret

Function4ca8:
	ld hl, $000b
	add hl, bc
	ld [hl], $04
	ld hl, $001f
	add hl, bc
	inc [hl]
	ld a, [hl]
	ld d, $60
	call $197b
	ld a, h
	sub $60
	ld hl, $001a
	add hl, bc
	ld [hl], a
	ld hl, $000a
	add hl, bc
	dec [hl]
	ret nz
	call IncrementObjectStructField28

Function4cca:
	ld hl, $000a
	add hl, bc
	ld [hl], $10
	call IncrementObjectStructField28
	ret

Function4cd4:
	ld hl, $000b
	add hl, bc
	ld [hl], $04
	ld hl, $000a
	add hl, bc
	dec [hl]
	ret nz
Function4ce0:
	ld hl, $000c
	add hl, bc
	ld [hl], $00
	ld hl, $001a
	add hl, bc
	ld [hl], $00
	ld hl, $0009
	add hl, bc
	ld [hl], $01
	ret

Function4cf3:
	call Object28AnonymousJumptable

	cp $4c
	dec c
	ld c, l
	ld l, $4d
	ld c, d
	ld c, l

Function4cfe:
	ld hl, $000b
	add hl, bc
	ld [hl], $00
	ld hl, $000a
	add hl, bc
	ld [hl], $10
	call IncrementObjectStructField28

Function4d0d:
	ld hl, $000a
	add hl, bc
	dec [hl]
	ret nz

	ld hl, $000b
	add hl, bc
	ld [hl], $02
	ld hl, $000c
	add hl, bc
	ld [hl], $00
	ld hl, $001f
	add hl, bc
	ld [hl], $00
	ld hl, $000a
	add hl, bc
	ld [hl], $10
	call IncrementObjectStructField28

Function4d2e:
	ld hl, $001f
	add hl, bc
	inc [hl]
	ld a, [hl]
	ld d, $60
	call $197b
	ld a, h
	sub $60
	ld hl, $001a
	add hl, bc
	ld [hl], a
	ld hl, $000a
	add hl, bc
	dec [hl]
	ret nz
	call IncrementObjectStructField28

Function4d4a:
	ld hl, $000c
	add hl, bc
	ld [hl], $00
	ld hl, $001a
	add hl, bc
	ld [hl], $00
	ld hl, $0009
	add hl, bc
	ld [hl], $01
	ret

Function4d5d:
	call Object28AnonymousJumptable

	ld h, h
	ld c, l
	ld [hl], e
	ld c, l

Function4d64:
	ld hl, $000a
	add hl, bc
	ld [hl], $08
	ld hl, $001a
	add hl, bc
	ld [hl], $00
	call IncrementObjectStructField28

Function4d73:
	ld hl, $001a
	add hl, bc
	ld a, [hl]
	xor $01
	ld [hl], a
	ld hl, $000a
	add hl, bc
	dec [hl]
	ret nz

	ld hl, $001a
	add hl, bc
	ld [hl], $00
	ld hl, $0009
	add hl, bc
	ld [hl], $01
	ret

Function4d8e:
	call Function4d94
	jp Function4b58

Function4d94:
	ld hl, $000a
	add hl, bc
	ld a, [hl]
	and $01
	ld a, $01
	jr z, .asm_4da1
	ld a, 0
.asm_4da1
	ld hl, $000b
	add hl, bc
	ld [hl], a
	ret

Function4da7:
	ld hl, $000a
	add hl, bc
	ld a, [hl]
	and $01
	ld a, $04
	jr z, .asm_4db4
	ld a, 5
.asm_4db4
	ld hl, $000b
	add hl, bc
	ld [hl], a
	jp Function4b58

Function4dbc:
	ld hl, $0007
	add hl, bc
	ld [hl], $ff
	ld hl, $000a
	add hl, bc
	dec [hl]
	ret nz

	ld hl, $0009
	add hl, bc
	ld [hl], $01
	ret

Function4dcf:
	ld hl, $0007
	add hl, bc
	ld [hl], $ff
	ld hl, $000a
	add hl, bc
	dec [hl]
	ret nz
	jp DeleteMapObject

Function4dde:
	ld hl, $000a
	add hl, bc
	dec [hl]
	ret nz

	ld hl, $0009
	add hl, bc
	ld [hl], $01
	ret

Function4deb:
	call Object28AnonymousJumptable

	ld a, [c]
	ld c, l
	nop
	ld c, [hl]

Function4df2:
	call RestoreDefaultMovement
	call $18b1
	ld hl, $0008
	add hl, bc
	ld [hl], a
	call IncrementObjectStructField28

Function4e00:
	call Function4f62
	ld hl, $0007
	add hl, bc
	ld [hl], $ff
	ret

Function4e0a:
	call Function4f62
	call AddStepVector
	ld hl, $000a
	add hl, bc
	dec [hl]
	ret nz

	call CopyNextCoordsTileToStandingCoordsTile
	ld hl, $0007
	add hl, bc
	ld [hl], $ff
	ld hl, $0009
	add hl, bc
	ld [hl], $01
	ret

Function4e26:
	call AddStepVector
	ld hl, $000a
	add hl, bc
	dec [hl]
	ret nz

	call CopyNextCoordsTileToStandingCoordsTile
	jp Function4afe

Function4e35:
	call Object28AnonymousJumptable

	inc a
	ld c, [hl]
	ld b, h
	ld c, [hl]

Function4e3c:
	ld hl, $ce79
	set 7, [hl]
	call IncrementObjectStructField28

Function4e44:
	call UpdatePlayerStep
	ld hl, $000a
	add hl, bc
	dec [hl]
	ret nz

	ld hl, $ce79
	set 6, [hl]
	call CopyNextCoordsTileToStandingCoordsTile
	ld hl, $0007
	add hl, bc
	ld [hl], $ff
	ld hl, $0009
	add hl, bc
	ld [hl], $01
	ret

Function4e62:
	call Object28AnonymousJumptable

	ld l, l
	ld c, [hl]
	add e
	ld c, [hl]
	adc h
	ld c, [hl]
	sbc a
	ld c, [hl]

Function4e6d:
	ld hl, $0007
	add hl, bc
	ld [hl], $ff
	ld hl, $000c
	add hl, bc
	ld a, [hl]
	ld [hl], $02
	ld hl, $000a
	add hl, bc
	ld [hl], $02
	call IncrementObjectStructField28

Function4e83:
	ld hl, $000a
	add hl, bc
	dec [hl]
	ret nz
	call IncrementObjectStructField28

Function4e8c:
	ld hl, $001d
	add hl, bc
	ld a, [hl]
	ld hl, $0008
	add hl, bc
	ld [hl], a
	ld hl, $000a
	add hl, bc
	ld [hl], $02
	call IncrementObjectStructField28

Function4e9f:
	ld hl, $000a
	add hl, bc
	dec [hl]
	ret nz

	ld hl, $0009
	add hl, bc
	ld [hl], $01
	ret

Function4eac:
	call AddStepVector
	ld hl, $000a
	add hl, bc
	dec [hl]
	ret nz

	push bc
	ld hl, $0010
	add hl, bc
	ld d, [hl]
	ld hl, $0011
	add hl, bc
	ld e, [hl]
	ld hl, $0001
	add hl, bc
	ld a, [hl]
	ld b, a
	ld a, $02
	ld hl, $4981
	rst $08
	pop bc
	ld hl, $0005
	add hl, bc
	res 2, [hl]
	call CopyNextCoordsTileToStandingCoordsTile
	ld hl, $0007
	add hl, bc
	ld [hl], $ff
	ld hl, $0009
	add hl, bc
	ld [hl], $01
	ret

Function4ee3:
	ld hl, $001d
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, $0000
	add hl, de
	ld a, [hl]
	and a
	jr z, .asm_4f0f

	ld hl, $0017
	add hl, de
	ld a, [hl]
	ld hl, $0017
	add hl, bc
	ld [hl], a
	ld hl, $0018
	add hl, de
	ld a, [hl]
	ld hl, $0018
	add hl, bc
	ld [hl], a
	ld hl, $000a
	add hl, bc
	ld a, [hl]
	and a
	ret z
	dec [hl]
	ret nz
.asm_4f0f
	jp DeleteMapObject

Function4f12:
	call Object28AnonymousJumptable

	add hl, de
	ld c, a
	ld [hl+], a
	ld c, a

Function4f19:
	xor a
	ld hl, $001d
	add hl, bc
	ld [hl], a
	call IncrementObjectStructField28

Function4f22:
	ld hl, $001d
	add hl, bc
	ld d, [hl]
	ld a, [$ce78]
	sub d
	ld [$ce78], a
	ld hl, $000a
	add hl, bc
	dec [hl]
	jr z, .asm_4f47

	ld a, [hl]
	call Function4f4b
	ld hl, $001d
	add hl, bc
	ld [hl], a
	ld d, a
	ld a, [$ce78]
	add d
	ld [$ce78], a
	ret

.asm_4f47
	call DeleteMapObject
	ret

Function4f4b:
	ld hl, $001e
	add hl, bc
	and $01
	ld a, [hl]
	ret z
	cpl
	inc a
	ret


Function4f56:
	call Object28AnonymousJumptable
Function4f59:
	call Object28AnonymousJumptable

	ld h, d
	ld c, a
	ld h, d
	ld c, a
	ld h, d
	ld c, a

Function4f62:
	ret

Function4f63:
	ld hl, $001d
	add hl, bc
	inc [hl]
	ld a, [hl]
	srl a
	srl a
	and $07
	ld l, a
	ld h, $00
	ld de, .data
	add hl, de
	ld a, [hl]
	ld hl, $001a
	add hl, bc
	ld [hl], a
	ret

.data
	db 0, -1, -2, -3, -4, -3, -2, -1

Function4f85:
	call GetStepVector
	ld a, h
	ld hl, $001f
	add hl, bc
	ld e, [hl]
	add e
	ld [hl], a
	nop
	srl e
	ld d, $00
	ld hl, .data
	add hl, de
	ld a, [hl]
	ld hl, $001a
	add hl, bc
	ld [hl], a
	ret

.data
	db  -4,  -6,  -8, -10, -11, -12, -12, -12
	db -11, -10,  -9,  -8,  -6,  -4,   0,   0

Function4fb0:
	ld a, [$ce7b]
	ld hl, wce7c
	ld [hl], a
	ld a, $3e
	ld [$ce7b], a
	ld a, [hl]
	ret

GetMovementByte:
	ld hl, wMovementDataBank
	call $1918
	ret

Function4fc5:
	ld hl, $001b
	add hl, bc
	ld e, [hl]
	inc [hl]
	ld d, $00
	ld hl, wMovementObject
	ld a, [hl+]
	ld h, [hl]
	ld l, a
	add hl, de
	ld a, [hl]
	ret

Function4fd6:
	ld hl, $001b
	add hl, bc
	ld e, [hl]
	inc [hl]
	ld d, $00
	ld hl, wce83
	ld a, [hl+]
	ld h, [hl]
	ld l, a
	add hl, de
	ld a, [hl]
	ret

Function4fe7:
	ld hl, GetMovementPerson
	jp $4ff1

GetMovementPerson:
	ld a, [$ce7f]
	ret

Jump_001_4ff1:
	dr $4ff1,$5005

Call_001_5005:
	dr $5005,$500e

Call_001_500e:
	dr $500e,$501b

Call_001_501b:
	dr $501b,$50de

Call_001_50de:
	dr $50de,$50ec

unk_001_50ec:
	dr $50ec,$545f

Call_001_545f:
	dr $545f,$570c

Call_001_570c:
	dr $570c,$571c

Call_001_571c:
	dr $571c,$58cd

ApplyBGMapAnchorToObjects:
	dr $58cd,$5a55
