DebugClockMenu_Overworld:
	ld hl, wStringBuffer2
	ld a, [wCurDay]
	ld [hli], a
	ldh a, [hHours]
	ld [hli], a
	ldh a, [hMinutes]
	ld [hli], a
	ldh a, [hSeconds]
	ld [hli], a
	ld hl, wOptions
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	call DebugClockOW_Init
	pop af
	ld [wOptions], a
	ret

DebugClockOW_Init:
	ld hl, DebugClockOW_HourMinText
	call PrintText
	call DebugClockOW_PlaceHourMin
	call WaitBGMap
.joypad_loop
	call DebugClockOW_Joypad
	push af
	call DebugClockOW_PlaceHourMin
	call WaitBGMap
	pop af
	jr nc, .joypad_loop
	cp B_BUTTON_F
	ret z
	call InitTime
	ret

DebugClockOW_PlaceHourMin:
	hlcoord 1, 14
	ld de, wStringBuffer2 + 1 ; Hours
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNum

	hlcoord 1, 16
	ld de, wStringBuffer2 + 2 ; Minutes
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNum
	ret

DebugClockOW_HourMinText:
	text "   じ"		; Hours
	line "   ふん"	; Minutes
	done

DebugClockOW_Joypad:
	call JoyTextDelay_ForcehJoyDown
	ld a, c
	bit D_UP_F, a
	jr nz, .increment_hours
	bit D_DOWN_F, a
	jr nz, .decrement_hours
	bit D_LEFT_F, a
	jr nz, .decrement_minutes
	bit D_RIGHT_F, a
	jr nz, .increment_minutes
	bit A_BUTTON_F, a
	jr nz, .confirm_time
	bit B_BUTTON_F, a
	jr nz, .exit
	jr .loop

.exit
	ld a, 1
	scf
	ret

.confirm_time
	ld a, 2
	scf
	ret

.increment_hours
	ld hl, wStringBuffer2 + 1
	inc [hl]
	ld a, [hl]
	cp 24
	jr c, .loop
	ld [hl], 0
	jr .loop

.decrement_hours
	ld hl, wStringBuffer2 + 1
	dec [hl]
	ld a, [hl]
	cp -1
	jr nz, .loop
	ld [hl], 23
	jr .loop

.increment_minutes
	ld hl, wStringBuffer2 + 2
	inc [hl]
	ld a, [hl]
	cp 60
	jr c, .loop
	ld [hl], 0
	jr .loop

.decrement_minutes
	ld hl, wStringBuffer2 + 2
	dec [hl]
	ld a, [hl]
	cp -1
	jr nz, .loop
	ld [hl], 59

.loop
	xor a
	ret

DebugClockMenu:
	ld hl, wOptions
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	xor a
	ld [wDebugClockCurrentOption], a
	ld [wDebugClockCurrentOptionBackup], a
	call DebugClock_Init
	call DebugClock_MainLoop
	pop af
	ld [wOptions], a
	call ClearTilemap
	ret

DebugClock_Init:
	call GetClock
	ldh a, [hRTCDayLo]
	ld [wDebugClockDayLo], a
	ldh a, [hRTCHours]
	ld [wDebugClockHours], a
	ldh a, [hRTCMinutes]
	ld [wDebugClockMinutes], a
	ldh a, [hRTCSeconds]
	ld [wDebugClockSeconds], a
	call DebugClock_PlaceText
	ret

DebugClock_MainLoop:
	call DebugClock_Joypad
	push af
	call GetClock
	call DebugClock_UpdateCursor
	call DebugClock_DisplayRegisters
	pop af
	jr nc, DebugClock_MainLoop
	ret

DebugClock_Joypad:
	call JoyTextDelay_ForcehJoyDown
	ld a, c
	bit D_UP_F, a
	jr nz, .previous_option
	bit D_DOWN_F, a
	jr nz, .next_option
	bit D_LEFT_F, a
	jr nz, .decrement_value
	bit D_RIGHT_F, a
	jr nz, .increment_value
	bit A_BUTTON_F, a
	jr nz, .update_current_value
	bit B_BUTTON_F, a
	jr nz, .return_to_debug_menu
	bit SELECT_F, a
	jr nz, .reset_values
	xor a
	ret

.previous_option:
	ld hl, wDebugClockCurrentOption
	ld a, [hl]
	and a
	jr z, .reached_top
	dec [hl]
	xor a
	ret

.reached_top
	ld [hl], 4
	xor a
	ret

.next_option:
	ld hl, wDebugClockCurrentOption
	ld a, [hl]
	cp 4
	jr z, .reached_bottom
	inc [hl]
	xor a
	ret

.reached_bottom
	ld [hl], 0
	xor a
	ret

.decrement_value:
	call DebugClock_LoadWRAMAddress
	dec [hl]
	xor a
	ret

.increment_value:
	call DebugClock_LoadWRAMAddress
	inc [hl]
	xor a
	ret

.update_current_value:
	call DebugClock_LoadPointer
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	inc hl
	inc hl
	ld a, [hl]
	cp -1
	jr z, .reset
	ld c, a
	ld a, [de]
	ld b, a
	call DebugClock_UpdateMBC3RTC
	xor a
	ret

.reset
	jp Reset

.return_to_debug_menu:
	scf
	ret

.reset_values:
	call DebugClock_Init
	xor a
	ret

DebugClock_UpdateCursor:
	ld a, [wDebugClockCurrentOption]
	ld c, a
	ld a, [wDebugClockCurrentOptionBackup]
	cp c
	jr z, .current_option_unchanged
	call DebugClock_FindCursor
	ld [hl], " "
.current_option_unchanged
	ld a, [wDebugClockCurrentOption]
	call DebugClock_FindCursor
	ld [hl], "▶"
	ld a, [wDebugClockCurrentOption]
	ld [wDebugClockCurrentOptionBackup], a
	ret

DebugClock_FindCursor:
	hlcoord 9, 8
	ld bc, 2 * SCREEN_WIDTH
	call AddNTimes
	ret

DebugClock_LoadWRAMAddress:
	call DebugClock_LoadPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

DebugClock_LoadPointer:
	ld hl, .PointerTable
	ld a, [wDebugClockCurrentOption]
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	add hl, de
	add hl, de
	add hl, de
	ret

.PointerTable:
	dw wDebugClockDayLo ; WRAM
	dw hRTCDayLo		; HRAM
	db RTC_DL			; MBC3RTC Register

	dw wDebugClockHours
	dw hRTCHours
	db RTC_H

	dw wDebugClockMinutes
	dw hRTCMinutes
	db RTC_M

	dw wDebugClockSeconds
	dw hRTCSeconds
	db RTC_S

	dw wDebugClockResetValue
	dw wDebugClockResetValue
	db -1

DebugClock_DisplayRegisters:
	hlcoord 10, 3
	ldh a, [hRTCDayHi]
	call DebugClock_PrintRTCDayHi

	hlcoord 10, 8
	ld de, wDebugClockDayLo
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum

	hlcoord 15, 8
	ld de, hRTCDayLo
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum

	hlcoord 10, 10
	ld de, wDebugClockHours
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum

	hlcoord 15, 10
	ld de, hRTCHours
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum

	hlcoord 10, 12
	ld de, wDebugClockMinutes
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum

	hlcoord 15, 12
	ld de, hRTCMinutes
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum

	hlcoord 10, 14
	ld de, wDebugClockSeconds
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum

	hlcoord 15, 14
	ld de, hRTCSeconds
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	ret

DebugClock_PrintRTCDayHi:
; Display hRTCDayHi as a binary number
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

DebugClock_PlaceText:
	hlcoord 1, 3
	ld de, .DebugClock_FlagRegisterText
	call PlaceString
	hlcoord 9, 6
	ld de, .DebugClock_HeaderText
	call PlaceString
	hlcoord 1, 8
	ld de, .DebugClock_DayCounter
	call PlaceString
	hlcoord 1, 10
	ld de, .DebugClock_HourCounter
	call PlaceString
	hlcoord 1, 12
	ld de, .DebugClock_MinuteCounter
	call PlaceString
	hlcoord 1, 14
	ld de, .DebugClock_SecondCounter
	call PlaceString
	hlcoord 10, 16
	ld de, .DebugClock_Reset
	call PlaceString
	ret

.DebugClock_FlagRegisterText: ; hRTCDayHi in Binary
	db "フラグレジスタ@"

.DebugClock_HeaderText:
	db "せってい じっさい@" ; Set	| Current

.DebugClock_DayCounter:
	db "にちカウンタ@"  ; Day counter

.DebugClock_HourCounter:
	db "じカウンタ@"   ; Hour counter

.DebugClock_MinuteCounter:
	db "ふんカウンタ@"  ; Minute counter

.DebugClock_SecondCounter:
	db "びょうカウンタ@" ; Second counter

.DebugClock_Reset:
	db "りセット@" ; Reset

DebugClock_UpdateMBC3RTC:
; Write value b into RTC register c
	ld a, SRAM_ENABLE
	ld [MBC3SRamEnable], a

	call LatchClock
	ld hl, MBC3SRamBank
	ld de, MBC3RTC
	ld [hl], c
	ld a, b
	ld [de], a

	call CloseSRAM
	ret
