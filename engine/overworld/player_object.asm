SpawnPlayer:
	ld a, -1
	ld [wObjectFollow_Leader], a
	ld [wObjectFollow_Follower], a
	ld a, PLAYER
	ld hl, PlayerObjectTemplate
	call CopyPlayerObjectTemplate
	ld b, PLAYER
	call PlayerSpawn_ConvertCoords
	ld a, PLAYER_OBJECT
	ldh [hObjectStructIndexBuffer], a
	ld de, wObjectStructs
	ld a, PLAYER_OBJECT
	ldh [hMapObjectIndexBuffer], a
	ld bc, wMapObjects
	call CopyMapObjectToObjectStruct
	ld a, PLAYER
	ld [wd1e9], a
	ret

PlayerObjectTemplate:
; A dummy map object used to initialize the player object.
; Shorter than the actual amount copied by two bytes.
; Said bytes seem to be unused.
_NUM_OBJECT_EVENTS = 0
	object_event -4, -4, SPRITE_CHRIS, SPRITEMOVEDATA_PLAYER, 15, 15, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, 0, -1

CopyDECoordsToMapObject::
	push de
	ld a, b
	call GetMapObject
	pop de
	ld hl, MAPOBJECT_X_COORD
	add hl, bc
	ld [hl], d
	ld hl, MAPOBJECT_Y_COORD
	add hl, bc
	ld [hl], e
	ret

PlayerSpawn_ConvertCoords:
	push bc
	ld a, [wXCoord]
	add 4
	ld d, a
	ld a, [wYCoord]
	add 4
	ld e, a
	pop bc
	call CopyDECoordsToMapObject
	ret

WriteObjectXY::
	ld a, b
	call CheckObjectVisibility
	ret c

	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld d, [hl]
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld e, [hl]
	ldh a, [hMapObjectIndexBuffer]
	ld b, a
	call CopyDECoordsToMapObject
	and a
	ret

RefreshPlayerCoords:
	ld a, [wXCoord]
	add 4
	ld d, a
	ld hl, wPlayerStandingMapX
	sub [hl]
	ld [hl], d
	ld hl, wMapObjects + MAPOBJECT_X_COORD
	ld [hl], d
	ld hl, wPlayerLastMapX
	ld [hl], d
	ld d, a
	ld a, [wYCoord]
	add 4
	ld e, a
	ld hl, wPlayerStandingMapY
	sub [hl]
	ld [hl], e
	ld hl, wMapObjects + MAPOBJECT_Y_COORD
	ld [hl], e
	ld hl, wPlayerLastMapY
	ld [hl], e
	ld e, a
; the next three lines are useless
	ld a, [wObjectFollow_Leader]
	cp PLAYER
	ret nz
	ret

SpawnObject1:
	ld a, 1
	ld hl, UnusedObject1Template
	call CopyPlayerObjectTemplate
	ld b, 1
	call PlayerSpawn_ConvertCoords
	ret

UnusedObject1Template:
	object_event -4, -4, SPRITE_CHRIS, SPRITEMOVEDATA_12, 15, 15, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, 0, -1

CopyObjectStruct::
	call CheckObjectMask
	and a
	ret nz ; masked

	ld hl, wObjectStructs + OBJECT_LENGTH * 1
	ld a, 1
	ld de, OBJECT_LENGTH
.loop
	ldh [hObjectStructIndexBuffer], a
	ld a, [hl]
	and a
	jr z, .done
	add hl, de
	ldh a, [hObjectStructIndexBuffer]
	inc a
	cp NUM_OBJECT_STRUCTS
	jr nz, .loop
	scf
	ret ; overflow

.done
	ld d, h
	ld e, l
	call CopyMapObjectToObjectStruct
	ld a, [wVramState]
	bit 7, a
	ret z

	ld hl, OBJECT_FLAGS2
	add hl, de
	set 5, [hl]
	ret

CopyMapObjectToObjectStruct:
	call .CopyMapObjectToTempObject
	call CopyTempObjectToObjectStruct
	ret

.CopyMapObjectToTempObject:
	ldh a, [hObjectStructIndexBuffer]
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ld [hl], a

	ldh a, [hMapObjectIndexBuffer]
	ld [wce8d], a

	ld hl, MAPOBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	ld [wce8e], a

	call GetSpriteVTile
	ld [wce8f], a

	ld a, [hl]
	call GetSpritePalette
	ld [wce90], a

	ld hl, MAPOBJECT_COLOR
	add hl, bc
	ld a, [hl]
	and $f0
	jr z, .skip_color_override
	swap a
	and PALETTE_MASK
	ld [wce90], a

.skip_color_override
	ld hl, MAPOBJECT_MOVEMENT
	add hl, bc
	ld a, [hl]
	ld [wce91], a

	ld hl, MAPOBJECT_RANGE
	add hl, bc
	ld a, [hl]
	ld [wce92], a

	ld hl, MAPOBJECT_X_COORD
	add hl, bc
	ld a, [hl]
	ld [wce93], a

	ld hl, MAPOBJECT_Y_COORD
	add hl, bc
	ld a, [hl]
	ld [wce94], a

	ld hl, MAPOBJECT_RADIUS
	add hl, bc
	ld a, [hl]
	ld [wce95], a
	ret

InitializeVisibleSprites:
	ld bc, wMap2Object
	ld a, 2
.loop
	ldh [hMapObjectIndexBuffer], a
	ld hl, MAPOBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	and a
	jr z, .next

	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ld a, [hl]
	cp -1
	jr nz, .next

	ld a, [wXCoord]
	ld d, a
	ld a, [wYCoord]
	ld e, a

	ld hl, MAPOBJECT_X_COORD
	add hl, bc
	ld a, [hl]
	add 1
	sub d
	jr c, .next

	cp MAPOBJECT_SCREEN_WIDTH
	jr nc, .next

	ld hl, MAPOBJECT_Y_COORD
	add hl, bc
	ld a, [hl]
	add 1
	sub e
	jr c, .next

	cp MAPOBJECT_SCREEN_HEIGHT
	jr nc, .next

	push bc
	call CopyObjectStruct
	pop bc
	jp c, .ret

.next
	ld hl, MAPOBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hMapObjectIndexBuffer]
	inc a
	cp NUM_OBJECTS
	jr nz, .loop
	ret

.ret
	ret

CheckObjectEnteringVisibleRange::
	nop
	ld a, [wPlayerStepDirection]
	cp STANDING
	ret z
	ld hl, .dw
	rst JumpTable
	ret

.dw
	dw .Down
	dw .Up
	dw .Left
	dw .Right

.Up:
	ld a, [wYCoord]
	sub 1
	jr .Vertical

.Down:
	ld a, [wYCoord]
	add 9
.Vertical:
	ld d, a
	ld a, [wXCoord]
	ld e, a
	ld bc, wMap2Object
	ld a, 2
.loop_v
	ldh [hMapObjectIndexBuffer], a
	ld hl, MAPOBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	and a
	jr z, .next_v
	ld hl, MAPOBJECT_Y_COORD
	add hl, bc
	ld a, d
	cp [hl]
	jr nz, .next_v
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ld a, [hl]
	cp -1
	jr nz, .next_v
	ld hl, MAPOBJECT_X_COORD
	add hl, bc
	ld a, [hl]
	add 1
	sub e
	jr c, .next_v
	cp MAPOBJECT_SCREEN_WIDTH
	jr nc, .next_v
	push de
	push bc
	call CopyObjectStruct
	pop bc
	pop de

.next_v
	ld hl, MAPOBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hMapObjectIndexBuffer]
	inc a
	cp NUM_OBJECTS
	jr nz, .loop_v
	ret

.Left:
	ld a, [wXCoord]
	sub 1
	jr .Horizontal

.Right:
	ld a, [wXCoord]
	add 10
.Horizontal:
	ld e, a
	ld a, [wYCoord]
	ld d, a
	ld bc, wMap2Object
	ld a, 2
.loop_h
	ldh [hMapObjectIndexBuffer], a
	ld hl, MAPOBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	and a
	jr z, .next_h
	ld hl, MAPOBJECT_X_COORD
	add hl, bc
	ld a, e
	cp [hl]
	jr nz, .next_h
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ld a, [hl]
	cp -1
	jr nz, .next_h
	ld hl, MAPOBJECT_Y_COORD
	add hl, bc
	ld a, [hl]
	add 1
	sub d
	jr c, .next_h
	cp MAPOBJECT_SCREEN_HEIGHT
	jr nc, .next_h
	push de
	push bc
	call CopyObjectStruct
	pop bc
	pop de

.next_h
	ld hl, MAPOBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hMapObjectIndexBuffer]
	inc a
	cp NUM_OBJECTS
	jr nz, .loop_h
	ret

CopyTempObjectToObjectStruct:
	ld a, [wce8d]
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, de
	ld [hl], a

	ld a, [wce91]
	call CopySpriteMovementData

	ld a, [wce90]
	ld hl, OBJECT_PALETTE
	add hl, de
	or [hl]
	ld [hl], a

	ld a, [wce94]
	call .InitYCoord

	ld a, [wce93]
	call .InitXCoord

	ld a, [wce8e]
	ld hl, OBJECT_SPRITE
	add hl, de
	ld [hl], a

	ld a, [wce8f]
	ld hl, OBJECT_SPRITE_TILE
	add hl, de
	ld [hl], a

	ld hl, OBJECT_STEP_TYPE
	add hl, de
	ld [hl], STEP_TYPE_RESET

	ld hl, OBJECT_FACING_STEP
	add hl, de
	ld [hl], STANDING

	ld a, [wce95]
	call .InitRadius

	ld a, [wce92]
	ld hl, OBJECT_RANGE
	add hl, de
	ld [hl], a

	and a
	ret

.InitYCoord:
	ld hl, OBJECT_INIT_Y
	add hl, de
	ld [hl], a

	ld hl, OBJECT_NEXT_MAP_Y
	add hl, de
	ld [hl], a

	ld hl, wYCoord
	sub [hl]
	and $f
	swap a
	ld hl, wce76
	sub [hl]
	ld hl, OBJECT_SPRITE_Y
	add hl, de
	ld [hl], a
	ret

.InitXCoord:
	ld hl, OBJECT_INIT_X
	add hl, de
	ld [hl], a
	ld hl, OBJECT_NEXT_MAP_X
	add hl, de
	ld [hl], a
	ld hl, wXCoord
	sub [hl]
	and $f
	swap a
	ld hl, wce75
	sub [hl]
	ld hl, OBJECT_SPRITE_X
	add hl, de
	ld [hl], a
	ret

.InitRadius:
	ld h, a
	inc a
	and $f
	ld l, a
	ld a, h
	add $10
	and $f0
	or l
	ld hl, OBJECT_RADIUS
	add hl, de
	ld [hl], a
	ret

TrainerWalkToPlayer::
	dr $8c3c, $8df7
