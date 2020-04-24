CheckTime::
	dr $c000, $c01b

EngineFlagAction::
	dr $c01b, $c188

Jump_003_4188:
	dr $c188, $c381

unk_003_4381:
	dr $c381, $c4f4

Call_003_44f4:
	dr $c4f4, $cfb1

Call_003_4fb1:
	dr $cfb1, $dbb3

GeneratePartyMonStats:
	dr $dbb3, $ea52

INCLUDE "engine/events/bug_contest/caught_mon.asm"

_DoItemEffect::
	dr $eaae, $eac8

unkData_003_6ac8:
	dr $eac8, $10000