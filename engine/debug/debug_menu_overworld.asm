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
	dw unk_03f_46a1, unkData_03f_45aa
	dw unk_03f_46c8, unkData_03f_45cf
	dw unk_03f_4bd5, unkData_03f_45ae
	dw unk_03f_4873, unkData_03f_45d8
	dw unk_03f_4876, unkData_03f_45dc
	dw unk_03f_4da7, unkData_03f_45b6
	dw unk_03f_4dae, unkData_03f_45bb
	dw unk_03f_4db5, unkData_03f_45c0
	dw unk_03f_4dbc, unkData_03f_45c5
	dw unk_03f_4932, unkData_03f_45ca
	dw unk_03f_4954, unkData_03f_45b2
	dw unk_03f_4ba0, unkData_03f_45d3
	dw OTID_Editor,  unkData_03f_45e2
	dw unk_03f_4b91, unkData_03f_45e7
	dw unk_03f_4c65, unkData_03f_45f7
	dw unk_03f_4ba9, unkData_03f_45eb
	dw unk_03f_4c7a, unkData_03f_45f3
	dw unk_03f_4718, unkData_03f_45fc
	dw unk_03f_482d, unkData_03f_4600
	dw unk_03f_4cd1, unkData_03f_4605
	dw unk_03f_4d59, unkData_03f_460a

unkData_03f_45aa: db "とじる@" ; Cancel
unkData_03f_45ae: db "ゲーム@" ; Game
unkData_03f_45b2: db "ワープ@" ; Warp
unkData_03f_45b6: db "テスト1@" ; Test 1
unkData_03f_45bb: db "テスト2@" ; Test 2
unkData_03f_45c0: db "テスト3@" ; Test 3
unkData_03f_45c5: db "テスト4@" ; Test 4
unkData_03f_45ca: db "かいふく@" ; Recovery
unkData_03f_45cf: db "つぎ▶@" ; Next
unkData_03f_45d3: db "パソコン@" ; PC
unkData_03f_45d8: db "キャラ@" ; Character
unkData_03f_45dc: db "ツールギア@" ; Pokegear
unkData_03f_45e2: db "じっけん@" ; Experiment​ (OT ID Editor)
unkData_03f_45e7: db "つくる@" ; Build a Pokemon
unkData_03f_45eb: db "フロア@" ; Floor
unkData_03f_45ef: db "たまご@" ; Egg
unkData_03f_45f3: db "きろく@" ; Record
unkData_03f_45f7: db "タイマー@" ; Timer
unkData_03f_45fc: db "どうぐ@" ; Item
unkData_03f_4600: db "むしとり@" ; Bug Catching
unkData_03f_4605: db "こづくり@" ; Breeding
unkData_03f_460a: db "うまれる@" ; Hatch

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

unk_03f_463e:
	call UpdateTimePals
	call UpdateSprites
	ld a, [wcfbf]
	ld [wMenuCursorBuffer], a
	call DoNthMenu
	jr c, unk_03f_467c

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
	dw unk_03f_463e
	dw unk_03f_467c
	dw unk_03f_467f
	dw unk_03f_4685
	dw unk_03f_468e

unk_03f_467c:
	call CloseWindow

unk_03f_467f:
	push af
	call CloseText
	pop af
	ret

unk_03f_4685:
	call ExitMenu
	ld a, $80
	ldh [hMenuReturn], a
	jr unk_03f_467f

unk_03f_468e:
	call ExitMenu
	ld hl, wQueuedScriptAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wQueuedScriptBank]
	rst FarCall
	ld a, $80
	ldh [hMenuReturn], a
	jr unk_03f_467f

unk_03f_46a1:
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
	jr unk_03f_46d6

.asm_46b9
	ld a, [wWhichIndexSet]
	dec a
	cp -1
	jr nz, .asm_46c3
	ld a, 2
.asm_46c3
	ld [wWhichIndexSet], a
	jr unk_03f_46d6

unk_03f_46c8:
	ld a, [wWhichIndexSet]
	and a
	jr z, .asm_46d1
	xor a
	jr .asm_46d3

.asm_46d1
	ld a, 1

.asm_46d3
	ld [wWhichIndexSet], a

unk_03f_46d6:
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

Call_03f_4797:
.loop:
	call JoyTextDelay_ForcehJoyDown
	ld a, c
	bit 6, a
	jr nz, jr_03f_47b5
	bit 7, a
	jr nz, jr_03f_47c4
	bit 5, a
	jr nz, jr_03f_47d3
	bit 4, a
	jr nz, jr_03f_47dd
	bit 1, a
	jr nz, jr_03f_47e9
	bit 0, a
	jr nz, jr_03f_47eb
	jr .loop

jr_03f_47b5:
	ld hl, wDebugClockCurrentOption
	ld a, [hl]
	cp $fb
	jr z, jr_03f_47c0

	inc [hl]
	xor a
	ret

jr_03f_47c0:
	ld [hl], 1
	xor a
	ret

jr_03f_47c4:
	ld hl, wDebugClockCurrentOption
	ld a, [hl]
	cp $01
	jr z, jr_03f_47cf
	dec [hl]
	xor a
	ret

jr_03f_47cf:
	ld [hl], $fb
	xor a
	ret

jr_03f_47d3:
	ld hl, wDebugClockCurrentOptionBackup
	dec [hl]
	jr nz, jr_03f_47db
	ld [hl], $63
jr_03f_47db:
	xor a
	ret

jr_03f_47dd:
	ld hl, wDebugClockCurrentOptionBackup
	inc [hl]
	cp $64
	jr c, jr_03f_47e7
	ld [hl], 1
jr_03f_47e7:
	xor a
	ret

jr_03f_47e9:
	scf
	ret

jr_03f_47eb:
	ld a, 1
	and a
	ret

Call_03f_47ef:
	ld hl, wOptions
	ld a, [hl]
	push af
	set 4, [hl]
	ldh a, [hBGMapMode]
	push af
	xor a
	ldh [hBGMapMode], a
	ld a, [wDebugClockCurrentOption]
	ld [wd143], a
	call GetItemName

	ld hl, .unkData_03f_4813
	call PrintText
	pop af
	ldh [hBGMapMode], a
	pop af
	ld [wOptions], a
	ret

.unkData_03f_4813:
	text "ばんごう@"
	text_decimal $d0c5, $1, $3 ; TEMP
	text ""
	line "@"
	text_ram $cf87 ; TEMP
	text "  ×@"
	text_decimal $d0c6, $1, $2 ; TEMP
	text_end

unk_03f_482d:
	ld hl, .unkData_03f_4866
	call MenuTextbox
.asm_4833:
	call UpdateTime
	ld a, 4
	ld hl, $5861
	rst FarCall
	ld hl, $c4e5
	ld de, wBugContestMinsRemaining
	lb bc, $81, 2
	call PrintNum
	ld hl, $c4e8
	ld de, wBugContestSecsRemaining
	lb bc, $81, 2
	call PrintNum
	call WaitBGMap
	call GetJoypad
	ldh a, [hJoyPressed]
	and $03
	jr z, .asm_4833
	call ExitMenu
	ld a, 0
	ret

.unkData_03f_4866:
	text "たいかい のこりじかん"
	done

unk_03f_4873:
	ld a, 0
	ret

unk_03f_4876:
	call Call_03f_48e4
	jr c, .asm_4890
	ld a, [wMenuCursorY]
	dec a
	ld hl, .unkData_03f_4884
	rst JumpTable
	ret

.unkData_03f_4884:
	dw unk_03f_48c4
	dw unk_03f_48d5
	dw unk_03f_48a1
	dw unk_03f_4893
	dw unk_03f_489a
	dw unk_03f_48cf

.asm_4890:
	ld a, 0
	ret

unk_03f_4893:
	ld hl, wd55c
	set 7, [hl]
	jr jr_03f_48a7

unk_03f_489a:
	ld hl, wd55c
	res 7, [hl]
	jr jr_03f_48a7

unk_03f_48a1:
	ld a, $3f
	ld hl, $4000
	rst FarCall

jr_03f_48a7:
	ld a, $23
	ld hl, $440e
	rst FarCall
	ld a, $23
	ld hl, $43b9
	rst FarCall
	ld b, 9
	call GetSGBLayout
	ld a, $23
	ld hl, $4403
	rst FarCall
	call UpdateTimePals
	ld a, 1
	ret

unk_03f_48c4:
	call Function1e7c
	ld hl, wd55c
	res 0, [hl]
	ld a, 1
	ret

unk_03f_48cf:
	call Function1e82
	ld a, 1
	ret

unk_03f_48d5:
	call Call_03f_48db
	ld a, 1
	ret

Call_03f_48db:
	call Function1e7c
	ld hl, wd55c
	set 0, [hl]
	ret

Call_03f_48e4:
	ld hl, MenuHeader_03f_490a
	call LoadMenuHeader
	call Call_03f_48f7
	ld [wMenuCursorBuffer], a
	call VerticalMenu
	call CloseWindow
	ret

Call_03f_48f7:
	ld a, [wEnteredMapFromContinue]
	bit 0, a
	ld a, 3
	ret nz
	ld hl, wd55c
	bit 0, [hl]
	ld a, 1
	ret nz
	ld a, 2
	ret

MenuHeader_03f_490a:
	db MENU_BACKUP_TILES ; flags
	db 0, 0, 14, 7
	dw MenuData_03f_4912
	db 1 ; default option

MenuData_03f_4912:
	db STATICMENU_CURSOR ; flags
	db 6
	db "とけい@" ; Clock
	db "ざひょう@" ; Coordinates
	db "アジャスト@" ; Adjust
	db "60びょう@" ; 60 Seconds
	db "24じかん@" ; 24 Hours
	db "けす@" ; Erase

unk_03f_4932:
	ld a, 2
	call Predef
	ld hl, unkData_03f_4940
	call MenuTextboxBackup
	ld a, 0
	ret

unkData_03f_4940:
	text "#の たいリょくを"
	line "かいふくしました"
	prompt

unk_03f_4954:
	xor a
	ldh [hMapAnims], a
	call LoadStandardMenuHeader
	call ClearSprites
	ld a, 0
	ld [wCurPartyMon], a
	ld a, $24
	ld hl, $6398
	rst FarCall
	ld a, e
	ld [wMenuSelection], a
	call CloseSubmenu
	ld a, [wMenuSelection]
	cp -1
	jr z, .asm_499d
	ld a, [wMenuSelection]
	cp -1
	jr z, .asm_499d
	cp $1c
	jr nc, .asm_499d
	ld [wDefaultSpawnpoint], a
	ld hl, wVramState
	set 6, [hl]
	ldh a, [hROMBank]
	ld hl, unk_03f_4a5b
	call FarQueueScript
	ld de, $27
	call PlaySFX
	call DelayFrame
	ld a, 4
	ret

.asm_499d:
	ld a, 0
	ret

unkData_03f_49a0:
	db MENU_BACKUP_TILES ; flags
	db 01, 01 ; start coords
	db 10, 11 ; end coords
	dw MenuData_03f_49a8
	db 1 ; default option

MenuData_03f_49a8:
	db 0 ; flags
	db 4, 0 ; rows, columns
	db 1 ; spacing
	dba unkData_03f_4a43
	dba unk_03f_49b8
	db $00
	dw $0000
	db $00
	dw $0000

unk_03f_49b8:
	push de
	ld a, [wMenuSelection]
	call Call_03f_49c4
	pop hl
	call PlaceString
	ret

Call_03f_49c4:
	ld hl, unkData_03f_49cd
	call GetNthString
	ld d, h
	ld e, l
	ret

; Warp destinations
unkData_03f_49cd:
	db "じぶんのうち@" ; My home
	db "マサラ@" ; Pallet Town
	db "トキワ@" ; Viridian City
	db "ニビ@" ; Pewter City
	db "ハナダ@" ; Cerulean City
	db "イワヤマトンネルまえ@" ; Rock Tunnel Entrance
	db "クチバ@" ; Vermilion City
	db "シオン@" ; Lavender Town
	db "ヤマブキ@" ; Saffron City
	db "タマムシ@" ; Celadon City
	db "セキチク@" ; Fuchsia City
	db "グレン@" ; Cinnabar Island

	db "ワカバ@" ; New Bark Town
	db "ヨシノ@" ; Cherrygrove City
	db "キキョウ@" ; Violet City
	db "ヒワダ@" ; Azalea Town
	db "タンバ@" ; Cianwood City
	db "コガネ@" ; Goldenrod City
	db "アサギ@" ; Olivine City
	db "エンジュ@" ; Ecruteak City
	db "チョウジ@" ; Mahogany Town
	db "イカリの みずうみ@" ; Lake of Rage
	db "フスべ@" ; Blackthorn City
	db "シロガネ@" ; Mt. Silver

unkData_03f_4a43:
	db SPAWN_NEW_BARK, SPAWN_CHERRYGROVE, SPAWN_VIOLET, SPAWN_AZALEA, SPAWN_CIANWOOD, SPAWN_GOLDENROD, SPAWN_OLIVINE, SPAWN_ECRUTEAK, SPAWN_MAHOGANY, SPAWN_LAKE_OF_RAGE, SPAWN_BLACKTHORN, SPAWN_MT_SILVER

	db SPAWN_PALLET, SPAWN_VIRIDIAN, SPAWN_PEWTER, SPAWN_CERULEAN, SPAWN_ROCK_TUNNEL, SPAWN_VERMILION, SPAWN_LAVENDER, SPAWN_SAFFRON, SPAWN_CELADON, SPAWN_FUCHSIA, SPAWN_CINNABAR

	db -1

unk_03f_4a5b:
	call Call_03f_4a67
	ldh a, [hROMBank]
	ld hl, unkScript_03f_4a77
	call FarQueueScript
	ret

Call_03f_4a67:
	ld hl, unkData_03f_4a6e
	call Call_03f_46df
	ret

unkData_03f_4a6e:
	text "ワープします!" ; Warp!
	done

unkScript_03f_4a77:
	applymovement PLAYER, .TeleportFrom
	newloadmap MAPSETUP_TELEPORT
	applymovement PLAYER, .TeleportTo
	end

.TeleportFrom:
	teleport_from
	step_end

.TeleportTo:
	teleport_to
	step_end

OTID_Editor:
	call LoadStandardMenuHeader
	call OTID_Init
	call CloseWindow
	ld a, 0
	ret

unk_03f_4a92:
	ld a, 0
	ret

OTID_Init:
; Clear OT ID input buffer
	ld hl, wStringBuffer2
	ld bc, 5
	xor a
	call ByteFill
; Set default cursor position to last digit
	ld a, 4
	ld [wStringBuffer2 + 5], a
; Print message
	ld hl, NumberToChangeText
	call PrintText

.InitInputArea:
	call OTID_UpdateInputArea

.ReadJoypad:
	call JoyTextDelay
	ldh a, [hJoyLast]
	ld b, a
	and A_BUTTON
	jr nz, .exit
	ld a, b
	and D_PAD
	jr z, .ReadJoypad
	call OTID_InterpretJoypad

	ld c, 3
	call DelayFrames
	jr .InitInputArea

.exit
	call OTID_ConvertToHex
	ld a, h
	ld [wPartyMon1ID], a
	ld a, l
	ld [wPartyMon1ID + 1], a
	ret

NumberToChangeText:
; “Which number should be changed?”
	text "へんこうするナンバーを"
	line "してい してください"
	done

OTID_UpdateInputArea:
; Convert digit to character
	hlcoord 14, 15
	ld de, wStringBuffer2
	ld c, 5
.outputDigit
	ld a, [de]
	add "0"
	ld [hli], a
	inc de
	dec c
	jr nz, .outputDigit

; Clear the cursor area
	hlcoord 14, 16
	ld bc, 5
	ld a, " "
	call ByteFill
; Display cursor
	hlcoord 14, 16
	ld a, [wStringBuffer2 + 5]
	ld e, a
	ld d, 0
	add hl, de
	ld [hl], "▲"
	ret

OTID_InterpretJoypad:
	ld a, b
	and D_LEFT
	jr nz, .pressed_left
	ld a, b
	and D_RIGHT
	jr nz, .pressed_right
	ld a, b
	and D_UP
	jr nz, .increment_digit
	ld a, b
	and D_DOWN
	jr nz, .decrement_digit
	ret

.pressed_left
	ld a, [wStringBuffer2 + 5]
	; Are we on the left-most digit?
	and a
	ret z
	; Nope, let's move left.
	dec a
	ld [wStringBuffer2 + 5], a
	ret

.pressed_right
	ld a, [wStringBuffer2 + 5]
	cp 4
	ret z
	inc a
	ld [wStringBuffer2 + 5], a
	ret

.increment_digit
	call OTID_GetDigitLocation
	ld a, [hl]
	cp 9
	jr z, .max
	inc a
	ld [hl], a
	ret

.max
	ld [hl], 0
	ret

.decrement_digit
	call OTID_GetDigitLocation
	ld a, [hl]
	and a
	jr z, .min
	dec a
	ld [hl], a
	ret

.min
	ld [hl], 9
	ret

OTID_GetDigitLocation:
	ld a, [wStringBuffer2 + 5]
	ld e, a
	ld d, 0
	ld hl, wStringBuffer2
	add hl, de
	ret

OTID_ConvertToHex:
	ld hl, 0
	ld de, wStringBuffer2 + 4
	ld bc, 1
	call .convertDigit
	ld bc, 10
	call .convertDigit
	ld bc, 100
	call .convertDigit
	ld bc, 1000
	call .convertDigit
	ld bc, 10000
; fallthrough

.convertDigit:
	ld a, [de]
	dec de
	push hl
	ld hl, 0
	call AddNTimes
	ld c, l
	ld b, h
	pop hl
	add hl, bc
	ret

unk_03f_4b91:
	dr $fcb91,$fcba0

unk_03f_4ba0:
	dr $fcba0,$fcba9

unk_03f_4ba9:
	dr $fcba9,$fcbaf

Call_03f_4baf:
	dr $fcbaf,$fcbd5

unk_03f_4bd5:
	dr $fcbd5,$fcbdb

Call_03f_4bdb:
	dr $fcbdb,$fcc07

Call_03f_4c07:
	dr $fcc07,$fcc65

unk_03f_4c65:
	dr $fcc65,$fcc7a

unk_03f_4c7a:
	dr $fcc7a,$fccc0

Call_03f_4cc0:
	dr $fccc0,$fccd1

unk_03f_4cd1:
	dr $fccd1,$fcd51

Call_03f_4d51:
	dr $fcd51,$fcd59

unk_03f_4d59:
	dr $fcd59,$fcd81

Call_03f_4d81:
	dr $fcd81,$fcda7

unk_03f_4da7:
	dr $fcda7,$fcdae

unk_03f_4dae:
	dr $fcdae,$fcdb5

unk_03f_4db5:
	dr $fcdb5,$fcdbc

unk_03f_4dbc:
	dr $fcdbc,$fcebb

Call_03f_4ebb:
	dr $fcebb,$fcee2
