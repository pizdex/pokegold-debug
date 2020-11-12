	db 0

	const_def
	const DEBUG_CANCEL    ; 0
	const DEBUG_NEXT
	const DEBUG_GAME
	const DEBUG_CHARACTER
	const DEBUG_TOOLGEAR
	const DEBUG_TEST1     ; 5
	const DEBUG_TEST2
	const DEBUG_TEST3
	const DEBUG_TEST4
	const DEBUG_RECOVERY
	const DEBUG_WARP      ; 10
	const DEBUG_PC
	const DEBUG_EXPERIMENT
	const DEBUG_BUILD
	const DEBUG_TIMER
	const DEBUG_ELEVATOR  ; 15
	const DEBUG_RECORD
	const DEBUG_ITEM
	const DEBUG_BUGCATCHING
	const DEBUG_BREEDING
	const DEBUG_HATCH     ; 20

	const_def
	const QUICKMENU_UPDATE
	const QUICKMENU_EXITWINDOW
	const QUICKMENU_EXIT
	const QUICKMENU_EXITSCRIPT1
	const QUICKMENU_EXITSCRIPT2

QuickDebug_MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 7, 17
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_ENABLE_LEFT_RIGHT | STATICMENU_ENABLE_START | STATICMENU_WRAP | STATICMENU_CURSOR ; flags
	db 0 ; items
	dw QuickDebug_MenuItems
	dw PlaceNthMenuStrings
	dw QuickDebug_MenuOptions

QuickDebug_MenuOptions:
	dw QuickDebug_CloseOption,       .QuickDebug_Cancel
	dw QuickDebug_NextPageOption,    .QuickDebug_Next
	dw QuickDebug_MinigameOption,    .QuickDebug_Game
	dw QuickDebug_CharacterOption,   .QuickDebug_Character ; unused
	dw QuickDebug_ToolgearOption,    .QuickDebug_Toolgear
	dw QuickDebug_Test1Option,       .QuickDebug_Test1
	dw QuickDebug_Test2Option,       .QuickDebug_Test2
	dw QuickDebug_Test3Option,       .QuickDebug_Test3
	dw QuickDebug_Test4Option,       .QuickDebug_Test4
	dw QuickDebug_RecoverHPOption,   .QuickDebug_Recovery
	dw QuickDebug_WarpOption,        .QuickDebug_Warp
	dw QuickDebug_PCOption,          .QuickDebug_PC
	dw QuickDebug_OTIDOption,        .QuickDebug_Experiment
	dw QuickDebug_BuildOption,       .QuickDebug_Build
	dw QuickDebug_TimerOption,       .QuickDebug_Timer
	dw QuickDebug_ElevatorOption,    .QuickDebug_Elevator
	dw QuickDebug_RecordOption,      .QuickDebug_Record ; unused
	dw QuickDebug_ItemOption,        .QuickDebug_Item
	dw QuickDebug_BugCatchingOption, .QuickDebug_BugCatching ; unused
	dw QuickDebug_BreedingOption,    .QuickDebug_Breeding
	dw QuickDebug_HatchOption,       .QuickDebug_Hatch

.QuickDebug_Cancel:      db "とじる@" ; Cancel
.QuickDebug_Game:        db "ゲーム@" ; Game
.QuickDebug_Warp:        db "ワープ@" ; Warp
.QuickDebug_Test1:       db "テスト1@" ; Test 1
.QuickDebug_Test2:       db "テスト2@" ; Test 2
.QuickDebug_Test3:       db "テスト3@" ; Test 3
.QuickDebug_Test4:       db "テスト4@" ; Test 4
.QuickDebug_Recovery:    db "かいふく@" ; Recovery
.QuickDebug_Next:        db "つぎ▶@" ; Next
.QuickDebug_PC:          db "パソコン@" ; PC
.QuickDebug_Character:   db "キャラ@" ; Character
.QuickDebug_Toolgear:    db "ツールギア@" ; Toolgear
.QuickDebug_Experiment:  db "じっけん@" ; Experiment​ (OT ID Editor)
.QuickDebug_Build:       db "つくる@" ; Build a Pokemon
.QuickDebug_Elevator:    db "フロア@" ; Floor
.QuickDebug_Egg:         db "たまご@" ; Egg
.QuickDebug_Record:      db "きろく@" ; Record
.QuickDebug_Timer:       db "タイマー@" ; Timer
.QuickDebug_Item:        db "どうぐ@" ; Item
.QuickDebug_BugCatching: db "むしとり@" ; Bug Catching
.QuickDebug_Breeding:    db "こづくり@" ; Breeding
.QuickDebug_Hatch:       db "うまれる@" ; Hatch

QuickDebug_MenuItems:
; First Page
	db 7
	db DEBUG_NEXT
	db DEBUG_WARP
	db DEBUG_BREEDING
	db DEBUG_BUILD
	db DEBUG_TOOLGEAR
	db DEBUG_PC
	db DEBUG_CANCEL
	db -1 ; end

; Second Page
	db 7
	db DEBUG_NEXT
	db DEBUG_ITEM
	db DEBUG_RECOVERY
	db DEBUG_EXPERIMENT
	db DEBUG_GAME
	db DEBUG_TIMER
	db DEBUG_CANCEL
	db -1 ; end

; Third Page
	db 7
	db DEBUG_NEXT
	db DEBUG_TEST1
	db DEBUG_TEST2
	db DEBUG_TEST3
	db DEBUG_TEST4
	db DEBUG_HATCH
	db DEBUG_CANCEL
	db -1 ; end

QuickDebug_Main:
; Overworld Debug Menu
	call RefreshScreen
	ld de, SFX_MENU
	call PlaySFX
	ld hl, QuickDebug_MenuHeader
	call LoadMenuHeader
	ld a, 0
	ld [wWhichIndexSet], a

QuickDebug_Update:
	call UpdateTimePals
	call UpdateSprites
	ld a, [wcfbf]
	ld [wMenuCursorBuffer], a
	call DoNthMenu
	jr c, .exit_menu_window
; Player made selection
	ld a, [wMenuCursorBuffer]
	ld [wcfbf], a
	call PlaceHollowCursor
; Run selected option if A_BUTTON is pressed
	ld a, [wMenuJoypad]
	cp A_BUTTON
	jr z, .RunSelectedOption
; Either D_RIGHT or D_LEFT was pressed, switch page
	call QuickDebug_SwitchPage
	jr .MenuAction

.RunSelectedOption:
	ld a, [wMenuSelection]
	ld hl, QuickDebug_MenuOptions
	call MenuJumptable

.MenuAction:
	ld hl, .Jumptable
	rst JumpTable
	ret

.Jumptable:
	dw QuickDebug_Update
	dw .exit_menu_window
	dw .exit_menu
	dw .exit_menu_after_script
	dw .exit_menu_before_script

.exit_menu_window
	call CloseWindow

.exit_menu
	push af
	call CloseText
	pop af
	ret

.exit_menu_after_script:
	call ExitMenu
	ld a, HMENURETURN_SCRIPT
	ldh [hMenuReturn], a
	jr .exit_menu

.exit_menu_before_script:
	call ExitMenu
	ld hl, wQueuedScriptAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wQueuedScriptBank]
	rst FarCall
	ld a, HMENURETURN_SCRIPT
	ldh [hMenuReturn], a
	jr .exit_menu

QuickDebug_CloseOption:
	ld a, QUICKMENU_EXITWINDOW
	ret

QuickDebug_SwitchPage:
	ld a, [wMenuJoypad]
	cp D_LEFT
	jr z, .decrement_page

	ld a, [wWhichIndexSet]
	inc a
	cp 3
	jr nz, .not_max
	xor a
.not_max
	ld [wWhichIndexSet], a
	jr QuickDebug_ChangePageSFX

.decrement_page
	ld a, [wWhichIndexSet]
	dec a
	cp -1
	jr nz, .not_min
	ld a, 2
.not_min
	ld [wWhichIndexSet], a
	jr QuickDebug_ChangePageSFX

QuickDebug_NextPageOption:
; It is impossible to switch to the third page using this function.
	ld a, [wWhichIndexSet]
	and a
	jr z, .second_page
	xor a
	jr .first_page

.second_page
	ld a, 1

.first_page
	ld [wWhichIndexSet], a

QuickDebug_ChangePageSFX:
	ld de, SFX_MENU
	call PlaySFX
	ld a, QUICKMENU_UPDATE
	ret

QuickDebug_TextboxWaitAorB:
	call MenuTextbox
	ld a, A_BUTTON | B_BUTTON
	call .Joypad
	call CloseWindow
	ret

.Joypad:
	push bc
	ld b, a
.loop
	call GetJoypad
	ldh a, [hJoyPressed]
	and b
	jr z, .loop
	pop bc
	ret

QuickDebug_Unavailable:
	ld hl, .FeatureCurrentlyUnavailableText
	call MenuTextboxBackup
	ret

.FeatureCurrentlyUnavailableText:
; "This feature is currently unavailable"
	text "げんざい このきのうは"
	line "つかうことが できません"
	prompt

QuickDebug_ItemOption:
	call LoadStandardMenuHeader
	call DebugItem_LoadDefaultItem
.loop
	call DebugItem_Main
	jr nc, .loop
; B was pressed
	call ExitMenu
	ld a, QUICKMENU_UPDATE
	ret

DebugItem_LoadDefaultItem:
	ld a, 1
	ld [wDebugItem], a
	ld [wDebugItemQuantity], a
	ret

DebugItem_Main:
.loop
	call DebugItem_PrintTextbox
	call WaitBGMap
	call DebugItem_Joypad
	ret c ; Pressing B sets carry
	jr z, .loop
; Pressing A unsets the zero flag
; Place selected item into Bag
	ld a, [wDebugItem]
	and a
	ret z
	call DebugItem_GiveSelectedItem
	and a
	ret

DebugItem_GiveSelectedItem:
	ld hl, wNumItems
; Load selected item
	ld a, [wDebugItem]
	ld [wCurItem], a
; Load selected item quantity
	ld a, [wDebugItemQuantity]
	ld [wItemQuantityChangeBuffer], a
	call ReceiveItem
	jr c, .success
; Failed to receive item
	ld hl, .CantPlaceItemText
	call MenuTextboxWaitButton
	ret

.success
	ld de, SFX_FULL_HEAL
	call PlaySFX
	ld hl, .PlacedItemText
	call MenuTextboxWaitButton
	ret

.CantPlaceItemText:
; "That item can't be put in the PACK."
	text "どうぐを りュックに"
	line "いれられません!"
	done

.PlacedItemText:
 ; "The [wStringBuffer1] was put in the PACK."
	text_ram wStringBuffer1
	text "を "
	line "リュックにいれました"
	done

DebugItem_Joypad:
.joypad_loop
	call JoyTextDelay_ForcehJoyDown
	ld a, c
; DPAD
	bit D_UP_F, a
	jr nz, .increment_item
	bit D_DOWN_F, a
	jr nz, .decrement_item
	bit D_LEFT_F, a
	jr nz, .decrement_quantity
	bit D_RIGHT_F, a
	jr nz, .increment_quantity
; BUTTONS
	bit B_BUTTON_F, a
	jr nz, .exit
	bit A_BUTTON_F, a
	jr nz, .receive_item
; LOOP
	jr .joypad_loop

.increment_item:
	ld hl, wDebugItem
	ld a, [hl]
	cp NUM_TOTAL_ITEMS
	jr z, .max
	inc [hl]
	xor a
	ret

.max
	ld [hl], 1
	xor a
	ret

.decrement_item:
	ld hl, wDebugItem
	ld a, [hl]
	cp 1
	jr z, .min
	dec [hl]
	xor a
	ret

.min
	ld [hl], NUM_TOTAL_ITEMS
	xor a
	ret

.decrement_quantity:
	ld hl, wDebugItemQuantity
	dec [hl]
	jr nz, .above_0
	ld [hl], MAX_ITEM_STACK
.above_0
	xor a
	ret

.increment_quantity:
	ld hl, wDebugItemQuantity
	inc [hl]
; BUG: Item quantity is never loaded into 'a', and the initial value
; means that the quantity can be always be incremented (even past 99!)
	cp MAX_ITEM_STACK + 1
	jr c, .below_100
	ld [hl], 1
.below_100
	xor a
	ret

.exit
	scf
	ret

.receive_item
	ld a, 1
	and a
	ret

DebugItem_PrintTextbox:
	ld hl, wOptions
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	ldh a, [hBGMapMode]
	push af
	xor a
	ldh [hBGMapMode], a
; Get the name of the selected item
	ld a, [wDebugItem]
	ld [wNamedObjectIndexBuffer], a
	call GetItemName
; Print the data into a textbox
	ld hl, .ItemNameAndQuantityText
	call PrintText
	pop af
	ldh [hBGMapMode], a
	pop af
	ld [wOptions], a
	ret

.ItemNameAndQuantityText:
	text "ばんごう@" ; Number
	text_decimal wDebugItem, 1, 3
	text_start
	line "@"
	text_ram wStringBuffer1
	text "  ×@"
	text_decimal wDebugItemQuantity, 1, 2
	text_end

QuickDebug_BugCatchingOption:
	ld hl, .RemainingTimeText
	call MenuTextbox
.update:
	call UpdateTime
	farcall CheckBugContestTimer

; Print minutes
	hlcoord 5, 16
	ld de, wBugContestMinsRemaining
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNum
; Print seconds
	hlcoord 8, 16
	ld de, wBugContestSecsRemaining
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNum
	call WaitBGMap

; Continually update until A or B is pressed
	call GetJoypad
	ldh a, [hJoyPressed]
	and A_BUTTON | B_BUTTON
	jr z, .update
; Exit
	call ExitMenu
	ld a, QUICKMENU_UPDATE
	ret

.RemainingTimeText:
; "Remaining Time"
	text "たいかい のこりじかん"
	done

QuickDebug_CharacterOption:
; Dummied out
	ld a, QUICKMENU_UPDATE
	ret

QuickDebug_ToolgearOption:
	call DebugToolgear_DisplayMenu
	jr c, .return
; Get pointer from selection
	ld a, [wMenuCursorY]
	dec a
	ld hl, .JumpTable
	rst JumpTable
	ret

.JumpTable:
	dw .ShowClock       ; Clock
	dw .ShowCoordinates ; Coordinates
	dw .AdjustTime      ; Adjust
	dw .asm_4893        ; 60 Seconds
	dw .asm_489a        ; 24 Hours
	dw .RemoveHUD       ; Erase

.return
	ld a, QUICKMENU_UPDATE
	ret

.asm_4893:
; Supposedly will make a day to night to darkness transition every 60 seconds.
	ld hl, wDebugToolgearStatus
	set 7, [hl]
	jr .UpdateTimePals

.asm_489a:
	ld hl, wDebugToolgearStatus
	res 7, [hl]
	jr .UpdateTimePals

.AdjustTime:
	farcall DebugClockMenu_Overworld

.UpdateTimePals:
	farcall FadeOutPalettes
	farcall UpdateTimeOfDayPal
	ld b, SCGB_MAPPALS
	call GetSGBLayout
	farcall FadeInPalettes
	call UpdateTimePals
	ld a, QUICKMENU_EXITWINDOW
	ret

.ShowClock:
	call Function1e7c
	ld hl, wDebugToolgearStatus
	res 0, [hl]
	ld a, QUICKMENU_EXITWINDOW
	ret

.RemoveHUD:
	call Function1e82
	ld a, QUICKMENU_EXITWINDOW
	ret

.ShowCoordinates:
	call .show ; Useless call
	ld a, QUICKMENU_EXITWINDOW
	ret

.show
	call Function1e7c
	ld hl, wDebugToolgearStatus
	set 0, [hl]
	ret

DebugToolgear_DisplayMenu:
	ld hl, DebugToolgear_MenuHeader
	call LoadMenuHeader
	call .PlaceCursor
	ld [wMenuCursorBuffer], a
	call VerticalMenu
	call CloseWindow
	ret

.PlaceCursor:
; Place cursor at 3rd option if Toolgear HUD is displayed
	ld a, [wd558]
	bit 0, a
	ld a, 3
	ret nz
; Place cursor at 1st option if coordinates are displayed
	ld hl, wDebugToolgearStatus
	bit 0, [hl]
	ld a, 1
	ret nz
; Place cursor at 2nd option otherwise
	ld a, 2
	ret

DebugToolgear_MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 7, 14
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 6 ; items
	db "とけい@" ; Clock
	db "ざひょう@" ; Coordinates
	db "アジャスト@" ; Adjust
	db "60びょう@" ; 60 Seconds
	db "24じかん@" ; 24 Hours
	db "けす@" ; Erase

QuickDebug_RecoverHPOption:
	predef HealParty
	ld hl, .MonsHPWasHealedText
	call MenuTextboxBackup
	ld a, QUICKMENU_UPDATE
	ret

.MonsHPWasHealedText:
; "Your #MON's HP was healed."
	text "#の たいりょくを"
	line "かいふくしました"
	prompt

QuickDebug_WarpOption:
	xor a
	ldh [hMapAnims], a
	call LoadStandardMenuHeader
	call ClearSprites
; Show first party mon's icon, whether or not it knows Fly
	ld a, 0
	ld [wCurPartyMon], a
	farcall EntireFlyMap
	ld a, e
	ld [wMenuSelection], a
	call CloseSubmenu
	ld a, [wMenuSelection]
	cp -1
	jr z, .return
	ld a, [wMenuSelection]
	cp -1
	jr z, .return
	cp $1c
	jr nc, .return
	ld [wDefaultSpawnpoint], a
	ld hl, wVramState
	set 6, [hl]
	ldh a, [hROMBank]
	ld hl, DebugWarp_Main
	call FarQueueScript
	ld de, SFX_ELEVATOR_END
	call PlaySFX
	call DelayFrame
	ld a, QUICKMENU_EXITSCRIPT2
	ret

.return
	ld a, QUICKMENU_UPDATE
	ret

DebugWarp_MenuHeader:
	db MENU_BACKUP_TILES ; flags
	db 01, 01 ; start coords
	db 10, 11 ; end coords
	dw .MenuData
	db 1 ; default option

.MenuData:
	db 0 ; flags
	db 4, 0 ; rows, columns
	db 1 ; spacing
	dba .DestinationMaps
	dba .SelectDestination
	dba NULL
	dba NULL

.SelectDestination:
	push de
	ld a, [wMenuSelection]
	call .GetDestinationName
	pop hl
	call PlaceString
	ret

.GetDestinationName:
	ld hl, .DestinationNames
	call GetNthString
	ld d, h
	ld e, l
	ret

.DestinationNames:
	db "じぶんのうち@" ; My home
	db "マサラ@" ; Pallet Town
	db "トキワ@" ; Viridian City
	db "ニビ@" ; Pewter City
	db "ハナダ@" ; Cerulean City
	db "イワヤマトンネルまえ@" ; Rock Tunnel Entrance
	db "クチバ@" ; Vermilion City
	db "シオン@" ; Lavender Town
	db "ヤマブキ@" ; Saffron City
	db "タマムシ@" ; Celadon City
	db "セキチク@" ; Fuchsia City
	db "グレン@" ; Cinnabar Island

	db "ワカバ@" ; New Bark Town
	db "ヨシノ@" ; Cherrygrove City
	db "キキョウ@" ; Violet City
	db "ヒワダ@" ; Azalea Town
	db "タンバ@" ; Cianwood City
	db "コガネ@" ; Goldenrod City
	db "アサギ@" ; Olivine City
	db "エンジュ@" ; Ecruteak City
	db "チョウジ@" ; Mahogany Town
	db "イカりの みずうみ@" ; Lake of Rage
	db "フスべ@" ; Blackthorn City
	db "シロガネ@" ; Mt. Silver

.DestinationMaps:
	db SPAWN_NEW_BARK, SPAWN_CHERRYGROVE, SPAWN_VIOLET, SPAWN_AZALEA, SPAWN_CIANWOOD, SPAWN_GOLDENROD
	db SPAWN_OLIVINE, SPAWN_ECRUTEAK, SPAWN_MAHOGANY, SPAWN_LAKE_OF_RAGE, SPAWN_BLACKTHORN, SPAWN_MT_SILVER

	db SPAWN_PALLET, SPAWN_VIRIDIAN, SPAWN_PEWTER, SPAWN_CERULEAN, SPAWN_ROCK_TUNNEL, SPAWN_VERMILION
	db SPAWN_LAVENDER, SPAWN_SAFFRON, SPAWN_CELADON, SPAWN_FUCHSIA, SPAWN_CINNABAR

	db -1

DebugWarp_Main:
	call DebugWarp_Textbox
	ldh a, [hROMBank]
	ld hl, DebugWarp_TeleportScript
	call FarQueueScript
	ret

DebugWarp_Textbox:
	ld hl, .WarpText
	call QuickDebug_TextboxWaitAorB
	ret

.WarpText:
; "Warping…"
	text "ワープします!"
	done

DebugWarp_TeleportScript:
	applymovement PLAYER, .TeleportFrom
	newloadmap MAPSETUP_TELEPORT
	applymovement PLAYER, .TeleportTo
	end

.TeleportFrom:
	teleport_from
	step_end

.TeleportTo:
	teleport_to
	step_end

QuickDebug_OTIDOption:
	call LoadStandardMenuHeader
	call OTID_Init
	call CloseWindow
	ld a, QUICKMENU_UPDATE
	ret

QuickDebug_TestPackAndPokegear: ; unreferenced
; Dummied out code
; Presumbly used to test the Pack and Pokegear before the start menu was implemented
	ld a, QUICKMENU_UPDATE
	ret

OTID_Init:
; Clear OT ID input buffer
	ld hl, wStringBuffer2
	ld bc, 5
	xor a
	call ByteFill
; Set default cursor position to last digit
	ld a, 4
	ld [wStringBuffer2 + 5], a
; Print message
	ld hl, NumberToChangeText
	call PrintText

.InitInputArea:
	call OTID_UpdateInputArea

.ReadJoypad:
	call JoyTextDelay
	ldh a, [hJoyLast]
	ld b, a
	and A_BUTTON
	jr nz, .exit
	ld a, b
	and D_PAD
	jr z, .ReadJoypad
	call OTID_InterpretJoypad

	ld c, 3
	call DelayFrames
	jr .InitInputArea

.exit
	call OTID_ConvertToHex
	ld a, h
	ld [wPartyMon1ID], a
	ld a, l
	ld [wPartyMon1ID + 1], a
	ret

NumberToChangeText:
; “Which number should be changed?”
	text "へんこうするナンバーを"
	line "してい してください"
	done

OTID_UpdateInputArea:
; Convert digit to character
	hlcoord 14, 15
	ld de, wStringBuffer2
	ld c, 5
.outputDigit
	ld a, [de]
	add "0"
	ld [hli], a
	inc de
	dec c
	jr nz, .outputDigit

; Clear the cursor area
	hlcoord 14, 16
	ld bc, 5
	ld a, " "
	call ByteFill
; Display cursor
	hlcoord 14, 16
	ld a, [wStringBuffer2 + 5]
	ld e, a
	ld d, 0
	add hl, de
	ld [hl], "▲"
	ret

OTID_InterpretJoypad:
	ld a, b
	and D_LEFT
	jr nz, .pressed_left
	ld a, b
	and D_RIGHT
	jr nz, .pressed_right
	ld a, b
	and D_UP
	jr nz, .increment_digit
	ld a, b
	and D_DOWN
	jr nz, .decrement_digit
	ret

.pressed_left
	ld a, [wStringBuffer2 + 5]
	; Are we on the left-most digit?
	and a
	ret z
	; Nope, let's move left.
	dec a
	ld [wStringBuffer2 + 5], a
	ret

.pressed_right
	ld a, [wStringBuffer2 + 5]
	cp 4
	ret z
	inc a
	ld [wStringBuffer2 + 5], a
	ret

.increment_digit
	call OTID_GetDigitLocation
	ld a, [hl]
	cp 9
	jr z, .max
	inc a
	ld [hl], a
	ret

.max
	ld [hl], 0
	ret

.decrement_digit
	call OTID_GetDigitLocation
	ld a, [hl]
	and a
	jr z, .min
	dec a
	ld [hl], a
	ret

.min
	ld [hl], 9
	ret

OTID_GetDigitLocation:
	ld a, [wStringBuffer2 + 5]
	ld e, a
	ld d, 0
	ld hl, wStringBuffer2
	add hl, de
	ret

OTID_ConvertToHex:
	ld hl, 0
	ld de, wStringBuffer2 + 4
	ld bc, 1
	call .convertDigit
	ld bc, 10
	call .convertDigit
	ld bc, 100
	call .convertDigit
	ld bc, 1000
	call .convertDigit
	ld bc, 10000
; fallthrough

.convertDigit:
	ld a, [de]
	dec de
	push hl
	ld hl, 0
	call AddNTimes
	ld c, l
	ld b, h
	pop hl
	add hl, bc
	ret

QuickDebug_BuildOption:
	call LoadStandardMenuHeader
	farcall unk_03f_57e6
	call CloseWindow
	ld a, QUICKMENU_UPDATE
	ret

QuickDebug_PCOption:
	farcall PokemonCenterPC
	ld a, QUICKMENU_UPDATE
	ret

QuickDebug_ElevatorOption:
	call DebugElevator
	ld a, QUICKMENU_UPDATE
	ret

DebugElevator:
	ld b, BANK(DebugElevator_FloorData)
	ld de, DebugElevator_FloorData
	farcall Elevator
	ret

DebugElevator_FloorData:
	db 6 ; floors
	elevfloor FLOOR_6F, 2, CELADON_DEPT_STORE_6F
	elevfloor FLOOR_5F, 3, CELADON_DEPT_STORE_5F
	elevfloor FLOOR_4F, 3, CELADON_DEPT_STORE_4F
	elevfloor FLOOR_3F, 3, CELADON_DEPT_STORE_3F
	elevfloor FLOOR_2F, 3, CELADON_DEPT_STORE_2F
	elevfloor FLOOR_1F, 4, CELADON_DEPT_STORE_1F
	db -1 ; end

QuickDebug_MinigameOption:
	call ChooseMinigame
	ld a, QUICKMENU_UPDATE
	ret

ChooseMinigame:
; Load minigame selection menu
	ld hl, DebugGame_MenuHeader
	call LoadMenuHeader
	call VerticalMenu ; Wait for either A or B to be pressed
; Save flags for B button
	push af
	call LoadSelectedMinigame
	pop af
	call CloseWindow
	ret c ; pressed B
; Make sure the tester didn't misclick
	ld hl, DebugGame_WantToPlayText
	call MenuTextbox
	call YesNoBox
	call CloseWindow
	ret c ; pressed B
; Confirmed, play the selected minigame
	call FadeToMenu
	ld hl, wQueuedScriptBank
	call CallPointerAt
	call CloseSubmenu
	ret

LoadSelectedMinigame:
; Get the currently selected name
	ld a, [wMenuCursorY]
	dec a
	call CopyNameFromMenu
; Get pointer to minigame based off of selection
	ld a, [wMenuCursorY]
	dec a
	ld e, a
	ld d, 0
	ld hl, DebugGame_PointerTable
	add hl, de
	add hl, de
	add hl, de
; Load that into the queued script
	ld a, [hli]
	ld [wQueuedScriptBank], a
	ld a, [hli]
	ld [wQueuedScriptAddr], a
	ld a, [hl]
	ld [wQueuedScriptAddr + 1], a
	ret

DebugGame_MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 10, 10
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 3 ; items
	db "スロットマシン@"  ; Slot Machine
	db "ポーカーゲーム@" ; Poker Game (Card Flip)
	db "ぺアゲーム@"    ; Pair Game
	db "ピクロス@"      ; Picross (Unused)

DebugGame_PointerTable:
	dba _SlotMachine ; Slot Machine
	dba _CardFlip    ; Poker Game (Card Flip)
	dba _MemoryGame  ; Pair Game

DebugGame_WantToPlayText:
; "Do you want to play [wStringBuffer2]?"
	text_ram wStringBuffer2
	text "で "
	line "あそびますか?"
	done

QuickDebug_TimerOption:
	call FadeToMenu
	farcall BlankScreen
	farcall DebugClockMenu
	call CloseSubmenu
	ld a, QUICKMENU_UPDATE
	ret

QuickDebug_RecordOption:
	ld hl, .MonCounterAndTimerText
	call MenuTextbox
; Print RTC status flags to textbox
	ld a, BANK(sRTCStatusFlags)
	call OpenSRAM
	ld a, [sRTCStatusFlags]
	call CloseSRAM
	hlcoord 2, 16
	call QuickDebug_PrintRTCStatus
; Wait for button press
	call PromptButton
; Exit
	call CloseWindow
	ld a, QUICKMENU_UPDATE
	ret

.MonCounterAndTimerText:
; "Number of times I've fought a wild Pokémon: [wWildPokemonCounter]"
	text "やせいの#とたたかった"
	line "かいすう @"
	text_decimal wWildPokemonCounter, 2, 5
	text "かい"

	para "タイマーのステータス" ; Timer status
	; Print binary number here
	done

QuickDebug_PrintRTCStatus:
; Display sRTCStatusFlags as an 8 bit binary number
	push bc
	ld c, a
	ld b, 8
.print_digit
	sla c
	ld a, "0"
	jr nc, .no_overflow
	inc a
.no_overflow
	ld [hli], a
	dec b
	jr nz, .print_digit
	pop bc
	ret

QuickDebug_BreedingOption:
; Check if either slot in the daycare is free
	ld a, [wDayCareMan]
	bit DAYCAREMAN_HAS_MON_F, a
	jr z, .need_two_mons
	ld a, [wDayCareLady]
	bit DAYCARELADY_HAS_MON_F, a
	jr z, .need_two_mons
; Check compatibility
	farcall CheckBreedmonCompatibility
	ld a, [wBreedingCompatibility]
	and a
	jr z, .incompatible
	cp -1
	jr z, .incompatible
; Deciding time
	ld hl, .CompatibilityShouldTheyBreedText
	call MenuTextbox
	call YesNoBox
	call ExitMenu
	jr c, .return
	call SetDayCareEggFlags
.return
	ld a, QUICKMENU_UPDATE
	ret

.need_two_mons:
	ld hl, .YouNeedTwoMonForBreedingText
	call MenuTextboxBackup
	ld a, QUICKMENU_UPDATE
	ret

.YouNeedTwoMonForBreedingText:
; "You need two #MON for breeding"
	text "2たい いないので"
	line "こづくり できません"
	prompt

.incompatible
	ld hl, .BreedingIsNotPossibleText
	call MenuTextboxBackup
	ld a, QUICKMENU_UPDATE
	ret

.BreedingIsNotPossibleText:
; "Breeding is not possible"
	text "こづくりできません"
	prompt

.CompatibilityShouldTheyBreedText:
; "The compatibility is [wBreedingCompatibility]"
; "Should they breed?"
	text "あいしょう @"
	text_decimal wBreedingCompatibility, 1, 3
	text "です"
	line "こづくり しますか?"
	done

SetDayCareEggFlags:
	ld hl, wDayCareMan
	res DAYCAREMAN_MONS_COMPATIBLE_F, [hl]
	set DAYCAREMAN_HAS_EGG_F, [hl]
	ret

QuickDebug_HatchOption:
	call SetEggToHatch
	jr c, .success

; Didn't find any Eggs to set...
	ld hl, .NoEggsText
	call MenuTextboxBackup
	ld a, QUICKMENU_UPDATE
	ret

.success
	ld hl, .HatchText
	call MenuTextboxBackup
	ld a, QUICKMENU_UPDATE
	ret

.NoEggsText:
; "There is no EGG."
	text "タマゴが ない!"
	prompt

.HatchText:
; "It's going to hatch!"
	text "うまれる!"
	prompt

SetEggToHatch:
; Search for the first egg in the party.
; If found, set it to hatch on the next step.
	ld hl, wPartySpecies
	ld c, 0
.partyloop
	ld a, [hli]
	cp -1
	jr z, .terminator
	cp EGG
	jr z, .egg
	inc c
	jr .partyloop

.egg
	ld a, c
	ld bc, PARTYMON_STRUCT_LENGTH
	ld hl, wPartyMon1Happiness
	call AddNTimes
	ld [hl], 1 ; Egg happiness is decremented to 0
	ld a, 127 ; On the next step
	ld [wStepCount], a
	scf
	ret

.terminator
	xor a
	ret

QuickDebug_Test1Option:
	ld a, 1
	ld de, DebugTest_Tutorial
	jr DebugTest_RunScript

QuickDebug_Test2Option:
	ld a, 2
	ld de, DebugTest_HallOfFame
	jr DebugTest_RunScript

QuickDebug_Test3Option:
	ld a, 3
	ld de, DebugTest_Rocket
	jr DebugTest_RunScript

QuickDebug_Test4Option:
	ld a, 4
	ld de, DebugTest_FillPCItems
	jr DebugTest_RunScript

DebugTest_RunScript:
	ld [wStringBuffer2], a
; Confirm selection
	push de
	ld hl, .TestEventText
	call MenuTextbox
	call YesNoBox
	call CloseWindow
	pop de
	jr c, .return
; Queue selected script
	ld h, d
	ld l, e
	ld a, BANK(@)
	call FarQueueScript
	ld a, QUICKMENU_EXITSCRIPT1
	ret

.return
	ld a, QUICKMENU_UPDATE
	ret

.TestEventText:
; "Do you want to test Event [wStringBuffer2]?"
	text "イべント@"
	text_decimal wStringBuffer2, 1, 2
	text "を テストしますか?"
	done

DebugTest_Tutorial:
	sjump DebugTest_TutorialScript

DebugTest_HallOfFame:
	sjump DebugTest_HallOfFameScript

DebugTest_Rocket:
	sjump DebugTest_RocketScripts

DebugTest_FillPCItems:
	sjump DebugTest_FillPCItemsScript

DebugTest_LoadGameHeader:
	opentext
	loadmenu DebugTest_GameHeader

DebugTest_SelectGame:
.loop
	writetext WhichOneToPlayText
	verticalmenu
	ifequal 0, .exit
	scall DebugTest_SelectGameScript
	sjump .loop

.exit
	closewindow
	closetext
	end

DebugTest_SelectGameScript:
	ifequal 1, .UnownPuzzle
	ifequal 2, .SlotMachine
	ifequal 3, .CardFlip
	ifequal 4, .MemoryGame
	ifequal 5, .Picross
	end

.UnownPuzzle:
	special UnownPuzzle
	end

.SlotMachine:
	special SlotMachine
	end

.CardFlip:
	special CardFlip
	end

.MemoryGame:
	special MemoryGame
	end

.Picross:
; Crashes
	special PicrossGame
	reloadmap
	db refreshscreen_command
	end

WhichOneToPlayText:
; "Which one do you want to play?"
	text "どれで あそぶ?"
	done

DebugTest_GameHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 10, 12
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 5 ; # items
	db "15パズル@" ; "15 Puzzle"
	db "スロットマシン@" ; "Slot Machine"
	db "ポーカーゲーム@" ; "Poker Game"
	db "ぺアゲーム@" ; "Pair Game"
	db "ピクロス@" ; "Picross"

DebugTest_TutorialScript:
	loadwildmon RATTATA, 5
	catchtutorial BATTLETYPE_TUTORIAL
	end

DebugTest_HallOfFameScript2:
; unreferenced
	halloffame
	loadmem wSpawnAfterChampion, SPAWN_LANCE
	end

DebugTest_PokedexCompletion:
; unreferenced
	opentext
	special ProfOaksPCBoot
	closetext
	end

DebugTest_GiveAbraEgg:
; unreferenced
	giveegg ABRA, 20
	end

DebugTest_GiveMailSetSwarmScript:
; unreferenced
	opentext
	writetext .YouCanHaveThisText
	verbosegiveitem FLOWER_MAIL, 99
	closetext
	end

.YouCanHaveThisText:
; "You can have this."
	text "これを あげよう"
	prompt
; Set swarm (why?)
	swarm DARK_CAVE_VIOLET_ENTRANCE
	end

DebugTest_HallOfFameScript:
	warpfacing FACING_STEP_DOWN_1, HALL_OF_FAME, 4, 3
	playmusic MUSIC_NONE
	refreshscreen
	setval HEALMACHINE_HALL_OF_FAME
	special HealMachineAnim
	closetext
	halloffame
	end

DebugTest_RocketScripts:
	callstd RadioTowerRocketsScript
	callstd GoldenrodRocketsScript
	end

DebugTest_RocketBase:
	warpfacing FACING_STEP_DOWN_1, TEAM_ROCKET_BASE_B1F, 4, 14
	end

DebugTest_FillPCItemsScript:
	callasm .FillPCItems
	end

.FillPCItems:
; Set max PC items
	ld hl, wNumPCItems
	ld [hl], MAX_PC_ITEMS
; Fill the empty slots with items 1 through 50
	inc hl
	ld a, MASTER_BALL
	ld c, MAX_PC_ITEMS
.load_item
	ld [hli], a
	ld [hl], MAX_ITEM_STACK
	inc hl
	inc a
	dec c
	jr nz, .load_item
	ld [hl], -1 ; terminator
	ret
