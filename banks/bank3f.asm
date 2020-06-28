INCLUDE "engine/debug/debug_clock_menu.asm"
INCLUDE "engine/debug/debug_menu.asm"

Call_03f_452b::
	ld hl, wStatusFlags
	set 0, [hl]
	ld hl, wd66f
	set 7, [hl]
	ld hl, wd66f
	set 1, [hl]
	ld hl, wd66f
	set 2, [hl]
	ld hl, wd66f
	set 0, [hl]
	ret

	nop

INCLUDE "engine/debug/debug_menu_overworld.asm"
INCLUDE "engine/debug/debug_fight_menu.asm"

unkData_03f_57d4:
	dr $fd7d4,$fd7e6

unk_03f_57e6:
	dr $fd7e6,$fd82b

Jump_03f_582b:
	dr $fd82b,$fd851

Jump_03f_5851:
	dr $fd851,$fd85e

Jump_03f_585e:
	dr $fd85e,$fd868

Call_03f_5868::
	hlcoord 1, 0
	ld b, 2
	ld c, 9
	call ClearBox
	hlcoord 1, 1
	ld de, wCurPartySpecies
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	inc hl
	push hl
	ld a, [wCurPartySpecies]
	ld [wTempSpecies], a
	call GetPokemonName
	pop hl
	call PlaceString
	ld a, [wTempSpecies]
	ld [wCurSpecies], a
	call GetBaseData
	ret

Jump_03f_5897:
	dr $fd897,$fd8d2

Jump_03f_58d2:
	dr $fd8d2,$fd8dc

Jump_03f_58dc:
	dr $fd8dc,$fd8e3

Call_03f_58e3:
	hlcoord 1, 3
	ld de, wCurPartyLevel
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	ret

Call_03f_58f0:
	dr $fd8f0,$fd93e

Jump_03f_593e:
	dr $fd93e,$fd9e4

Call_03f_59e4:
	dr $fd9e4,$fd9ee

Jump_03f_59ee:
	dr $fd9ee,$fda42

Jump_03f_5a42:
	dr $fda42,$fda51

Call_03f_5a51:
	dr $fda51,$fda77

Call_03f_5a77::
	hlcoord 12, 0
	ld b, 18
	ld c, 8
	call ClearBox
	hlcoord 13, 1
	ld de, unkData_03f_5ac9
	call PlaceString

	ld b, $a
	ld hl, wd010
	ld a, [wddf0]
.asm_5a92
	ld [hli], a
	dec b
	jr nz, .asm_5a92

	ld a, [wddee]
	ld [hli], a
	ld a, [wddef]
	ld [hl], a
	ld hl, wd00f
	ld de, wd029
	ld b, 1
	ld a, 12
	call Predef

	hlcoord 17, 1
	ld de, wd029
	ld b, 6
.asm_5ab3
	push bc
	push de
	push hl
	lb bc, PRINTNUM_LEADINGZEROS | 2, 3
	call PrintNum
	pop hl
	ld bc, $28
	add hl, bc
	pop de
	inc de
	inc de
	pop bc
	dec b
	jr nz, .asm_5ab3
	ret

unkData_03f_5ac9:
	db "たいリき"
	next "<KOUGEKI>"
	next "ぼうぎょ"
	next "すばやさ"
	next "とくこう"
	next "とくぼう@"

Jump_03f_5ae4:
	dr $fdae4,$fdb65

Call_03f_5b65:
	dr $fdb65,$fdb99

Call_03f_5b99:
	dr $fdb99,$fdbe8

Call_03f_5be8:
	dr $fdbe8,$fdc0e

Call_03f_5c0e:
	dr $fdc0e,$fdc29

INCLUDE "engine/debug/debug_sound_menu.asm"

unk_03f_5f06:
	dr $fdf06,$fdf21

unkData_03f_5f21:
	dr $fdf21,$fe3cd

Jump_03f_63cd:
	dr $fe3cd,$fe927

Call_03f_6927:
	dr $fe927,$fe94b

Call_03f_694b:
	dr $fe94b,$fe952

INCLUDE "engine/events/npc_trade.asm"
INCLUDE "engine/events/mom_phone.asm"
INCLUDE "engine/link/mystery_gift_3.asm"
INCLUDE "engine/debug/debug_color_picker.asm"
