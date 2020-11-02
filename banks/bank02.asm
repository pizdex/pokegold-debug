INCLUDE "engine/tilesets/map_palettes.asm"

unk_002_4097:
	dr $8097, $85f1

BlankScreen::
	call DisableSpriteUpdates
	xor a
	ldh [hBGMapMode], a
	call ClearBGPalettes
	call ClearSprites
	hlcoord 0, 0
	ld bc, wTilemapEnd - wTilemap
	ld a, " "
	call ByteFill
	hlcoord 0, 0, wAttrmap
	ld bc, wAttrmapEnd - wAttrmap
	ld a, $7
	call ByteFill
	call WaitBGMap2
	call SetPalettes
	ret

INCLUDE "engine/debug/debug_password_menu.asm"

INCLUDE "engine/overworld/player_object.asm"
INCLUDE "engine/math/sine.asm"
INCLUDE "engine/predef.asm"

unk_002_4f55:
	dr $8f55, $8fbd

unk_002_4fbd:
	dr $8fbd, $9391

unk_002_5391:
	dr $9391, $9f84

unk_002_5f84:
	dr $9f84, $aff1

unkData_002_6ff1:
	dr $aff1, $b7f1

unkData_002_77f1:
	dr $b7f1, $c000
