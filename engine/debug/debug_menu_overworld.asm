	db 0

QuickDebug_MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 7, 17
	dw .MenuData
	db 1

.MenuData:
	db STATICMENU_ENABLE_LEFT_RIGHT | STATICMENU_ENABLE_START | STATICMENU_WRAP | STATICMENU_CURSOR ; flags
	db 0 ; items
	dw QuickDebug_MenuItems
	dw PlaceNthMenuStrings
	dw unk_03f_4556

	const_def
	const DEBUG_CANCEL ; 0
	const DEBUG_NEXT
	const DEBUG_GAME
	const DEBUG_CHARACTER
	const DEBUG_TOOLGEAR
	const DEBUG_TEST1 ; 5
	const DEBUG_TEST2
	const DEBUG_TEST3
	const DEBUG_TEST4
	const DEBUG_RECOVERY
	const DEBUG_WARP ; 10
	const DEBUG_PC
	const DEBUG_EXPERIMENT
	const DEBUG_BUILD
	const DEBUG_TIMER
	const DEBUG_ELEVATOR ; 15
	const DEBUG_RECORD
	const DEBUG_ITEM
	const DEBUG_BUGCATCHING
	const DEBUG_BREEDING
	const DEBUG_HATCH ; 20

unk_03f_4556:
	dw QuickDebug_CloseOption,       .QuickDebug_Cancel
	dw QuickDebug_NextPageOption,    .QuickDebug_Next
	dw QuickDebug_MinigameOption,    .QuickDebug_Game ; unused
	dw QuickDebug_CharacterOption,   .QuickDebug_Character
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

; Overworld Debug Menu
unk_03f_462a:
	call RefreshScreen
	ld de, SFX_MENU
	call PlaySFX
	ld hl, QuickDebug_MenuHeader
	call LoadMenuHeader
	ld a, 0
	ld [wWhichIndexSet], a

unk_03f_463e:
	call UpdateTimePals
	call UpdateSprites
	ld a, [wcfbf]
	ld [wMenuCursorBuffer], a
	call DoNthMenu
	jr c, unk_03f_467c

	ld a, [wMenuCursorBuffer]
	ld [wcfbf], a
	call PlaceHollowCursor
	ld a, [wMenuJoypad]
	cp 1
	jr z, jr_03f_4664

	call QuickDebug_SwitchPage
	jr jr_03f_466d

jr_03f_4664:
	ld a, [wMenuSelection]
	ld hl, unk_03f_4556
	call MenuJumptable

jr_03f_466d:
	ld hl, unk_03f_4672
	rst JumpTable
	ret

unk_03f_4672:
	dw unk_03f_463e
	dw unk_03f_467c
	dw unk_03f_467f
	dw unk_03f_4685
	dw unk_03f_468e

unk_03f_467c:
	call CloseWindow

unk_03f_467f:
	push af
	call CloseText
	pop af
	ret

unk_03f_4685:
	call ExitMenu
	ld a, $80
	ldh [hMenuReturn], a
	jr unk_03f_467f

unk_03f_468e:
	call ExitMenu
	ld hl, wQueuedScriptAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wQueuedScriptBank]
	rst FarCall
	ld a, $80
	ldh [hMenuReturn], a
	jr unk_03f_467f

QuickDebug_CloseOption:
	ld a, 1
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
	ld a, 0
	ret

Call_03f_46df:
	call MenuTextbox
	ld a, 3
	call Call_03f_46eb
	call CloseWindow
	ret

Call_03f_46eb:
	push bc
	ld b, a
.asm_46ed:
	call GetJoypad
	ldh a, [hJoyPressed]
	and b
	jr z, .asm_46ed
	pop bc
	ret

unk_03f_46f7:
	ld hl, .unkData_03f_46fe
	call MenuTextboxBackup
	ret

.unkData_03f_46fe:
	text "げんざい このきのうは"
	line "つかうことが できません"
	prompt

QuickDebug_ItemOption:
	call LoadStandardMenuHeader
	call Call_03f_4729
.asm_471e:
	call Call_03f_4732
	jr nc, .asm_471e
	call ExitMenu
	ld a, 0
	ret

Call_03f_4729:
	ld a, 1
	ld [wDebugItem], a
	ld [wDebugItemQuantity], a
	ret

Call_03f_4732:
.loop
	call Call_03f_47ef
	call WaitBGMap
	call Call_03f_4797
	ret c
	jr z, .loop

	ld a, [wDebugItem]
	and a
	ret z
	call Call_03f_4748
	and a
	ret

Call_03f_4748:
	ld hl, wNumItems
	ld a, [wDebugItem]
	ld [wCurItem], a
	ld a, [wDebugItemQuantity]
	ld [wItemQuantityChangeBuffer], a
	call ReceiveItem
	jr c, .asm_4763

	ld hl, .unkData_03f_4770
	call MenuTextboxWaitButton
	ret

.asm_4763:
	ld de, SFX_FULL_HEAL
	call PlaySFX
	ld hl, .unkData_03f_4785
	call MenuTextboxWaitButton
	ret

.unkData_03f_4770:
	text "どうぐを りュックに"
	line "いれられません!"
	done

.unkData_03f_4785:
	text_ram wStringBuffer1
	text "を "
	line "りュックにいれました"
	done

Call_03f_4797:
.loop:
	call JoyTextDelay_ForcehJoyDown
	ld a, c
	bit 6, a
	jr nz, jr_03f_47b5
	bit 7, a
	jr nz, jr_03f_47c4
	bit 5, a
	jr nz, jr_03f_47d3
	bit 4, a
	jr nz, jr_03f_47dd
	bit 1, a
	jr nz, jr_03f_47e9
	bit 0, a
	jr nz, jr_03f_47eb
	jr .loop

jr_03f_47b5:
	ld hl, wDebugItem
	ld a, [hl]
	cp $fb
	jr z, jr_03f_47c0

	inc [hl]
	xor a
	ret

jr_03f_47c0:
	ld [hl], 1
	xor a
	ret

jr_03f_47c4:
	ld hl, wDebugItem
	ld a, [hl]
	cp $01
	jr z, jr_03f_47cf
	dec [hl]
	xor a
	ret

jr_03f_47cf:
	ld [hl], $fb
	xor a
	ret

jr_03f_47d3:
	ld hl, wDebugItemQuantity
	dec [hl]
	jr nz, jr_03f_47db
	ld [hl], $63
jr_03f_47db:
	xor a
	ret

jr_03f_47dd:
	ld hl, wDebugItemQuantity
	inc [hl]
	cp $64
	jr c, jr_03f_47e7
	ld [hl], 1
jr_03f_47e7:
	xor a
	ret

jr_03f_47e9:
	scf
	ret

jr_03f_47eb:
	ld a, 1
	and a
	ret

Call_03f_47ef:
	ld hl, wOptions
	ld a, [hl]
	push af
	set 4, [hl]
	ldh a, [hBGMapMode]
	push af
	xor a
	ldh [hBGMapMode], a
	ld a, [wDebugItem]
	ld [wd143], a
	call GetItemName
	ld hl, .unkData_03f_4813
	call PrintText
	pop af
	ldh [hBGMapMode], a
	pop af
	ld [wOptions], a
	ret

.unkData_03f_4813:
	text "ばんごう@" ; Number
	text_decimal wDebugItem, 1, 3
	text ""
	line "@"
	text_ram wStringBuffer1
	text "  ×@"
	text_decimal wDebugItemQuantity, 1, 2
	text_end

QuickDebug_BugCatchingOption:
	ld hl, .RemainingTimeText
	call MenuTextbox
.asm_4833:
	call UpdateTime
	farcall CheckBugContestTimer
	hlcoord 5, 16
	ld de, wBugContestMinsRemaining
	lb bc, $81, 2
	call PrintNum
	hlcoord 8, 16
	ld de, wBugContestSecsRemaining
	lb bc, $81, 2
	call PrintNum
	call WaitBGMap
	call GetJoypad
	ldh a, [hJoyPressed]
	and 3
	jr z, .asm_4833
	call ExitMenu
	ld a, 0
	ret

.RemainingTimeText:
	text "たいかい のこりじかん"
	done

QuickDebug_CharacterOption:
	ld a, 0
	ret

QuickDebug_ToolgearOption:
	call Call_03f_48e4
	jr c, .asm_4890
	ld a, [wMenuCursorY]
	dec a
	ld hl, .unkData_03f_4884
	rst JumpTable
	ret

.unkData_03f_4884:
	dw unk_03f_48c4
	dw unk_03f_48d5
	dw unk_03f_48a1
	dw unk_03f_4893
	dw unk_03f_489a
	dw unk_03f_48cf

.asm_4890:
	ld a, 0
	ret

unk_03f_4893:
	ld hl, wd55c
	set 7, [hl]
	jr jr_03f_48a7

unk_03f_489a:
	ld hl, wd55c
	res 7, [hl]
	jr jr_03f_48a7

unk_03f_48a1:
	farcall DebugClockMenu_Overworld

jr_03f_48a7:
	farcall unk_023_440e
	farcall unk_023_43b9
	ld b, 9
	call GetSGBLayout
	farcall unk_023_4403
	call UpdateTimePals
	ld a, 1
	ret

unk_03f_48c4:
	call Function1e7c
	ld hl, wd55c
	res 0, [hl]
	ld a, 1
	ret

unk_03f_48cf:
	call Function1e82
	ld a, 1
	ret

unk_03f_48d5:
	call Call_03f_48db
	ld a, 1
	ret

Call_03f_48db:
	call Function1e7c
	ld hl, wd55c
	set 0, [hl]
	ret

Call_03f_48e4:
	ld hl, MenuHeader_03f_490a
	call LoadMenuHeader
	call Call_03f_48f7
	ld [wMenuCursorBuffer], a
	call VerticalMenu
	call CloseWindow
	ret

Call_03f_48f7:
	ld a, [wEnteredMapFromContinue]
	bit 0, a
	ld a, 3
	ret nz
	ld hl, wd55c
	bit 0, [hl]
	ld a, 1
	ret nz
	ld a, 2
	ret

MenuHeader_03f_490a:
	db MENU_BACKUP_TILES ; flags
	db 0, 0, 14, 7
	dw MenuData_03f_4912
	db 1 ; default option

MenuData_03f_4912:
	db STATICMENU_CURSOR ; flags
	db 6
	db "とけい@" ; Clock
	db "ざひょう@" ; Coordinates
	db "アジャスト@" ; Adjust
	db "60びょう@" ; 60 Seconds
	db "24じかん@" ; 24 Hours
	db "けす@" ; Erase

QuickDebug_RecoverHPOption:
	ld a, 2
	call Predef
	ld hl, unkData_03f_4940
	call MenuTextboxBackup
	ld a, 0
	ret

unkData_03f_4940:
	text "#の たいりょくを"
	line "かいふくしました"
	prompt

QuickDebug_WarpOption:
	xor a
	ldh [hMapAnims], a
	call LoadStandardMenuHeader
	call ClearSprites
	ld a, 0
	ld [wCurPartyMon], a
	farcall unk_024_6398
	ld a, e
	ld [wMenuSelection], a
	call CloseSubmenu
	ld a, [wMenuSelection]
	cp -1
	jr z, .asm_499d
	ld a, [wMenuSelection]
	cp -1
	jr z, .asm_499d
	cp $1c
	jr nc, .asm_499d
	ld [wDefaultSpawnpoint], a
	ld hl, wVramState
	set 6, [hl]
	ldh a, [hROMBank]
	ld hl, unk_03f_4a5b
	call FarQueueScript
	ld de, SFX_ELEVATOR_END
	call PlaySFX
	call DelayFrame
	ld a, 4
	ret

.asm_499d:
	ld a, 0
	ret

unkData_03f_49a0:
	db MENU_BACKUP_TILES ; flags
	db 01, 01 ; start coords
	db 10, 11 ; end coords
	dw MenuData_03f_49a8
	db 1 ; default option

MenuData_03f_49a8:
	db 0 ; flags
	db 4, 0 ; rows, columns
	db 1 ; spacing
	dba unkData_03f_4a43
	dba unk_03f_49b8
	; placeholders
	db $00
	dw $0000
	db $00
	dw $0000

unk_03f_49b8:
	push de
	ld a, [wMenuSelection]
	call Call_03f_49c4
	pop hl
	call PlaceString
	ret

Call_03f_49c4:
	ld hl, unkData_03f_49cd
	call GetNthString
	ld d, h
	ld e, l
	ret

; Warp destinations
unkData_03f_49cd:
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

unkData_03f_4a43:
	db SPAWN_NEW_BARK, SPAWN_CHERRYGROVE, SPAWN_VIOLET, SPAWN_AZALEA, SPAWN_CIANWOOD, SPAWN_GOLDENROD, SPAWN_OLIVINE, SPAWN_ECRUTEAK, SPAWN_MAHOGANY, SPAWN_LAKE_OF_RAGE, SPAWN_BLACKTHORN, SPAWN_MT_SILVER

	db SPAWN_PALLET, SPAWN_VIRIDIAN, SPAWN_PEWTER, SPAWN_CERULEAN, SPAWN_ROCK_TUNNEL, SPAWN_VERMILION, SPAWN_LAVENDER, SPAWN_SAFFRON, SPAWN_CELADON, SPAWN_FUCHSIA, SPAWN_CINNABAR

	db -1

unk_03f_4a5b:
	call Call_03f_4a67
	ldh a, [hROMBank]
	ld hl, unkScript_03f_4a77
	call FarQueueScript
	ret

Call_03f_4a67:
	ld hl, unkData_03f_4a6e
	call Call_03f_46df
	ret

unkData_03f_4a6e:
	text "ワープします!" ; Warp!
	done

unkScript_03f_4a77:
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
	ld a, 0
	ret

unk_03f_4a92:
	ld a, 0
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
	ld a, 0
	ret

QuickDebug_PCOption:
	farcall unk_005_57e5
	ld a, 0
	ret

QuickDebug_ElevatorOption:
	call DebugElevator
	ld a, 0
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
	call Call_03f_4bdb
	ld a, 0
	ret

Call_03f_4bdb:
	ld hl, MenuHeader_03f_4c28
	call LoadMenuHeader
	call VerticalMenu
	push af
	call Call_03f_4c07
	pop af
	call CloseWindow
	ret c

	ld hl, unkData_03f_4c56
	call MenuTextbox
	call YesNoBox
	call CloseWindow
	ret c

	call FadeToMenu
	ld hl, wQueuedScriptBank
	call CallPointerAt
	call CloseSubmenu
	ret

Call_03f_4c07:
	ld a, [wMenuCursorY]
	dec a
	call CopyNameFromMenu
	ld a, [wMenuCursorY]

Call_03f_4c11:
	dec a
	ld e, a
	ld d, 0
	ld hl, unkData_03f_4c4d
	add hl, de
	add hl, de
	add hl, de
	ld a, [hli]
	ld [wQueuedScriptBank], a
	ld a, [hli]
	ld [wQueuedScriptAddr], a
	ld a, [hl]
	ld [wQueuedScriptAddr + 1], a
	ret

MenuHeader_03f_4c28:
	db $40
	db 0, 0, 10, 10
	dw MenuData_03f_4c30
	db 1

MenuData_03f_4c30:
	db STATICMENU_CURSOR ; flags
	db 3 ; # items
	db "スロットマシン@" ; Slot Machine
	db "ポーカーゲーム@" ; Poker Game (Card Flip)
	db "ぺアゲーム@" ; Pair Game
	db "ピクロス@" ; Picross (Unused)

unkData_03f_4c4d:
	dba unk_024_6b85
	dba unk_038_48bd
	dba unk_038_667a

unkData_03f_4c56:
	text_ram wStringBuffer2
	text "で "
	line "あそびますか?"
	done

QuickDebug_TimerOption:
	call FadeToMenu
	farcall unk_002_45f1
	farcall DebugClockMenu
	call CloseSubmenu
	ld a, 0
	ret

QuickDebug_RecordOption:
	ld hl, unkData_03f_4c9a
	call MenuTextbox
	ld a, 0
	call OpenSRAM
	ld a, [s0_b000]
	call CloseSRAM
	hlcoord 2, 16
	call Call_03f_4cc0
	call PromptButton
	call CloseWindow
	ld a, 0
	ret

unkData_03f_4c9a:
	text "やせいの#とたたかった"
	line "かいすう @"
	text_decimal wd91d, 2, 5
	text "かい"

	para "タイマーのステータス"
	done

Call_03f_4cc0:
	push bc
	ld c, a
	ld b, 8
.asm_4cc4
	sla c
	ld a, "0"
	jr nc, .asm_4ccb
	inc a
.asm_4ccb
	ld [hli], a
	dec b
	jr nz, .asm_4cc4
	pop bc
	ret

QuickDebug_BreedingOption:
	ld a, [wDayCareMan]
	bit 0, a
	jr z, .asm_4d03
	ld a, [wDayCareLady]
	bit 0, a
	jr z, .asm_4d03
	farcall unk_005_78f0
	ld a, [wApplyStatLevelMultipliersToEnemy]
	and a
	jr z, jr_03f_4d22
	cp $ff
	jr z, jr_03f_4d22
	ld hl, unkData_03f_4d36
	call MenuTextbox
	call YesNoBox
	call ExitMenu
	jr c, .asm_4d00
	call Call_03f_4d51
.asm_4d00:
	ld a, 0
	ret

.asm_4d03:
	ld hl, unkData_03f_4d0c
	call MenuTextboxBackup
	ld a, 0
	ret

unkData_03f_4d0c:
; You need two POKéMON for breeding.
	text "2たい いないので"
	line "こづくり できません"
	prompt

jr_03f_4d22:
	ld hl, unkData_03f_4d2b
	call MenuTextboxBackup
	ld a, 0
	ret

unkData_03f_4d2b:
; Breeding is not possible.
	text "こづくりできません"
	prompt

unkData_03f_4d36:
	text "あいしょう @"
	text_decimal wd143, 1, 3
	text "です"
	line "こづくり しますか?"
	done

Call_03f_4d51:
	ld hl, wDayCareMan
	res 5, [hl]
	set 6, [hl]
	ret

QuickDebug_HatchOption:
	call Call_03f_4d81
	jr c, jr_03f_4d67

	ld hl, unkData_03f_4d70
	call MenuTextboxBackup
	ld a, 0
	ret

jr_03f_4d67:
	ld hl, unkData_03f_4d7a
	call MenuTextboxBackup
	ld a, 0
	ret

unkData_03f_4d70:
	text "タマゴが ない!"
	prompt

unkData_03f_4d7a:
	text "うまれる!"
	prompt

Call_03f_4d81:
	ld hl, wPartySpecies
	ld c, 0
jr_03f_4d86:
	ld a, [hli]
	cp $ff
	jr z, jr_03f_4da5
	cp $fd
	jr z, jr_03f_4d92
	inc c
	jr jr_03f_4d86

jr_03f_4d92:
	ld a, c
	ld bc, $30
	ld hl, wPartyMon1Happiness
	call AddNTimes
	ld [hl], 1
	ld a, $7f
	ld [wd983], a
	scf
	ret

jr_03f_4da5:
	xor a
	ret

QuickDebug_Test1Option:
	ld a, 1
	ld de, unkData_03f_4df9
	jr jr_03f_4dc3

QuickDebug_Test2Option:
	ld a, 2
	ld de, unkData_03f_4dfc
	jr jr_03f_4dc3

QuickDebug_Test3Option:
	ld a, 3
	ld de, unkData_03f_4dff
	jr jr_03f_4dc3

QuickDebug_Test4Option:
	ld a, 4
	ld de, unkData_03f_4e02
	jr jr_03f_4dc3

jr_03f_4dc3:
	ld [wStringBuffer2], a
	push de
	ld hl, unkData_03f_4de3
	call MenuTextbox
	call YesNoBox
	call CloseWindow
	pop de
	jr c, jr_03f_4de0
	ld h, d
	ld l, e
	ld a, BANK(unk_03f_4e05)
	call FarQueueScript
	ld a, 3
	ret

jr_03f_4de0:
	ld a, 0
	ret

unkData_03f_4de3:
	text "イべント@"
	text_decimal wStringBuffer2, 1, 2
	text "を テストしますか?"
	done

unkData_03f_4df9:
	sjump unk_03f_4e7a

unkData_03f_4dfc:
	sjump unk_03f_4ea7

unkData_03f_4dff:
	sjump unk_03f_4eba

unkData_03f_4e02:
	sjump unk_03f_4ec8

unk_03f_4e05:
	opentext
	loadmenu unkData_03f_4e4f

unk_03f_4e09:
	writetext unkData_03f_4e45
	verticalmenu
	ifequal 0, unk_03f_4e17
	scall unk_03f_4e1a
	sjump unk_03f_4e09

unk_03f_4e17:
	closewindow
	closetext
	end

unk_03f_4e1a:
	ifequal 1, unk_03f_4e2f
	ifequal 2, unk_03f_4e33
	ifequal 3, unk_03f_4e37
	ifequal 4, unk_03f_4e3b
	ifequal 5, unk_03f_4e3f
	end

; Special script stuff (to-do)

unk_03f_4e2f:
	db $0F, $29, $00
	end

unk_03f_4e33:
	db $0F, $2A, $00
	end

unk_03f_4e37:
	db $0F, $2B, $00
	end

unk_03f_4e3b:
	db $0F, $2C, $00
	end

unk_03f_4e3f:
	db $0F, $2D, $00
	reloadmap
	db $48
	end

unkData_03f_4e45:
	text "どれで あそぶ?"
	done

unkData_03f_4e4f:
	db $40, $00
	db $00, $0C, $0A, $57
	next "イ゛アガ15パズル@"

	db "スロットマシン@"
	db "ポーカーゲーム@"
	db "ぺアゲーム@"
	db "ピクロス@"

unk_03f_4e7a:
	loadwildmon $13, $05 ; TEMP
	catchtutorial 3
	end

unk_03f_4e80:
	halloffame
	loadmem wd1d4, 1
	end

unk_03f_4e86:
	opentext
	db $0F, $64, $00
	closetext
	end

unk_03f_4e8c:
	giveegg $3f, $14 ; TEMP
	end

unk_03f_4e90:
	opentext
	writetext unkData_03f_4e99
	verbosegiveitem $9e, $63 ; TEMP
	closetext
	end

unkData_03f_4e99:
	db $00, $BA, $DA, $DD, $7F, $B1, $29, $D6, $B3, $58, $9E, $03, $46
	end

unk_03f_4ea7:
	warpfacing FACING_STEP_DOWN_1, HALL_OF_FAME, 4, 3
	playmusic MUSIC_NONE
	refreshscreen 0
	setval 2
	db $0F, $3D, $00
	closetext
	halloffame
	end

unk_03f_4eba:
	db $0D, $13, $00
	db $0D, $12, $00
	end

unk_03f_4ec1:
	warpfacing FACING_STEP_DOWN_1, TEAM_ROCKET_BASE_B1F, 4, 14 ; TEMP
	end

unk_03f_4ec8:
	callasm unk_03f_4ecd
	end

unk_03f_4ecd:
	ld hl, wNumPCItems
	ld [hl], 50
	inc hl
	ld a, 1
	ld c, 50
.asm_4ed7
	ld [hli], a
	ld [hl], 99
	inc hl
	inc a
	dec c
	jr nz, .asm_4ed7
	ld [hl], -1
	ret
