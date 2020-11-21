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
	db "おんがく" ; Music
	next "じょうげ エー" ; UP/DOWN and A
	next ""
	next "こうかおん" ; Sound Effect
	next "さゆう  スタート@" ; LEFT/RIGHT and START

SoundMenu_MusicNames:
	db "ストップ " ; STOP
	db "タイトル " ; TITLE
	db "どうろ1 " ; ROUTE 1
	db "どうろ3 " ; ROUTE 3
	db "どうろ4 " ; ROUTE 4
	db "りニア  " ; LINEAR
	db "バトル1 " ; BATTLE 1
	db "バトル3 " ; BATTLE 3
	db "バトル4 " ; BATTLE 4
	db "ポケセン " ; POKECENTER
	db "しせん1 " ; GAZE 1
	db "しせん2 " ; GAZE 2
	db "しせん3 " ; GAZE 3
	db "あさ   " ; MORNING
	db "シオン  " ; LAVENDER TOWN
	db "ちか2  " ; UNDERGROUND 2
	db "ちか3  " ; UNDERGROUND 3
	db "つれてく2" ; BRING ALONG 2
	db "カジノ  " ; CASINO
	db "じてんしゃ" ; BICYCLE
	db "でんどう " ; HALL OF FAME
	db "タウン1 " ; TOWN 1
	db "タウン3 " ; TOWN 3
	db "かち1  " ; VICTORY 1
	db "かち2  " ; VICTORY 2
	db "かち3  " ; VICTORY 3
	db "かち4  " ; VICTORY 4
	db "ジム   " ; GYM
	db "マイホーム" ; MY HOME
	db "ラボ   " ; LAB
	db "オーキド " ; OAK
	db "ライバル1" ; RIVAL 1
	db "ライバル2" ; RIVAL 2
	db "なみのり " ; SURFING
	db "しんか  " ; EVOLUTION
	db "こうえん " ; PARK
	db "おしまい " ; THE END
	db "キキョウ " ; VIOLET CITY
	db "タウン12" ; TOWN 12
	db "まいこ  " ; KIMONO GIRL
	db "ちか17 " ; UNDERGROUND 17
	db "バトル11" ; BATTLE 11
	db "バトル13" ; BATTLE 13
	db "どうろ13" ; ROUTE 13
	db "ヒワダ  " ; AZALEA TOWN
	db "ヨシノ  " ; CHERRYGROVE CITY
	db "バトル12" ; BATTLE 12
	db "バトル14" ; BATTLE 14
	db "バトル15" ; BATTLE 15
	db "バトル16" ; BATTLE 16
	db "ラボ11 " ; LAB 11
	db "ちか112" ; UNDERGROUND 112
	db "どうろ15" ; ROUTE 15
	db "どうろ18" ; ROUTE 18
	db "こうそく " ; HIGH-SPEED
	db "しょうねん" ; BOY
	db "しょうじょ" ; GIRL
	db "ロケット " ; ROCKET
	db "あやしい " ; SUSPICIOUS
	db "ぼうさん " ; MONK
	db "ワカバ  " ; NEW BARK TOWN
	db "コガネ  " ; GOLDENROD CITY
	db "クチバ  " ; VERMILION CITY
	db "ラジオ  " ; RADIO
	db "ふえ   " ; FLUTE
	db "とう11 " ; TOWER 11
	db "とう11ー" ; TOWER 11-
	db "とう12 " ; TOWER 12
	db "とう14 " ; TOWER 14
	db "みち111" ; ROAD 111
	db "みち112" ; ROAD 112
	db "みち113" ; ROAD 113
	db "ちか12ー" ; UNDERGROUND 12-
	db "ちか113" ; UNDERGROUND 113
	db "バト112" ; BATTLE 112
	db "アンノーン" ; UNOWN
	db "かち22 " ; VICTORY 22
	db "ごうロード" ; ? ROAD
	db "つれてく1" ; BRING ALONG 1
	db "とう15 " ; TOWER 15
	db "こもり  " ; NURSE
	db "マーチ  " ; MARCH
	db "タイトル1" ; TITLE 1
	db "タイトル2" ; TITLE 2
	db "スタート " ; START
	db "いせき  " ; HISTORIC RUINS
	db "せんきょ " ; WAR SITUATION
	db "ぶよう  " ; DANCER
	db "たいまい " ; ?
	db "たいかい " ; ?
	db "かいでんぱ" ; STRANGE RADIO WAVE
	db "プりンタ " ; PRINTER
	db "エンド2 " ; END 2
