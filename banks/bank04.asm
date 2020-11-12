DoPlayerMovement::
	dr $10000, $10017

Call_004_4017:
	dr $10017, $1002d

Call_004_402d:
	dr $1002d, $100c3

Call_004_40c3:
	dr $100c3, $100ee

Call_004_40ee:
	dr $100ee, $1017e

Call_004_417e:
	dr $1017e, $101a2

Call_004_41a2:
	dr $101a2, $101f7

Call_004_41f7:
	dr $101f7, $1022a

Call_004_422a:
	dr $1022a, $10254

Jump_004_4254:
	dr $10254, $102ea

Call_004_42ea:
	dr $102ea, $10302

Call_004_4302:
	dr $10302, $10425

Call_004_4425:
	dr $10425, $10430

Call_004_4430:
	dr $10430, $10467

Pack:
	dr $10467, $10e64

Call_004_4e64:
	dr $10e64, $1184d

StartBugContestTimer:
	ld a, BUG_CONTEST_MINUTES
	ld [wBugContestMinsRemaining], a
	ld a, BUG_CONTEST_SECONDS
	ld [wBugContestSecsRemaining], a
	call UpdateTime
	ld hl, wBugContestStartTime
	call CopyDayHourMinSecToHL
	ret

CheckBugContestTimer::
	ld hl, wBugContestStartTime
	call Call_004_5998
	ld a, [wDaysSince]
	and a
	jr nz, .timed_out
	ld a, [wHoursSince]
	and a
	jr nz, .timed_out
	ld a, [wSecondsSince]
	ld b, a
	ld a, [wBugContestSecsRemaining]
	sub b
	jr nc, .okay
	add 60

.okay
	ld [wBugContestSecsRemaining], a
	ld a, [wMinutesSince]
	ld b, a
	ld a, [wBugContestMinsRemaining]
	sbc b
	ld [wBugContestMinsRemaining], a
	jr c, .timed_out
	and a
	ret

.timed_out
	xor a
	ld [wBugContestMinsRemaining], a
	ld [wBugContestSecsRemaining], a
	scf
	ret

unk_004_589a:
	dr $1189a, $11998

Call_004_5998:
	dr $11998, $119d0

CopyDayHourMinSecToHL:
	dr $119d0, $11a74

_NamingScreen:
	dr $11a74, $11a7e

unk_004_5a7e:
	dr $11a7e, $125a4

HealMachineAnim::
	dr $125a4, $13877

Elevator::
	dr $13877, $13a43

INCLUDE "engine/events/bug_contest/contest.asm"

RepelWoreOffScript::
	dr $13aa9, $13b12

CheckFacingTileForStdScript::
	dr $13b12, $13b54

INCLUDE "engine/events/bug_contest/judging.asm"
INCLUDE "engine/events/pokerus/apply_pokerus_tick.asm"
INCLUDE "engine/events/bug_contest/contest_2.asm"
