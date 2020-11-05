DoMysteryGift::
	call ClearTilemap
	call ClearSprites
	call WaitBGMap
	farcall InitMysteryGiftLayout
	ld hl, $c443
	ld de, $5f68
	call PlaceString
	call WaitBGMap
	ld a, $0b
	ld hl, $5771
	rst FarCall
	call Call_00a_65df
	ld a, 2
	ld [wc901], a

jr_00a_5e8f:
	dr $29e8f, $2a0eb

Jump_00a_60eb:
	dr $2a0eb, $2a109

Jump_00a_6109:
	dr $2a109, $2a1b9

Jump_00a_61b9:
jr_00a_61b9:
	nop
	ldh a, [hMGStatusFlags]
	cp $10
	jr z, jr_00a_6201
	cp $6c
	jr nz, jr_00a_6201
	ld hl, wc901
	dec [hl]
	jr z, jr_00a_6201
	ld hl, wc750
	ld de, wc800
	ld bc, $000f
	call CopyBytes
	ld a, [wc750]
	cp $03
	jr nc, jr_00a_6201
	farcall StagePartyDataForMysteryGift
	call Call_00a_65df
	ld a, $2b
	ld [wc902], a
	ldh a, [$bd]
	cp $02
	jr z, jr_00a_61f9
	call Call_00a_6227
	jr nz, jr_00a_61b9
	jp Jump_00a_60eb

jr_00a_61f9:
	call Call_00a_621c
	jr nz, jr_00a_61b9
	jp Jump_00a_6109

jr_00a_6201:
	xor a
	ldh [rIF], a
	ldh a, [rIE]
	or $01
	ldh [rIE], a
	ei
	call DelayFrame
	ldh a, [hMGStatusFlags]
	push af
	call Call_00a_6284
	pop af
	ret

Jump_00a_6216:
	dr $2a216, $2a21c

Call_00a_621c:
	dr $2a21c, $2a227

Call_00a_6227:
	dr $2a227, $2a284

Call_00a_6284:
	dr $2a284, $2a5df

Call_00a_65df:
	dr $2a5df, $2a5ef
