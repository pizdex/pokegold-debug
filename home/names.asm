NamesPointers::
; entries correspond to GetName constants (see constants/text_constants.asm)
	dbw $14, $7a0c
	dbw $10, $563e
	dba NULL                ; DUMMY_NAME
	dba ItemNames           ; ITEM_NAME
	dbw $00, $db10
	dbw $00, $ddee
	dbw $0b, $52d6
	dbw $04, $5cf7

GetName::
; Return name wCurSpecies from name list wNamedObjectTypeBuffer in wStringBuffer1.

	ldh a, [hROMBank]
	push af
	push hl
	push bc
	push de

	ld a, [wNamedObjectTypeBuffer]
	cp MON_NAME
	jr nz, .NotPokeName

	ld a, [wCurSpecies]
	ld [wNamedObjectIndex], a
	call GetPokemonName
	ld hl, MON_NAME_LENGTH
	add hl, de
	ld e, l
	ld d, h
	jr .done

.NotPokeName:
	ld a, [wNamedObjectTypeBuffer]
	dec a
	ld e, a
	ld d, 0
	ld hl, NamesPointers
	add hl, de
	add hl, de
	add hl, de
	ld a, [hli]
	rst Bankswitch
	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld a, [wCurSpecies]
	dec a
	call GetNthString

	ld de, wStringBuffer1
	ld bc, ITEM_NAME_LENGTH
	call CopyBytes

.done
	ld a, e
	ld [wUnusedNamesPointer], a
	ld a, d
	ld [wUnusedNamesPointer + 1], a

	pop de
	pop bc
	pop hl
	pop af
	rst Bankswitch
	ret

GetNthString::
; Return the address of the
; ath string starting from hl.

	and a
	ret z

	push bc
	ld b, a
	ld c, "@"
.readChar
	ld a, [hli]
	cp c
	jr nz, .readChar
	dec b
	jr nz, .readChar
	pop bc
	ret

GetBasePokemonName::
; Discards gender (Nidoran).

	push hl
	call GetPokemonName

	ld hl, wStringBuffer1
.loop
	ld a, [hl]
	cp "@"
	jr z, .quit
	cp "♂"
	jr z, .end
	cp "♀"
	jr z, .end
	inc hl
	jr .loop
.end
	ld [hl], "@"
.quit
	pop hl
	ret

GetPokemonName::
; Get Pokemon name for wNamedObjectIndex.

	ldh a, [hROMBank]
	push af
	push hl
	ld a, $14
	rst Bankswitch

; Each name is six characters
	ld a, [wNamedObjectIndex]
	dec a
	ld hl, $7a0c
	ld e, a
	ld d, 0

rept MON_NAME_LENGTH - 1
	add hl, de
endr

; Terminator
	ld de, wStringBuffer1
	push de
	ld bc, MON_NAME_LENGTH - 1
	call CopyBytes
	ld hl, wStringBuffer1 + MON_NAME_LENGTH - 1
	ld [hl], "@"
	pop de

	pop hl
	pop af
	rst Bankswitch
	ret

GetItemName::
; Get item name for wNamedObjectIndex.

	push hl
	push bc
	ld a, [wNamedObjectIndex]

	cp TM01
	jr nc, .TM

	ld [wCurSpecies], a
	ld a, ITEM_NAME
	ld [wNamedObjectTypeBuffer], a
	call GetName
	jr .Copied
.TM:
	call GetTMHMName
.Copied:
	ld de, wStringBuffer1
	pop bc
	pop hl
	ret

GetTMHMName::
; Get TM/HM name for item wNamedObjectIndex.

	push hl
	push de
	push bc
	ld a, [wNamedObjectIndex]
	push af

; TM/HM prefix
	cp HM01
	push af
	jr c, .TM

	ld hl, .HMText
	ld bc, .HMTextEnd - .HMText
	jr .copy

.TM:
	ld hl, .TMText
	ld bc, .TMTextEnd - .TMText

.copy
	ld de, wStringBuffer1
	call CopyBytes

; TM/HM number
	push de
	ld a, [wNamedObjectIndex]
	ld c, a
	ld hl, $56e3
	ld a, $03
	rst FarCall
	pop de

; HM numbers start from 51, not 1
	pop af
	ld a, c
	jr c, .not_hm
	sub NUM_TMS
.not_hm

; Divide and mod by 10 to get the top and bottom digits respectively
	ld b, "0"
.mod10
	sub 10
	jr c, .done_mod
	inc b
	jr .mod10

.done_mod
	add 10
	push af
	ld a, b
	ld [de], a
	inc de
	pop af

	ld b, "0"
	add b
	ld [de], a

; End the string
	inc de
	ld a, "@"
	ld [de], a

	pop af
	ld [wNamedObjectIndex], a
	pop bc
	pop de
	pop hl
	ret

.TMText:
	db "わざマシン"
.TMTextEnd:
	db "@"

.HMText:
	db "ひでんマシン"
.HMTextEnd:
	db "@"

INCLUDE "home/hm_moves.asm"

GetMoveName::
	push hl

	ld a, MOVE_NAME
	ld [wNamedObjectTypeBuffer], a

	ld a, [wNamedObjectIndex] ; move id
	ld [wCurSpecies], a

	call GetName
	ld de, wStringBuffer1

	pop hl
	ret
