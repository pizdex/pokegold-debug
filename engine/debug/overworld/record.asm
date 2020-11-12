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
