KnowsMove:
	ld a, MON_MOVES
	call GetPartyParamLocation
	ld a, [wTMHMMove]
	ld b, a
	ld c, NUM_MOVES
.loop
	ld a, [hli]
	cp b
	jr z, .knows_move
	dec c
	jr nz, .loop
	and a
	ret

.knows_move
	ld hl, .KnowsMoveText
	call PrintText
	scf
	ret

.KnowsMoveText:
	text_ram wStringBuffer1
	text "は すでに"
	line "@"
	text_ram wStringBuffer2
	text "を おPえています"
	prompt
