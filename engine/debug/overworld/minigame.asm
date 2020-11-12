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
