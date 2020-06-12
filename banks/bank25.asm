unk_025_4000:
	dr $94000,$965f9

OverworldLoop::
	xor a
	ld [wd14b], a
.asm_65fd
	ld a, [wd14b]
	ld hl, .unkPointers_025_660c
	rst $28
	ld a, [wd14b]
	cp $03
	jr nz, .asm_65fd
	ret

.unkPointers_025_660c:
	dw $666D
	dw $6683
	dw $66B8
	dw $660B

Call_025_6614:
	dr $96614,$97ad4

LoadScriptBDE::
	dr $97ad4,$98000
