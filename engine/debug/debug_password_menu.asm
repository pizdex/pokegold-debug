DebugPasswordMenu:
	ld b, 1
	ld de, wMovementBufferCount
	ld a, 4
	ld hl, $5a7e
	rst FarCall
	call DebugPasswordMenu_EnterTID
	call Call_002_47ea

	call Call_002_4677

	ld hl, DebugPasswordMenu_OKText
	call PrintText

	call YesNoBox
	jr c, DebugPasswordMenu

	call DebugPasswordMenu_CalculatePassword
	ld a, d
	ld [wcf3f], a
	ld a, e
	ld [wcf3f + 1], a
	ld hl, DebugPasswordMenu_PasswordText
	call PrintText

	hlcoord 1, 16
	ld de, wcf3f
	lb bc, PRINTNUM_LEADINGZEROS | 2, 5
	call PrintNum

	call WaitPressAorB_BlinkCursor
	ret

DebugPasswordMenu_PasswordText:
	text "パスワードは" ; The password is
	line "      です"
	done

DebugPasswordMenu_OKText:
	text "これで いいですか？" ; Is this OK?
	done

Call_002_4677:
	call ClearTilemap
	xor a
	ldh [hBGMapMode], a

	hlcoord 3, 2
	ld de, unkData_002_46ab
	call PlaceString

	hlcoord 12, 2
	ld de, wcf21 ; Player's name
	call PlaceString

	hlcoord 12, 4
	ld de, wcf2b
	lb bc, PRINTNUM_LEADINGZEROS | 2, 5
	call PrintNum

	hlcoord 11, 6
	ld de, wcf35
	lb bc, PRINTNUM_LEADINGZEROS | 3, 6
	call PrintNum

	call WaitBGMap
	ret

unkData_002_46ab:
	db "なまえ"		; Name
	next "アイディー"	; Trainer ID
	next "おかね@"	; Money

unk_002_46b9:
.loop
	ld a, [de]
	add "0"
	ld [hl+], a
	inc de
	dec c
	jr nz, .loop
	ret

DebugPasswordMenu_CalculatePassword:
	ld de, 0

	ld hl, wcf2b ; id
	ld c, 2
	call .ComponentFromNumber

	ld hl, wcf21 ; name
	ld c, NAME_LENGTH - 1
	call .ComponentFromString

	ld hl, wcf35 ; money
	ld c, 3
	call .ComponentFromNumber
	ret

.ComponentFromNumber:
	ld a, [hli]
	add e
	ld e, a
	ld a, 0
	adc d
	ld d, a

	dec c
	jr nz, .ComponentFromNumber
	ret

.ComponentFromString:
	ld a, [hli]
	cp "@"
	ret z
	add e
	ld e, a
	ld a, 0
	adc d
	ld d, a

	dec c
	jr nz, .ComponentFromString
	ret

DebugPasswordMenu_EnterTID:
	ld hl, wStringBuffer2
	ld bc, 5
	xor a
	call ByteFill

	ld a, 4
	ld [$cf97], a

	ld hl, unkData_002_4734
	call PrintText

.asm_470c:
	call Call_002_4743

.asm_470f:
	call JoyTextDelay
	ldh a, [hJoyLast]
	ld b, a
	and A_BUTTON
	jr nz, .asm_4728
	ld a, b
	and D_PAD
	jr z, .asm_470f

	call Call_002_476b
	ld c, 3
	call DelayFrames
	jr .asm_470c

.asm_4728:
	call Call_002_47bb
	ld a, h
	ld [wcf2b], a
	ld a, l
	ld [wcf2c], a
	ret

unkData_002_4734:
	text "アイディーを" ; Trainer ID
	line "にゅうりょく" ; Input
	done

Call_002_4743:
	hlcoord 14, 15
	ld de, wStringBuffer2
	ld c, 5
.asm_474b:
	ld a, [de]
	add "0"
	ld [hl+], a
	inc de
	dec c
	jr nz, .asm_474b

.asm_4753:
	hlcoord 14, 16
	ld bc, 5
	ld a, " "
	call ByteFill

	hlcoord 14, 16
	ld a, [$cf97]
	ld e, a
	ld d, 0
	add hl, de
	ld [hl], $61
	ret

Call_002_476b:
	ld a, b
	and D_LEFT
	jr nz, .left
	ld a, b
	and D_RIGHT
	jr nz, .right
	ld a, b
	and D_UP
	jr nz, .up
	ld a, b
	and D_DOWN
	jr nz, .down
	ret

.left
	ld a, [$cf97]
	and a
	ret z
	dec a
	ld [$cf97], a
	ret

.right
	ld a, [$cf97]
	cp 4
	ret z
	inc a
	ld [$cf97], a
	ret

.up
	call Call_002_47b0
	ld a, [hl]
	cp 9
	jr z, .asm_47a0
	inc a
	ld [hl], a
	ret
.asm_47a0
	ld [hl], 0
	ret

.down:
	call Call_002_47b0
	ld a, [hl]
	and a
	jr z, .asm_47ad
	dec a
	ld [hl], a
	ret
.asm_47ad
	ld [hl], 9
	ret

Call_002_47b0:
	ld a, [$cf97]
	ld e, a
	ld d, 0
	ld hl, wStringBuffer2
	add hl, de
	ret

Call_002_47bb:
	ld hl, 0
	ld de, wStringBuffer2 + 4

	ld bc, 1
	call Call_002_47dc
	ld bc, 10
	call Call_002_47dc
	ld bc, 100
	call Call_002_47dc
	ld bc, 1000
	call Call_002_47dc

	ld bc, 10000
Call_002_47dc:
	ld a, [de]
	dec de
	push hl
	ld hl, 0
	call AddNTimes
	ld c, l
	ld b, h
	pop hl
	add hl, bc
	ret

Call_002_47ea:
	ld hl, wStringBuffer2
	ld bc, 6
	xor a
	call ByteFill
	ld a, 5
	ld [$cf98], a
	ld hl, unkData_002_482b
	call PrintText

jr_002_47ff:
	call Call_002_4838

jr_002_4802:
	call JoyTextDelay
	ldh a, [hJoyLast]
	ld b, a
	and 1
	jr nz, jr_002_481b

	ld a, b
	and $f0
	jr z, jr_002_4802

	call Call_002_4860
	ld c, 3
	call DelayFrames
	jr jr_002_47ff

jr_002_481b:
	call Call_002_48b0
	ld a, b
	ld [wcf35], a
	ld a, d
	ld [wcf36], a
	ld a, e
	ld [wcf37], a
	ret

unkData_002_482b:
	text "おかねを" ; Money
	line "にゅうりょく" ; Input
	done

Call_002_4838:
	hlcoord 13, 15
	ld de, wStringBuffer2
	ld c, 6

.asm_4840:
	ld a, [de]
	add "0"
	ld [hli], a
	inc de
	dec c
	jr nz, .asm_4840

	hlcoord 13, 16
	ld bc, 6
	ld a, " "
	call ByteFill

	hlcoord 13, 16
	ld a, [$cf98]
	ld e, a
	ld d, 0
	add hl, de
	ld [hl], $61
	ret

Call_002_4860:
	ld a, b
	and D_LEFT
	jr nz, .left
	ld a, b
	and D_RIGHT
	jr nz, .right
	ld a, b
	and D_UP
	jr nz, .up
	ld a, b
	and D_DOWN
	jr nz, .down
	ret

.left
	ld a, [$cf98]
	and a
	ret z
	dec a
	ld [$cf98], a
	ret

.right
	ld a, [$cf98]
	cp 5
	ret z
	inc a
	ld [$cf98], a
	ret

.up
	call Call_002_48a5
	ld a, [hl]
	cp 9
	jr z, .asm_4895
	inc a
	ld [hl], a
	ret
.asm_4895
	ld [hl], 0
	ret

.down
	call Call_002_48a5
	ld a, [hl]
	and a
	jr z, .asm_48a2
	dec a
	ld [hl], a
	ret
.asm_48a2
	ld [hl], 9
	ret

Call_002_48a5:
	ld a, [$cf98]
	ld e, a
	ld d, 0
	ld hl, wStringBuffer2
	add hl, de
	ret

Call_002_48b0:
	call Call_002_48da
	ld e, l
	ld d, h
	ld b, 0

	ld a, [$cf93]
	ld hl, unkData_002_492a + 2
	call Call_002_4903
	call Call_002_48d0

	ld a, [wStringBuffer2]
	ld hl, unkData_002_490c + 2
	call Call_002_4903
	call Call_002_48d0
	ret

Call_002_48d0:
	ld a, [hld]
	add e
	ld e, a
	ld a, [hld]
	adc d
	ld d, a
	ld a, [hl]
	adc b
	ld b, a
	ret

Call_002_48da:
	ld hl, 0
	ld de, wStringBuffer2 + 5

	ld bc, 1
	call Call_002_48f5
	ld bc, 10
	call Call_002_48f5
	ld bc, 100
	call Call_002_48f5

	ld bc, 1000
Call_002_48f5:
	ld a, [de]
	dec de
	push hl
	ld hl, 0
	call AddNTimes
	ld c, l
	ld b, h
	pop hl
	add hl, bc
	ret

Call_002_4903:
	push de
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	add hl, de
	pop de
	ret

unkData_002_490c:
	db $00, $00, $00
	db $01, $86, $a0
	db $03, $0d, $40
	db $04, $93, $e0
	db $06, $1a, $80
	db $07, $a1, $20
	db $09, $27, $c0
	db $0a, $ae, $60
	db $0c, $35, $00
	db $0d, $bb, $a0

unkData_002_492a:
	db $00, $00, $00
	db $00, $27, $10
	db $00, $4e, $20
	db $00, $75, $30
	db $00, $9c, $40
	db $00, $c3, $50
	db $00, $ea, $60
	db $01, $11, $70
	db $01, $38, $80
	db $01, $5f, $90
