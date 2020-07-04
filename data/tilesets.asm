tileset: MACRO
	dba \1GFX, \1Meta, \1Coll
	dw \1Anim
	dw NULL
	dw \1PalMap
ENDM

; Associated data:
; - The *GFX, *Meta, and *Coll are defined in gfx/tilesets.asm
; - The *PalMap are defined in gfx/tileset_palette_maps.asm
; - The *Anim are defined in engine/tilesets/tileset_anims.asm

Tilesets::
; entries correspond to TILESET_* constants
	db $06, $60, $4E
	db $06, $F0, $52
	db $06, $F0, $5A
	dw Tileset0Anim
	dw NULL
	db $C7, $40

	db $06, $60, $4E
	db $06, $F0, $52
	db $06, $F0, $5A
	dw TilesetJohtoAnim
	dw NULL
	db $C7, $40

	db $06, $F0, $5C
	db $06, $A0, $61
	db $06, $A0, $69
	dw TilesetJohtoModernAnim
	dw NULL
	db $F7, $40

	db $06, $00, $40
	db $06, $60, $44
	db $06, $60, $4C
	dw TilesetKantoAnim
	dw NULL
	db $97, $40

	db $37, $33, $61
	db $37, $D3, $65
	db $37, $D3, $69
	dw TilesetHouseAnim
	dw NULL
	db $27, $41

	db $07, $4C, $5E
	db $07, $2C, $62
	db $07, $2C, $66
	dw TilesetPlayersHouseAnim
	dw NULL
	db $57, $41

	db $07, $0C, $4C
	db $07, $3C, $50
	db $07, $3C, $54
	dw TilesetPokecenterAnim
	dw NULL
	db $87, $41

	db $07, $0C, $43
	db $07, $0C, $47
	db $07, $0C, $4B
	dw TilesetGateAnim
	dw NULL
	db $B7, $41

	db $07, $3C, $55
	db $07, $4C, $59
	db $07, $4C, $5D
	dw TilesetPortAnim
	dw NULL
	db $E7, $41

	db $08, $2C, $4B
	db $08, $FC, $4E
	db $08, $FC, $52
	dw TilesetLabAnim
	dw NULL
	db $17, $42

	db $08, $FC, $53
	db $08, $1C, $58
	db $08, $1C, $5C
	dw TilesetFacilityAnim
	dw NULL
	db $47, $42

	db $08, $1C, $5D
	db $08, $CC, $60
	db $08, $CC, $64
	dw TilesetMartAnim
	dw NULL
	db $77, $42

	db $07, $2C, $67
	db $07, $BC, $6A
	db $07, $BC, $6E
	dw TilesetMansionAnim
	dw NULL
	db $A7, $42

	db $08, $CC, $65
	db $08, $CC, $69
	db $08, $CC, $6D
	dw TilesetGameCornerAnim
	dw NULL
	db $D7, $42

	db $0C, $00, $40
	db $0C, $E0, $44
	db $0C, $E0, $48
	dw TilesetEliteFourRoomAnim
	dw NULL
	db $07, $43

	db $06, $A0, $75
	db $06, $50, $7A
	db $06, $50, $7E
	dw TilesetTraditionalHouseAnim
	dw NULL
	db $37, $43

	db $08, $CC, $6E
	db $08, $6C, $72
	db $08, $6C, $76
	dw TilesetTrainStationAnim
	dw NULL
	db $57, $44

	db $37, $73, $57
	db $37, $33, $5C
	db $37, $33, $60
	dw TilesetChampionsRoomAnim
	dw NULL
	db $B7, $44

	db $37, $D3, $6A
	db $37, $D3, $6E
	db $37, $D3, $72
	dw TilesetLighthouseAnim
	dw NULL
	db $E7, $44

	db $37, $D3, $73
	db $37, $93, $78
	db $37, $93, $7C
	dw TilesetPlayersRoomAnim
	dw NULL
	db $17, $45

	db $08, $FC, $41
	db $08, $2C, $46
	db $08, $2C, $4A
	dw TilesetTowerAnim
	dw NULL
	db $67, $43

	db $07, $BC, $6F
	db $07, $4C, $73
	db $07, $4C, $77
	dw TilesetCaveAnim
	dw NULL
	db $97, $43

	db $0C, $E0, $49
	db $0C, $40, $4E
	db $0C, $40, $52
	dw TilesetParkAnim
	dw NULL
	db $C7, $43

	db $0C, $40, $53
	db $0C, $70, $56
	db $0C, $70, $5A
	dw TilesetRuinsOfAlphAnim
	dw NULL
	db $F7, $43

	db $0C, $70, $5B
	db $0C, $C0, $5F
	db $0C, $C0, $63
	dw TilesetRadioTowerAnim
	dw NULL
	db $27, $44

	db $0C, $C0, $64
	db $0C, $90, $68
	db $0C, $90, $6C
	dw TilesetUndergroundAnim
	dw NULL
	db $87, $44

	db $0C, $90, $6D
	db $0C, $D0, $71
	db $0C, $D0, $75
	dw TilesetIcePathAnim
	dw NULL
	db $77, $45

	db $0C, $D0, $76
	db $07, $4C, $73
	db $07, $4C, $77
	dw TilesetDarkCaveAnim
	dw NULL
	db $97, $43

	db $0C, $10, $7A
	db $08, $6C, $77
	db $37, $93, $7D
	dw TilesetForestAnim
	dw NULL
	db $A7, $45
