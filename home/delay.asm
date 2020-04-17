DelayFrame::
; Wait for one frame
	ld a, 1
    ld [$cf1e], a

; Wait for the next VBlank, halting to conserve battery
.halt
	halt
    ld a, [$cf1e]
	and a
	jr nz, .halt
	ret


DelayFrames::
; Wait c frames
	call DelayFrame
	dec c
	jr nz, DelayFrames
	ret