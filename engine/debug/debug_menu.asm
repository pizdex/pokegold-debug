_DebugMenu::
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
	jr _DebugMenu

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
	dw DebugMenuOptionFight,    .DebugFightText
	dw DebugMenuOptionLink,     .DebugLinkText
	dw DebugMenuOptionField,    .DebugFieldText
	dw DebugMenuOptionSound,    .DebugSoundText
	dw DebugMenuOptionMonster,  .DebugMonsterText
	dw DebugMenuOptionTrainer,  .DebugTrainerText
	dw DebugMenuOptionPassword, .DebugPasswordText
	dw DebugMenuOptionClock,    .DebugClockText

.DebugFightText:	db "ファイト@"		; Fight
.DebugLinkText:		db "つうしんよう@"	; Communication
.DebugFieldText:	db "フィールド@"	; Field
.DebugSoundText:	db "サウンド@"		; Soundtrack
.DebugMonsterText:	db "モンスター@"	; Monster
.DebugTrainerText:	db "トレーナー@"	; Trainer
.DebugPasswordText:	db "パスワード@"	; Password
.DebugClockText		db "とけいきのう@"	; Clock (RTC) Function

FIGHT		EQU 0
LINK		EQU 1
FIELD		EQU 2
SOUND		EQU 3
MON			EQU 4
TRAINER		EQU 5
PASSWORD	EQU 6
CLOCK		EQU 7

.DebugMenuItems:
	db 8
	db FIGHT
	db LINK
	db FIELD
	db SOUND
	db CLOCK
	db MON
	db TRAINER
	db PASSWORD
	db -1

DebugMenuOptionField:
	farcall DebugField_SpawnHome
	ret

DebugMenuOptionLink:
	farcall DebugField_SpawnPokecenter
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

Debug_InitField:
; Does everything needed to have a nice time in the world

; Give the player and rival a name
	call Debug_SetPlayerAndRivalNames

; Give max money
; $0f423f = 999999
	ld a, $0f
	ld [wMoney], a
	ld a, $42
	ld [wMoney + 1], a
	ld a, $3f
	ld [wMoney + 2], a

; Give 0099 coins
	xor a
	ld [wCoins], a
	ld a, 99
	ld [wCoins + 1], a

; Give evolved starter mon
	call Debug_RandomizeFieldStarter

; Fill box with random mons
	ld b, 20 ; last mon's level - 1
	ld c, 5  ; test
	ld c, 30 ; no. of mons to load
	call GenerateRandomMonsIntoBox

; Give 1 of every TM and HM
	call Debug_GiveTMsHMs

; Load bag with items
	ld de, Debug_ItemData
	call Debug_LoadItemData

; Set all Pokemon as caught and seen
	ld hl, wPokedexCaught
	call Debug_CompletePokedex
	ld hl, wPokedexSeen
	call Debug_CompletePokedex

; Set the "G" Unown as seen
	ld hl, wUnownDex
	ld [hl], 1
	ld hl, wFirstUnownSeen
	ld [hl], UNOWN_G ; G for Gamefreak?

; Get all contacts, pokegear cards and decorations
	call Debug_FillPhoneList
	call Debug_SetPokegearFlags
	call Debug_SetDecorationFlags

; Release the three roaming mons
	farcall InitRoamMons

; Elm's mystery egg event
	call Debug_SetMysteryEggEvent

; Set time of day to 12:34 PM (Displayed as 【ごご 0じ 34ふん】 in-game)
	ld a, 12 ; Hour
	ld [wStringBuffer2 + 1], a
	ld a, 34 ; Minutes
	ld [wStringBuffer2 + 2], a
	call InitTimeOfDay

; Randomise lucky ID number
	call Random
	ld [wLuckyIDNumber], a
	call Random
	ld [wLuckyIDNumber + 1], a
	ret

Debug_FillPhoneList:
	ld a, 1
	ld b, CONTACT_LIST_SIZE
	ld hl, wPhoneList
.loop
	ld [hli], a
	inc a
	dec b
	jr nz, .loop
	ret

Debug_CompletePokedex:
; Input: hl = wPokedexCaught or wPokedexSeen
	ld b, (((NUM_POKEMON) + 7) / 8) - 1 ; sizeof(flag_array NUM_POKEMON)
	ld a, %11111111
.loop
	ld [hli], a
	dec b
	jr nz, .loop
; sizeof(flag_array NUM_POKEMON) * 8 bits = 248 mons
; NUM_POKEMON - 248 = 3 mons (bits) left to set
	ld [hl], %00000111
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

Debug_LoadItemData:
	ld hl, wNumItems
.loop
	ld a, [de]  ; Item ID
; check for terminator
	cp -1
	ret z
; item is valid, receive it
	ld [wCurItem], a
	inc de
	ld a, [de] ; Quantity
	inc de
	ld [wItemQuantityChangeBuffer], a
	call ReceiveItem
	jr .loop
	ret

Debug_ItemData:
; Item data that gets loaded into the bag in the field
.KeyItemData:
	;   ITEM    QUANTITY
	db BICYCLE,    1
	db OLD_ROD,    1
	db GOOD_ROD,   1
	db SUPER_ROD,  1
	db COIN_CASE,  1
	db ITEMFINDER, 1
	; fallthrough
.MailData:
	db FLOWER_MAIL,  6
	db SURF_MAIL,    6
	db LITEBLUEMAIL, 6
	db PORTRAITMAIL, 6
	db LOVELY_MAIL,  6
	db EON_MAIL,     6
	db MORPH_MAIL,   6
	db BLUESKY_MAIL, 6
	db MUSIC_MAIL,   6
	db MIRAGE_MAIL,  6
	; fallthrough
.BallData:
	db MASTER_BALL, 99
	db ULTRA_BALL,  99
	db POKE_BALL,   99
	db HEAVY_BALL,  99
	db LEVEL_BALL,  99
	db LURE_BALL,   99
	db FAST_BALL,   99
	; fallthrough
.ItemData:
	db POTION,     30
	db RARE_CANDY, 20
	db FULL_HEAL,  99
	db -1

Debug_RandomizeFieldStarter:
; Sets wCurPartySpecies to either Meganium (154), Typhlosion (157) or Feraligatr (160)
.loop
	call Random
	and 3
	jr z, .loop
	dec a
; a is now either 0, 1 or 2
; multiply by 3 and add to Meganium's species index
	ld b, a
	add a
	add b
	add MEGANIUM
	ld b, 80 ; level
	call _TryAddMonToParty
	ret

_TryAddMonToParty:
	ld [wCurPartySpecies], a
	ld a, b
	ld [wCurPartyLevel], a
	predef TryAddMonToParty
	ret

GenerateRandomMonsIntoBox:
; Loads a number of random mons into the first box
; starting from the bottom position.
; c = number of mons to load
; b = level

; Make sure we're loading 1 or more mons into the box
	ld a, c
	and a
	ret z
; level is incremented each time the loop is run
	ld a, b
	ld [wCurPartyLevel], a
.loop
	push bc
	xor a
	ld [wEnemySubStatus5], a
; Randomise the mon
	call GenerateRandomSpecies
	ld [wTempEnemyMonSpecies], a
; Increment level
	ld hl, wCurPartyLevel
	inc [hl]
; Generate that species' data into EnemyMon
	farcall LoadEnemyMon
; Send it to the box
	ld a, [wTempEnemyMonSpecies]
	ld [wCurPartySpecies], a
	farcall SendMonIntoBox
; Loop until all mons are generated
	pop bc
	dec c
	jr nz, .loop
	ret

GenerateRandomSpecies:
; Load a random mon species between 1 (BULBASAUR) and 246 (LARVITAR) into a
; excluding UNOWN
.loop
	call Random
	and a
	jr z, .loop
	cp LARVITAR
	jr nc, .loop
	cp UNOWN
	jr z, .loop
	ret

Debug_SetDecorationFlags:
	farcall SetAllDecorationFlags
	ret

Debug_SetMysteryEggEvent:
	ld de, EVENT_GAVE_MYSTERY_EGG_TO_ELM
	ld b, SET_FLAG
	jp EventFlagAction

Debug_SetPlayerAndRivalNames:
.loop
; Load random trainer class into a
	call Random
	cp NUM_TRAINER_CLASSES - 1
	jr nc, .loop
; Get the Trainer's name from the class and copy it into the Player's name
	ld c, a
	ld b, 0
	ld hl, TrainerGroups
	add hl, bc
	add hl, bc
	ld a, BANK(TrainerGroups)
	call GetFarHalfword
	ld de, wPlayerName
	ld bc, NAME_LENGTH
	ld a, BANK(TrainerGroups)
	call FarCopyBytes
; Rival's name is レッド (Red)
	ld hl, .RivalName
	ld de, wRivalName
	ld bc, NAME_LENGTH
	call CopyBytes
	ret

.RivalName:
	db "レッド@" ; Red

Debug_SetPokegearFlags::
	ld hl, wStatusFlags
	set STATUSFLAGS_POKEDEX_F, [hl]

	ld hl, wPokegearFlags
	set POKEGEAR_OBTAINED_F, [hl]
	ld hl, wPokegearFlags
	set POKEGEAR_RADIO_CARD_F, [hl]
	ld hl, wPokegearFlags
	set POKEGEAR_PHONE_CARD_F, [hl]
	ld hl, wPokegearFlags
	set POKEGEAR_MAP_CARD_F, [hl]
	ret
