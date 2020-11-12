QuickDebug_OTIDOption:
	call LoadStandardMenuHeader
	call OTID_Init
	call CloseWindow
	ld a, QUICKMENU_UPDATE
	ret

QuickDebug_TestPackAndPokegear: ; unreferenced
; Dummied out code
; Presumbly used to test the Pack and Pokegear before the start menu was implemented
	ld a, QUICKMENU_UPDATE
	ret

OTID_Init:
; Clear OT ID input buffer
	ld hl, wStringBuffer2
	ld bc, 5
	xor a
	call ByteFill
; Set default cursor position to last digit
	ld a, 4
	ld [wStringBuffer2 + 5], a
; Print message
	ld hl, NumberToChangeText
	call PrintText

.InitInputArea:
	call OTID_UpdateInputArea

.ReadJoypad:
	call JoyTextDelay
	ldh a, [hJoyLast]
	ld b, a
	and A_BUTTON
	jr nz, .exit
	ld a, b
	and D_PAD
	jr z, .ReadJoypad
	call OTID_InterpretJoypad

	ld c, 3
	call DelayFrames
	jr .InitInputArea

.exit
	call OTID_ConvertToHex
	ld a, h
	ld [wPartyMon1ID], a
	ld a, l
	ld [wPartyMon1ID + 1], a
	ret

NumberToChangeText:
; “Which number should be changed?”
	text "へんこうするナンバーを"
	line "してい してください"
	done

OTID_UpdateInputArea:
; Convert digit to character
	hlcoord 14, 15
	ld de, wStringBuffer2
	ld c, 5
.outputDigit
	ld a, [de]
	add "0"
	ld [hli], a
	inc de
	dec c
	jr nz, .outputDigit

; Clear the cursor area
	hlcoord 14, 16
	ld bc, 5
	ld a, " "
	call ByteFill
; Display cursor
	hlcoord 14, 16
	ld a, [wStringBuffer2 + 5]
	ld e, a
	ld d, 0
	add hl, de
	ld [hl], "▲"
	ret

OTID_InterpretJoypad:
	ld a, b
	and D_LEFT
	jr nz, .pressed_left
	ld a, b
	and D_RIGHT
	jr nz, .pressed_right
	ld a, b
	and D_UP
	jr nz, .increment_digit
	ld a, b
	and D_DOWN
	jr nz, .decrement_digit
	ret

.pressed_left
	ld a, [wStringBuffer2 + 5]
	; Are we on the left-most digit?
	and a
	ret z
	; Nope, let's move left.
	dec a
	ld [wStringBuffer2 + 5], a
	ret

.pressed_right
	ld a, [wStringBuffer2 + 5]
	cp 4
	ret z
	inc a
	ld [wStringBuffer2 + 5], a
	ret

.increment_digit
	call OTID_GetDigitLocation
	ld a, [hl]
	cp 9
	jr z, .max
	inc a
	ld [hl], a
	ret

.max
	ld [hl], 0
	ret

.decrement_digit
	call OTID_GetDigitLocation
	ld a, [hl]
	and a
	jr z, .min
	dec a
	ld [hl], a
	ret

.min
	ld [hl], 9
	ret

OTID_GetDigitLocation:
	ld a, [wStringBuffer2 + 5]
	ld e, a
	ld d, 0
	ld hl, wStringBuffer2
	add hl, de
	ret

OTID_ConvertToHex:
	ld hl, 0
	ld de, wStringBuffer2 + 4
	ld bc, 1
	call .convertDigit
	ld bc, 10
	call .convertDigit
	ld bc, 100
	call .convertDigit
	ld bc, 1000
	call .convertDigit
	ld bc, 10000
; fallthrough

.convertDigit:
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
