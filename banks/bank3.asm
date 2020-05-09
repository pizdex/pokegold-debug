CheckTime::
	dr $c000, $c01b

EngineFlagAction::
	dr $c01b, $c188

Jump_003_4188:
	dr $c188, $c381

unk_003_4381:
	dr $c381, $c4f4

Call_003_44f4:
	dr $c4f4, $c677

unk_003_4677:
	dr $c677, $c6b3

unk_003_46b3:
	dr $c6b3, $c6f4

unk_003_46f4:
	dr $c6f4, $c73b

unk_003_473b:
	dr $c73b, $cfb1

Call_003_4fb1:
	dr $cfb1, $db39

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
	dr $eac8, $10000