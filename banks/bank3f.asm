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
	ld bc, $8102
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

.asm_4873:
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
	dw $48c4
	dw $48d5
	dw $48a1
	dw $4893
	dw $489a
	dw $48cf

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
	ld hl, unkData_03f_490a
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

unkData_03f_490a:
	dr $fc90a,$fc954

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
	ld hl, $4a5b
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
	dr $fc9a0,$fc9b8

unk_03f_49b8:
	dr $fc9b8,$fc9c4

Call_03f_49c4:
	ld hl, unkData_03f_49cd
	call GetNthString
	ld d, h
	ld e, l
	ret

unkData_03f_49cd:
	dr $fc9cd,$fca67

Call_03f_4a67:
	ld hl, unkData_03f_4a6e
	call Call_03f_46df
	ret

unkData_03f_4a6e:
	dr $fca6e,$fca95

Call_03f_4a95:
	dr $fca95,$fcaea

Call_03f_4aea:
	dr $fcaea,$fcb12

Call_03f_4b12:
	dr $fcb12,$fcb57

Call_03f_4b57:
	dr $fcb57,$fcb62

Call_03f_4b62:
	dr $fcb62,$fcb91

unk_03f_4b91:
	dr $fcb91,$fcbaf

Call_03f_4baf:
	dr $fcbaf,$fcbdb

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
	dr $fcda7,$fcebb

Call_03f_4ebb:
	dr $fcebb,$fcee2

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

Call_03f_5868:
	dr $fd868,$fd897

Jump_03f_5897:
	dr $fd897,$fd8d2

Jump_03f_58d2:
	dr $fd8d2,$fd8dc

Jump_03f_58dc:
	dr $fd8dc,$fd8e3

Call_03f_58e3:
	dr $fd8e3,$fd8f0

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

Call_03f_5a77:
	dr $fda77,$fdae4

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
