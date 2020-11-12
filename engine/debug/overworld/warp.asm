QuickDebug_WarpOption:
	xor a
	ldh [hMapAnims], a
	call LoadStandardMenuHeader
	call ClearSprites
; Show first party mon's icon, whether or not it knows Fly
	ld a, 0
	ld [wCurPartyMon], a
	farcall EntireFlyMap
	ld a, e
	ld [wMenuSelection], a
	call CloseSubmenu
	ld a, [wMenuSelection]
	cp -1
	jr z, .return
	ld a, [wMenuSelection]
	cp -1
	jr z, .return
	cp $1c
	jr nc, .return
	ld [wDefaultSpawnpoint], a
	ld hl, wVramState
	set 6, [hl]
	ldh a, [hROMBank]
	ld hl, DebugWarp_Main
	call FarQueueScript
	ld de, SFX_ELEVATOR_END
	call PlaySFX
	call DelayFrame
	ld a, QUICKMENU_EXITSCRIPT2
	ret

.return
	ld a, QUICKMENU_UPDATE
	ret

DebugWarp_MenuHeader:
	db MENU_BACKUP_TILES ; flags
	db 01, 01 ; start coords
	db 10, 11 ; end coords
	dw .MenuData
	db 1 ; default option

.MenuData:
	db 0 ; flags
	db 4, 0 ; rows, columns
	db 1 ; spacing
	dba .DestinationMaps
	dba .SelectDestination
	dba NULL
	dba NULL

.SelectDestination:
	push de
	ld a, [wMenuSelection]
	call .GetDestinationName
	pop hl
	call PlaceString
	ret

.GetDestinationName:
	ld hl, .DestinationNames
	call GetNthString
	ld d, h
	ld e, l
	ret

.DestinationNames:
	db "じぶんのうち@" ; My home
	db "マサラ@" ; Pallet Town
	db "トキワ@" ; Viridian City
	db "ニビ@" ; Pewter City
	db "ハナダ@" ; Cerulean City
	db "イワヤマトンネルまえ@" ; Rock Tunnel Entrance
	db "クチバ@" ; Vermilion City
	db "シオン@" ; Lavender Town
	db "ヤマブキ@" ; Saffron City
	db "タマムシ@" ; Celadon City
	db "セキチク@" ; Fuchsia City
	db "グレン@" ; Cinnabar Island

	db "ワカバ@" ; New Bark Town
	db "ヨシノ@" ; Cherrygrove City
	db "キキョウ@" ; Violet City
	db "ヒワダ@" ; Azalea Town
	db "タンバ@" ; Cianwood City
	db "コガネ@" ; Goldenrod City
	db "アサギ@" ; Olivine City
	db "エンジュ@" ; Ecruteak City
	db "チョウジ@" ; Mahogany Town
	db "イカりの みずうみ@" ; Lake of Rage
	db "フスべ@" ; Blackthorn City
	db "シロガネ@" ; Mt. Silver

.DestinationMaps:
	db SPAWN_NEW_BARK, SPAWN_CHERRYGROVE, SPAWN_VIOLET, SPAWN_AZALEA, SPAWN_CIANWOOD, SPAWN_GOLDENROD
	db SPAWN_OLIVINE, SPAWN_ECRUTEAK, SPAWN_MAHOGANY, SPAWN_LAKE_OF_RAGE, SPAWN_BLACKTHORN, SPAWN_MT_SILVER

	db SPAWN_PALLET, SPAWN_VIRIDIAN, SPAWN_PEWTER, SPAWN_CERULEAN, SPAWN_ROCK_TUNNEL, SPAWN_VERMILION
	db SPAWN_LAVENDER, SPAWN_SAFFRON, SPAWN_CELADON, SPAWN_FUCHSIA, SPAWN_CINNABAR

	db -1

DebugWarp_Main:
	call DebugWarp_Textbox
	ldh a, [hROMBank]
	ld hl, DebugWarp_TeleportScript
	call FarQueueScript
	ret

DebugWarp_Textbox:
	ld hl, .WarpText
	call QuickDebug_TextboxWaitAorB
	ret

.WarpText:
; "Warping…"
	text "ワープします!"
	done

DebugWarp_TeleportScript:
	applymovement PLAYER, .TeleportFrom
	newloadmap MAPSETUP_TELEPORT
	applymovement PLAYER, .TeleportTo
	end

.TeleportFrom:
	teleport_from
	step_end

.TeleportTo:
	teleport_to
	step_end
