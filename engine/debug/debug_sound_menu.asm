DebugSoundMenu::
	call ClearTilemap
	call ClearSprites
	ld de, MUSIC_NONE
	call PlayMusic
	ld a, 1
	ldh [hInMenu], a

; Draw the layout onto the screen
	hlcoord 1, 6
	ld de, SoundMenu_Layout
	call PlaceString

; Initialization
	xor a
	ld [wDebugMusicTrack], a
	call .PlaceMusicName
	xor a
	ld [wDebugSFXTrack], a
	call .PlaceSFXNumber
	call WaitBGMap
.JoypadLoop:
	call JoyTextDelay
	ldh a, [hJoyPressed]
	call .ReadJoypad
	call DelayFrame
	jr .JoypadLoop

.ReadJoypad:
	bit B_BUTTON_F, a
	jr nz, .stop_music

	bit START_F, a
	jr nz, .play_sfx

	ldh a, [hJoyLast]
	bit D_UP_F, a
	jr nz, .increment_music
	bit D_DOWN_F, a
	jr nz, .decrement_music
	bit D_RIGHT_F, a
	jr nz, .increment_sfx
	bit D_LEFT_F, a
	jr nz, .decrement_sfx

	bit A_BUTTON_F, a
	ret z
	ld de, MUSIC_NONE
	call PlayMusic
	call DelayFrame
	; Play music
	ld a, [wDebugMusicTrack]
	ld e, a
	ld d, 0
	jp PlayMusic

.increment_music:
	ld a, [wDebugMusicTrack]
	inc a
	cp NUM_MUSIC
	jr nz, .inc_music_okay
	xor a
.inc_music_okay
	ld [wDebugMusicTrack], a
	jp .PlaceMusicName

.decrement_music:
	ld a, [wDebugMusicTrack]
	dec a
	cp -1
	jr nz, .dec_music_okay
	ld a, NUM_MUSIC - 1
.dec_music_okay
	ld [wDebugMusicTrack], a
	jp .PlaceMusicName

.stop_music:
	ld de, MUSIC_NONE
	jp PlayMusic

.play_sfx:
	ld a, [wDebugSFXTrack]
	ld e, a
	ld d, 0
	jp PlaySFX

.increment_sfx:
	ld a, [wDebugSFXTrack]
	inc a
	cp NUM_SFX
	jr nz, .inc_sfx_okay
	xor a
.inc_sfx_okay
	ld [wDebugSFXTrack], a
	jp .PlaceSFXNumber

.decrement_sfx:
	ld a, [wDebugSFXTrack]
	dec a
	cp -1
	jr nz, .dec_sfx_okay
	ld a, NUM_SFX - 1
.dec_sfx_okay
	ld [wDebugSFXTrack], a
	jp .PlaceSFXNumber

.PlaceMusicName:
; Clear out the old name first
	hlcoord 6, 5
	ld bc, 5
	ld a, " "
	call ByteFill

; Get the music track name from the index number
	ld hl, SoundMenu_MusicNames
	ld a, [wDebugMusicTrack]
	ld e, a
	ld d, 0
rept 5
	add hl, de
endr
	ld de, wStringBuffer1
	push de
	ld bc, 5
	call CopyBytes
	pop de
	ld a, "@"
	ld [wStringBuffer1 + 5], a
	hlcoord 6, 6
	jp PlaceString

.PlaceSFXNumber:
	hlcoord 6, 12
	ld de, wDebugSFXTrack
	lb bc, 1, 3
	; Does not contain leading zeroes, and so does not display properly if the first two digits were displayed.
	jp PrintNum

SoundMenu_Layout:
	db "おんがく"
	db "<NEXT>"
	db "じょうげ エー"
	db "<NEXT>"
	db "<NEXT>"
	db "こうかおん"
	db "<NEXT>"
	db "さゆう  スタート@"

SoundMenu_MusicNames:
	db "ストップ "
	db "タイトル "
	db "どうろ1 "
	db "どうろ3 "
	db "どうろ4 "
	db "りニア  "
	db "バトル1 "
	db "バトル3 "
	db "バトル4 "
	db "ポケセン "
	db "しせん1 "
	db "しせん2 "
	db "しせん3 "
	db "あさ   "
	db "シオン  "
	db "ちか2  "
	db "ちか3  "
	db "つれてく2"
	db "カジノ  "
	db "じてんしゃ"
	db "でんどう "
	db "タウン1 "
	db "タウン3 "
	db "かち1  "
	db "かち2  "
	db "かち3  "
	db "かち4  "
	db "ジム   "
	db "マイホーム"
	db "ラボ   "
	db "オーキド "
	db "ライバル1"
	db "ライバル2"
	db "なみのり "
	db "しんか  "
	db "こうえん "
	db "おしまい "
	db "キキョウ "
	db "タウン12"
	db "まいこ  "
	db "ちか17 "
	db "バトル11"
	db "バトル13"
	db "どうろ13"
	db "ヒワダ  "
	db "ヨシノ  "
	db "バトル12"
	db "バトル14"
	db "バトル15"
	db "バトル16"
	db "ラボ11 "
	db "ちか112"
	db "どうろ15"
	db "どうろ18"
	db "こうそく "
	db "しょうねん"
	db "しょうじょ"
	db "ロケット "
	db "あやしい "
	db "ぼうさん "
	db "ワカバ  "
	db "コガネ  "
	db "クチバ  "
	db "ラジオ  "
	db "ふえ   "
	db "とう11 "
	db "とう11ー"
	db "とう12 "
	db "とう14 "
	db "みち111"
	db "みち112"
	db "みち113"
	db "ちか12ー"
	db "ちか113"
	db "バト112"
	db "アンノーン"
	db "かち22 "
	db "ごうロード"
	db "つれてく1"
	db "とう15 "
	db "こもり  "
	db "マーチ  "
	db "タイトル1"
	db "タイトル2"
	db "スタート "
	db "いせき  "
	db "せんきょ "
	db "ぶよう  "
	db "たいまい "
	db "たいかい "
	db "かいでんぱ"
	db "プりンタ "
	db "エンド2 "
