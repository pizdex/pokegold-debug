INCLUDE "engine/pokemon/health.asm"
INCLUDE "engine/events/overworld.asm"

_ReceiveItem::
	dr $d4b1, $d8fc

_AnimateHPBar:
	dr $d8fc, $db39

TryAddMonToParty:
	dr $db39, $dbb3

GeneratePartyMonStats:
	dr $dbb3, $dd1a

unk_003_5d1a:
	dr $dd1a, $dd43

unk_003_5d43:
	dr $dd43, $ddec

unk_003_5dec:
	dr $ddec, $e11b

unk_003_611b:
	dr $e11b, $e239

unk_003_6239:
	dr $e239, $e415

unk_003_6415:
	dr $e415, $e429

unk_003_6429:
	dr $e429, $ea52

INCLUDE "engine/events/bug_contest/caught_mon.asm"

_DoItemEffect::
	dr $eaae, $eac8

unkData_003_6ac8:
	dr $eac8, $fe58

RestoreAllPP:
	dr $fe58, $10000
