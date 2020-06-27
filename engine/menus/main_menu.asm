	; MainMenuItems indexes
	const_def
	const MAINMENU_NEW_GAME ; 0
	const MAINMENU_CONTINUE ; 1
	const MAINMENU_MYSTERY  ; 2

	; MainMenu.Strings and MainMenu.Jumptable indexes
	const_def
	const MAINMENUITEM_CONTINUE     ; 0
	const MAINMENUITEM_NEW_GAME     ; 1
	const MAINMENUITEM_OPTION       ; 2
	const MAINMENUITEM_MYSTERY_GIFT ; 3

MainMenu:
	ld de, MUSIC_NONE
	call PlayMusic
	call DelayFrame
	ld de, MUSIC_MAIN_MENU
	ld a, e
	ld [wMapMusic], a
	call PlayMusic
.loop
	xor a
	ld [wDisableTextAcceleration], a
	call ClearTilemapEtc
	ld b, SCGB_DIPLOMA
	call GetSGBLayout
	ld hl, wGameTimerPause
	res GAMETIMERPAUSE_TIMER_PAUSED_F, [hl]
	call MainMenu_GetWhichMenu
	ld [wWhichIndexSet], a
	call MainMenu_PrintCurrentTimeAndDay
	ld hl, .MenuHeader
	call LoadMenuHeader
	call MainMenuJoypadLoop
	call CloseWindow
	jr c, .quit
	call ClearTilemap
	ld a, [wMenuSelection]
	ld hl, .Jumptable
	rst JumpTable
	jr .loop

.quit
	jp StartTitleScreen

.MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 13, 7
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 0 ; items
	dw MainMenuItems
	dw PlaceMenuStrings
	dw .Strings

.Strings:
; entries correspond to MAINMENUITEM_* constants
	db "つづきから はじめる@"
	db "さいしょから はじめる@"
	db "せっていを かえる@"
	db "ふしぎな おくリもの@"

.Jumptable:
; entries correspond to MAINMENUITEM_* constants
	dw Continue
	dw NewGame
	dw Option
	dw MysteryGift

MainMenuItems:
; entries correspond to MAINMENU_* constants

	; MAINMENU_NEW_GAME
	db 2
	db MAINMENUITEM_NEW_GAME
	db MAINMENUITEM_OPTION
	db -1

	; MAINMENU_CONTINUE
	db 3
	db MAINMENUITEM_CONTINUE
	db MAINMENUITEM_NEW_GAME
	db MAINMENUITEM_OPTION
	db -1

	; MAINMENU_MYSTERY
	db 4
	db MAINMENUITEM_CONTINUE
	db MAINMENUITEM_NEW_GAME
	db MAINMENUITEM_OPTION
	db MAINMENUITEM_MYSTERY_GIFT
	db -1

MainMenu_GetWhichMenu:
	nop
	nop
	nop
	ld a, [wSaveFileExists]
	and a
	jr nz, .next
	ld a, MAINMENU_NEW_GAME
	ret

.next
	ldh a, [hCGB]
	cp TRUE
	ld a, MAINMENU_CONTINUE
	ret nz
	ld a, BANK(s0_ab53)
	call OpenSRAM
	ld a, [s0_ab53]
	cp -1
	call CloseSRAM
	ld a, MAINMENU_CONTINUE
	ret z
	ld a, MAINMENU_MYSTERY
	ret

MainMenuJoypadLoop:
	call SetUpMenu
.loop
	call MainMenu_PrintCurrentTimeAndDay
	call GetScrollingMenuJoypad
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jr z, .b_button
	cp A_BUTTON
	jr z, .a_button
	jr .loop

.a_button
	call PlayClickSFX
	and a
	ret

.b_button
	scf
	ret

MainMenu_PrintCurrentTimeAndDay:
	ld a, [wSaveFileExists]
	and a
	ret z
	xor a
	ldh [hBGMapMode], a
	call .PlaceBox
	ld hl, wOptions
	ld a, [hl]
	push af
	set 4, [hl]
	call .PlaceTime
	pop af
	ld [wOptions], a
	ld a, 1
	ldh [hBGMapMode], a
	ret

.PlaceBox:
	call CheckRTCStatus
	and $80
	jr nz, .TimeFail
	hlcoord 0, 12
	ld b, 4
	ld c, 13
	call Textbox
	ret

.TimeFail:
	call SpeechTextbox
	ret

.PlaceTime:
	ld a, [wSaveFileExists]
	and a
	ret z
	call CheckRTCStatus
	and %10000000 ; Day count exceeded 16383
	jp nz, .PrintTimeNotSet
	call UpdateTime
	call GetWeekday
	ld b, a
	decoord 1, 14
	call PrintDayOfWeek
	decoord 2, 16
	ldh a, [hHours]
	ld c, a
	farcall PrintHour
	hlcoord 9, 16
	ld de, hMinutes
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNum
	hlcoord 11, 16
	ld de, .min
	call PlaceString
	ret

.min
	db "ふん@"

.PrintTimeNotSet:
	hlcoord 1, 14
	ld de, .TimeNotSet
	call PlaceString
	ret

.TimeNotSet:
	db "とけいのじこく  ふめい@"

.MainMenuTimeUnknownText:
	text "とけいのじこく  ふめい"
	done

PrintDayOfWeek:
	push de
	ld hl, .Days
	ld a, b
	call GetNthString
	ld d, h
	ld e, l
	pop hl
	call PlaceString
	ld h, b
	ld l, c
	ld de, .Day
	call PlaceString
	ret

.Days:
	db "にち@"
	db "げつ@"
	db "か@"
	db "すい@"
	db "もく@"
	db "きん@"
	db "ど@"
.Day:
	db "ようび@"

ClearTilemapEtc:
	xor a
	ldh [hMapAnims], a
	call ClearTilemap
	call LoadFontsExtra
	call LoadStandardFont
	call ClearWindowData
	ret

MysteryGift:
	call UpdateTime
	ld a, $04
	ld hl, $5905
	rst FarCall
	farcall DoMysteryGift
	ret

Option:
	ld a, $39
	ld hl, $4baf
	rst FarCall
	ret
