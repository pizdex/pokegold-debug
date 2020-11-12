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
