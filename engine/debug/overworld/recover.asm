QuickDebug_RecoverHPOption:
	predef HealParty
	ld hl, .MonsHPWasHealedText
	call MenuTextboxBackup
	ld a, QUICKMENU_UPDATE
	ret

.MonsHPWasHealedText:
; "Your #MON's HP was healed."
	text "#の たいりょくを"
	line "かいふくしました"
	prompt
