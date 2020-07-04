; Updates the values for the toolgear to display at the bottom of the screen

UpdateDebugToolgear::
	ld a, [wEnteredMapFromContinue]
	bit 0, a
	ret z

; Clear the toolbar buffer
	ld hl, wToolgearBuffer
	ld bc, SCREEN_WIDTH
	ld a, " "
	call ByteFill

; Bit 0 set = Coordinates
; Bit 0 reset = Date and Time
	ld hl, wd55c
	bit 0, [hl]
	jr z, .UpdateDateAndTime

; Update the Coordinates
	ld hl, wXCoord
	ld de, wToolgearBuffer + 4
	ld c, 1
	call ConvertByteToCoordTiles
	ld hl, wYCoord
	ld de, wToolgearBuffer + 8
	ld c, 1
	call ConvertByteToCoordTiles
	ret

.UpdateDateAndTime
	ld hl, wCurDay
	ld de, wToolgearBuffer
	call ConvertByteToDecimalTiles

	ld a, $70 ; ":"
	ld [wToolgearBuffer + 4], a

	ld hl, hHours
	ld de, wToolgearBuffer + 5
	call ConvertByteToDecimalTiles

	ld a, $70
	ld [wToolgearBuffer + 7], a

	ld hl, hMinutes
	ld de, wToolgearBuffer + 8
	call ConvertByteToDecimalTiles

	ld hl, hSeconds
	ld de, wToolgearBuffer + 11
	call ConvertByteToDecimalTiles

	call GetWeekday
	add $71
	ld [wToolgearBuffer + 14], a

	ld a, $78
	ld [wToolgearBuffer + 16], a
	inc a
	ld [wToolgearBuffer + 17], a

	ldh a, [hSeconds]
	and $01
	ret z

	ret

ConvertByteToCoordTiles:
; hl = source coord byte
; de = dest coord tiles
; c = Number of bytes to convert
.loop
	ld a, [hli]
	ld b, a
	swap a
	call ConvertCoordToTile
	ld a, b
	call ConvertCoordToTile
	dec c
	jr nz, .loop
	ret

ConvertByteToDecimalTiles:
	ld a, [hli]
	ld b, 0
.increment_tens
	inc b
	sub 10
	jr nc, .increment_tens
	dec b
	add 10
	push af
	ld a, b
	call ConvertCoordToTile
	pop af
	call ConvertCoordToTile
	ret

ConvertCoordToTile:
; Calculate one digit at a time
	and %00001111
	add $66 ; "0"
	ld [de], a
	inc de
	ret
