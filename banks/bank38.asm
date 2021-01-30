unk_038_4000:
	dr $e0000, $e08bd

_CardFlip:
	ld hl, wOptions
	set NO_TEXT_SCROLL, [hl]
	call ClearBGPalettes
	call ClearTilemap
	call ClearSprites
	ld de, MUSIC_NONE
	call PlayMusic
	call DelayFrame
	call DisableLCD
	call LoadStandardFont
	call LoadFontsExtra

	ld hl, $551b
	ld de, vTiles2 tile $00
	call Decompress
	ld hl, $56ad
	ld de, vTiles2 tile $3e
	call Decompress
	ld hl, $54e0
	ld de, vTiles0 tile $00
	call Decompress
	ld hl, $54fb
	ld de, $8ef0
	ld bc, 1 tiles
	call CopyBytes
	ld hl, $550b
	ld de, $8f50
	ld bc, 1 tiles
	call CopyBytes

	call CardFlip_InitTilemap
	call CardFlip_InitAttrPals
	call unk_001_5446
	call EnableLCD
	call WaitBGMap2
	ld a, %11100100
	call DmgToCgbBGPals
	lb de, %11100100, %11100100
	call DmgToCgbObjPals
	call DelayFrame
	xor a
	ld [wJumptableIndex], a
	ld a, $2
	ld [wce58], a
	ld [wce59], a
	ld de, MUSIC_GAME_CORNER
	call PlayMusic
.MasterLoop:
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .leavethegame
	call .CardFlip
	jr .MasterLoop

.leavethegame
	call WaitSFX
	ld de, SFX_QUIT_SLOTS
	call PlaySFX
	call WaitSFX
	call ClearBGPalettes
	ld hl, wOptions
	res 4, [hl]
	ret

.CardFlip:
	dr $e0960, $e0cce

CardFlip_InitAttrPals:
	dr $e0cce, $e0d2e

CardFlip_InitTilemap:
	dr $e0d2e, $e267a

_MemoryGame:
	dr $e267a, $e2bb6

_DepositPKMN::
	dr $e2bb6, $e2d81

_WithdrawPKMN::
	dr $e2d81, $e2f4e

_MovePKMNWithoutMail::
	dr $e2f4e, $e3ce3

_ChangeBox::
	dr $e3ce3, $e4000
