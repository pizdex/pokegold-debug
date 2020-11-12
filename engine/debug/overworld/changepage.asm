QuickDebug_SwitchPage:
	ld a, [wMenuJoypad]
	cp D_LEFT
	jr z, .decrement_page

	ld a, [wWhichIndexSet]
	inc a
	cp 3
	jr nz, .not_max
	xor a
.not_max
	ld [wWhichIndexSet], a
	jr QuickDebug_ChangePageSFX

.decrement_page
	ld a, [wWhichIndexSet]
	dec a
	cp -1
	jr nz, .not_min
	ld a, 2
.not_min
	ld [wWhichIndexSet], a
	jr QuickDebug_ChangePageSFX

QuickDebug_NextPageOption:
; It is impossible to switch to the third page using this function.
	ld a, [wWhichIndexSet]
	and a
	jr z, .second_page
	xor a
	jr .first_page

.second_page
	ld a, 1

.first_page
	ld [wWhichIndexSet], a

QuickDebug_ChangePageSFX:
	ld de, SFX_MENU
	call PlaySFX
	ld a, QUICKMENU_UPDATE
	ret
