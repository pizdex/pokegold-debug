PrintLetterDelay::
; Wait before printing the next letter.

; The text speed setting in wOptions is actually a frame count:
; 	fast: 1 frame
; 	mid:  3 frames
; 	slow: 5 frames

; wTextboxFlags[!0] and A or B override text speed with a one-frame delay.
; wOptions[4] and wTextboxFlags[!1] disable the delay.

	ld a, [wOptions]
	bit NO_TEXT_SCROLL, a
	ret nz

; non-scrolling text?
	ld a, [wTextboxFlags]
	bit NO_TEXT_DELAY_F, a
	ret z

	push hl
	push de
	push bc

	ld hl, hOAMUpdate
	ld a, [hl]
	push af

; orginally turned oam update off...
;	ld a, 1
	ld [hl], a

; force fast scroll?
	ld a, [wTextboxFlags]
	bit FAST_TEXT_DELAY_F, a
	jr z, .fast

; text speed
	ld a, [wOptions]
	and %111
	jr .updatedelay

.fast
	ld a, TEXT_DELAY_FAST

.updatedelay
	ld [wTextDelayFrames], a

.checkjoypad
	call GetJoypad

; input override
	ld a, [wDisableTextAcceleration]
	and a
	jr nz, .wait

; Wait one frame if holding A or B.
	ldh a, [hJoyDown]
	bit A_BUTTON_F, a
	jr z, .checkb
	jr .delay
.checkb
	bit B_BUTTON_F, a
	jr z, .wait

.delay
	call DelayFrame
	jr .end

.wait
	ld a, [wTextDelayFrames]
	and a
	jr nz, .checkjoypad

.end
	pop af
	ldh [hOAMUpdate], a
	pop bc
	pop de
	pop hl
	ret

CopyDataUntil::
; Copy [hl .. bc) to de.

; In other words, the source data is
; from hl up to but not including bc,
; and the destination is de.

	ld a, [hli]
	ld [de], a
	inc de
	ld a, h
	cp b
	jr nz, CopyDataUntil
	ld a, l
	cp c
	jr nz, CopyDataUntil
	ret

PrintNum::
; Print c digits of the b-byte value from de to hl.
; Allows 2 to 7 digits. For 1-digit numbers, add
; the value to char "0" instead of calling PrintNum.
; The high nybble of the c register specifies how many of the total amount of
; digits will be in front of the decimal point.
; Some extra flags can be given in bits 5-7 of b.
; Bit 5: money if set (unless left-aligned without leading zeros)
; Bit 6: left-aligned if set
; Bit 7: print leading zeros if set

	push bc

.main
	xor a
	ldh [hPrintNumBuffer + 0], a
	ldh [hPrintNumBuffer + 1], a
	ldh [hPrintNumBuffer + 2], a
	ld a, b
	and $f
	cp 1
	jr z, .byte
	cp 2
	jr z, .word
; maximum 3 bytes
.long
	ld a, [de]
	ldh [hPrintNumBuffer + 1], a
	inc de
	ld a, [de]
	ldh [hPrintNumBuffer + 2], a
	inc de
	ld a, [de]
	ldh [hPrintNumBuffer + 3], a
	jr .start

.word
	ld a, [de]
	ldh [hPrintNumBuffer + 2], a
	inc de
	ld a, [de]
	ldh [hPrintNumBuffer + 3], a
	jr .start

.byte
	ld a, [de]
	ldh [hPrintNumBuffer + 3], a

.start
	push de

	ld d, b
	ld a, c
    ld b, a
    xor a
    ld c, a
    ld a, b
	cp 2
	jr z, .two
	cp 3
	jr z, .three
	cp 4
	jr z, .four
	cp 5
	jr z, .five
	cp 6
	jr z, .six

.seven
	ld a, HIGH(1000000 >> 8)
	ldh [hPrintNumBuffer + 4], a
	ld a, HIGH(1000000) ; mid
	ldh [hPrintNumBuffer + 5], a
	ld a, LOW(1000000)
	ldh [hPrintNumBuffer + 6], a
	call .PrintDigit
	call .AdvancePointer

.six
	ld a, HIGH(100000 >> 8)
	ldh [hPrintNumBuffer + 4], a
	ld a, HIGH(100000) ; mid
	ldh [hPrintNumBuffer + 5], a
	ld a, LOW(100000)
	ldh [hPrintNumBuffer + 6], a
	call .PrintDigit
	call .AdvancePointer

.five
	xor a ; HIGH(10000 >> 8)
	ldh [hPrintNumBuffer + 4], a
	ld a, HIGH(10000) ; mid
	ldh [hPrintNumBuffer + 5], a
	ld a, LOW(10000)
	ldh [hPrintNumBuffer + 6], a
	call .PrintDigit
	call .AdvancePointer

.four
	xor a ; HIGH(1000 >> 8)
	ldh [hPrintNumBuffer + 4], a
	ld a, HIGH(1000) ; mid
	ldh [hPrintNumBuffer + 5], a
	ld a, LOW(1000)
	ldh [hPrintNumBuffer + 6], a
	call .PrintDigit
	call .AdvancePointer

.three
	xor a ; HIGH(100 >> 8)
	ldh [hPrintNumBuffer + 4], a
	xor a ; HIGH(100) ; mid
	ldh [hPrintNumBuffer + 5], a
	ld a, LOW(100)
	ldh [hPrintNumBuffer + 6], a
	call .PrintDigit
	call .AdvancePointer

.two
    ld c, $00
    ldh a, [hPrintNumBuffer + 3]

.mod_10
	cp 10
	jr c, .modded_10
	sub 10
	inc c
	jr .mod_10
.modded_10

	ld b, a
	ldh a, [hPrintNumBuffer + 0]
    or c
    ldh [hPrintNumBuffer + 0], a
    jr nz, .money
    call .PrintLeadingZero
    jr .money_leading_zero

.money
	ld a, "0"
	add c
	ld [hl], a

.money_leading_zero
    call .AdvancePointer
	ld a, "0"
	add b
	ld [hli], a

	pop de
	pop bc
	ret


.PrintDigit:
    ld c, 0
.loop
	ldh a, [hPrintNumBuffer + 4]
	ld b, a
	ldh a, [hPrintNumBuffer + 1]
	ldh [hPrintNumBuffer + 7], a
	cp b
	jr c, .skip1
	sub b
	ldh [hPrintNumBuffer + 1], a
	ldh a, [hPrintNumBuffer + 5]
	ld b, a
	ldh a, [hPrintNumBuffer + 2]
	ldh [hPrintNumBuffer + 8], a
	cp b
	jr nc, .skip2
	ldh a, [hPrintNumBuffer + 1]
	or 0
	jr z, .skip3
	dec a
	ldh [hPrintNumBuffer + 1], a
	ldh a, [hPrintNumBuffer + 2]
.skip2
	sub b
	ldh [hPrintNumBuffer + 2], a
	ldh a, [hPrintNumBuffer + 6]
	ld b, a
	ldh a, [hPrintNumBuffer + 3]
	ldh [hPrintNumBuffer + 9], a
	cp b
	jr nc, .skip4
	ldh a, [hPrintNumBuffer + 2]
	and a
	jr nz, .skip5
	ldh a, [hPrintNumBuffer + 1]
	and a
	jr z, .skip6
	dec a
	ldh [hPrintNumBuffer + 1], a
	xor a
.skip5
	dec a
	ldh [hPrintNumBuffer + 2], a
	ldh a, [hPrintNumBuffer + 3]
.skip4
	sub b
	ldh [hPrintNumBuffer + 3], a
	inc c
	jr .loop
.skip6
	ldh a, [hPrintNumBuffer + 8]
	ldh [hPrintNumBuffer + 2], a
.skip3
	ldh a, [hPrintNumBuffer + 7]
	ldh [hPrintNumBuffer + 1], a
.skip1
	ldh a, [hPrintNumBuffer + 0]
	or c
	jr z, .PrintLeadingZero
.done
	ld a, "0"
	add c
	ld [hl], a
	ldh [hPrintNumBuffer + 0], a
    ret

.PrintLeadingZero:
; prints a leading zero unless they are turned off in the flags
	bit 7, d ; print leading zeroes?
	ret z
	ld [hl], "0"
	ret

.AdvancePointer:
; increments the pointer unless leading zeroes are not being printed,
; the number is left-aligned, and no nonzero digits have been printed yet
	bit 7, d ; print leading zeroes?
	jr nz, .inc
	bit 6, d ; left alignment or right alignment?
	jr z, .inc
	ldh a, [hPrintNumBuffer + 0]
	and a
	ret z
.inc
	inc hl
	ret

Function33e1::
; Print c-digit hex number from de to hl
.asm_33e1
    push bc
    call Function33ea
    pop bc
    dec c
    jr nz, .asm_33e1
    ret

Function33ea::
    ld a, [de]
    swap a
    and $f
    call Function33fc
    ld [hli], a
    ld a, [de]
    and $f
    call Function33fc
    ld [hl+], a
    inc de
    ret

Function33fc:
	ld bc, .digits
	add c
	ld c, a
	ld a, $0
	adc b
	ld b, a
	ld a, [bc]
	ret

.digits db "0123456789<BOLD_A><BOLD_B><BOLD_C><BOLD_D><BOLD_E><BOLD_F>"

FarPrintText::
	ld [wBuffer], a
	ldh a, [hROMBank]
	push af
	ld a, [wBuffer]
	rst Bankswitch
	
	call PrintText
	
	pop af
	rst Bankswitch
	ret

CallPointerAt::
	ldh a, [hROMBank]
	push af
	ld a, [hli]
	rst Bankswitch

	ld a, [hli]
	ld h, [hl]
	ld l, a

	call _hl_

	pop hl
	ld a, h
	rst Bankswitch
	ret
