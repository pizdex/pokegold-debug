_AnimateHPBar:
	dr $d8fc, $d9b7

ShortAnim_UpdateVariables:
	dr $d9b7, $da89

HPBarAnim_PaletteUpdate:
	dr $da89, $db39

INCLUDE "engine/pokemon/move_mon.asm"

unk_003_6692:
	dr $e692, $e8a5

CopyBoxmonToTempMon:
	dr $e8a5, $e973

GetBreedMon1LevelGrowth:
	dr $e973, $e98e

GetBreedMon2LevelGrowth:
	dr $e98e, $ea52

INCLUDE "engine/events/bug_contest/caught_mon.asm"

_DoItemEffect::
	dr $eaae, $eac8

unkData_003_6ac8:
	dr $eac8, $fe58

RestoreAllPP:
	dr $fe58, $fe8b

GetMaxPPOfMove:
	dr $fe8b, $10000
