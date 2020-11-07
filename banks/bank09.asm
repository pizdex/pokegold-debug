StringBufferPointers:
	dr $24000, $2400e

_2DMenu_::
	dr $2400e, $24136

_StaticMenuJoypad::
	dr $24136, $24139

_ScrollingMenuJoypad::
	dr $24139, $242a0

_PushWindow::
	dr $242a0, $24358

_ExitMenu::
	dr $24358, $243f7

_InitVerticalMenuCursor::
	dr $243f7, $24539

_InitScrollingMenu::
	dr $24539, $24555

_ScrollingMenu::
	dr $24555, $26f78

DecorationFlagAction:
	dr $26f78, $27428

DecorationFlagAction_c::
	dr $27428, $27450

SetAllDecorationFlags:
	ld hl, DecorationIDs
.loop
	ld a, [hli]
	cp -1
	jr z, .done
	push hl
	ld b, SET_FLAG
	call DecorationFlagAction
	pop hl
	jr .loop

.done
	ret

DecorationIDs:
	dr $27462, $28000
