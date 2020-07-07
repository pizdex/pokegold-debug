Call_001_6493:
	call ClearBGPalettes
	xor a
	ld [wd55b], a
	ld de, $0000
	call PlayMusic
	call ClearTilemap
	call DisableLCD
	call ClearSprites
	xor a
	ldh [hBGMapMode], a
	ldh [hMapAnims], a
	ldh [hSCY], a
	ldh [hSCX], a
	ld hl, vTiles3
	ld bc, $2000
	xor a
	call ByteFill
	ld a, $23
	ld hl, $51d7
	rst FarCall
	ld hl, $45c8
	ld de, vTiles5
	ld a, $39
	call FarDecompress
	ld hl, $4220
	ld de, vTiles3
	ld a, $39
	call FarDecompress
	ld hl, $41a0
	ld de, $8f80
	ld bc, $0080
	ld a, $39
	call FarCopyBytes
	call Call_001_6565
	call Call_001_65b8
	ld hl, wMisc
	xor a
	ld [hli], a
	ld [hl], a
	ld hl, $ff40
	set 2, [hl]
	call EnableLCD
	xor a
	ld hl, wJumptableIndex
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld de, $6058
	ld a, $2c
	call InitSpriteAnimStruct
	ld hl, wc51c
	ld de, wc5ac
	ld bc, $000a
	call CopyBytes
	ld hl, wc51c
	ld [hl], $00
	ld hl, wMysteryGiftStaging
	ld bc, $0090
	xor a
	call ByteFill
	ld a, $43
	ldh [hLCDCPointer], a
	ld b, $0c
	call GetSGBLayout
	call Call_001_6538
	ld de, $0001
	call PlayMusic
	ret

Call_001_6538:
	ldh a, [hCGB]
	and a
	jr nz, jr_001_655c
	ldh a, [hSGB]
	and a
	jr nz, jr_001_654f
	ld a, $d8
	ldh [rBGP], a
	ld a, $ff
	ldh [rOBP0], a
	ld a, $f8
	ldh [rOBP1], a
	ret

jr_001_654f:
	ld a, $e4
	ldh [rBGP], a
	ld a, $ff
	ldh [rOBP0], a
	ld a, $e4
	ldh [rOBP1], a
	ret

jr_001_655c:
	ld a, $e4
	call DmgToCgbBGPals
	call DmgToCgbObjPal0
	ret

Call_001_6565:
	ldh a, [hCGB]
	and a
	ret z
	ld a, $01
	ldh [rVBK], a
	ld hl, vBGMap2
	ld bc, $0240
	xor a
	call ByteFill
	ld hl, $9821
	ld bc, $040e
	ld a, $01
	call Call_001_65a8
	ld hl, $982f
	ld bc, $0404
	ld a, $03
	call Call_001_65a8
	ld hl, $98a2
	ld bc, $000f
	ld a, $02
	call ByteFill
	ld hl, $9980
	ld bc, $00a0
	ld a, $04
	call ByteFill
	ld a, $00
	ldh [rVBK], a
	ret

Call_001_65a8:
jr_001_65a8:
	push bc
	push hl

jr_001_65aa:
	ld [hli], a
	dec c
	jr nz, jr_001_65aa
	pop hl
	ld bc, $0020
	add hl, bc
	pop bc
	dec b
	jr nz, jr_001_65a8
	ret

Call_001_65b8:
	ld hl, $4afc
	ld de, vBGMap2

jr_001_65be:
	ld a, $39
	call GetFarByte
	cp $ff
	jr z, jr_001_65eb
	inc hl
	bit 7, a
	jr nz, jr_001_65da
	ld c, a
	ld a, $39
	call GetFarByte
	inc hl

jr_001_65d3:
	ld [de], a
	inc de
	dec c
	jr nz, jr_001_65d3
	jr jr_001_65be

jr_001_65da:
	and $7f
	ld c, a
	ld a, $39
	call GetFarByte
	inc hl

jr_001_65e3:
	ld [de], a
	inc de
	inc a
	dec c
	jr nz, jr_001_65e3
	jr jr_001_65be

jr_001_65eb:
	ldh a, [hCGB]
	and a
	ret nz
	ld hl, $9960
	ld bc, $0020
	ld a, $0e
	call ByteFill
	ret
