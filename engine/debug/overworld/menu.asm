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
	dw QuickDebug_CharacterOption,   .QuickDebug_Character  ; unused
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
	dw QuickDebug_RecordOption,      .QuickDebug_Record      ; unused
	dw QuickDebug_ItemOption,        .QuickDebug_Item
	dw QuickDebug_BugCatchingOption, .QuickDebug_BugCatching ; unused
	dw QuickDebug_BreedingOption,    .QuickDebug_Breeding
	dw QuickDebug_HatchOption,       .QuickDebug_Hatch

.QuickDebug_Cancel:      db "とじる@" 	 ; Cancel
.QuickDebug_Game:        db "ゲーム@" 	 ; Game
.QuickDebug_Warp:        db "ワープ@" 	 ; Warp
.QuickDebug_Test1:       db "テスト1@" 	 ; Test 1
.QuickDebug_Test2:       db "テスト2@" 	 ; Test 2
.QuickDebug_Test3:       db "テスト3@" 	 ; Test 3
.QuickDebug_Test4:       db "テスト4@" 	 ; Test 4
.QuickDebug_Recovery:    db "かいふく@" 	 ; Recovery
.QuickDebug_Next:        db "つぎ▶@" 	 ; Next
.QuickDebug_PC:          db "パソコン@" 	 ; PC
.QuickDebug_Character:   db "キャラ@" 	 ; Character
.QuickDebug_Toolgear:    db "ツールギア@" ; Toolgear
.QuickDebug_Experiment:  db "じっけん@" 	 ; Experiment​ (OT ID Editor)
.QuickDebug_Build:       db "つくる@" 	 ; Build a Pokemon
.QuickDebug_Elevator:    db "フロア@" 	 ; Floor
.QuickDebug_Egg:         db "たまご@" 	 ; Egg
.QuickDebug_Record:      db "きろく@" 	 ; Record
.QuickDebug_Timer:       db "タイマー@" 	 ; Timer
.QuickDebug_Item:        db "どうぐ@" 	 ; Item
.QuickDebug_BugCatching: db "むしとり@" 	 ; Bug Catching
.QuickDebug_Breeding:    db "こづくり@" 	 ; Breeding
.QuickDebug_Hatch:       db "うまれる@" 	 ; Hatch

QuickDebug_MenuItems:
; First Page
	db 7
	db DEBUG_NEXT
	db DEBUG_WARP
	db DEBUG_BREEDING
;	db DEBUG_CHARACTER
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
