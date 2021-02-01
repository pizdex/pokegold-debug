_AnimateHPBar:
	dr $d8fc, $d9b7

ShortAnim_UpdateVariables:
	dr $d9b7, $da89

HPBarAnim_PaletteUpdate:
	dr $da89, $db39

INCLUDE "engine/pokemon/move_mon.asm"
INCLUDE "engine/pokemon/bills_pc_top.asm"
INCLUDE "engine/pokemon/breedmon_level_growth.asm"
INCLUDE "engine/pokemon/search2.asm"
INCLUDE "engine/events/bug_contest/caught_mon.asm"
INCLUDE "engine/items/item_effects.asm"
INCLUDE "engine/battle_anims/pokeball_wobble.asm"

unk_003_7f75:
	ld a, $02
	call GetPartyParamLocation
	ld a, [wTMHMMove]
	ld b, a
	ld c, $04

jr_003_7f80:
	ld a, [hli]
	cp b
	jr z, jr_003_7f89
	dec c
	jr nz, jr_003_7f80
	and a
	ret

jr_003_7f89:
	ld hl, unkText_003_7f91
	call PrintText
	scf
	ret

unkText_003_7f91:
	dr $ff91, $10000
