unk_00a_4000:
	dr $28000, $28df0

TradeAnimation::
	dr $28df0, $29e66

INCLUDE "engine/link/mystery_gift.asm"

unk_00a_65ef:
	dr $2a5ef, $2a88d

InitRoamMons:
; initialize wRoamMon structs

; species
	ld a, RAIKOU
	ld [wRoamMon1Species], a
	ld a, ENTEI
	ld [wRoamMon2Species], a
	ld a, SUICUNE
	ld [wRoamMon3Species], a

; level
	ld a, 40
	ld [wRoamMon1Level], a
	ld [wRoamMon2Level], a
	ld [wRoamMon3Level], a

; raikou starting map
	ld a, GROUP_ROUTE_42
	ld [wRoamMon1MapGroup], a
	ld a, MAP_ROUTE_42
	ld [wRoamMon1MapNumber], a

; entei starting map
	ld a, GROUP_ROUTE_37
	ld [wRoamMon2MapGroup], a
	ld a, MAP_ROUTE_37
	ld [wRoamMon2MapNumber], a

; suicune starting map
	ld a, GROUP_ROUTE_38
	ld [wRoamMon3MapGroup], a
	ld a, MAP_ROUTE_38
	ld [wRoamMon3MapNumber], a

; hp
	xor a ; generate new stats
	ld [wRoamMon1HP], a
	ld [wRoamMon2HP], a
	ld [wRoamMon3HP], a
	ret

Call_00a_68d0:
	dr $2a8d0, $2c000
