DebugBuildMenu::
	ld a, BANK(s1_ad10)
	call OpenSRAM
	ld a, [s1_ad10]
	cp MONS_PER_BOX
	call CloseSRAM
	jp nc, DebugBuilder_FullBox

	call ClearTilemap
	call UpdateSprites

	ld a, [wOptions]
	push af
	set NO_TEXT_SCROLL, a
	ld [wOptions], a

	xor a
	ld hl, wDebugBuilderDVs
	ld [hli], a
	ld [hli], a
	ld [hl], a
	inc a
	ldh [hInMenu], a
	ld [wCurItem], a

	ld a, [wCurPartySpecies]
	cp NUM_POKEMON + 1
	jr c, .species_good
; overflow
	ld a, 1
	ld [wCurPartySpecies], a
.species_good
	ld a, [wCurPartyLevel]
	dec a
	cp MAX_LEVEL
	jr c, DebugBuilder_SpeciesEditor
; overflow
	ld a, 1
	ld [wCurPartyLevel], a

DebugBuilder_SpeciesEditor:
	hlcoord 0, 3
	ld [hl], " "
	hlcoord 0, 1
	ld [hl], "▶"
	call DebugBuilder_UpdateNameAndSpecies
.Joypad:
	call DelayFrame
	call JoyTextDelay

	ldh a, [hJoyLast]
	bit A_BUTTON_F, a
	jp nz, .IncrementSpecies
	bit B_BUTTON_F, a
	jp nz, .DecrementSpecies
	bit D_DOWN_F, a
	jp nz, DebugBuilder_LevelEditor
	jr .Joypad

.IncrementSpecies:
	ld hl, wCurPartySpecies
	inc [hl]
	ld a, [hl]
	cp NUM_POKEMON + 1
	jr c, DebugBuilder_SpeciesEditor
	ld [hl], 1
	jr DebugBuilder_SpeciesEditor

.DecrementSpecies:
	ld hl, wCurPartySpecies
	dec [hl]
	jr nz, DebugBuilder_SpeciesEditor
	ld [hl], NUM_POKEMON
	jr DebugBuilder_SpeciesEditor

DebugBuilder_UpdateNameAndSpecies:
; Clear old species index and name
	hlcoord 1, 0
	ld b, 2
	ld c, 9
	call ClearBox
; Print new species index
	hlcoord 1, 1
	ld de, wCurPartySpecies
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
; Print new name
	inc hl
	push hl
	ld a, [wCurPartySpecies]
	ld [wTempSpecies], a
	call GetPokemonName
	pop hl
	call PlaceString
; Get data
	ld a, [wTempSpecies]
	ld [wCurSpecies], a
	call GetBaseData
	ret

DebugBuilder_LevelEditor:
	hlcoord 0, 1
	ld [hl], " "
	hlcoord 0, 3
	ld [hl], "▶"
	hlcoord 0, 5
	ld [hl], " "
	call DebugBuilder_PrintLevel
	call DebugBuilder_UpdateMoves
.Joypad:
	call DelayFrame
	call JoyTextDelay
	ld hl, wCurPartyLevel

	ldh a, [hJoyLast]
	bit A_BUTTON_F, a
	jp nz, .IncrementLevel
	bit B_BUTTON_F, a
	jp nz, .DecrementLevel
	bit START_F, a
	jp nz, DebugBuilder_SendMonToBox
	bit D_UP_F, a
	jp nz, DebugBuilder_SpeciesEditor
	bit D_DOWN_F, a
	jp nz, DebugBuilder_MoveEditorDefault
	jr .Joypad

.IncrementLevel:
	inc [hl]
	ld a, [hl]
	cp MAX_LEVEL + 1
	jr c, DebugBuilder_LevelEditor
	ld [hl], 1
	jr DebugBuilder_LevelEditor

.DecrementLevel:
	dec [hl]
	jr nz, DebugBuilder_LevelEditor
	ld [hl], MAX_LEVEL
	jr DebugBuilder_LevelEditor

DebugBuilder_PrintLevel:
	hlcoord 1, 3
	ld de, wCurPartyLevel
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	ret

DebugBuilder_UpdateMoves:
; Clear moves
	hlcoord 1, 4
	ld b, 8
	ld c, 11
	call ClearBox
	ld hl, wListMoves_MoveIndicesBuffer
	ld bc, NUM_MOVES
	xor a
	call ByteFill

	xor a
	ld [wd0c5], a
	ld de, wListMoves_MoveIndicesBuffer
	predef FillMoves

; Update all move IDs and names
	hlcoord 1, 5
	ld de, wListMoves_MoveIndicesBuffer
	ld b, NUM_MOVES
.update_moves:
	ld a, [de]
	inc de
	and a
	jr z, .exit
; Print move
	push de
	push bc
	push hl
	ld [wTempByteValue], a
	ld de, wTempByteValue
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
; Print move name
	inc hl
	call GetMoveName
	call PlaceString
; Next move
	pop hl
	ld bc, 2 * SCREEN_WIDTH
	add hl, bc
	pop bc
	pop de
	dec b
	jr nz, .update_moves

.exit
	ret

DebugBuilder_MoveEditorDefault:
	ld de, wListMoves_MoveIndicesBuffer
	hlcoord 0, 5
	ld b, 1

DebugBuilder_MoveEditor:
	call DebugBuilder_UpdateMove

.Joypad:
	call DelayFrame
	push de
	push bc
	call JoyTextDelay
	pop bc
	pop de

	ldh a, [hJoyLast]
	bit A_BUTTON_F, a
	jp nz, .IncrementMove
	bit B_BUTTON_F, a
	jp nz, .DecrementMove
	bit START_F, a
	jp nz, DebugBuilder_SendMonToBox
	bit D_UP_F, a
	jp nz, .PreviousMove
	bit D_DOWN_F, a
	jp nz, .NextMove
	jr .Joypad

.IncrementMove:
	ld a, [de]
	inc a
	ld [de], a
	cp NUM_POKEMON + 1
	jr c, DebugBuilder_MoveEditor

	ld a, 1
	ld [de], a
	jr DebugBuilder_MoveEditor

.DecrementMove:
	ld a, [de]
	dec a
	ld [de], a
	jr nz, DebugBuilder_MoveEditor

	ld a, NUM_POKEMON
	ld [de], a
	jr DebugBuilder_MoveEditor

.PreviousMove:
	dec de
	dec b
	jp z, DebugBuilder_LevelEditor

	push bc
	ld bc, -2 * SCREEN_WIDTH
	add hl, bc
	pop bc
	jr DebugBuilder_MoveEditor

.NextMove:
	inc de
	inc b
	ld a, b
	cp 5
	jp z, DebugBuilder_StatsEditor

	push bc
	ld bc, 2 * SCREEN_WIDTH
	add hl, bc
	pop bc
	jr DebugBuilder_MoveEditor

DebugBuilder_UpdateMove:
	push hl
	push de
	push bc
; Clear out move
	push hl
	push de
	ld bc, -1 * SCREEN_WIDTH + 1
	add hl, bc
	lb bc, 2, 11
	call ClearBox
	pop de
	pop hl
; Place cursor for selected move
	push hl
	ld [hl], "▶"
; Remove current cursor (could be above or below selected move)
	ld bc, -2 * SCREEN_WIDTH
	add hl, bc
	ld [hl], " "
	ld bc, 4 * SCREEN_WIDTH
	add hl, bc
	ld [hl], " "
	pop hl
; Print new move ID
	inc hl
	ld a, [de]
	ld de, wTempByteValue
	ld [de], a
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
; Move 0 has blank name
	ld a, [wTempByteValue]
	and a
	jr z, .exit

; Print move name
	call DebugBuilder_DisplayLearnability
	inc hl
	call GetMoveName
	call PlaceString

.exit
	pop bc
	pop de
	pop hl
	ret

DebugBuilder_DisplayLearnability:
	push hl
	call DebugBuilder_CanLearnMove
	pop hl
	jr c, .exit
; Move not learnable
	ld [hl], "×"
.exit
	ret

DebugBuilder_StatsEditor:
	ld de, wDebugBuilderStats
	hlcoord 0, 13
	ld b, 1
.Update:
	call DebugBuilder_UpdateStats

.Joypad:
	call DelayFrame
	push de
	push bc
	call JoyTextDelay
	pop bc
	pop de

	ldh a, [hJoyLast]
	bit A_BUTTON_F, a
	jp nz, .IncrementStat
	bit B_BUTTON_F, a
	jp nz, .DecrementStat
	bit START_F, a
	jp nz, DebugBuilder_SendMonToBox
	bit D_UP_F, a
	jp nz, .PreviousStat
	bit D_DOWN_F, a
	jp nz, .NextStat
	jr .Joypad

.IncrementStat:
	ld a, [de]
	inc a
	ld [de], a
	jr .Update

.DecrementStat:
	ld a, [de]
	dec a
	ld [de], a
	jr .Update

.PreviousStat:
	dec de
	dec b
	jp z, .move_editor

	push bc
	ld bc, -2 * SCREEN_WIDTH
	add hl, bc
	pop bc
	jr .Update

.move_editor:
	ld de, wListMoves_MoveIndicesBuffer + 3
	hlcoord 0, 11
	ld b, 4
	jp DebugBuilder_MoveEditor

.NextStat:
	ld a, b
	cp 3
	jr z, .Update

	inc b
	inc de
	push bc
	ld bc, 2 * SCREEN_WIDTH
	add hl, bc
	pop bc
	jr .Update

DebugBuilder_UpdateStats:
	push hl
	push de
	push bc
; Place cursor
	push hl
	ld [hl], "▶"
; Remove cursor from surrounding lines
	ld bc, -2 * SCREEN_WIDTH
	add hl, bc
	ld [hl], " "
	ld bc, 4 * SCREEN_WIDTH
	add hl, bc
	ld [hl], " "
; Print value
	pop hl
	inc hl
	ld a, [de]
	ld de, wTempByteValue
	ld [de], a
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum

	call DebugBuilder_UpdateMonStats

	pop bc
	pop de
	pop hl
	ret

DebugBuilder_UpdateMonStats:
; Clear all stat values and stats text
	hlcoord 12, 0
	ld b, SCREEN_HEIGHT
	ld c, 8
	call ClearBox
; Print text (again...)
	hlcoord 13, 1
	ld de, DebugBuilder_StatsText
	call PlaceString

; Copy stat exp values
	ld b, NUM_EXP_STATS * 2
	ld hl, wTempMonStatExp
	ld a, [wDebugBuilderStatExp]
.copy
	ld [hli], a
	dec b
	jr nz, .copy

; Copy DVs
	ld a, [wDebugBuilderDVs]
	ld [hli], a
	ld a, [wDebugBuilderDVs + 1]
	ld [hl], a

; Update stats based on new stat exp and DVs
	ld hl, wTempMonExp + 2
	ld de, wTempMonMaxHP
	ld b, TRUE
	predef CalcMonStats

; Print all stat values
	hlcoord 17, 1
	ld de, wTempMonMaxHP
	ld b, NUM_STATS
.print_stat
	push bc
	push de
	push hl
	lb bc, PRINTNUM_LEADINGZEROS | 2, 3
	call PrintNum
; Next stat
	pop hl
	ld bc, 2 * SCREEN_WIDTH
	add hl, bc
	pop de
	inc de
	inc de
	pop bc
	dec b
	jr nz, .print_stat
	ret

DebugBuilder_StatsText:
	db "たいりき" ; Health
	next "<KOUGEKI>" ; Attack
	next "ぼうぎょ" ; Defense​
	next "すばやさ" ; Speed
	next "とくこう" ; Special Attack
	next "とくぼう@" ; Special Defense

DebugBuilder_SendMonToBox:
	ld a, [wCurPartyLevel]
	ld [wEnemyMonLevel], a
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	call GetBaseData

	ld a, [wCurPartySpecies]
	ld [wEnemyMon], a
	ld hl, wEnemyMonHP
	ld a, [wTempMonMaxHP]
	ld [hli], a
	ld a, [wTempMonMaxHP + 1]
	ld [hli], a

	xor a
	ld [wEnemyMonStatus], a
	ld [wEnemyMonStatus + 1], a

	ld hl, wEnemyMonMoves
	ld a, [wListMoves_MoveIndicesBuffer]
	ld [hli], a
	ld a, [wListMoves_MoveIndicesBuffer + 1]
	ld [hli], a
	ld a, [wListMoves_MoveIndicesBuffer + 2]
	ld [hli], a
	ld a, [wListMoves_MoveIndicesBuffer + 3]
	ld [hl], a

	ld hl, wEnemyMonPP
	xor a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a

	ld a, [wDebugBuilderDVs]
	ld [wEnemyMonDVs], a
	ld a, [wDebugBuilderDVs + 1]
	ld [wEnemyMonDVs + 1], a

	predef SendMonIntoBox

	ld a, BANK(s1_ad3b)
	call OpenSRAM
	ld b, 10
	ld hl, s1_ad3b
	ld a, [wDebugBuilderStatExp]
.copy
	ld [hli], a
	dec b
	jr nz, .copy
	call CloseSRAM
	pop af
	ld [wOptions], a
	jr DebugBuilder_FullBox.exit ; should have done ret

DebugBuilder_FullBox:
	ld hl, DebugBuilder_BoxIsFullText
	call PrintText

.exit
	ret

DebugBuilder_BoxIsFullText:
; The BOX is full!
	text "ボックスが いっぱい!"
	done

DebugBuilder_CanLearnMove:
; Checks to see if move can be learned as a TM, Level-Up or Egg move.
; Returns carry if valid

; Can the current pokemon learn this move?
	ld a, [wCurPartySpecies]
	push af
	call DebugBuilder_CheckLevelUpOrTMMoves
	jr c, .valid_move

; Is there a pre-evolved form? (either second or first stage)
	farcall GetPreEvolution
	jr nc, .egg_move
; Can the pre-evolved form learn it?
	call DebugBuilder_CheckLevelUpOrTMMoves
	jr c, .valid_move

; We might be on the second stage, check for another pre-evolved form.
	farcall GetPreEvolution
	jr nc, .egg_move
; Can this pre-evolved form learn it?
	call DebugBuilder_CheckLevelUpOrTMMoves
	jr c, .valid_move

; It might be able to learn the move as an egg move, check for those too.
.egg_move
	call DebugBuilder_CheckEggMoves
	jr c, .valid_move
	pop af
	ld [wCurPartySpecies], a
	and a
	ret

.valid_move
	pop af
	ld [wCurPartySpecies], a
	scf
	ret

DebugBuilder_CheckLevelUpOrTMMoves:
; See if move can be learned as TM first
	ld a, [wTempTMHM]
	ld [wTMHMMove], a
	predef CanLearnTMHMMove
	ld a, c
	and a
	jr nz, .found
; See if move can be learned as level-up move
	ld a, [wTempTMHM]
	ld d, a
	call DebugBuilder_GetLearnsetPointer
.check_move:
; Check for terminator of move list
	ld a, BANK("Evolutions and Attacks")
	call GetFarByte
	inc hl
	and a
	jr z, .not_found
; Check if move is in list
	ld a, BANK("Evolutions and Attacks")
	call GetFarByte
	inc hl
	cp d
	jr z, .found
	jr .check_move

.not_found
	and a
	ret

.found
	scf
	ret

unkData_03f_5bc7:
	db 007, 009, 010, 014, 016, 020, 022, 028
	db 049, 066, 083, 089, 091, 099, 100, 103
	db 104, 105, 114, 125, 126, 139, 142, 149
	db 152, 154, 155, 178, 179, 180, 187, 190
	db -1

DebugBuilder_CheckEggMoves:
; See if selected move is in mon's egg move list
	ld hl, EggMovePointers
	ld a, [wCurPartySpecies]
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, BANK(EggMovePointers)
	call GetFarHalfword
.next_move:
	ld a, BANK("Egg Moves")
	call GetFarByte
	inc hl
	cp -1
	jr z, .not_found
	ld b, a
	ld a, [wTempByteValue]
	cp b
	jr nz, .next_move
; found
	scf
	ret

.not_found
	and a
	ret

DebugBuilder_GetLearnsetPointer:
; 'hl' = pointer to start of a specified pokemon's level-up move list
; Skips over evolution data at the start of the list
	ld hl, EvosAttacksPointers
	ld b, 0
	ld a, [wCurPartySpecies]
	dec a
	ld c, a
	add hl, bc
	add hl, bc
	ld a, BANK(EvosAttacksPointers)
	call GetFarHalfword
.skip_evos
	ld a, BANK(EvosAttacksPointers)
	call GetFarByte
	inc hl
	and a
	jr nz, .skip_evos
	ret
