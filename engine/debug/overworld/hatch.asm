QuickDebug_HatchOption:
	call SetEggToHatch
	jr c, .success

; Didn't find any Eggs to set...
	ld hl, .NoEggsText
	call MenuTextboxBackup
	ld a, QUICKMENU_UPDATE
	ret

.success
	ld hl, .HatchText
	call MenuTextboxBackup
	ld a, QUICKMENU_UPDATE
	ret

.NoEggsText:
; "There is no EGG."
	text "タマゴが ない!"
	prompt

.HatchText:
; "It's going to hatch!"
	text "うまれる!"
	prompt

SetEggToHatch:
; Search for the first egg in the party.
; If found, set it to hatch on the next step.
	ld hl, wPartySpecies
	ld c, 0
.partyloop
	ld a, [hli]
	cp -1
	jr z, .terminator
	cp EGG
	jr z, .egg
	inc c
	jr .partyloop

.egg
	ld a, c
	ld bc, PARTYMON_STRUCT_LENGTH
	ld hl, wPartyMon1Happiness
	call AddNTimes
	ld [hl], 1 ; Egg happiness is decremented to 0
	ld a, 127 ; On the next step
	ld [wStepCount], a
	scf
	ret

.terminator
	xor a
	ret
