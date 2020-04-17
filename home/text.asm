ClearBox::
; Fill a c*b box at hl with blank tiles.
	ld a, " "
	; fallthrough

FillBoxWithByte::
	ld de, SCREEN_WIDTH
.row
	push hl
	push bc
.col
	ld [hli], a
	dec c
	jr nz, .col
	pop bc
	pop hl
	add hl, de
	dec b
	jr nz, .row
	ret

ClearTilemap::
; Fill wTilemap with blank tiles.
    ld hl, $c3a0
	ld a, " "
    ld bc, $0168
    call $31b9

	; Update the BG Map.
	ldh a, [rLCDC]
	bit rLCDC_ENABLE, a
	ret z
    jp $345f

ClearScreen::
	ld a, PAL_BG_TEXT
    ld hl, $cccd
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
    call $31b9
	jr ClearTilemap

Textbox::
; Draw a text box at hl with room for b lines of c characters each.
; Places a border around the textbox, then switches the palette to the
; text black-and-white scheme.
	push bc
	push hl
	call TextboxBorder
	pop hl
	pop bc
	jr TextboxPalette

TextboxBorder::
	; Top
	push hl
	ld a, "┌"
	ld [hli], a
	inc a ; "─"
	call .PlaceChars
	inc a ; "┐"
	ld [hl], a
	pop hl

	; Middle
	ld de, SCREEN_WIDTH
	add hl, de
.row
	push hl
	ld a, "│"
	ld [hli], a
	ld a, " "
	call .PlaceChars
	ld [hl], "│"
	pop hl

	ld de, SCREEN_WIDTH
	add hl, de
	dec b
	jr nz, .row

	; Bottom
	ld a, "└"
	ld [hli], a
	ld a, "─"
	call .PlaceChars
	ld [hl], "┘"

	ret

.PlaceChars:
; Place char a c times.
	ld d, c
.loop
	ld [hli], a
	dec d
	jr nz, .loop
	ret

TextboxPalette::
; Fill text box width c height b at hl with pal 7
    ld de, $092d
	add hl, de
	inc b
	inc b
	inc c
	inc c
	ld a, PAL_BG_TEXT
.col
	push bc
	push hl
.row
	ld [hli], a
	dec c
	jr nz, .row
	pop hl
	ld de, SCREEN_WIDTH
	add hl, de
	pop bc
	dec b
	jr nz, .col
	ret

SpeechTextbox::
; Standard textbox.
    ld hl, $c490
	ld b, TEXTBOX_INNERH
	ld c, TEXTBOX_INNERW
	jp Textbox

TestText::
	text "ゲームフりーク!"
	done

RadioTerminator::
	ld hl, .stop
	ret

.stop:
	text_end

PrintText::
	call SetUpTextbox

PrintTextboxText::
    ld bc, $c4b9
    call $1275
    ret

SetUpTextbox::
    push hl
	call SpeechTextbox
    call $193c
    call $3485
    pop hl
    ret

PlaceString::
	push hl

PlaceNextChar::
	ld a, [de]
	cp "@"
	jr nz, CheckDict
	ld b, h
	ld c, l
	pop hl
	ret
	pop de

NextChar::
	inc de
	jp PlaceNextChar

CheckDict::
dict: MACRO
if \1 == "<NULL>"
	and a
else
	cp \1
endc

if STRSUB("\2", 1, 1) == "\""
; Replace a character with another one
	jr nz, ._\@
	ld a, \2
._\@:
elif STRSUB("\2", 1, 1) == "."
; Locals can use a short jump
	jr z, \2
else
	jp z, \2
endc
ENDM

	dict "<LINE>", LineChar
	dict "<NEXT>", NextLineChar

    and a
    jp z, $121b

    cp "<SCROLL>"
    jp z, _ContTextNoPause

    cp "<_CONT>"
    jp z, _ContText

	dict "<PARA>", Paragraph
	dict "<MOM>", PrintMomsName
	dict "<PLAYER>", PrintPlayerName
	dict "<RIVAL>", PrintRivalName
	dict "<ROUTE>", PlaceRoute
	dict "<WATASHI>", PlaceWatashi
	dict "<KOKO_WA>", PlaceKokoWa
	dict "<RED>", PrintRedsName
	dict "<GREEN>", PrintGreensName
	dict "#", PlacePOKe
	dict "<PC>", PCChar
	dict "<ROCKET>", RocketChar
	dict "<TM>", TMChar
	dict "<TRAINER>", TrainerChar
	dict "<KOUGEKI>", PlaceKougeki
	dict "<TA!>", PlaceHey
	dict "<CONT>", ContText
	dict "<……>", SixDotsChar
	dict "<DONE>", DoneText
	dict "<PROMPT>", PromptText
	dict "<GA>", PlaceGrammar
	dict "<WA>", PlaceGrammar1
	dict "<NO>", PlaceGrammar2
	dict "<WO>", PlaceGrammar3
	dict "<TTE>", PlaceGrammar5
	dict "<NI>", PlaceGrammar4
	dict "<DEXEND>", PlaceDexEnd
	dict "<TARGET>", PlaceMoveTargetsName
	dict "<USER>", PlaceMoveUsersName
	dict "<ENEMY>", PlaceEnemysName
	cp $e4
	jr z, .diacritic
	cp $e5
	jr nz, .not_diacritic

.diacritic
	ld b, a
	call Diacritic
	jp NextChar

.not_diacritic
	cp FIRST_REGULAR_TEXT_CHAR
	jr nc, .place

	cp "パ"
	jr nc, .handakuten

.dakuten
	cp FIRST_HIRAGANA_DAKUTEN_CHAR
	jr nc, .hiragana_dakuten
	add "カ" - "ガ"
	jr .katakana_dakuten
.hiragana_dakuten
	add "か" - "が"
.katakana_dakuten
	ld b, "ﾞ" ; dakuten
	call Diacritic
	jr .place

.handakuten
	cp "ぱ"
	jr nc, .hiragana_handakuten
	add "ハ" - "パ"
	jr .katakana_handakuten
.hiragana_handakuten
	add "は" - "ぱ"
.katakana_handakuten
	ld b, "ﾟ" ; handakuten
	call Diacritic

.place
	ld [hli], a
	call $324f
	jp NextChar

print_name: MACRO
	push de
	ld de, \1
	jp PlaceCommandCharacter
ENDM

PrintMomsName:   print_name wd1bb ; 1041
PrintPlayerName: print_name wd1b5 ; 1048
PrintRivalName:  print_name wd1c1 ; 104f
PrintRedsName:   print_name wd1c7 ; 1056
PrintGreensName: print_name wd1cd ; 105d

TrainerChar:   print_name TrainerCharText ; 1064
TMChar:        print_name TMCharText ; 106b
PCChar:        print_name PCCharText ; 1072
RocketChar:    print_name RocketCharText ; 1079
PlacePOKe:     print_name PlacePOKeText ; 1080
PlaceKougeki:  print_name KougekiText ; 1087
PlaceHey:      print_name HeyText ; 108e
SixDotsChar:   print_name SixDotsCharText ; 1095
PlaceGrammar:  print_name GrammarText ; 109c
PlaceGrammar1: print_name GrammarText1 ; 10a3
PlaceGrammar2: print_name GrammarText2 ; 10aa
PlaceGrammar3: print_name GrammarText3 ; 10b1
PlaceGrammar4: print_name GrammarText4 ; 10b8
PlaceGrammar5: print_name GrammarText5 ; 10bf
PlaceRoute:    print_name RouteText ; 10c6
PlaceWatashi:  print_name WatashiText ; 10cd
PlaceKokoWa:   print_name KokoWaText ; 10d4

PlaceMoveTargetsName::
	ldh a, [hBattleTurn]
	xor 1
	jr PlaceMoveUsersName.place

PlaceMoveUsersName::
	ldh a, [hBattleTurn]

.place:
	push de
	and a
	jr nz, .enemy
    ld de, $cafc
    jr PlaceCommandCharacter

.enemy
    ld de, $1161
    call $0f46
    ld h, b
    ld l, c
    ld de, $caf6
    jr PlaceCommandCharacter

PlaceEnemysName::
    push de
    ld a, [$d03c]
    and a
    jr nz, .linkbattle
    ld a, [$d10f]
	cp RIVAL1
	jr z, .rival
	cp RIVAL2
	jr z, .rival
    ld de, $cb2a
	call PlaceString
	ld h, b
	ld l, c
    ld de, $116c
	call PlaceString

    push bc
    ld hl, $5910
    ld a, $0e
    rst $08
    pop hl
    ld de, $cf87
    jr PlaceCommandCharacter

.rival:
    ld de, $d1c1
    jr PlaceCommandCharacter

.linkbattle:
    ld de, $cb2a
    jr PlaceCommandCharacter

PlaceCommandCharacter::
    call $0f46
    ld h, b
    ld l, c
    pop de
    jp $0f51

TMCharText::      db "わざマシン@"
TrainerCharText:: db "トレーナー@"
PCCharText::      db "パソコン@"
RocketCharText::  db "ロケットだん@"
PlacePOKeText::   db "ポケモン@"
KougekiText::     db "こうげき@"
HeyText::         db "た!@"
SixDotsCharText:: db "……@"
EnemyText::       db "てきの @"
GrammarText::     db "が @"
GrammarText1::    db "は @"
GrammarText2::    db "の @"
GrammarText3::    db "を @"
GrammarText4::    db "に @"
GrammarText5::    db "って@"
RouteText::       db "ばん どうろ@"
WatashiText::     db "わたし@"
KokoWaText::      db "ここは @"

NextLineChar::
	pop hl
	ld bc, SCREEN_WIDTH * 2
	add hl, bc
	push hl
	jp NextChar

LineChar::
    pop hl
    ld hl, $c4e1
	push hl
	jp NextChar

Paragraph::
	push de
    ld a, [$d03c]
	cp LINK_COLOSSEUM
	jr z, .linkbattle
    call $1264

.linkbattle
    call $1249
	call PromptButton
    ld hl, $c4a5
    ld bc, $0412
	call ClearBox
    call $126a
	ld c, 20
	call DelayFrames
    ld hl, $c4b9
    pop de
	jp NextChar

_ContText::
    ld a, [$d03c]
    cp LINK_COLOSSEUM
    jr z, .communication
    call $1264

.communication
    call $1249

	push de
	call PromptButton
	pop de

    call $126a

_ContTextNoPause::
    push de
    call $122c
    call $122c
    ld hl, $c4e1
	pop de
	jp NextChar

ContText::
	push de
	ld de, .cont
	ld b, h
	ld c, l
	call PlaceString
	ld h, b
	ld l, c
	pop de
	jp NextChar

.cont: db "<_CONT>@"

PlaceDexEnd::
; Ends a Pokédex entry in Gen 1.
; Dex entries are now regular strings.
	ld [hl], "."
	pop hl
	ret

PromptText::
    ld a, [$d03c]
    cp LINK_COLOSSEUM
    jr z, .ok
    call $1264

.ok
    call $1249
	call PromptButton
    ld a, [$d03c]
	cp LINK_COLOSSEUM
    jr z, DoneText
    call $126a

DoneText::
    pop hl
    ld de, .stop
	dec de
	ret

.stop:
	text_end

NullChar::
	ld b, h
	ld c, l
	pop hl
	ld de, .ErrorText
	dec de
	ret

.ErrorText
	text_decimal hObjectStructIndexBuffer, 1, 2
	text "エラー"
	done

TextScroll::
    ld hl, $c4b8
    ld de, $c4a4
	ld bc, 3 * SCREEN_WIDTH
    call $3187

    ld hl, $c4e1
	ld a, " "
	ld bc, TEXTBOX_INNERW
	call $31b9
	ld c, 5
	call DelayFrames
	ret

Text_WaitBGMap::
	push bc
	ldh a, [hOAMUpdate]
	push af
	ld a, 1
	ldh [hOAMUpdate], a

    call $345f

	pop af
	ldh [hOAMUpdate], a
	pop bc
	ret

Diacritic::
	push af
	push hl
	ld a, b
	ld bc, -SCREEN_WIDTH
	add hl, bc
	ld [hl], a
	pop hl
	pop af
	ret

LoadBlinkingCursor::
	ld a, "▼"
    ld [$c506], a
    ret

UnloadBlinkingCursor::
	ld a, "─"
    ld [$c506], a
    ret

PokeFluteTerminatorCharacter::
	ld hl, .stop
	ret

.stop:
	text_end

Call_000_1275:
    ld a, [$d1ae]
	push af
	set NO_TEXT_DELAY_F, a
	ld [wTextboxFlags], a

	call DoTextUntilTerminator

	pop af
    ld [$d1ae], a
    ret


DoTextUntilTerminator::
	ld a, [hli]
	cp TX_END
	ret z
	call .TextCommand
	jr DoTextUntilTerminator


.TextCommand:
	push hl
	push bc
	ld c, a
	ld b, 0
	ld hl, TextCommands
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	pop bc
	pop hl

	; jp de
	push de
	ret

TextCommands::
; entries correspond to TX_* constants (see macros/scripts/text.asm)
    call z, $d712
    ld [de], a
    db $e3
    ld [de], a
    di
    ld [de], a
    cp $12
    ld c, $13
    ld [de], a
    inc de
    jr z, jr_000_12c3

    scf
    inc de
    jr c, jr_000_12c7

    ld d, e
    inc de
    ld h, [hl]
    inc de
    xor c
    inc de
    ret z

    inc de
    ld h, [hl]
    inc de
    ld h, [hl]
    inc de
    ld h, [hl]
    inc de
    ld h, [hl]

jr_000_12c3:
    inc de
    ld h, [hl]
    inc de
    ld h, [hl]

jr_000_12c7:
    inc de
    ret nc

    inc de
    add sp, $13

TextCommand_START::
; text_start
; write text until "@"
; [$00]["...@"]

	ld d, h
	ld e, l
	ld h, b
	ld l, c
	call PlaceString
	ld h, d
	ld l, e
	inc hl
	ret

TextCommand_RAM::
; text_ram
; write text from a ram address
; little endian
; [$01][addr]

	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	push hl
	ld h, b
	ld l, c
	call PlaceString
	pop hl
	ret

TextCommand_BCD::
; text_bcd
; write bcd from address, typically ram
; [$02][addr][flags]
; flags: see PrintBCDNumber

	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	push hl
	ld h, b
	ld l, c
	ld c, a
    call $3af3
	ld b, h
	ld c, l
	pop hl
	ret

TextCommand_MOVE::
; text_move
; move to a new tile
; [$03][addr]

	ld a, [hli]
    ld [$cfd0], a
	ld c, a
	ld a, [hli]
    ld [$cfd1], a
	ld b, a
	ret

TextCommand_BOX::
; text_box
; draw a box
; little endian
; [$04][addr][height][width]

	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	push hl
	ld h, d
	ld l, e
	call Textbox
	pop hl
	ret

TextCommand_LOW::
; text_low
; write text at (1,16)
; [$05]

    ld bc, $c4e1
	ret

TextCommand_PROMPT_BUTTON::
; text_promptbutton
; wait for button press
; show arrow
; [06]

    ld a, [$d03c]
	cp LINK_COLOSSEUM
	jp z, TextCommand_LINK_PROMPT_BUTTON

	push hl
	call LoadBlinkingCursor
	push bc
	call PromptButton
	pop bc
	call UnloadBlinkingCursor
	pop hl
	ret

TextCommand_SCROLL::
; text_scroll
; pushes text up two lines and sets the BC cursor to the border tile
; below the first character column of the text box.
	push hl
	call UnloadBlinkingCursor
	call TextScroll
	call TextScroll
	pop hl
    ld bc, $c4e1
	ret

TextCommand_START_ASM::
; text_asm

    jp hl

TextCommand_NUM::
; text_decimal
; [$09][addr][hi:bytes lo:digits]
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	push hl
	ld h, b
	ld l, c
	ld b, a
	and $f
	ld c, a
	ld a, b
	and $f0
	swap a
	set PRINTNUM_LEFTALIGN_F, a
	ld b, a
	call $32aa
	ld b, h
	ld c, l
	pop hl
	ret

TextCommand_PAUSE::
; text_pause
	push hl
	push bc
	call GetJoypad
	ldh a, [hJoyDown]
	and A_BUTTON | B_BUTTON
	jr nz, .done
	ld c, 30
	call DelayFrames
.done
	pop bc
	pop hl
	ret

TextCommand_SOUND::
; chars:
;   $0b, $0e, $0f, $10, $11, $12, $13
; see TextSFX

	push bc
	dec hl
	ld a, [hli]
	ld b, a
	push hl
	ld hl, $1393
.loop
	ld a, [hli]
	cp -1
	jr z, .done
	cp b
	jr z, .play
	inc hl
	inc hl
	jr .loop

.play
	push de
	ld e, [hl]
	inc hl
	ld d, [hl]
	call $3df6
	call $3e28
	pop de

.done
	pop hl
	pop bc
	ret

Unreferenced_Function1388::
; sound_cry
	push de
	ld e, [hl]
	inc hl
	ld d, [hl]
    call $3a0e
	pop de
	pop hl
	pop bc
	ret


TextSFX::
	dbw TX_SOUND_DEX_FANFARE_50_79,  SFX_DEX_FANFARE_50_79
	dbw TX_SOUND_FANFARE,            SFX_FANFARE
	dbw TX_SOUND_DEX_FANFARE_20_49,  SFX_DEX_FANFARE_20_49
	dbw TX_SOUND_ITEM,               SFX_ITEM
	dbw TX_SOUND_CAUGHT_MON,         SFX_CAUGHT_MON
	dbw TX_SOUND_DEX_FANFARE_80_109, SFX_DEX_FANFARE_80_109
	dbw TX_SOUND_SLOT_MACHINE_START, SFX_SLOT_MACHINE_START
	db -1

TextCommand_DOTS::
; text_dots
; [$0C][num]
	ld a, [hli]
	ld d, a
	push hl
	ld h, b
	ld l, c

.loop
	push de
	ld a, "…"
	ld [hli], a
	call GetJoypad
	ldh a, [hJoyDown]
	and A_BUTTON | B_BUTTON
	jr nz, .next
	ld c, 10
	call DelayFrames
.next
	pop de
	dec d
	jr nz, .loop

	ld b, h
	ld c, l
	pop hl
	ret

TextCommand_LINK_PROMPT_BUTTON::
; text_linkpromptbutton
; wait for key down
; display arrow
	push hl
	push bc
	call PromptButton
	pop bc
	pop hl
	ret

TextCommand_STRINGBUFFER::
; text_buffer
; Print a string from one of the following:
; 0: wStringBuffer3
; 1: wStringBuffer4
; 2: wStringBuffer5
; 3: wStringBuffer2
; 4: wStringBuffer1
; 5: wEnemyMonNick
; 6: wBattleMonNick
; [$14][id]

	ld a, [hli]
	push hl
	ld e, a
	ld d, 0
    ld hl, $4000
    add hl, de
    add hl, de
    ld a, $09
    call $31a9
	ld d, h
	ld e, l
	ld h, b
	ld l, c
	call PlaceString
	pop hl
	ret

TextCommand_DAY::
; text_today

	call $35cc
	push hl
	push bc
	ld c, a
	ld b, 0
	ld hl, .Days
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld d, h
	ld e, l
	pop hl
	call PlaceString
	ld h, b
	ld l, c
	ld de, .Day
	call PlaceString
	pop hl
	ret

.Days:
	dw .Sun
	dw .Mon
	dw .Tues
	dw .Wednes
	dw .Thurs
	dw .Fri
	dw .Satur

.Sun:    db "にち@"
.Mon:    db "げつ@"
.Tues:   db "か@"
.Wednes: db "すい@"
.Thurs:  db "もく@"
.Fri:    db "きん@"
.Satur:  db "ど@"
.Day:    db "ようび@"
