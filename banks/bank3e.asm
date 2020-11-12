

unk_03e_744a:
	call LoadFrame
	ld hl, wDebugToolgearStatus
	bit 0, [hl]
	jr z, jr_03e_746d

	ld hl, vTiles2 tile $66
	ld de, $46a2
	ld bc, $3e0a
	call Get1bpp

	ld hl, vTiles2 tile $70
	ld de, $40f2
	ld bc, $3e06
	call Get2bpp
	ret

jr_03e_746d:
	ld hl,vTiles2 tile $66
	ld de, $46a2
	ld bc, $3e0a
	call Get1bpp

	ld hl, vTiles2 tile $70
	ld de, $7492
	ld bc, $3e01
	call Get1bpp

	ld hl, vTiles2 tile $71
	ld de, $4e22
	ld bc, $3e09
	call Get2bpp
	ret

unkData_03e_7492:
	dr $fb492, $fb56a

INCLUDE "engine/link/time_capsule.asm"
INCLUDE "engine/events/name_rater.asm"
INCLUDE "engine/events/play_slow_cry.asm"

NewPokedexEntry:
	dr $fb9b9, $fba0d

ConvertMon_2to1:
	dr $fba0d, $fbb34

UpdateUnownDex:
	dr $fbb34, $fbc4e

CheckMagikarpLength:
	dr $fbc4e, $fbe06

HiddenPowerDamage:
	dr $fbe06, $fbe6f

_DisappearUser:
	dr $fbe6f, $fbf97

BadgeTypeBoosts:
	dr $fbf97, $fc000
