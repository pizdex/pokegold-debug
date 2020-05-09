unk_001_5a55:
	dr $5a55,$5b18

Call_001_5b18:
	dr $5b18,$5bfb

Call_001_5bfb:
	xor a
	ldh [hMapAnims], a
	call ClearTilemap
	call LoadFontsExtra
	call LoadStandardFont
	call ClearWindowData
	ret

unk_001_5c0b:
	dr $5c0b,$5c1b

unk_001_5c1b:
	dr $5c1b,$5c22

unk_001_5c22:
	dr $5c22,$5c3e

unk_001_5c3e:
	ld hl, wDebugFlags
	set 1, [hl]
	call Call_001_5c7e

	farcall unk_03f_43ae

	call Call_001_5bfb
	call Call_001_5dd5

	ld a, SPAWN_HOME
	ld [wDefaultSpawnpoint], a

	ld a, MAPSETUP_WARP
	ldh [hMapEntryMethod], a
	jp FinishContinueFunction

unk_001_5c5e:
	ld hl, wDebugFlags
	set 1, [hl]
	call Call_001_5c7e

	farcall unk_03f_43ae

	call Call_001_5bfb
	call Call_001_5dd5
	ld a, SPAWN_DEBUG
	ld [wDefaultSpawnpoint], a
	ld a, MAPSETUP_WARP
	ldh [hMapEntryMethod], a
	jp FinishContinueFunction

Call_001_5c7e:
	xor a
	ldh [hBGMapMode], a
	call Call_001_5c85
	ret

Call_001_5c85:
    ld hl, wVirtualOAM
    ld bc, $0e8b
    xor a
    call ByteFill

    ld hl, wd1b3
    ld bc, $0c83
    xor a
    call ByteFill

    ldh a, [rLY]
    ldh [hSecondsBackup], a
    call DelayFrame
    ldh a, [hRandomSub]
    ld [wd1b3], a
    ldh a, [rLY]
    ldh [hSecondsBackup], a
    call DelayFrame
    ldh a, [hRandom]
    ld [wd1b4], a

    ld hl, wPartyCount
    call .clear

    xor a
    ld [wd8af], a
    ld [wd1d3], a
    call Call_001_5d5e

    ld a, BANK(s1_ad10)
    call OpenSRAM
    ld hl, s1_ad10
    call .clear
    call CloseSRAM

    ld hl, wNumItems
    call .clear
    ld hl, wNumKeyItems
    call .clear
    ld hl, wNumBalls
    call .clear
    ld hl, wPCItems
    call .clear

    xor a
    ld [wdc90], a
    ld [wdc97], a
    ld [wdc9e], a
    ld a, $ff
    ld [wdc92], a
    ld [wdc99], a
    ld [wdca0], a
    ld [wdc93], a
    ld [wdc9a], a
    ld [wdca1], a

    ld a, BANK(s0_ab50)
    call OpenSRAM
    ld hl, s0_ab50
    xor a
    ld [hli], a
    dec a
    ld [hl], a
    call CloseSRAM

    call Call_001_5de5
    call Call_001_5d82

    xor a
    ld [wMonType], a
    ld [wJohtoBadges], a
    ld [wKantoBadges], a

    ld [wCoins], a
    ld [wCoins + 1], a

; $000bb8 = 003000
    ld [wMoney], a
    ld a, $b
    ld [wMoney + 1], a
    ld a, $b8
    ld [wMoney + 2], a

    xor a
    ld [wd927], a
    ld hl, wd929
    ld [hl], 0
    inc hl
    ld [hl], 8
    inc hl
    ld [hl], $fc
    call Call_001_5d9a

    ld a, 9
    ld hl, $6c93
    rst FarCall
    ld a, $11
    ld hl, $7d06
    rst FarCall
    call ResetGameTime
    ret

.clear
    xor a
    ld [hli], a
    dec a
    ld [hl], a
    ret

Call_001_5d5e:
	dr $5d5e,$5d82

Call_001_5d82:
	dr $5d82,$5d9a

Call_001_5d9a:
	dr $5d9a,$5dd5

Call_001_5dd5:
	dr $5dd5,$5de5

Call_001_5de5:
	dr $5de5,$5e8b

Call_001_5e8b:
	dr $5e8b,$5ece

FinishContinueFunction:
.loop
	xor a
	ld [wDontPlayMapMusicOnReload], a
	ld hl, wGameTimerPause
	set GAMETIMERPAUSE_TIMER_PAUSED_F, [hl]

	farcall OverworldLoop

	ld a, [wd1d4]
	cp SPAWN_RED
	jr z, .AfterRed
	jp Reset

.AfterRed:
	call Call_001_5e8b
	jr .loop

Call_001_5eec:
	dr $5eec,$5fd9

Call_001_5fd9:
	dr $5fd9,$5ff2

Call_001_5ff2:
	dr $5ff2,$6451

unk_001_6451:
	dr $6451,$676d

unk_001_676d:
	dr $676d,$6779
