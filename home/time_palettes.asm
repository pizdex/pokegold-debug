UpdateTimeAndPals::
; update time and time-sensitive palettes

; rtc enabled?
	ld a, [$c1cd]
	cp 0
	ret z

	call UpdateTime

; obj update on?
	ld a, [$cfdf]
	bit 0, a ; obj update
	ret z

	ld hl, $43c9
	ld a, $23
	rst $08
	ret

UpdateTimePals::
	ld hl, $43fa
	ld a, $23
	rst $08
	ret