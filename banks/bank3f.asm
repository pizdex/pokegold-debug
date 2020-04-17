unk_03f_4000:
	dr $fc000,$fc01f

Call_03f_401f:
	dr $fc01f,$fc03f

Call_03f_403f:
	dr $fc03f,$fc064

Call_03f_4064:
	dr $fc064,$fc0be

unk_03f_40be:
	ld hl, wOptions
	ld a, [hl]
	push af
	set 4, [hl]
	xor a
	ld [wd0c5], a
	ld [wd0c6], a
	call Call_03f_40da
	call Call_03f_40f5
	pop af
	ld [wOptions], a
	call ClearTilemap
	ret

Call_03f_40da:
	dr $fc0da,$fc0f5

Call_03f_40f5:
	dr $fc0f5,$fc106

Call_03f_4106:
	dr $fc106,$fc171

Call_03f_4171:
	dr $fc171,$fc18f

Call_03f_418f:
	dr $fc18f,$fc199

Call_03f_4199:
	dr $fc199,$fc1a0

Call_03f_41a0:
	dr $fc1a0,$fc1c8

Call_03f_41c8:
	dr $fc1c8,$fc231

Call_03f_4231:
	dr $fc231,$fc242

Call_03f_4242:
	dr $fc242,$fc2b5

Call_03f_42b5:
	dr $fc2b5,$fc2ca

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
	dw DebugMenuOptionRTC, .DebugRTCText

.DebugFightText:	db "ファイト@"		; Fight
.DebugLinkText:		db "つうしんよう@"	; Communication
.DebugFieldText:	db "フィールド@"	; Field
.DebugSoundText:	db "サウンド@"		; Soundtrack
.DebugMonsterText:	db "モンスター@"	; Monster
.DebugTrainerText:	db "トレーナー@"	; Trainer
.DebugPasswordText:	db "パスワード@"	; Password
.DebugRTCText		db "とけいきのう@"	; RTC Function

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
	ld a, $3a
	call Predef
	ld hl, wDebugFlags
	res 0, [hl]
	ret

DebugMenuOptionSound:
	farcall _DebugSoundMenu
	ret

DebugMenuOptionMonster:
	xor a
	ld [wMovementBufferCount], a
	ld a, $3f
	ld hl, $7495
	rst FarCall
	ld a, %11100100
	call DmgToCgbBGPals
	ret

DebugMenuOptionTrainer:
	ld a, 1
	ld [wMovementBufferCount], a
	ld a, $3f
	ld hl, $7495
	rst FarCall
	ret

DebugMenuOptionPassword:
	ld a, 2
	ld hl, $461a
	rst FarCall
	ret

DebugMenuOptionRTC:
	farcall unk_03f_40be
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
	rst $08
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
    ld [wcffc], a
    inc de
    ld a, [de]
    inc de
    ld [wd003], a
    call ReceiveItem
    jr .loop
    ret

.KeyItemData:
	db $07, 1
	db $3A, 1
	db $3B, 1
	db $3D, 1
	db $36, 1
	db $37, 1

.ItemData1:
	db $9E, 6
	db $B5, 6
	db $B6, 6
	db $B7, 6
	db $B8, 6
	db $B9, 6
	db $BA, 6
	db $BB, 6
	db $BC, 6
	db $BD, 6

.BallData:
	db $01, 99
	db $02, 99
	db $05, 99
	db $9D, 99
	db $9F, 99
	db $A0, 99
	db $A1, 99

.ItemData2:
	db $12, 30
	db $20, 20
	db $26, 99
	db $FF

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
    ld [wd03a], a
    ld a, 6
    call Predef
    ret

Call_03f_44b0:
	ld a, c
	and a
	ret z
	ld a, b
	ld [wd03a], a
.loop
	push bc
	xor a
	ld [$cb43], a

	call Call_03f_44dd
	ld [wd0df], a
	ld hl, wd03a
	inc [hl]

	ld a, $0f
	ld hl, $6802
	rst FarCall

	ld a, [wd0df]
	ld [wCurPartySpecies], a

	ld a, $03
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
	ld a, $0e
	call GetFarHalfword
	ld de, wd1b5
	ld bc, $0006
	ld a, $0e
	call FarCopyBytes

	ld hl, .RivalName
	ld de, wd1c1
	ld bc, $0006
	call CopyBytes
	ret

.RivalName:
	db "レッド@" ; Red

Call_03f_452b:
	dr $fc52b,$fc629

unk_03f_4629:
	dr $fc629,$fc685

unk_03f_4685:
	dr $fc685,$fc6a4

Call_03f_46a4:
	dr $fc6a4,$fc6df

Call_03f_46df:
	dr $fc6df,$fc6eb

Call_03f_46eb:
	dr $fc6eb,$fc729

Call_03f_4729:
	dr $fc729,$fc732

Call_03f_4732:
	dr $fc732,$fc748

Call_03f_4748:
	dr $fc748,$fc797

Call_03f_4797:
	dr $fc797,$fc7ef

Call_03f_47ef:
	dr $fc7ef,$fc82d

unk_03f_482d:
	dr $fc82d,$fc876

unk_03f_4876:
	dr $fc876,$fc893

unk_03f_4893:
	dr $fc893,$fc8c4

unk_03f_48c4:
	dr $fc8c4,$fc8db

Call_03f_48db:
	dr $fc8db,$fc8e4

Call_03f_48e4:
	dr $fc8e4,$fc8f7

Call_03f_48f7:
	dr $fc8f7,$fc954

unk_03f_4954:
	dr $fc954,$fc9b8

unk_03f_49b8:
	dr $fc9b8,$fc9c4

Call_03f_49c4:
	dr $fc9c4,$fca67

Call_03f_4a67:
	dr $fca67,$fca95

Call_03f_4a95:
	dr $fca95,$fcaea

Call_03f_4aea:
	dr $fcaea,$fcb12

Call_03f_4b12:
	dr $fcb12,$fcb57

Call_03f_4b57:
	dr $fcb57,$fcb62

Call_03f_4b62:
	dr $fcb62,$fcb91

unk_03f_4b91:
	dr $fcb91,$fcbaf

Call_03f_4baf:
	dr $fcbaf,$fcbdb

Call_03f_4bdb:
	dr $fcbdb,$fcc07

Call_03f_4c07:
	dr $fcc07,$fcc65

unk_03f_4c65:
	dr $fcc65,$fcc7a

unk_03f_4c7a:
	dr $fcc7a,$fccc0

Call_03f_4cc0:
	dr $fccc0,$fccd1

unk_03f_4cd1:
	dr $fccd1,$fcd51

Call_03f_4d51:
	dr $fcd51,$fcd59

unk_03f_4d59:
	dr $fcd59,$fcd81

Call_03f_4d81:
	dr $fcd81,$fcda7

unk_03f_4da7:
	dr $fcda7,$fcebb

Call_03f_4ebb:
	dr $fcebb,$fcee2

Jump_03f_4ee2:
	dr $fcee2,$fcf6d

Jump_03f_4f6d:
	dr $fcf6d,$fcfb6

Call_03f_4fb6:
	dr $fcfb6,$fcffe

Jump_03f_4ffe:
	dr $fcffe,$fd03d

Jump_03f_503d:
	dr $fd03d,$fdc29

_DebugSoundMenu:
	dr $fdc29,$fdcdc

Call_03f_5cdc:
	dr $fdcdc,$fffff
