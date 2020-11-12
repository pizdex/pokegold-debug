QuickDebug_BreedingOption:
; Check if either slot in the daycare is free
	ld a, [wDayCareMan]
	bit DAYCAREMAN_HAS_MON_F, a
	jr z, .need_two_mons
	ld a, [wDayCareLady]
	bit DAYCARELADY_HAS_MON_F, a
	jr z, .need_two_mons
; Check compatibility
	farcall CheckBreedmonCompatibility
	ld a, [wBreedingCompatibility]
	and a
	jr z, .incompatible
	cp -1
	jr z, .incompatible
; Deciding time
	ld hl, .CompatibilityShouldTheyBreedText
	call MenuTextbox
	call YesNoBox
	call ExitMenu
	jr c, .return
	call SetDayCareEggFlags
.return
	ld a, QUICKMENU_UPDATE
	ret

.need_two_mons:
	ld hl, .YouNeedTwoMonForBreedingText
	call MenuTextboxBackup
	ld a, QUICKMENU_UPDATE
	ret

.YouNeedTwoMonForBreedingText:
; "You need two #MON for breeding"
	text "2たい いないので"
	line "こづくり できません"
	prompt

.incompatible
	ld hl, .BreedingIsNotPossibleText
	call MenuTextboxBackup
	ld a, QUICKMENU_UPDATE
	ret

.BreedingIsNotPossibleText:
; "Breeding is not possible"
	text "こづくりできません"
	prompt

.CompatibilityShouldTheyBreedText:
; "The compatibility is [wBreedingCompatibility]"
; "Should they breed?"
	text "あいしょう @"
	text_decimal wBreedingCompatibility, 1, 3
	text "です"
	line "こづくり しますか?"
	done

SetDayCareEggFlags:
	ld hl, wDayCareMan
	res DAYCAREMAN_MONS_COMPATIBLE_F, [hl]
	set DAYCAREMAN_HAS_EGG_F, [hl]
	ret
