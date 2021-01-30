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
	ld [wMenuCursorPosition], a
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
