	db 0

INCLUDE "engine/debug/overworld/menu.asm"

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
	ld [wMenuCursorPosition], a
	call DoNthMenu
	jr c, .exit_menu_window
; Player made selection
	ld a, [wMenuCursorPosition]
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

INCLUDE "engine/debug/overworld/changepage.asm"

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

INCLUDE "engine/debug/overworld/item.asm"
INCLUDE "engine/debug/overworld/bugcatching.asm"

QuickDebug_CharacterOption:
; Dummied out
; Pokedex character dictionary?
	ld a, QUICKMENU_UPDATE
	ret

INCLUDE "engine/debug/overworld/toolgear.asm"
INCLUDE "engine/debug/overworld/recover.asm"
INCLUDE "engine/debug/overworld/warp.asm"
INCLUDE "engine/debug/overworld/otid.asm"

QuickDebug_BuildOption:
	call LoadStandardMenuHeader
	farcall DebugBuildMenu
	call CloseWindow
	ld a, QUICKMENU_UPDATE
	ret

QuickDebug_PCOption:
	farcall PokemonCenterPC
	ld a, QUICKMENU_UPDATE
	ret

INCLUDE "engine/debug/overworld/elevator.asm"
INCLUDE "engine/debug/overworld/minigame.asm"

QuickDebug_TimerOption:
	call FadeToMenu
	farcall BlankScreen
	farcall DebugClockMenu
	call CloseSubmenu
	ld a, QUICKMENU_UPDATE
	ret

INCLUDE "engine/debug/overworld/record.asm"
INCLUDE "engine/debug/overworld/breeding.asm"
INCLUDE "engine/debug/overworld/hatch.asm"
INCLUDE "engine/debug/overworld/tests.asm"
