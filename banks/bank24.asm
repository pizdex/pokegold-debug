unk_024_4000:
	dr $90000, $90a86

PrintHour::
	dr $90a86, $90ada

PokeGear:
	dr $90ada, $91da5

unk_024_5da5:
	dr $91da5, $92010

TownMapMon:
	dr $92010, $92398

EntireFlyMap::
	dr $92398, $923f5

.loop
	dr $923f5, $92489

GetLandmarkCoords:
	dr $92489, $92b85

_SlotMachine:
	ld hl, wOptions
	set NO_TEXT_SCROLL, [hl]
	call .InitGFX
	call DelayFrame
.loop
	call SlotsLoop
	jr nc, .loop
	call WaitSFX
	ld de, SFX_QUIT_SLOTS
	call PlaySFX
	call WaitSFX
	call ClearBGPalettes
	ld hl, wOptions
	res NO_TEXT_SCROLL, [hl]
	ld hl, rLCDC
	res rLCDC_SPRITE_SIZE, [hl] ; 8x8
	ret

.InitGFX:
	dr $92baf, $92c53

Call_024_6c53:
	dr $92c53, $92c67

SlotsLoop:
	dr $92c67, $92c8b

Call_024_6c8b:
	dr $92c8b, $92cb0

Call_024_6cb0:
	dr $92cb0, $94000
