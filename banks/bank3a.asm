_InitSound::
; restart sound operation
; clear all relevant hardware registers & wram
	push hl
	push de
	push bc
	push af
	call MusicOff
	ld hl, rNR50 ; channel control registers
	xor a
	ld [hli], a ; rNR50 ; volume/vin
	ld [hli], a ; rNR51 ; sfx channels
	ld a, $80 ; all channels on
	ld [hli], a ; rNR52 ; music channels

	ld hl, rNR10 ; sound channel registers
	ld e, NUM_MUSIC_CHANS
.clearsound
;   sound channel   1      2      3      4
	xor a
	ld [hli], a ; rNR10, rNR20, rNR30, rNR40 ; sweep = 0

	ld [hli], a ; rNR11, rNR21, rNR31, rNR41 ; length/wavepattern = 0
	ld a, $8
	ld [hli], a ; rNR12, rNR22, rNR32, rNR42 ; envelope = 0
	xor a
	ld [hli], a ; rNR13, rNR23, rNR33, rNR43 ; frequency lo = 0
	ld a, $80
	ld [hli], a ; rNR14, rNR24, rNR34, rNR44 ; restart sound (freq hi = 0)
	dec e
	jr nz, .clearsound

	ld hl, wc001
	ld de, $01bf
.clearaudio
	xor a
	ld [hli], a
	dec de
	ld a, e
	or d
	jr nz, .clearaudio

	ld a, MAX_VOLUME
	ld [wVolume], a
	call MusicOn
	pop af
	pop bc
	pop de
	pop hl
	ret

Call_03a_403d:
	dr $e803d, $e8051

MusicOn:
	ld a, 1
	ld [wc000], a
	ret

MusicOff:
	xor a
	ld [wc000], a
	ret

_UpdateSound::
	dr $e805c, $e8b30

_PlayMusic::
	dr $e8b30, $e8b79

_PlayCry::
	dr $e8b79, $e8c04

_PlaySFX::
	dr $e8c04, $e8d76

LoadMusicByte::
	dr $e8d76, $ec000
