unkData_03f_4546:
	db $40
	menu_coords 0, 0, 7, 17
	dw unkData_03f_454e
	db 1

unkData_03f_454e:
	db STATICMENU_ENABLE_LEFT_RIGHT | STATICMENU_ENABLE_START | STATICMENU_WRAP | STATICMENU_CURSOR
	db 0
	dw unk_03f_460f
	dw $1dc4
	dw unk_03f_4556

unk_03f_4556:
	dw $46a1, unkData_03f_45aa
	dw $46c8, unkData_03f_45cf
	dw $4bd5, unkData_03f_45ae
	dw $4873, unkData_03f_45d8
	dw $4876, unkData_03f_45dc
	dw $4da7, unkData_03f_45b6
	dw $4dae, unkData_03f_45bb
	dw $4db5, unkData_03f_45c0
	dw $4dbc, unkData_03f_45c5
	dw $4932, unkData_03f_45ca
	dw $4954, unkData_03f_45b2
	dw $4ba0, unkData_03f_45d3
	dw $4a86, $45e2
	dw $4b91, $45e7
	dw $4c65, $45f7
	dw $4ba9, $45eb
	dw $4c7a, $45f3
	dw $4718, $45fc
	dw $482d, $4600
	dw $4cd1, $4605
	dw $4d59, $460a

unkData_03f_45aa:
	db "とじる@" ; Cancel
unkData_03f_45ae:
	db "ゲーム@" ; Game
unkData_03f_45b2:
	db "ワープ@" ; Warp
unkData_03f_45b6:
	db "テスト1@" ; Test 1
unkData_03f_45bb:
	db "テスト2@" ; Test 2
unkData_03f_45c0:
	db "テスト3@" ; Test 3
unkData_03f_45c5:
	db "テスト4@" ; Test 4
unkData_03f_45ca:
	db "かいふく@" ; Recovery
unkData_03f_45cf:
	db "つぎ▶@" ; Next
unkData_03f_45d3:
	db "パソコン@" ; PC
unkData_03f_45d8:
	db "キャラ@" ; Character
unkData_03f_45dc:
	db "ツールギア@" ; Pokegear
	db "じっけん@" ; Experiment​
	db "つくる@" ; Build a Pokemon
	db "フロア@" ; Floor
	db "たまご@" ; Egg
	db "きろく@" ; Record
	db "タイマー@" ; Timer
	db "どうぐ@" ; Item
	db "むしとり@" ; Bug Catching
	db "こづくり@" ; Breeding
	db "うまれる@" ; Hatch

unk_03f_460f:
	db 7
	db 1, 10, 19, 13, 4, 11, 0
	db -1

	db 7
	db 1, 17, 9, 12, 2, 14, 0
	db -1

	db 7
	db 1, 5, 6, 7, 8, 20, 0
	db -1

; Overworld Debug Menu
unk_03f_462a:
	call RefreshScreen

	ld de, 6
	call PlaySFX

	ld hl, unkData_03f_4546
	call LoadMenuHeader

	ld a, 0
	ld [wWhichIndexSet], a
	call UpdateTimePals
	call UpdateSprites
	ld a, [wcfbf]
	ld [wMenuCursorBuffer], a
	call DoNthMenu
	jr c, jr_03f_467c

	ld a, [wMenuCursorBuffer]
	ld [wcfbf], a
	call PlaceHollowCursor
	ld a, [wMenuJoypad]
	cp 1
	jr z, jr_03f_4664

	call Call_03f_46a4
	jr jr_03f_466d

jr_03f_4664:
	ld a, [wMenuSelection]
	ld hl, unk_03f_4556
	call MenuJumptable

jr_03f_466d:
	ld hl, unk_03f_4672
	rst JumpTable
	ret

unk_03f_4672:
	dw $463e
	dw $467c
	dw $467f
	dw $4685
	dw $468e

jr_03f_467c:
	call CloseWindow

jr_03f_467f:
	push af
	call CloseText
	pop af
	ret

unk_03f_4685:
	call ExitMenu
	ld a, $80
	ldh [hMenuReturn], a
	jr jr_03f_467f
	call ExitMenu
	ld hl, wQueuedScriptAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wQueuedScriptBank]
	rst FarCall
	ld a, $80
	ldh [hMenuReturn], a
	jr jr_03f_467f
	ld a, 1
	ret

Call_03f_46a4:
	ld a, [wMenuJoypad]
	cp $20
	jr z, .asm_46b9
	ld a, [wWhichIndexSet]
	inc a
	cp 3
	jr nz, .asm_46b4
	xor a
.asm_46b4
	ld [wWhichIndexSet], a
	jr .asm_46d6

.asm_46b9
	ld a, [wWhichIndexSet]
	dec a
	cp -1
	jr nz, .asm_46c3
	ld a, 2
.asm_46c3
	ld [wWhichIndexSet], a
	jr .asm_46d6

.asm_46c8
	ld a, [wWhichIndexSet]
	and a
	jr z, .asm_46d1
	xor a
	jr .asm_46d3

.asm_46d1
	ld a, 1

.asm_46d3
	ld [wWhichIndexSet], a

.asm_46d6
	ld de, $06
	call PlaySFX
	ld a, 0
	ret

Call_03f_46df:
	call MenuTextbox
	ld a, 3
	call Call_03f_46eb
	call CloseWindow
	ret

Call_03f_46eb:
	push bc
	ld b, a
.asm_46ed:
	call GetJoypad
	ldh a, [hJoyPressed]
	and b
	jr z, .asm_46ed
	pop bc
	ret

unk_03f_46f7:
	ld hl, .unkData_03f_46fe
	call MenuTextboxBackup
	ret

.unkData_03f_46fe:
	text "げんざい このきのうは"
	line "つかうことが できません"
	prompt

unk_03f_4718:
	call LoadStandardMenuHeader
	call Call_03f_4729

.asm_471e:
	call Call_03f_4732
	jr nc, .asm_471e
	call ExitMenu
	ld a, 0
	ret

Call_03f_4729:
	ld a, 1
	ld [wDebugClockCurrentOption], a
	ld [wDebugClockCurrentOptionBackup], a
	ret

Call_03f_4732:
.loop
	call Call_03f_47ef
	call WaitBGMap
	call Call_03f_4797
	ret c
	jr z, .loop

	ld a, [wDebugClockCurrentOption]
	and a
	ret z
	call Call_03f_4748
	and a
	ret

Call_03f_4748:
	ld hl, wNumItems
	ld a, [wDebugClockCurrentOption]
	ld [wCurItem], a ; ?
	ld a, [wDebugClockCurrentOptionBackup]
	ld [wItemQuantityChangeBuffer], a
	call ReceiveItem
	jr c, .asm_4763

	ld hl, .unkData_03f_4770
	call MenuTextboxWaitButton
	ret

.asm_4763:
	ld de, $05
	call PlaySFX
	ld hl, .unkData_03f_4785
	call MenuTextboxWaitButton
	ret

.unkData_03f_4770:
	text "どうぐを りュックに"
	line "いれられません!"
	done

.unkData_03f_4785:
	text_ram $cf87 ; TEMP
	text "を "
	line "りュックにいれました"
	done
