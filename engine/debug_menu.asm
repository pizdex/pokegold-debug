DebugMenu::
	call ClearTilemap
	call ClearWindowData
	call LoadStandardFont
	call LoadFontsBattleExtra
	call ClearSprites
	call GetMemSGBLayout
	call SetPalettes

	xor a
	ld [wWhichIndexSet], a
	ld hl, .DebugMenuHeader
	call LoadMenuHeader
	call DoNthMenu
	call CloseWindow
	ret c
	call MenuJumptable
	jr DebugMenu

.DebugMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 5, 0, 13, 17
	dw .DebugMenuData
	db 1 ; default option

.DebugMenuData:
	db STATICMENU_CURSOR | STATICMENU_WRAP
	db 0 ; items
	dw .DebugMenuItems
	dw PlaceNthMenuStrings
	dw .DebugMenuPointers

.DebugMenuPointers:
	dw DebugMenuOptionFight, .DebugFightText
	dw DebugMenuOptionLink, .DebugLinkText
	dw DebugMenuOptionField, .DebugFieldText
	dw DebugMenuOptionSound, .DebugSoundText
	dw DebugMenuOptionMonster, .DebugMonsterText
	dw DebugMenuOptionTrainer, .DebugTrainerText
	dw DebugMenuOptionPassword, .DebugPasswordText
	dw DebugMenuOptionClock, .DebugClockText

.DebugFightText:	db "ファイト@"		; Fight
.DebugLinkText:		db "つうしんよう@"	; Communication
.DebugFieldText:	db "フィールド@"	; Field
.DebugSoundText:	db "サウンド@"		; Soundtrack
.DebugMonsterText:	db "モンスター@"	; Monster
.DebugTrainerText:	db "トレーナー@"	; Trainer
.DebugPasswordText:	db "パスワード@"	; Password
.DebugClockText		db "とけいきのう@"	; Clock (RTC) Function

FIGHT		EQU 0
COMM		EQU 1
FIELD		EQU 2
SOUND		EQU 3
MON			EQU 4
TRAINER		EQU 5
PASSWORD	EQU 6
CLOCK		EQU 7

.DebugMenuItems:
	db 8
	db FIGHT
	db COMM
	db FIELD
	db SOUND
	db CLOCK
	db MON
	db TRAINER
	db PASSWORD
	db -1

DebugMenuOptionField:
	farcall unk_001_5c3e
	ret

DebugMenuOptionLink:
	farcall unk_001_5c5e
	ret

DebugMenuOptionFight:
	ld hl, wDebugFlags
	set 0, [hl]
	predef DebugFightMenu
	ld hl, wDebugFlags
	res 0, [hl]
	ret

DebugMenuOptionSound:
	farcall DebugSoundMenu
	ret

DebugMenuOptionMonster:
	xor a
	ld [wMovementBufferCount], a
	farcall DebugColorPicker
	ld a, %11100100
	call DmgToCgbBGPals
	ret

DebugMenuOptionTrainer:
	ld a, 1
	ld [wMovementBufferCount], a
	farcall DebugColorPicker
	ret

DebugMenuOptionPassword:
	farcall DebugPasswordMenu
	ret

DebugMenuOptionClock:
	farcall DebugClockMenu
	ret

unk_03f_43ae:
	call Call_03f_44fb

; $0f423f = 999999
	ld a, $0f
	ld [wMoney], a
	ld a, $42
	ld [wMoney + 1], a
	ld a, $3f
	ld [wMoney + 2], a

	xor a
	ld [wCoins], a
	ld a, 99
	ld [wCoins + 1], a

	call RandomizeFieldStarter

	ld b, 20
	ld c, 5
	ld c, 30
	call Call_03f_44b0
	call Debug_GiveTMsHMs

	ld de, $445b
	call Call_03f_4445
	ld hl, wPokedexCaught
	call Call_03f_442d
	ld hl, wPokedexSeen
	call Call_03f_442d

	ld hl, wdbb8
	ld [hl], 1
	ld hl, wdbd3
	ld [hl], 7

	call Call_03f_4420
	call Call_03f_452b
	call Call_03f_44ec

	ld a, $0a
	ld hl, $688d
	rst FarCall
	call Call_03f_44f3

	ld a, 12 ; Hour
	ld [wStringBuffer2 + 1], a
	ld a, 34 ; Minutes
	ld [wStringBuffer2 + 2], a
	call InitTimeOfDay

	call Random
	ld [wd9af], a
	call Random
	ld [wd9b0], a
	ret

Call_03f_4420:
    ld a, 1
    ld b, 10
    ld hl, wd98c
.loop
    ld [hli], a
    inc a
    dec b
    jr nz, .loop
    ret

Call_03f_442d:
    ld b, $1f
    ld a, $ff
.loop
    ld [hli], a
    dec b
    jr nz, .loop
    ld [hl], 7
    ret

Debug_GiveTMsHMs:
    nop
    ld b, NUM_TMS + NUM_HMS
    ld a, 1 ; Quantity
    ld hl, wTMsHMs
.loop
    ld [hli], a
    dec b
    jr nz, .loop
    ret

Call_03f_4445:
    ld hl, wNumItems
.loop
    ld a, [de]
    cp $ff
    ret z
    ld [wCurItem], a
    inc de
    ld a, [de]
    inc de
    ld [wd003], a
    call ReceiveItem
    jr .loop
    ret

.KeyItemData:
	db BICYCLE, 1
	db OLD_ROD, 1
	db GOOD_ROD, 1
	db SUPER_ROD, 1
	db COIN_CASE, 1
	db ITEMFINDER, 1

.MailData1:
	db FLOWER_MAIL, 6
	db SURF_MAIL, 6
	db LITEBLUEMAIL, 6
	db PORTRAITMAIL, 6
	db LOVELY_MAIL, 6
	db EON_MAIL, 6
	db MORPH_MAIL, 6
	db BLUESKY_MAIL, 6
	db MUSIC_MAIL, 6
	db  MIRAGE_MAIL, 6

.BallData:
	db MASTER_BALL, 99
	db ULTRA_BALL, 99
	db POKE_BALL, 99
	db HEAVY_BALL, 99
	db LEVEL_BALL, 99
	db LURE_BALL, 99
	db FAST_BALL , 99

.ItemData2:
	db POTION, 30
	db RARE_CANDY, 20
	db FULL_HEAL, 99
	db -1

RandomizeFieldStarter:
; Sets wCurPartySpecies to either Meganium ($9a), Typhlosion ($9d) or Feraligatr ($a0)

.loop
    call Random
    and 3
    jr z, .loop
    dec a

; a is now either 0, 1 or 2
    ld b, a
    add a
    add b
    add $9a
    ld b, $50
    call Call_03f_44a3
    ret

Call_03f_44a3:
    ld [wCurPartySpecies], a
    ld a, b
    ld [wCurPartyLevel], a
    ld a, 6
    call Predef
    ret

Call_03f_44b0:
	ld a, c
	and a
	ret z
	ld a, b
	ld [wCurPartyLevel], a
.loop
	push bc
	xor a
	ld [$cb43], a

	call Call_03f_44dd
	ld [wTempEnemyMonSpecies], a
	ld hl, wCurPartyLevel
	inc [hl]

	ld a, $0f
	ld hl, $6802
	rst FarCall

	ld a, [wTempEnemyMonSpecies]
	ld [wCurPartySpecies], a

	ld a, $3
	ld hl, $611b
	rst FarCall

	pop bc
	dec c
	jr nz, .loop
	ret

Call_03f_44dd:
.loop
    call Random
    and a
    jr z, .loop
    cp $f6
    jr nc, .loop
    cp $c9
    jr z, .loop
    ret

Call_03f_44ec:
    ld a, 9
    ld hl, $7450
    rst FarCall
    ret

Call_03f_44f3:
    ld de, $001f
    ld b, 1
    jp EventFlagAction

Call_03f_44fb:
.loop
	call Random
	cp $42
	jr nc, .loop

	ld c, a
	ld b, 0
	ld hl, $595c
	add hl, bc
	add hl, bc
	ld a, $e
	call GetFarHalfword
	ld de, wPlayerName
	ld bc, 6
	ld a, $e
	call FarCopyBytes

	ld hl, .RivalName
	ld de, wd1c1
	ld bc, 6
	call CopyBytes
	ret

.RivalName:
	db "レッド@" ; Red
