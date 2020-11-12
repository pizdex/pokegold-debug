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
