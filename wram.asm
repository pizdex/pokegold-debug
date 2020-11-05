INCLUDE "constants.asm"

INCLUDE "macros/wram.asm"

INCLUDE "vram.asm"

SECTION "Audio RAM", WRAM0

wc000:: ds 1 ; c000
wc001:: ds 1 ; c001
wc002:: ds 1 ; c002
wc003:: ds 1 ; c003
wc004:: ds 1 ; c004
wc005:: ds 1 ; c005
wc006:: ds 1 ; c006
wc007:: ds 1 ; c007
wc008:: ds 1 ; c008
wc009:: ds 1 ; c009
wc00a:: ds 1 ; c00a
wc00b:: ds 1 ; c00b
wc00c:: ds 1 ; c00c
wc00d:: ds 1 ; c00d
wc00e:: ds 1 ; c00e
wc00f:: ds 1 ; c00f
wc010:: ds 1 ; c010
wc011:: ds 1 ; c011
wc012:: ds 1 ; c012
wc013:: ds 1 ; c013
wc014:: ds 1 ; c014
wc015:: ds 1 ; c015
wc016:: ds 1 ; c016
wc017:: ds 1 ; c017
wc018:: ds 1 ; c018
wc019:: ds 1 ; c019
wc01a:: ds 1 ; c01a
wc01b:: ds 1 ; c01b
wc01c:: ds 1 ; c01c
wc01d:: ds 1 ; c01d
wc01e:: ds 1 ; c01e
wc01f:: ds 1 ; c01f
wc020:: ds 1 ; c020
wc021:: ds 1 ; c021
wc022:: ds 1 ; c022
wc023:: ds 1 ; c023
wc024:: ds 1 ; c024
wc025:: ds 1 ; c025
wc026:: ds 1 ; c026
wc027:: ds 1 ; c027
wc028:: ds 1 ; c028
wc029:: ds 1 ; c029
wc02a:: ds 1 ; c02a
wc02b:: ds 1 ; c02b
wc02c:: ds 1 ; c02c
wc02d:: ds 1 ; c02d
wc02e:: ds 1 ; c02e
wc02f:: ds 1 ; c02f
wc030:: ds 1 ; c030
wc031:: ds 1 ; c031
wc032:: ds 1 ; c032
wc033:: ds 1 ; c033
wc034:: ds 1 ; c034
wc035:: ds 1 ; c035
wc036:: ds 1 ; c036
wc037:: ds 1 ; c037
wc038:: ds 1 ; c038
wc039:: ds 1 ; c039
wc03a:: ds 1 ; c03a
wc03b:: ds 1 ; c03b
wc03c:: ds 1 ; c03c
wc03d:: ds 1 ; c03d
wc03e:: ds 1 ; c03e
wc03f:: ds 1 ; c03f
wc040:: ds 1 ; c040
wc041:: ds 1 ; c041
wc042:: ds 1 ; c042
wc043:: ds 1 ; c043
wc044:: ds 1 ; c044
wc045:: ds 1 ; c045
wc046:: ds 1 ; c046
wc047:: ds 1 ; c047
wc048:: ds 1 ; c048
wc049:: ds 1 ; c049
wc04a:: ds 1 ; c04a
wc04b:: ds 1 ; c04b
wc04c:: ds 1 ; c04c
wc04d:: ds 1 ; c04d
wc04e:: ds 1 ; c04e
wc04f:: ds 1 ; c04f
wc050:: ds 1 ; c050
wc051:: ds 1 ; c051
wc052:: ds 1 ; c052
wc053:: ds 1 ; c053
wc054:: ds 1 ; c054
wc055:: ds 1 ; c055
wc056:: ds 1 ; c056
wc057:: ds 1 ; c057
wc058:: ds 1 ; c058
wc059:: ds 1 ; c059
wc05a:: ds 1 ; c05a
wc05b:: ds 1 ; c05b
wc05c:: ds 1 ; c05c
wc05d:: ds 1 ; c05d
wc05e:: ds 1 ; c05e
wc05f:: ds 1 ; c05f
wc060:: ds 1 ; c060
wc061:: ds 1 ; c061
wc062:: ds 1 ; c062
wc063:: ds 1 ; c063
wc064:: ds 1 ; c064
wc065:: ds 1 ; c065
wc066:: ds 1 ; c066
wc067:: ds 1 ; c067
wc068:: ds 1 ; c068
wc069:: ds 1 ; c069
wc06a:: ds 1 ; c06a
wc06b:: ds 1 ; c06b
wc06c:: ds 1 ; c06c
wc06d:: ds 1 ; c06d
wc06e:: ds 1 ; c06e
wc06f:: ds 1 ; c06f
wc070:: ds 1 ; c070
wc071:: ds 1 ; c071
wc072:: ds 1 ; c072
wc073:: ds 1 ; c073
wc074:: ds 1 ; c074
wc075:: ds 1 ; c075
wc076:: ds 1 ; c076
wc077:: ds 1 ; c077
wc078:: ds 1 ; c078
wc079:: ds 1 ; c079
wc07a:: ds 1 ; c07a
wc07b:: ds 1 ; c07b
wc07c:: ds 1 ; c07c
wc07d:: ds 1 ; c07d
wc07e:: ds 1 ; c07e
wc07f:: ds 1 ; c07f
wc080:: ds 1 ; c080
wc081:: ds 1 ; c081
wc082:: ds 1 ; c082
wc083:: ds 1 ; c083
wc084:: ds 1 ; c084
wc085:: ds 1 ; c085
wc086:: ds 1 ; c086
wc087:: ds 1 ; c087
wc088:: ds 1 ; c088
wc089:: ds 1 ; c089
wc08a:: ds 1 ; c08a
wc08b:: ds 1 ; c08b
wc08c:: ds 1 ; c08c
wc08d:: ds 1 ; c08d
wc08e:: ds 1 ; c08e
wc08f:: ds 1 ; c08f
wc090:: ds 1 ; c090
wc091:: ds 1 ; c091
wc092:: ds 1 ; c092
wc093:: ds 1 ; c093
wc094:: ds 1 ; c094
wc095:: ds 1 ; c095
wc096:: ds 1 ; c096
wc097:: ds 1 ; c097
wc098:: ds 1 ; c098
wc099:: ds 1 ; c099
wc09a:: ds 1 ; c09a
wc09b:: ds 1 ; c09b
wc09c:: ds 1 ; c09c
wc09d:: ds 1 ; c09d
wc09e:: ds 1 ; c09e
wc09f:: ds 1 ; c09f
wc0a0:: ds 1 ; c0a0
wc0a1:: ds 1 ; c0a1
wc0a2:: ds 1 ; c0a2
wc0a3:: ds 1 ; c0a3
wc0a4:: ds 1 ; c0a4
wc0a5:: ds 1 ; c0a5
wc0a6:: ds 1 ; c0a6
wc0a7:: ds 1 ; c0a7
wc0a8:: ds 1 ; c0a8
wc0a9:: ds 1 ; c0a9
wc0aa:: ds 1 ; c0aa
wc0ab:: ds 1 ; c0ab
wc0ac:: ds 1 ; c0ac
wc0ad:: ds 1 ; c0ad
wc0ae:: ds 1 ; c0ae
wc0af:: ds 1 ; c0af
wc0b0:: ds 1 ; c0b0
wc0b1:: ds 1 ; c0b1
wc0b2:: ds 1 ; c0b2
wc0b3:: ds 1 ; c0b3
wc0b4:: ds 1 ; c0b4
wc0b5:: ds 1 ; c0b5
wc0b6:: ds 1 ; c0b6
wc0b7:: ds 1 ; c0b7
wc0b8:: ds 1 ; c0b8
wc0b9:: ds 1 ; c0b9
wc0ba:: ds 1 ; c0ba
wc0bb:: ds 1 ; c0bb
wc0bc:: ds 1 ; c0bc
wc0bd:: ds 1 ; c0bd
wc0be:: ds 1 ; c0be
wc0bf:: ds 1 ; c0bf
wc0c0:: ds 1 ; c0c0
wc0c1:: ds 1 ; c0c1
wc0c2:: ds 1 ; c0c2
wc0c3:: ds 1 ; c0c3
wc0c4:: ds 1 ; c0c4
wc0c5:: ds 1 ; c0c5
wc0c6:: ds 1 ; c0c6
wc0c7:: ds 1 ; c0c7
wc0c8:: ds 1 ; c0c8

wSFXChannels::
wChannel5:: channel_struct wChannel5 ; c0c9
wChannel6:: channel_struct wChannel6 ; c0fe
wChannel7:: channel_struct wChannel7 ; c130
wChannel8:: channel_struct wChannel8 ; c162

wc191:: ds 1 ; c191
wc192:: ds 1 ; c192
wc193:: ds 1 ; c193
wc194:: ds 1 ; c194
wc195:: ds 1 ; c195
wUnusedBCDNumber:: ds 1 ; c196
wc197:: ds 1 ; c197

wCurMusicByte:: ds 1 ; c198
wc199:: ds 1 ; c199
wVolume:: ds 1 ; c19a
wc19b:: ds 1 ; c19b
wSoundInput:: ds 1 ; c19c
wc19d:: ds 1 ; c19d
wc19e:: ds 1 ; c19e
wc19f:: ds 1 ; c19f
wc1a0:: ds 1 ; c1a0
wc1a1:: ds 1 ; c1a1
wc1a2:: ds 1 ; c1a2
wc1a3:: ds 1 ; c1a3
wc1a4:: ds 1 ; c1a4
wc1a5:: ds 1 ; c1a5
wc1a6:: ds 1 ; c1a6

wMusicFade:: ds 1 ; c1a7
wMusicFadeCount:: ds 1 ; c1a8
wMusicFadeID:: ds 7 ; c1a9

wCryPitch:: ds 2 ; c1b0
wCryLength:: ds 2 ; c1b2

wc1b4:: ds 1 ; c1b4
wc1b5:: ds 1 ; c1b5
wc1b6:: ds 1 ; c1b6
wc1b7:: ds 1 ; c1b7
wc1b8:: ds 1 ; c1b8
wc1b9:: ds 1 ; c1b9
wc1ba:: ds 1 ; c1ba
wc1bb:: ds 1 ; c1bb

wStereoPanningMask:: ds 1 ; c1bc
wCryTracks:: ds 1 ; c1bd

wc1be:: ds 1 ; c1be
wCurSFX:: ds 1 ; c1bf
wMapMusic:: ds 1 ; c1c0
wDontPlayMapMusicOnReload:: ds 1 ; c1c1

SECTION "WRAM", WRAM0

wLZAddress:: ds 2 ; c1c2
wLZBank:: ds 1 ; c1c4

wc1c5:: ds 1 ; c1c5

wInputType:: ds 1 ; c1c6
wAutoInputAddress:: ds 2 ; c1c7
wAutoInputBank:: ds 1 ; c1c9
wAutoInputLength:: ds 1 ; c1ca

wDebugFlags:: ds 1 ; c1cb
wGameLogicPaused:: ds 1 ; c1cc
wSpriteUpdatesEnabled:: ds 1 ; c1cd
wc1ce:: ds 1 ; c1ce
wMapTimeOfDay:: ds 1 ; c1cf
	ds 3

wPrinterConnectionOpen:: ds 1 ; c1d3
wPrinterOpcode:: ds 1 ; c1d4

wc1d5:: ds 1 ; c1d5

wDisableTextAcceleration:: ds 1 ; c1d6

wc1d7:: ds 1 ; c1d7
wc1d8:: ds 1 ; c1d8
wc1d9:: ds 1 ; c1d9
wc1da:: ds 1 ; c1da
wc1db:: ds 1 ; c1db
wc1dc:: ds 1 ; c1dc
wc1dd:: ds 1 ; c1dd
wc1de:: ds 1 ; c1de
wc1df:: ds 1 ; c1df
wc1e0:: ds 1 ; c1e0
wc1e1:: ds 1 ; c1e1
wc1e2:: ds 1 ; c1e2
wc1e3:: ds 1 ; c1e3
wc1e4:: ds 1 ; c1e4
wc1e5:: ds 1 ; c1e5
wc1e6:: ds 1 ; c1e6
wc1e7:: ds 1 ; c1e7
wc1e8:: ds 1 ; c1e8
wc1e9:: ds 1 ; c1e9
wc1ea:: ds 1 ; c1ea
wc1eb:: ds 1 ; c1eb
wc1ec:: ds 1 ; c1ec
wc1ed:: ds 1 ; c1ed
wc1ee:: ds 1 ; c1ee
wc1ef:: ds 1 ; c1ef
wc1f0:: ds 1 ; c1f0
wc1f1:: ds 1 ; c1f1
wc1f2:: ds 1 ; c1f2
wc1f3:: ds 1 ; c1f3
wc1f4:: ds 1 ; c1f4
wc1f5:: ds 1 ; c1f5
wc1f6:: ds 1 ; c1f6
wc1f7:: ds 1 ; c1f7
wc1f8:: ds 1 ; c1f8
wc1f9:: ds 1 ; c1f9
wc1fa:: ds 1 ; c1fa
wc1fb:: ds 1 ; c1fb
wc1fc:: ds 1 ; c1fc
wc1fd:: ds 1 ; c1fd
wc1fe:: ds 1 ; c1fe
wc1ff:: ds 1 ; c1ff

SECTION "GBC Palettes", WRAM0

; eight 4-color palettes each
wBGPals1:: ds 8 palettes
wOBPals1:: ds 8 palettes
wBGPals2:: ds 8 palettes
wOBPals2:: ds 8 palettes


SECTION "Sprites", WRAM0

wVirtualOAM:: ; c300
wVirtualOAMSprite00:: sprite_oam_struct wVirtualOAMSprite00
wVirtualOAMSprite01:: sprite_oam_struct wVirtualOAMSprite01
wVirtualOAMSprite02:: sprite_oam_struct wVirtualOAMSprite02
wVirtualOAMSprite03:: sprite_oam_struct wVirtualOAMSprite03
wVirtualOAMSprite04:: sprite_oam_struct wVirtualOAMSprite04
wVirtualOAMSprite05:: sprite_oam_struct wVirtualOAMSprite05
wVirtualOAMSprite06:: sprite_oam_struct wVirtualOAMSprite06
wVirtualOAMSprite07:: sprite_oam_struct wVirtualOAMSprite07
wVirtualOAMSprite08:: sprite_oam_struct wVirtualOAMSprite08
wVirtualOAMSprite09:: sprite_oam_struct wVirtualOAMSprite09
wVirtualOAMSprite10:: sprite_oam_struct wVirtualOAMSprite10
wVirtualOAMSprite11:: sprite_oam_struct wVirtualOAMSprite11
wVirtualOAMSprite12:: sprite_oam_struct wVirtualOAMSprite12
wVirtualOAMSprite13:: sprite_oam_struct wVirtualOAMSprite13
wVirtualOAMSprite14:: sprite_oam_struct wVirtualOAMSprite14
wVirtualOAMSprite15:: sprite_oam_struct wVirtualOAMSprite15
wVirtualOAMSprite16:: sprite_oam_struct wVirtualOAMSprite16
wVirtualOAMSprite17:: sprite_oam_struct wVirtualOAMSprite17
wVirtualOAMSprite18:: sprite_oam_struct wVirtualOAMSprite18
wVirtualOAMSprite19:: sprite_oam_struct wVirtualOAMSprite19
wVirtualOAMSprite20:: sprite_oam_struct wVirtualOAMSprite20
wVirtualOAMSprite21:: sprite_oam_struct wVirtualOAMSprite21
wVirtualOAMSprite22:: sprite_oam_struct wVirtualOAMSprite22
wVirtualOAMSprite23:: sprite_oam_struct wVirtualOAMSprite23
wVirtualOAMSprite24:: sprite_oam_struct wVirtualOAMSprite24
wVirtualOAMSprite25:: sprite_oam_struct wVirtualOAMSprite25
wVirtualOAMSprite26:: sprite_oam_struct wVirtualOAMSprite26
wVirtualOAMSprite27:: sprite_oam_struct wVirtualOAMSprite27
wVirtualOAMSprite28:: sprite_oam_struct wVirtualOAMSprite28
wVirtualOAMSprite29:: sprite_oam_struct wVirtualOAMSprite29
wVirtualOAMSprite30:: sprite_oam_struct wVirtualOAMSprite30
wVirtualOAMSprite31:: sprite_oam_struct wVirtualOAMSprite31
wVirtualOAMSprite32:: sprite_oam_struct wVirtualOAMSprite32
wVirtualOAMSprite33:: sprite_oam_struct wVirtualOAMSprite33
wVirtualOAMSprite34:: sprite_oam_struct wVirtualOAMSprite34
wVirtualOAMSprite35:: sprite_oam_struct wVirtualOAMSprite35
wVirtualOAMSprite36:: sprite_oam_struct wVirtualOAMSprite36
wVirtualOAMSprite37:: sprite_oam_struct wVirtualOAMSprite37
wVirtualOAMSprite38:: sprite_oam_struct wVirtualOAMSprite38
wVirtualOAMSprite39:: sprite_oam_struct wVirtualOAMSprite39
wVirtualOAMEnd::

SECTION "Tilemap", WRAM0
wTilemap:: ; c3a0
	ds SCREEN_HEIGHT * SCREEN_WIDTH
wTilemapEnd:: ; c508

SECTION "Animated Objects", WRAM0
wMisc:: ; c508
wTempTilemap:: ; c508
	; ds SCREEN_HEIGHT * SCREEN_WIDTH

wc508:: ds 1 ; c508
wc509:: ds 1 ; c509
wc50a:: ds 1 ; c50a
wc50b:: ds 1 ; c50b
wc50c:: ds 1 ; c50c
wc50d:: ds 1 ; c50d
wc50e:: ds 1 ; c50e
wc50f:: ds 1 ; c50f
wc510:: ds 1 ; c510
wc511:: ds 1 ; c511
wc512:: ds 1 ; c512
wc513:: ds 1 ; c513
wc514:: ds 1 ; c514
wc515:: ds 1 ; c515
wc516:: ds 1 ; c516
wc517:: ds 1 ; c517
wc518:: ds 1 ; c518
wc519:: ds 1 ; c519
wc51a:: ds 1 ; c51a
wc51b:: ds 1 ; c51b
wc51c:: ds 1 ; c51c
wc51d:: ds 1 ; c51d
wc51e:: ds 1 ; c51e
wc51f:: ds 1 ; c51f
wc520:: ds 1 ; c520
wc521:: ds 1 ; c521
wc522:: ds 1 ; c522
wc523:: ds 1 ; c523
wc524:: ds 1 ; c524
wc525:: ds 1 ; c525
wc526:: ds 1 ; c526
wc527:: ds 1 ; c527
wc528:: ds 1 ; c528
wc529:: ds 1 ; c529
wc52a:: ds 1 ; c52a
wc52b:: ds 1 ; c52b
wc52c:: ds 1 ; c52c
wc52d:: ds 1 ; c52d
wc52e:: ds 1 ; c52e
wc52f:: ds 1 ; c52f
wc530:: ds 1 ; c530
wc531:: ds 1 ; c531
wc532:: ds 1 ; c532
wc533:: ds 1 ; c533
wc534:: ds 1 ; c534
wc535:: ds 1 ; c535
wc536:: ds 1 ; c536
wc537:: ds 1 ; c537
wc538:: ds 1 ; c538
wc539:: ds 1 ; c539
wc53a:: ds 1 ; c53a
wc53b:: ds 1 ; c53b
wc53c:: ds 1 ; c53c
wc53d:: ds 1 ; c53d
wc53e:: ds 1 ; c53e
wc53f:: ds 1 ; c53f
wc540:: ds 1 ; c540
wc541:: ds 1 ; c541
wc542:: ds 1 ; c542
wc543:: ds 1 ; c543
wc544:: ds 1 ; c544
wc545:: ds 1 ; c545
wc546:: ds 1 ; c546
wc547:: ds 1 ; c547
wc548:: ds 1 ; c548
wc549:: ds 1 ; c549
wc54a:: ds 1 ; c54a
wc54b:: ds 1 ; c54b
wc54c:: ds 1 ; c54c
wc54d:: ds 1 ; c54d
wc54e:: ds 1 ; c54e
wc54f:: ds 1 ; c54f
wc550:: ds 1 ; c550
wc551:: ds 1 ; c551
wc552:: ds 1 ; c552
wc553:: ds 1 ; c553
wc554:: ds 1 ; c554
wc555:: ds 1 ; c555
wc556:: ds 1 ; c556
wc557:: ds 1 ; c557
wc558:: ds 1 ; c558
wc559:: ds 1 ; c559
wc55a:: ds 1 ; c55a
wc55b:: ds 1 ; c55b
wc55c:: ds 1 ; c55c
wc55d:: ds 1 ; c55d
wc55e:: ds 1 ; c55e
wc55f:: ds 1 ; c55f
wc560:: ds 1 ; c560
wc561:: ds 1 ; c561
wc562:: ds 1 ; c562
wc563:: ds 1 ; c563
wc564:: ds 1 ; c564
wc565:: ds 1 ; c565
wc566:: ds 1 ; c566
wc567:: ds 1 ; c567
wc568:: ds 1 ; c568
wc569:: ds 1 ; c569
wc56a:: ds 1 ; c56a
wc56b:: ds 1 ; c56b
wc56c:: ds 1 ; c56c
wc56d:: ds 1 ; c56d
wc56e:: ds 1 ; c56e
wc56f:: ds 1 ; c56f
wc570:: ds 1 ; c570
wc571:: ds 1 ; c571
wc572:: ds 1 ; c572
wc573:: ds 1 ; c573
wc574:: ds 1 ; c574
wc575:: ds 1 ; c575
wc576:: ds 1 ; c576
wc577:: ds 1 ; c577
wc578:: ds 1 ; c578
wc579:: ds 1 ; c579
wc57a:: ds 1 ; c57a
wc57b:: ds 1 ; c57b
wc57c:: ds 1 ; c57c
wc57d:: ds 1 ; c57d
wc57e:: ds 1 ; c57e
wc57f:: ds 1 ; c57f
wc580:: ds 1 ; c580
wc581:: ds 1 ; c581
wc582:: ds 1 ; c582
wc583:: ds 1 ; c583
wc584:: ds 1 ; c584
wc585:: ds 1 ; c585
wc586:: ds 1 ; c586
wc587:: ds 1 ; c587
wc588:: ds 1 ; c588
wc589:: ds 1 ; c589
wc58a:: ds 1 ; c58a
wc58b:: ds 1 ; c58b
wc58c:: ds 1 ; c58c
wc58d:: ds 1 ; c58d
wc58e:: ds 1 ; c58e
wc58f:: ds 1 ; c58f
wc590:: ds 1 ; c590
wc591:: ds 1 ; c591
wc592:: ds 1 ; c592
wc593:: ds 1 ; c593
wc594:: ds 1 ; c594
wc595:: ds 1 ; c595
wc596:: ds 1 ; c596
wc597:: ds 1 ; c597
wc598:: ds 1 ; c598
wc599:: ds 1 ; c599
wc59a:: ds 1 ; c59a
wc59b:: ds 1 ; c59b
wc59c:: ds 1 ; c59c
wc59d:: ds 1 ; c59d
wc59e:: ds 1 ; c59e
wc59f:: ds 1 ; c59f
wc5a0:: ds 1 ; c5a0
wc5a1:: ds 1 ; c5a1
wc5a2:: ds 1 ; c5a2
wc5a3:: ds 1 ; c5a3
wc5a4:: ds 1 ; c5a4
wc5a5:: ds 1 ; c5a5
wc5a6:: ds 1 ; c5a6
wc5a7:: ds 1 ; c5a7
wc5a8:: ds 1 ; c5a8
wc5a9:: ds 1 ; c5a9
wc5aa:: ds 1 ; c5aa
wc5ab:: ds 1 ; c5ab
wc5ac:: ds 1 ; c5ac
wc5ad:: ds 1 ; c5ad
wc5ae:: ds 1 ; c5ae
wc5af:: ds 1 ; c5af
wc5b0:: ds 1 ; c5b0
wc5b1:: ds 1 ; c5b1
wc5b2:: ds 1 ; c5b2
wc5b3:: ds 1 ; c5b3
wc5b4:: ds 1 ; c5b4
wc5b5:: ds 1 ; c5b5
wc5b6:: ds 1 ; c5b6
wc5b7:: ds 1 ; c5b7
wc5b8:: ds 1 ; c5b8
wc5b9:: ds 1 ; c5b9
wc5ba:: ds 1 ; c5ba
wc5bb:: ds 1 ; c5bb
wc5bc:: ds 1 ; c5bc
wc5bd:: ds 1 ; c5bd
wc5be:: ds 1 ; c5be
wc5bf:: ds 1 ; c5bf

wAnimatedObjectStructIDBuffer:: ds 1 ; c5c0

wc5c1:: ds 1 ; c5c1
wc5c2:: ds 1 ; c5c2
wc5c3:: ds 1 ; c5c3
wc5c4:: ds 1 ; c5c4
wc5c5:: ds 1 ; c5c5
wc5c6:: ds 1 ; c5c6
wc5c7:: ds 1 ; c5c7
wc5c8:: ds 1 ; c5c8
wc5c9:: ds 1 ; c5c9
wc5ca:: ds 1 ; c5ca
wc5cb:: ds 1 ; c5cb
wc5cc:: ds 1 ; c5cc
wc5cd:: ds 1 ; c5cd
wc5ce:: ds 1 ; c5ce
wc5cf:: ds 1 ; c5cf
wc5d0:: ds 1 ; c5d0
wc5d1:: ds 1 ; c5d1
wc5d2:: ds 1 ; c5d2
wc5d3:: ds 1 ; c5d3
wc5d4:: ds 1 ; c5d4
wc5d5:: ds 1 ; c5d5
wc5d6:: ds 1 ; c5d6
wc5d7:: ds 1 ; c5d7
wc5d8:: ds 1 ; c5d8
wc5d9:: ds 1 ; c5d9
wc5da:: ds 1 ; c5da
wc5db:: ds 1 ; c5db
wc5dc:: ds 1 ; c5dc
wc5dd:: ds 1 ; c5dd
wc5de:: ds 1 ; c5de
wc5df:: ds 1 ; c5df
wc5e0:: ds 1 ; c5e0
wc5e1:: ds 1 ; c5e1
wc5e2:: ds 1 ; c5e2
wc5e3:: ds 1 ; c5e3
wc5e4:: ds 1 ; c5e4
wc5e5:: ds 1 ; c5e5
wc5e6:: ds 1 ; c5e6
wc5e7:: ds 1 ; c5e7
wc5e8:: ds 1 ; c5e8
wc5e9:: ds 1 ; c5e9
wc5ea:: ds 1 ; c5ea
wc5eb:: ds 1 ; c5eb
wc5ec:: ds 1 ; c5ec
wc5ed:: ds 1 ; c5ed
wc5ee:: ds 1 ; c5ee
wc5ef:: ds 1 ; c5ef
wc5f0:: ds 1 ; c5f0
wc5f1:: ds 1 ; c5f1
wc5f2:: ds 1 ; c5f2
wc5f3:: ds 1 ; c5f3
wc5f4:: ds 1 ; c5f4
wc5f5:: ds 1 ; c5f5
wc5f6:: ds 1 ; c5f6
wc5f7:: ds 1 ; c5f7
wc5f8:: ds 1 ; c5f8
wc5f9:: ds 1 ; c5f9
wc5fa:: ds 1 ; c5fa
wc5fb:: ds 1 ; c5fb
wc5fc:: ds 1 ; c5fc
wc5fd:: ds 1 ; c5fd
wc5fe:: ds 1 ; c5fe
wc5ff:: ds 1 ; c5ff
wc600:: ds 1 ; c600
wc601:: ds 1 ; c601
wc602:: ds 1 ; c602
wc603:: ds 1 ; c603
wc604:: ds 1 ; c604
wc605:: ds 1 ; c605
wc606:: ds 1 ; c606
wc607:: ds 1 ; c607
wc608:: ds 1 ; c608
wc609:: ds 1 ; c609
wc60a:: ds 1 ; c60a
wc60b:: ds 1 ; c60b
wc60c:: ds 1 ; c60c
wc60d:: ds 1 ; c60d
wc60e:: ds 1 ; c60e
wc60f:: ds 1 ; c60f
wc610:: ds 1 ; c610
wc611:: ds 1 ; c611
wc612:: ds 1 ; c612
wc613:: ds 1 ; c613
wc614:: ds 1 ; c614
wc615:: ds 1 ; c615
wc616:: ds 1 ; c616
wc617:: ds 1 ; c617
wc618:: ds 1 ; c618
wc619:: ds 1 ; c619
wc61a:: ds 1 ; c61a
wc61b:: ds 1 ; c61b
wc61c:: ds 1 ; c61c
wc61d:: ds 1 ; c61d
wc61e:: ds 1 ; c61e
wc61f:: ds 1 ; c61f
wc620:: ds 1 ; c620
wc621:: ds 1 ; c621
wc622:: ds 1 ; c622
wc623:: ds 1 ; c623
wc624:: ds 1 ; c624
wc625:: ds 1 ; c625
wc626:: ds 1 ; c626
wc627:: ds 1 ; c627
wc628:: ds 1 ; c628
wc629:: ds 1 ; c629
wc62a:: ds 1 ; c62a
wc62b:: ds 1 ; c62b
wc62c:: ds 1 ; c62c
wc62d:: ds 1 ; c62d
wc62e:: ds 1 ; c62e
wc62f:: ds 1 ; c62f
wc630:: ds 1 ; c630
wc631:: ds 1 ; c631
wc632:: ds 1 ; c632
wc633:: ds 1 ; c633
wc634:: ds 1 ; c634
wc635:: ds 1 ; c635
wc636:: ds 1 ; c636
wc637:: ds 1 ; c637
wc638:: ds 1 ; c638
wc639:: ds 1 ; c639
wc63a:: ds 1 ; c63a
wc63b:: ds 1 ; c63b
wc63c:: ds 1 ; c63c
wc63d:: ds 1 ; c63d
wc63e:: ds 1 ; c63e
wc63f:: ds 1 ; c63f
wc640:: ds 1 ; c640
wc641:: ds 1 ; c641
wc642:: ds 1 ; c642
wc643:: ds 1 ; c643
wc644:: ds 1 ; c644
wc645:: ds 1 ; c645
wc646:: ds 1 ; c646
wc647:: ds 1 ; c647
wc648:: ds 1 ; c648
wc649:: ds 1 ; c649
wc64a:: ds 1 ; c64a
wc64b:: ds 1 ; c64b
wc64c:: ds 1 ; c64c
wc64d:: ds 1 ; c64d
wc64e:: ds 1 ; c64e
wc64f:: ds 1 ; c64f
wc650:: ds 1 ; c650
wc651:: ds 1 ; c651
wc652:: ds 1 ; c652
wc653:: ds 1 ; c653
wc654:: ds 1 ; c654
wc655:: ds 1 ; c655
wc656:: ds 1 ; c656
wc657:: ds 1 ; c657
wc658:: ds 1 ; c658
wc659:: ds 1 ; c659
wc65a:: ds 1 ; c65a
wc65b:: ds 1 ; c65b
wc65c:: ds 1 ; c65c
wc65d:: ds 1 ; c65d
wc65e:: ds 1 ; c65e
wc65f:: ds 1 ; c65f
wc660:: ds 1 ; c660
wc661:: ds 1 ; c661
wc662:: ds 1 ; c662
wc663:: ds 1 ; c663
wc664:: ds 1 ; c664
wc665:: ds 1 ; c665
wc666:: ds 1 ; c666
wc667:: ds 1 ; c667
wc668:: ds 1 ; c668
wc669:: ds 1 ; c669
wc66a:: ds 1 ; c66a
wc66b:: ds 1 ; c66b
wc66c:: ds 1 ; c66c
wc66d:: ds 1 ; c66d
wc66e:: ds 1 ; c66e
wc66f:: ds 1 ; c66f
wc670:: ds 1 ; c670
wc671:: ds 1 ; c671
wc672:: ds 1 ; c672
wc673:: ds 1 ; c673
wc674:: ds 1 ; c674
wc675:: ds 1 ; c675
wc676:: ds 1 ; c676
wc677:: ds 1 ; c677
wc678:: ds 1 ; c678
wc679:: ds 1 ; c679
wc67a:: ds 1 ; c67a
wc67b:: ds 1 ; c67b
wc67c:: ds 1 ; c67c
wc67d:: ds 1 ; c67d
wc67e:: ds 1 ; c67e
wc67f:: ds 1 ; c67f
wc680:: ds 1 ; c680
wc681:: ds 1 ; c681
wc682:: ds 1 ; c682
wc683:: ds 1 ; c683
wc684:: ds 1 ; c684
wc685:: ds 1 ; c685
wc686:: ds 1 ; c686
wc687:: ds 1 ; c687
wc688:: ds 1 ; c688
wc689:: ds 1 ; c689
wc68a:: ds 1 ; c68a
wc68b:: ds 1 ; c68b
wc68c:: ds 1 ; c68c
wc68d:: ds 1 ; c68d
wc68e:: ds 1 ; c68e
wc68f:: ds 1 ; c68f
wc690:: ds 1 ; c690
wc691:: ds 1 ; c691
wc692:: ds 1 ; c692
wc693:: ds 1 ; c693
wc694:: ds 1 ; c694
wc695:: ds 1 ; c695
wc696:: ds 1 ; c696
wc697:: ds 1 ; c697
wc698:: ds 1 ; c698
wc699:: ds 1 ; c699
wc69a:: ds 1 ; c69a
wc69b:: ds 1 ; c69b
wc69c:: ds 1 ; c69c
wc69d:: ds 1 ; c69d
wc69e:: ds 1 ; c69e
wc69f:: ds 1 ; c69f
wc6a0:: ds 1 ; c6a0
wc6a1:: ds 1 ; c6a1
wc6a2:: ds 1 ; c6a2
wc6a3:: ds 1 ; c6a3
wc6a4:: ds 1 ; c6a4
wc6a5:: ds 1 ; c6a5
wc6a6:: ds 1 ; c6a6
wc6a7:: ds 1 ; c6a7
wc6a8:: ds 1 ; c6a8
wc6a9:: ds 1 ; c6a9
wc6aa:: ds 1 ; c6aa
wc6ab:: ds 1 ; c6ab
wc6ac:: ds 1 ; c6ac
wc6ad:: ds 1 ; c6ad
wc6ae:: ds 1 ; c6ae
wc6af:: ds 1 ; c6af
wc6b0:: ds 1 ; c6b0
wc6b1:: ds 1 ; c6b1
wc6b2:: ds 1 ; c6b2
wc6b3:: ds 1 ; c6b3
wc6b4:: ds 1 ; c6b4
wc6b5:: ds 1 ; c6b5
wc6b6:: ds 1 ; c6b6
wc6b7:: ds 1 ; c6b7
wc6b8:: ds 1 ; c6b8
wc6b9:: ds 1 ; c6b9
wc6ba:: ds 1 ; c6ba
wc6bb:: ds 1 ; c6bb
wc6bc:: ds 1 ; c6bc
wc6bd:: ds 1 ; c6bd
wc6be:: ds 1 ; c6be
wc6bf:: ds 1 ; c6bf
wc6c0:: ds 1 ; c6c0
wc6c1:: ds 1 ; c6c1
wc6c2:: ds 1 ; c6c2
wc6c3:: ds 1 ; c6c3
wc6c4:: ds 1 ; c6c4
wc6c5:: ds 1 ; c6c5
wc6c6:: ds 1 ; c6c6
wc6c7:: ds 1 ; c6c7
wc6c8:: ds 1 ; c6c8
wc6c9:: ds 1 ; c6c9
wc6ca:: ds 1 ; c6ca
wc6cb:: ds 1 ; c6cb
wc6cc:: ds 1 ; c6cc
wc6cd:: ds 1 ; c6cd
wc6ce:: ds 1 ; c6ce
wc6cf:: ds 1 ; c6cf
wc6d0:: ds 1 ; c6d0
wc6d1:: ds 1 ; c6d1
wc6d2:: ds 1 ; c6d2
wc6d3:: ds 1 ; c6d3
wc6d4:: ds 1 ; c6d4
wc6d5:: ds 1 ; c6d5
wc6d6:: ds 1 ; c6d6
wc6d7:: ds 1 ; c6d7
wc6d8:: ds 1 ; c6d8
wc6d9:: ds 1 ; c6d9
wc6da:: ds 1 ; c6da
wc6db:: ds 1 ; c6db
wc6dc:: ds 1 ; c6dc
wc6dd:: ds 1 ; c6dd
wc6de:: ds 1 ; c6de
wc6df:: ds 1 ; c6df
wc6e0:: ds 1 ; c6e0
wc6e1:: ds 1 ; c6e1
wc6e2:: ds 1 ; c6e2
wc6e3:: ds 1 ; c6e3
wc6e4:: ds 1 ; c6e4
wc6e5:: ds 1 ; c6e5
wc6e6:: ds 1 ; c6e6
wc6e7:: ds 1 ; c6e7
wc6e8:: ds 1 ; c6e8
wc6e9:: ds 1 ; c6e9
wc6ea:: ds 1 ; c6ea
wc6eb:: ds 1 ; c6eb
wc6ec:: ds 1 ; c6ec
wc6ed:: ds 1 ; c6ed
wc6ee:: ds 1 ; c6ee
wc6ef:: ds 1 ; c6ef
wc6f0:: ds 1 ; c6f0
wc6f1:: ds 1 ; c6f1
wc6f2:: ds 1 ; c6f2
wc6f3:: ds 1 ; c6f3
wc6f4:: ds 1 ; c6f4
wc6f5:: ds 1 ; c6f5
wc6f6:: ds 1 ; c6f6
wc6f7:: ds 1 ; c6f7
wc6f8:: ds 1 ; c6f8
wc6f9:: ds 1 ; c6f9
wc6fa:: ds 1 ; c6fa
wc6fb:: ds 1 ; c6fb
wc6fc:: ds 1 ; c6fc
wc6fd:: ds 1 ; c6fd
wc6fe:: ds 1 ; c6fe
wc6ff:: ds 1 ; c6ff

SECTION "Overworld Map", WRAM0

UNION
; overworld map blocks
wOverworldMapBlocks:: ds 1300
wOverworldMapBlocksEnd::

NEXTU
wMysteryGiftStaging::

NEXTU
; raw link data
wLinkData:: ds 271
	ds 229
	ds 5
	ds 198
	ds 79
	ds 5
	ds 113
	ds 100
	dw
wLinkOTPartyMonTypes:: ds 2 * PARTY_LENGTH
	ds 84
	ds 84
	ds 118
wLinkDataEnd:

NEXTU
; LCD expects wLYOverrides to have an alignment of $100
wLYOverrides:: ds SCREEN_HEIGHT_PX
wLYOverridesEnd::

UNION
	ds 16
wLYOverrides2:: ds SCREEN_HEIGHT_PX
wLYOverrides2End::

NEXTU
	ds $100 - SCREEN_HEIGHT_PX
wLYOverridesBackup:: ds SCREEN_HEIGHT_PX
wLYOverridesBackupEnd:: ds $100 - SCREEN_HEIGHT_PX
ENDU

NEXTU
wc700:: ds 1 ; c700
wc701:: ds 1 ; c701
wc702:: ds 1 ; c702
wc703:: ds 1 ; c703
wc704:: ds 1 ; c704
wc705:: ds 1 ; c705
wc706:: ds 1 ; c706
wc707:: ds 1 ; c707
wc708:: ds 1 ; c708
wc709:: ds 1 ; c709
wc70a:: ds 1 ; c70a
wc70b:: ds 1 ; c70b
wc70c:: ds 1 ; c70c
wc70d:: ds 1 ; c70d
wc70e:: ds 1 ; c70e
wc70f:: ds 1 ; c70f
wc710:: ds 1 ; c710
wc711:: ds 1 ; c711
wc712:: ds 1 ; c712
wc713:: ds 1 ; c713
wc714:: ds 1 ; c714
wc715:: ds 1 ; c715
wc716:: ds 1 ; c716
wc717:: ds 1 ; c717
wc718:: ds 1 ; c718
wc719:: ds 1 ; c719
wc71a:: ds 1 ; c71a
wc71b:: ds 1 ; c71b
wc71c:: ds 1 ; c71c
wc71d:: ds 1 ; c71d
wc71e:: ds 1 ; c71e
wc71f:: ds 1 ; c71f
wc720:: ds 1 ; c720
wc721:: ds 1 ; c721
wc722:: ds 1 ; c722
wc723:: ds 1 ; c723
wc724:: ds 1 ; c724
wc725:: ds 1 ; c725
wc726:: ds 1 ; c726
wc727:: ds 1 ; c727
wc728:: ds 1 ; c728
wc729:: ds 1 ; c729
wc72a:: ds 1 ; c72a
wc72b:: ds 1 ; c72b
wc72c:: ds 1 ; c72c
wc72d:: ds 1 ; c72d
wc72e:: ds 1 ; c72e
wc72f:: ds 1 ; c72f
wc730:: ds 1 ; c730
wc731:: ds 1 ; c731
wc732:: ds 1 ; c732
wc733:: ds 1 ; c733
wc734:: ds 1 ; c734
wc735:: ds 1 ; c735
wc736:: ds 1 ; c736
wc737:: ds 1 ; c737
wc738:: ds 1 ; c738
wc739:: ds 1 ; c739
wc73a:: ds 1 ; c73a
wc73b:: ds 1 ; c73b
wc73c:: ds 1 ; c73c
wc73d:: ds 1 ; c73d
wc73e:: ds 1 ; c73e
wc73f:: ds 1 ; c73f
wc740:: ds 1 ; c740
wc741:: ds 1 ; c741
wc742:: ds 1 ; c742
wc743:: ds 1 ; c743
wc744:: ds 1 ; c744
wc745:: ds 1 ; c745
wc746:: ds 1 ; c746
wc747:: ds 1 ; c747
wc748:: ds 1 ; c748
wc749:: ds 1 ; c749
wc74a:: ds 1 ; c74a
wc74b:: ds 1 ; c74b
wc74c:: ds 1 ; c74c
wc74d:: ds 1 ; c74d
wc74e:: ds 1 ; c74e
wc74f:: ds 1 ; c74f
wc750:: ds 1 ; c750
wc751:: ds 1 ; c751
wc752:: ds 1 ; c752
wc753:: ds 1 ; c753
wc754:: ds 1 ; c754
wc755:: ds 1 ; c755
wc756:: ds 1 ; c756
wc757:: ds 1 ; c757
wc758:: ds 1 ; c758
wc759:: ds 1 ; c759
wc75a:: ds 1 ; c75a
wc75b:: ds 1 ; c75b
wc75c:: ds 1 ; c75c
wc75d:: ds 1 ; c75d
wc75e:: ds 1 ; c75e
wc75f:: ds 1 ; c75f
wc760:: ds 1 ; c760
wc761:: ds 1 ; c761
wc762:: ds 1 ; c762
wc763:: ds 1 ; c763
wc764:: ds 1 ; c764
wc765:: ds 1 ; c765
wc766:: ds 1 ; c766
wc767:: ds 1 ; c767
wc768:: ds 1 ; c768
wc769:: ds 1 ; c769
wc76a:: ds 1 ; c76a
wc76b:: ds 1 ; c76b
wc76c:: ds 1 ; c76c
wc76d:: ds 1 ; c76d
wc76e:: ds 1 ; c76e
wc76f:: ds 1 ; c76f
wc770:: ds 1 ; c770
wc771:: ds 1 ; c771
wc772:: ds 1 ; c772
wc773:: ds 1 ; c773
wc774:: ds 1 ; c774
wc775:: ds 1 ; c775
wc776:: ds 1 ; c776
wc777:: ds 1 ; c777
wc778:: ds 1 ; c778
wc779:: ds 1 ; c779
wc77a:: ds 1 ; c77a
wc77b:: ds 1 ; c77b
wc77c:: ds 1 ; c77c
wc77d:: ds 1 ; c77d
wc77e:: ds 1 ; c77e
wc77f:: ds 1 ; c77f
wc780:: ds 1 ; c780
wc781:: ds 1 ; c781
wc782:: ds 1 ; c782
wc783:: ds 1 ; c783
wc784:: ds 1 ; c784
wc785:: ds 1 ; c785
wc786:: ds 1 ; c786
wc787:: ds 1 ; c787
wc788:: ds 1 ; c788
wc789:: ds 1 ; c789
wc78a:: ds 1 ; c78a
wc78b:: ds 1 ; c78b
wc78c:: ds 1 ; c78c
wc78d:: ds 1 ; c78d
wc78e:: ds 1 ; c78e
wc78f:: ds 1 ; c78f
wc790:: ds 1 ; c790
wc791:: ds 1 ; c791
wc792:: ds 1 ; c792
wc793:: ds 1 ; c793
wc794:: ds 1 ; c794
wc795:: ds 1 ; c795
wc796:: ds 1 ; c796
wc797:: ds 1 ; c797
wc798:: ds 1 ; c798
wc799:: ds 1 ; c799
wc79a:: ds 1 ; c79a
wc79b:: ds 1 ; c79b
wc79c:: ds 1 ; c79c
wc79d:: ds 1 ; c79d
wc79e:: ds 1 ; c79e
wc79f:: ds 1 ; c79f
wc7a0:: ds 1 ; c7a0
wc7a1:: ds 1 ; c7a1
wc7a2:: ds 1 ; c7a2
wc7a3:: ds 1 ; c7a3
wc7a4:: ds 1 ; c7a4
wc7a5:: ds 1 ; c7a5
wc7a6:: ds 1 ; c7a6
wc7a7:: ds 1 ; c7a7
wc7a8:: ds 1 ; c7a8
wc7a9:: ds 1 ; c7a9
wc7aa:: ds 1 ; c7aa
wc7ab:: ds 1 ; c7ab
wc7ac:: ds 1 ; c7ac
wc7ad:: ds 1 ; c7ad
wc7ae:: ds 1 ; c7ae
wc7af:: ds 1 ; c7af
wc7b0:: ds 1 ; c7b0
wc7b1:: ds 1 ; c7b1
wc7b2:: ds 1 ; c7b2
wc7b3:: ds 1 ; c7b3
wc7b4:: ds 1 ; c7b4
wc7b5:: ds 1 ; c7b5
wc7b6:: ds 1 ; c7b6
wc7b7:: ds 1 ; c7b7
wc7b8:: ds 1 ; c7b8
wc7b9:: ds 1 ; c7b9
wc7ba:: ds 1 ; c7ba
wc7bb:: ds 1 ; c7bb
wc7bc:: ds 1 ; c7bc
wc7bd:: ds 1 ; c7bd
wc7be:: ds 1 ; c7be
wc7bf:: ds 1 ; c7bf
wc7c0:: ds 1 ; c7c0
wc7c1:: ds 1 ; c7c1
wc7c2:: ds 1 ; c7c2
wc7c3:: ds 1 ; c7c3
wc7c4:: ds 1 ; c7c4
wc7c5:: ds 1 ; c7c5
wc7c6:: ds 1 ; c7c6
wc7c7:: ds 1 ; c7c7
wc7c8:: ds 1 ; c7c8
wc7c9:: ds 1 ; c7c9
wc7ca:: ds 1 ; c7ca
wc7cb:: ds 1 ; c7cb
wc7cc:: ds 1 ; c7cc
wc7cd:: ds 1 ; c7cd
wc7ce:: ds 1 ; c7ce
wc7cf:: ds 1 ; c7cf
wc7d0:: ds 1 ; c7d0
wc7d1:: ds 1 ; c7d1
wc7d2:: ds 1 ; c7d2
wc7d3:: ds 1 ; c7d3
wc7d4:: ds 1 ; c7d4
wc7d5:: ds 1 ; c7d5
wc7d6:: ds 1 ; c7d6
wc7d7:: ds 1 ; c7d7
wc7d8:: ds 1 ; c7d8
wc7d9:: ds 1 ; c7d9
wc7da:: ds 1 ; c7da
wc7db:: ds 1 ; c7db
wc7dc:: ds 1 ; c7dc
wc7dd:: ds 1 ; c7dd
wc7de:: ds 1 ; c7de
wc7df:: ds 1 ; c7df
wc7e0:: ds 1 ; c7e0
wc7e1:: ds 1 ; c7e1
wc7e2:: ds 1 ; c7e2
wc7e3:: ds 1 ; c7e3
wc7e4:: ds 1 ; c7e4
wc7e5:: ds 1 ; c7e5
wc7e6:: ds 1 ; c7e6
wc7e7:: ds 1 ; c7e7
wc7e8:: ds 1 ; c7e8
wc7e9:: ds 1 ; c7e9
wc7ea:: ds 1 ; c7ea
wc7eb:: ds 1 ; c7eb
wc7ec:: ds 1 ; c7ec
wc7ed:: ds 1 ; c7ed
wc7ee:: ds 1 ; c7ee
wc7ef:: ds 1 ; c7ef
wc7f0:: ds 1 ; c7f0
wc7f1:: ds 1 ; c7f1
wc7f2:: ds 1 ; c7f2
wc7f3:: ds 1 ; c7f3
wc7f4:: ds 1 ; c7f4
wc7f5:: ds 1 ; c7f5
wc7f6:: ds 1 ; c7f6
wc7f7:: ds 1 ; c7f7
wc7f8:: ds 1 ; c7f8
wc7f9:: ds 1 ; c7f9
wc7fa:: ds 1 ; c7fa
wc7fb:: ds 1 ; c7fb
wc7fc:: ds 1 ; c7fc
wc7fd:: ds 1 ; c7fd
wc7fe:: ds 1 ; c7fe
wc7ff:: ds 1 ; c7ff
wc800:: ds 1 ; c800
wc801:: ds 1 ; c801
wc802:: ds 1 ; c802
wc803:: ds 1 ; c803
wc804:: ds 1 ; c804
wc805:: ds 1 ; c805
wc806:: ds 1 ; c806
wc807:: ds 1 ; c807
wc808:: ds 1 ; c808
wc809:: ds 1 ; c809
wc80a:: ds 1 ; c80a
wc80b:: ds 1 ; c80b
wc80c:: ds 1 ; c80c
wc80d:: ds 1 ; c80d
wc80e:: ds 1 ; c80e
wc80f:: ds 1 ; c80f
wc810:: ds 1 ; c810
wc811:: ds 1 ; c811
wc812:: ds 1 ; c812
wc813:: ds 1 ; c813
wc814:: ds 1 ; c814
wc815:: ds 1 ; c815
wc816:: ds 1 ; c816
wc817:: ds 1 ; c817
wc818:: ds 1 ; c818
wc819:: ds 1 ; c819
wc81a:: ds 1 ; c81a
wc81b:: ds 1 ; c81b
wc81c:: ds 1 ; c81c
wc81d:: ds 1 ; c81d
wc81e:: ds 1 ; c81e
wc81f:: ds 1 ; c81f
wc820:: ds 1 ; c820
wc821:: ds 1 ; c821
wc822:: ds 1 ; c822
wc823:: ds 1 ; c823
wc824:: ds 1 ; c824
wc825:: ds 1 ; c825
wc826:: ds 1 ; c826
wc827:: ds 1 ; c827
wc828:: ds 1 ; c828
wc829:: ds 1 ; c829
wc82a:: ds 1 ; c82a
wc82b:: ds 1 ; c82b
wc82c:: ds 1 ; c82c
wc82d:: ds 1 ; c82d
wc82e:: ds 1 ; c82e
wc82f:: ds 1 ; c82f
wc830:: ds 1 ; c830
wc831:: ds 1 ; c831
wc832:: ds 1 ; c832
wc833:: ds 1 ; c833
wc834:: ds 1 ; c834
wc835:: ds 1 ; c835
wc836:: ds 1 ; c836
wc837:: ds 1 ; c837
wc838:: ds 1 ; c838
wc839:: ds 1 ; c839
wc83a:: ds 1 ; c83a
wc83b:: ds 1 ; c83b
wc83c:: ds 1 ; c83c
wc83d:: ds 1 ; c83d
wc83e:: ds 1 ; c83e
wc83f:: ds 1 ; c83f
wc840:: ds 1 ; c840
wc841:: ds 1 ; c841
wc842:: ds 1 ; c842
wc843:: ds 1 ; c843
wc844:: ds 1 ; c844
wc845:: ds 1 ; c845
wc846:: ds 1 ; c846
wc847:: ds 1 ; c847
wc848:: ds 1 ; c848
wc849:: ds 1 ; c849
wc84a:: ds 1 ; c84a
wc84b:: ds 1 ; c84b
wc84c:: ds 1 ; c84c
wc84d:: ds 1 ; c84d
wc84e:: ds 1 ; c84e
wc84f:: ds 1 ; c84f
wc850:: ds 1 ; c850
wc851:: ds 1 ; c851
wc852:: ds 1 ; c852
wc853:: ds 1 ; c853
wc854:: ds 1 ; c854
wc855:: ds 1 ; c855
wc856:: ds 1 ; c856
wc857:: ds 1 ; c857
wc858:: ds 1 ; c858
wc859:: ds 1 ; c859
wc85a:: ds 1 ; c85a
wc85b:: ds 1 ; c85b
wc85c:: ds 1 ; c85c
wc85d:: ds 1 ; c85d
wc85e:: ds 1 ; c85e
wc85f:: ds 1 ; c85f
wc860:: ds 1 ; c860
wc861:: ds 1 ; c861
wc862:: ds 1 ; c862
wc863:: ds 1 ; c863
wc864:: ds 1 ; c864
wc865:: ds 1 ; c865
wc866:: ds 1 ; c866
wc867:: ds 1 ; c867
wc868:: ds 1 ; c868
wc869:: ds 1 ; c869
wc86a:: ds 1 ; c86a
wc86b:: ds 1 ; c86b
wc86c:: ds 1 ; c86c
wc86d:: ds 1 ; c86d
wc86e:: ds 1 ; c86e
wc86f:: ds 1 ; c86f
wc870:: ds 1 ; c870
wc871:: ds 1 ; c871
wc872:: ds 1 ; c872
wc873:: ds 1 ; c873
wc874:: ds 1 ; c874
wc875:: ds 1 ; c875
wc876:: ds 1 ; c876
wc877:: ds 1 ; c877
wc878:: ds 1 ; c878
wc879:: ds 1 ; c879
wc87a:: ds 1 ; c87a
wc87b:: ds 1 ; c87b
wc87c:: ds 1 ; c87c
wc87d:: ds 1 ; c87d
wc87e:: ds 1 ; c87e
wc87f:: ds 1 ; c87f
wc880:: ds 1 ; c880
wc881:: ds 1 ; c881
wc882:: ds 1 ; c882
wc883:: ds 1 ; c883
wc884:: ds 1 ; c884
wc885:: ds 1 ; c885
wc886:: ds 1 ; c886
wc887:: ds 1 ; c887
wc888:: ds 1 ; c888
wc889:: ds 1 ; c889
wc88a:: ds 1 ; c88a
wc88b:: ds 1 ; c88b
wc88c:: ds 1 ; c88c
wc88d:: ds 1 ; c88d
wc88e:: ds 1 ; c88e
wc88f:: ds 1 ; c88f
wc890:: ds 1 ; c890
wc891:: ds 1 ; c891
wc892:: ds 1 ; c892
wc893:: ds 1 ; c893
wc894:: ds 1 ; c894
wc895:: ds 1 ; c895
wc896:: ds 1 ; c896
wc897:: ds 1 ; c897
wc898:: ds 1 ; c898
wc899:: ds 1 ; c899
wc89a:: ds 1 ; c89a
wc89b:: ds 1 ; c89b
wc89c:: ds 1 ; c89c
wc89d:: ds 1 ; c89d
wc89e:: ds 1 ; c89e
wc89f:: ds 1 ; c89f
wc8a0:: ds 1 ; c8a0
wc8a1:: ds 1 ; c8a1
wc8a2:: ds 1 ; c8a2
wc8a3:: ds 1 ; c8a3
wc8a4:: ds 1 ; c8a4
wc8a5:: ds 1 ; c8a5
wc8a6:: ds 1 ; c8a6
wc8a7:: ds 1 ; c8a7
wc8a8:: ds 1 ; c8a8
wc8a9:: ds 1 ; c8a9
wc8aa:: ds 1 ; c8aa
wc8ab:: ds 1 ; c8ab
wc8ac:: ds 1 ; c8ac
wc8ad:: ds 1 ; c8ad
wc8ae:: ds 1 ; c8ae
wc8af:: ds 1 ; c8af
wc8b0:: ds 1 ; c8b0
wc8b1:: ds 1 ; c8b1
wc8b2:: ds 1 ; c8b2
wc8b3:: ds 1 ; c8b3
wc8b4:: ds 1 ; c8b4
wc8b5:: ds 1 ; c8b5
wc8b6:: ds 1 ; c8b6
wc8b7:: ds 1 ; c8b7
wc8b8:: ds 1 ; c8b8
wc8b9:: ds 1 ; c8b9
wc8ba:: ds 1 ; c8ba
wc8bb:: ds 1 ; c8bb
wc8bc:: ds 1 ; c8bc
wc8bd:: ds 1 ; c8bd
wc8be:: ds 1 ; c8be
wc8bf:: ds 1 ; c8bf
wc8c0:: ds 1 ; c8c0
wc8c1:: ds 1 ; c8c1
wc8c2:: ds 1 ; c8c2
wc8c3:: ds 1 ; c8c3
wc8c4:: ds 1 ; c8c4
wc8c5:: ds 1 ; c8c5
wc8c6:: ds 1 ; c8c6
wc8c7:: ds 1 ; c8c7
wc8c8:: ds 1 ; c8c8
wc8c9:: ds 1 ; c8c9
wc8ca:: ds 1 ; c8ca
wc8cb:: ds 1 ; c8cb
wc8cc:: ds 1 ; c8cc
wc8cd:: ds 1 ; c8cd
wc8ce:: ds 1 ; c8ce
wc8cf:: ds 1 ; c8cf
wc8d0:: ds 1 ; c8d0
wc8d1:: ds 1 ; c8d1
wc8d2:: ds 1 ; c8d2
wc8d3:: ds 1 ; c8d3
wc8d4:: ds 1 ; c8d4
wc8d5:: ds 1 ; c8d5
wc8d6:: ds 1 ; c8d6
wc8d7:: ds 1 ; c8d7
wc8d8:: ds 1 ; c8d8
wc8d9:: ds 1 ; c8d9
wc8da:: ds 1 ; c8da
wc8db:: ds 1 ; c8db
wc8dc:: ds 1 ; c8dc
wc8dd:: ds 1 ; c8dd
wc8de:: ds 1 ; c8de
wc8df:: ds 1 ; c8df
wc8e0:: ds 1 ; c8e0
wc8e1:: ds 1 ; c8e1
wc8e2:: ds 1 ; c8e2
wc8e3:: ds 1 ; c8e3
wc8e4:: ds 1 ; c8e4
wc8e5:: ds 1 ; c8e5
wc8e6:: ds 1 ; c8e6
wc8e7:: ds 1 ; c8e7
wc8e8:: ds 1 ; c8e8
wc8e9:: ds 1 ; c8e9
wc8ea:: ds 1 ; c8ea
wc8eb:: ds 1 ; c8eb
wc8ec:: ds 1 ; c8ec
wc8ed:: ds 1 ; c8ed
wc8ee:: ds 1 ; c8ee
wc8ef:: ds 1 ; c8ef
wc8f0:: ds 1 ; c8f0
wc8f1:: ds 1 ; c8f1
wc8f2:: ds 1 ; c8f2
wc8f3:: ds 1 ; c8f3
wc8f4:: ds 1 ; c8f4
wc8f5:: ds 1 ; c8f5
wc8f6:: ds 1 ; c8f6
wc8f7:: ds 1 ; c8f7
wc8f8:: ds 1 ; c8f8
wc8f9:: ds 1 ; c8f9
wc8fa:: ds 1 ; c8fa
wc8fb:: ds 1 ; c8fb
wc8fc:: ds 1 ; c8fc
wc8fd:: ds 1 ; c8fd
wc8fe:: ds 1 ; c8fe
wc8ff:: ds 1 ; c8ff
wc900:: ds 1 ; c900
wc901:: ds 1 ; c901
wc902:: ds 1 ; c902
wc903:: ds 1 ; c903
wc904:: ds 1 ; c904
wc905:: ds 1 ; c905
wc906:: ds 1 ; c906
wc907:: ds 1 ; c907
wc908:: ds 1 ; c908
wc909:: ds 1 ; c909
wc90a:: ds 1 ; c90a
wc90b:: ds 1 ; c90b
wc90c:: ds 1 ; c90c
wc90d:: ds 1 ; c90d
wc90e:: ds 1 ; c90e
wc90f:: ds 1 ; c90f
wc910:: ds 1 ; c910
wc911:: ds 1 ; c911
wc912:: ds 1 ; c912
wc913:: ds 1 ; c913
wc914:: ds 1 ; c914
wc915:: ds 1 ; c915
wc916:: ds 1 ; c916
wc917:: ds 1 ; c917
wc918:: ds 1 ; c918
wc919:: ds 1 ; c919
wc91a:: ds 1 ; c91a
wc91b:: ds 1 ; c91b
wc91c:: ds 1 ; c91c
wc91d:: ds 1 ; c91d
wc91e:: ds 1 ; c91e
wc91f:: ds 1 ; c91f
wc920:: ds 1 ; c920
wc921:: ds 1 ; c921
wc922:: ds 1 ; c922
wc923:: ds 1 ; c923
wc924:: ds 1 ; c924
wc925:: ds 1 ; c925
wc926:: ds 1 ; c926
wc927:: ds 1 ; c927
wc928:: ds 1 ; c928
wc929:: ds 1 ; c929
wc92a:: ds 1 ; c92a
wc92b:: ds 1 ; c92b
wc92c:: ds 1 ; c92c
wc92d:: ds 1 ; c92d
wc92e:: ds 1 ; c92e
wc92f:: ds 1 ; c92f
wc930:: ds 1 ; c930
wc931:: ds 1 ; c931
wc932:: ds 1 ; c932
wc933:: ds 1 ; c933
wc934:: ds 1 ; c934
wc935:: ds 1 ; c935
wc936:: ds 1 ; c936
wc937:: ds 1 ; c937
wc938:: ds 1 ; c938
wc939:: ds 1 ; c939
wc93a:: ds 1 ; c93a
wc93b:: ds 1 ; c93b
wc93c:: ds 1 ; c93c
wc93d:: ds 1 ; c93d
wc93e:: ds 1 ; c93e
wc93f:: ds 1 ; c93f
wc940:: ds 1 ; c940
wc941:: ds 1 ; c941
wc942:: ds 1 ; c942
wc943:: ds 1 ; c943
wc944:: ds 1 ; c944
wc945:: ds 1 ; c945
wc946:: ds 1 ; c946
wc947:: ds 1 ; c947
wc948:: ds 1 ; c948
wc949:: ds 1 ; c949
wc94a:: ds 1 ; c94a
wc94b:: ds 1 ; c94b
wc94c:: ds 1 ; c94c
wc94d:: ds 1 ; c94d
wc94e:: ds 1 ; c94e
wc94f:: ds 1 ; c94f
wc950:: ds 1 ; c950
wc951:: ds 1 ; c951
wc952:: ds 1 ; c952
wc953:: ds 1 ; c953
wc954:: ds 1 ; c954
wc955:: ds 1 ; c955
wc956:: ds 1 ; c956
wc957:: ds 1 ; c957
wc958:: ds 1 ; c958
wc959:: ds 1 ; c959
wc95a:: ds 1 ; c95a
wc95b:: ds 1 ; c95b
wc95c:: ds 1 ; c95c
wc95d:: ds 1 ; c95d
wc95e:: ds 1 ; c95e
wc95f:: ds 1 ; c95f
wc960:: ds 1 ; c960
wc961:: ds 1 ; c961
wc962:: ds 1 ; c962
wc963:: ds 1 ; c963
wc964:: ds 1 ; c964
wc965:: ds 1 ; c965
wc966:: ds 1 ; c966
wc967:: ds 1 ; c967
wc968:: ds 1 ; c968
wc969:: ds 1 ; c969
wc96a:: ds 1 ; c96a
wc96b:: ds 1 ; c96b
wc96c:: ds 1 ; c96c
wc96d:: ds 1 ; c96d
wc96e:: ds 1 ; c96e
wc96f:: ds 1 ; c96f
wc970:: ds 1 ; c970
wc971:: ds 1 ; c971
wc972:: ds 1 ; c972
wc973:: ds 1 ; c973
wc974:: ds 1 ; c974
wc975:: ds 1 ; c975
wc976:: ds 1 ; c976
wc977:: ds 1 ; c977
wc978:: ds 1 ; c978
wc979:: ds 1 ; c979
wc97a:: ds 1 ; c97a
wc97b:: ds 1 ; c97b
wc97c:: ds 1 ; c97c
wc97d:: ds 1 ; c97d
wc97e:: ds 1 ; c97e
wc97f:: ds 1 ; c97f
wc980:: ds 1 ; c980
wc981:: ds 1 ; c981
wc982:: ds 1 ; c982
wc983:: ds 1 ; c983
wc984:: ds 1 ; c984
wc985:: ds 1 ; c985
wc986:: ds 1 ; c986
wc987:: ds 1 ; c987
wc988:: ds 1 ; c988
wc989:: ds 1 ; c989

wHandshakeFrameDelay:: ds 1 ; c98a

wc98b:: ds 1 ; c98b
wc98c:: ds 1 ; c98c
wc98d:: ds 1 ; c98d
wc98e:: ds 1 ; c98e
wc98f:: ds 1 ; c98f
wc990:: ds 1 ; c990
wc991:: ds 1 ; c991
wc992:: ds 1 ; c992
wc993:: ds 1 ; c993
wc994:: ds 1 ; c994
wc995:: ds 1 ; c995
wc996:: ds 1 ; c996
wc997:: ds 1 ; c997
wc998:: ds 1 ; c998
wc999:: ds 1 ; c999
wc99a:: ds 1 ; c99a
wc99b:: ds 1 ; c99b
wc99c:: ds 1 ; c99c
wc99d:: ds 1 ; c99d
wc99e:: ds 1 ; c99e
wc99f:: ds 1 ; c99f
wc9a0:: ds 1 ; c9a0
wc9a1:: ds 1 ; c9a1
wc9a2:: ds 1 ; c9a2
wc9a3:: ds 1 ; c9a3
wc9a4:: ds 1 ; c9a4
wc9a5:: ds 1 ; c9a5
wc9a6:: ds 1 ; c9a6
wc9a7:: ds 1 ; c9a7
wc9a8:: ds 1 ; c9a8
wc9a9:: ds 1 ; c9a9
wc9aa:: ds 1 ; c9aa
wc9ab:: ds 1 ; c9ab
wc9ac:: ds 1 ; c9ac
wc9ad:: ds 1 ; c9ad
wc9ae:: ds 1 ; c9ae
wc9af:: ds 1 ; c9af
wc9b0:: ds 1 ; c9b0
wc9b1:: ds 1 ; c9b1
wc9b2:: ds 1 ; c9b2
wc9b3:: ds 1 ; c9b3
wc9b4:: ds 1 ; c9b4
wc9b5:: ds 1 ; c9b5
wc9b6:: ds 1 ; c9b6
wc9b7:: ds 1 ; c9b7
wc9b8:: ds 1 ; c9b8
wc9b9:: ds 1 ; c9b9
wc9ba:: ds 1 ; c9ba
wc9bb:: ds 1 ; c9bb
wc9bc:: ds 1 ; c9bc
wc9bd:: ds 1 ; c9bd
wc9be:: ds 1 ; c9be
wc9bf:: ds 1 ; c9bf
wc9c0:: ds 1 ; c9c0
wc9c1:: ds 1 ; c9c1
wc9c2:: ds 1 ; c9c2
wc9c3:: ds 1 ; c9c3
wc9c4:: ds 1 ; c9c4
wc9c5:: ds 1 ; c9c5
wc9c6:: ds 1 ; c9c6
wc9c7:: ds 1 ; c9c7
wc9c8:: ds 1 ; c9c8
wc9c9:: ds 1 ; c9c9
wc9ca:: ds 1 ; c9ca
wc9cb:: ds 1 ; c9cb
wc9cc:: ds 1 ; c9cc
wc9cd:: ds 1 ; c9cd
wc9ce:: ds 1 ; c9ce
wc9cf:: ds 1 ; c9cf
wc9d0:: ds 1 ; c9d0
wc9d1:: ds 1 ; c9d1
wc9d2:: ds 1 ; c9d2
wc9d3:: ds 1 ; c9d3
wc9d4:: ds 1 ; c9d4
wc9d5:: ds 1 ; c9d5
wc9d6:: ds 1 ; c9d6
wc9d7:: ds 1 ; c9d7
wc9d8:: ds 1 ; c9d8
wc9d9:: ds 1 ; c9d9
wc9da:: ds 1 ; c9da
wc9db:: ds 1 ; c9db
wc9dc:: ds 1 ; c9dc
wc9dd:: ds 1 ; c9dd
wc9de:: ds 1 ; c9de
wc9df:: ds 1 ; c9df
wc9e0:: ds 1 ; c9e0
wc9e1:: ds 1 ; c9e1
wc9e2:: ds 1 ; c9e2
wc9e3:: ds 1 ; c9e3
wc9e4:: ds 1 ; c9e4
wc9e5:: ds 1 ; c9e5
wc9e6:: ds 1 ; c9e6
wc9e7:: ds 1 ; c9e7
wc9e8:: ds 1 ; c9e8
wc9e9:: ds 1 ; c9e9
wc9ea:: ds 1 ; c9ea
wc9eb:: ds 1 ; c9eb
wc9ec:: ds 1 ; c9ec
wc9ed:: ds 1 ; c9ed
wc9ee:: ds 1 ; c9ee
wc9ef:: ds 1 ; c9ef
wc9f0:: ds 1 ; c9f0
wc9f1:: ds 1 ; c9f1
wc9f2:: ds 1 ; c9f2
wc9f3:: ds 1 ; c9f3
wc9f4:: ds 1 ; c9f4
wc9f5:: ds 1 ; c9f5
wc9f6:: ds 1 ; c9f6
wc9f7:: ds 1 ; c9f7
wc9f8:: ds 1 ; c9f8
wc9f9:: ds 1 ; c9f9
wc9fa:: ds 1 ; c9fa
wc9fb:: ds 1 ; c9fb
wc9fc:: ds 1 ; c9fc
wc9fd:: ds 1 ; c9fd
wc9fe:: ds 1 ; c9fe
wc9ff:: ds 1 ; c9ff
wca00:: ds 1 ; ca00
wca01:: ds 1 ; ca01
wca02:: ds 1 ; ca02
wca03:: ds 1 ; ca03
wca04:: ds 1 ; ca04
wca05:: ds 1 ; ca05
wca06:: ds 1 ; ca06
wca07:: ds 1 ; ca07
wca08:: ds 1 ; ca08
wca09:: ds 1 ; ca09
wca0a:: ds 1 ; ca0a
wca0b:: ds 1 ; ca0b
wca0c:: ds 1 ; ca0c
wca0d:: ds 1 ; ca0d
wca0e:: ds 1 ; ca0e
wca0f:: ds 1 ; ca0f
wca10:: ds 1 ; ca10
wca11:: ds 1 ; ca11
wca12:: ds 1 ; ca12
wca13:: ds 1 ; ca13
wca14:: ds 1 ; ca14
wca15:: ds 1 ; ca15
wca16:: ds 1 ; ca16
wca17:: ds 1 ; ca17
wca18:: ds 1 ; ca18
wca19:: ds 1 ; ca19
wca1a:: ds 1 ; ca1a
wca1b:: ds 1 ; ca1b
wca1c:: ds 1 ; ca1c
wca1d:: ds 1 ; ca1d
wca1e:: ds 1 ; ca1e
wca1f:: ds 1 ; ca1f
wca20:: ds 1 ; ca20
wca21:: ds 1 ; ca21
wca22:: ds 1 ; ca22
wca23:: ds 1 ; ca23
wca24:: ds 1 ; ca24
wca25:: ds 1 ; ca25
wca26:: ds 1 ; ca26
wca27:: ds 1 ; ca27
wca28:: ds 1 ; ca28
wca29:: ds 1 ; ca29
wca2a:: ds 1 ; ca2a
wca2b:: ds 1 ; ca2b
wca2c:: ds 1 ; ca2c
wca2d:: ds 1 ; ca2d
wca2e:: ds 1 ; ca2e
wca2f:: ds 1 ; ca2f
wca30:: ds 1 ; ca30
wca31:: ds 1 ; ca31
wca32:: ds 1 ; ca32
wca33:: ds 1 ; ca33
wca34:: ds 1 ; ca34
wca35:: ds 1 ; ca35
wca36:: ds 1 ; ca36
wca37:: ds 1 ; ca37
wca38:: ds 1 ; ca38
wca39:: ds 1 ; ca39
wca3a:: ds 1 ; ca3a
wca3b:: ds 1 ; ca3b
wca3c:: ds 1 ; ca3c
wca3d:: ds 1 ; ca3d
wca3e:: ds 1 ; ca3e
wca3f:: ds 1 ; ca3f
wca40:: ds 1 ; ca40
wca41:: ds 1 ; ca41
wca42:: ds 1 ; ca42
wca43:: ds 1 ; ca43
wca44:: ds 1 ; ca44
wca45:: ds 1 ; ca45
wca46:: ds 1 ; ca46
wca47:: ds 1 ; ca47
wca48:: ds 1 ; ca48
wca49:: ds 1 ; ca49
wca4a:: ds 1 ; ca4a
wca4b:: ds 1 ; ca4b
wca4c:: ds 1 ; ca4c
wca4d:: ds 1 ; ca4d
wca4e:: ds 1 ; ca4e
wca4f:: ds 1 ; ca4f
wca50:: ds 1 ; ca50
wca51:: ds 1 ; ca51
wca52:: ds 1 ; ca52
wca53:: ds 1 ; ca53
wca54:: ds 1 ; ca54
wca55:: ds 1 ; ca55
wca56:: ds 1 ; ca56
wca57:: ds 1 ; ca57
wca58:: ds 1 ; ca58
wca59:: ds 1 ; ca59
wca5a:: ds 1 ; ca5a
wca5b:: ds 1 ; ca5b
wca5c:: ds 1 ; ca5c
wca5d:: ds 1 ; ca5d
wca5e:: ds 1 ; ca5e
wca5f:: ds 1 ; ca5f
wca60:: ds 1 ; ca60
wca61:: ds 1 ; ca61

	ds 134

wBattle::
wEnemyMoveStruct:: move_struct wEnemyMoveStruct
wPlayerMoveStruct:: move_struct wPlayerMoveStruct

wEnemyMonNick:: ds MON_NAME_LENGTH
wBattleMonNick:: ds MON_NAME_LENGTH

wBattleMon:: battle_struct wBattleMon ; cb02

wcb22:: ds 1 ; cb22
wcb23:: ds 1 ; cb23
wcb24:: ds 1 ; cb24
wcb25:: ds 1 ; cb25
wcb26:: ds 1 ; cb26
wcb27:: ds 1 ; cb27
wcb28:: ds 1 ; cb28
wcb29:: ds 1 ; cb29
wcb2a:: ds 1 ; cb2a
wcb2b:: ds 1 ; cb2b
wcb2c:: ds 1 ; cb2c
wcb2d:: ds 1 ; cb2d
wcb2e:: ds 1 ; cb2e
wcb2f:: ds 1 ; cb2f
wcb30:: ds 1 ; cb30
wcb31:: ds 1 ; cb31
wcb32:: ds 1 ; cb32
wcb33:: ds 1 ; cb33
wcb34:: ds 1 ; cb34

wCurOTMon:: ds 1 ; cb35

wcb36:: ds 1 ; cb36
wcb37:: ds 1 ; cb37
wcb38:: ds 1 ; cb38
wcb39:: ds 1 ; cb39

wPlayerSubStatus1:: db
wPlayerSubStatus2:: db
wPlayerSubStatus3:: db
wPlayerSubStatus4:: db
wPlayerSubStatus5:: db

wEnemySubStatus1:: db
wEnemySubStatus2:: db
wEnemySubStatus3:: db
wEnemySubStatus4:: db
wEnemySubStatus5:: db

wPlayerRolloutCount:: db
wPlayerConfuseCount:: db
wPlayerToxicCount:: db
wPlayerDisableCount:: db
wPlayerEncoreCount:: db
wPlayerPerishCount:: db
wPlayerFuryCutterCount:: db
wPlayerProtectCount:: db

wcb4c:: ds 1 ; cb4c
wcb4d:: ds 1 ; cb4d
wcb4e:: ds 1 ; cb4e
wcb4f:: ds 1 ; cb4f
wcb50:: ds 1 ; cb50
wcb51:: ds 1 ; cb51
wcb52:: ds 1 ; cb52
wcb53:: ds 1 ; cb53

wcb54:: ds 1 ; cb54
wcb55:: ds 1 ; cb55
wcb56:: ds 1 ; cb56
wcb57:: ds 1 ; cb57

wcb58:: ds 1 ; cb58
wcb59:: ds 1 ; cb59
wcb5a:: ds 1 ; cb5a
wcb5b:: ds 1 ; cb5b
wcb5c:: ds 1 ; cb5c
wcb5d:: ds 1 ; cb5d
wcb5e:: ds 1 ; cb5e
wcb5f:: ds 1 ; cb5f
wcb60:: ds 1 ; cb60
wcb61:: ds 1 ; cb61
wcb62:: ds 1 ; cb62
wcb63:: ds 1 ; cb63
wcb64:: ds 1 ; cb64
wcb65:: ds 1 ; cb65
wcb66:: ds 1 ; cb66
wcb67:: ds 1 ; cb67
wcb68:: ds 1 ; cb68
wcb69:: ds 1 ; cb69
wcb6a:: ds 1 ; cb6a
wcb6b:: ds 1 ; cb6b
wcb6c:: ds 1 ; cb6c
wcb6d:: ds 1 ; cb6d
wcb6e:: ds 1 ; cb6e
wcb6f:: ds 1 ; cb6f
wcb70:: ds 1 ; cb70
wcb71:: ds 1 ; cb71
wcb72:: ds 1 ; cb72
wcb73:: ds 1 ; cb73
wcb74:: ds 1 ; cb74
wcb75:: ds 1 ; cb75
wcb76:: ds 1 ; cb76
wcb77:: ds 1 ; cb77
wcb78:: ds 1 ; cb78
wcb79:: ds 1 ; cb79
wcb7a:: ds 1 ; cb7a
wcb7b:: ds 1 ; cb7b
wcb7c:: ds 1 ; cb7c
wcb7d:: ds 1 ; cb7d
wcb7e:: ds 1 ; cb7e
wcb7f:: ds 1 ; cb7f
wcb80:: ds 1 ; cb80
wcb81:: ds 1 ; cb81
wcb82:: ds 1 ; cb82
wcb83:: ds 1 ; cb83
wcb84:: ds 1 ; cb84
wcb85:: ds 1 ; cb85
wcb86:: ds 1 ; cb86
wcb87:: ds 1 ; cb87
wcb88:: ds 1 ; cb88
wcb89:: ds 1 ; cb89
wcb8a:: ds 1 ; cb8a
wcb8b:: ds 1 ; cb8b
wcb8c:: ds 1 ; cb8c
wcb8d:: ds 1 ; cb8d
wcb8e:: ds 1 ; cb8e
wcb8f:: ds 1 ; cb8f
wcb90:: ds 1 ; cb90
wcb91:: ds 1 ; cb91
wcb92:: ds 1 ; cb92
wcb93:: ds 1 ; cb93
wcb94:: ds 1 ; cb94
wcb95:: ds 1 ; cb95
wcb96:: ds 1 ; cb96
wcb97:: ds 1 ; cb97
wcb98:: ds 1 ; cb98
wcb99:: ds 1 ; cb99
wcb9a:: ds 1 ; cb9a
wcb9b:: ds 1 ; cb9b
wcb9c:: ds 1 ; cb9c
wcb9d:: ds 1 ; cb9d
wcb9e:: ds 1 ; cb9e
wcb9f:: ds 1 ; cb9f
wcba0:: ds 1 ; cba0
wcba1:: ds 1 ; cba1
wcba2:: ds 1 ; cba2
wcba3:: ds 1 ; cba3
wcba4:: ds 1 ; cba4
wcba5:: ds 1 ; cba5
wcba6:: ds 1 ; cba6
wcba7:: ds 1 ; cba7
wcba8:: ds 1 ; cba8
wcba9:: ds 1 ; cba9
wcbaa:: ds 1 ; cbaa
wcbab:: ds 1 ; cbab
wcbac:: ds 1 ; cbac
wcbad:: ds 1 ; cbad
wcbae:: ds 1 ; cbae
wcbaf:: ds 1 ; cbaf
wcbb0:: ds 1 ; cbb0
wcbb1:: ds 1 ; cbb1
wcbb2:: ds 1 ; cbb2
wcbb3:: ds 1 ; cbb3
wcbb4:: ds 1 ; cbb4

wCurPlayerMove:: ds 1 ; cbb5
wCurEnemyMove:: ds 1 ; cbb6

wcbb7:: ds 1 ; cbb7
wcbb8:: ds 1 ; cbb8
wcbb9:: ds 1 ; cbb9
wcbba:: ds 1 ; cbba
wcbbb:: ds 1 ; cbbb
wcbbc:: ds 1 ; cbbc
wcbbd:: ds 1 ; cbbd
wcbbe:: ds 1 ; cbbe
wcbbf:: ds 1 ; cbbf
wcbc0:: ds 1 ; cbc0
wcbc1:: ds 1 ; cbc1
wcbc2:: ds 1 ; cbc2
wcbc3:: ds 1 ; cbc3
wcbc4:: ds 1 ; cbc4
wcbc5:: ds 1 ; cbc5
wcbc6:: ds 1 ; cbc6

wDisabledMove:: ds 1 ; cbc7
wcbc8:: ds 1 ; cbc8
wcbc9:: ds 1 ; cbc9

wLastEnemyCounterMove:: ds 1 ; cbca
wLastPlayerCounterMove:: ds 1 ; cbcb

wcbcc:: ds 1 ; cbcc
wcbcd:: ds 1 ; cbcd
wcbce:: ds 1 ; cbce
wcbcf:: ds 1 ; cbcf
wcbd0:: ds 1 ; cbd0
wcbd1:: ds 1 ; cbd1
wcbd2:: ds 1 ; cbd2
wcbd3:: ds 1 ; cbd3
wcbd4:: ds 1 ; cbd4
wcbd5:: ds 1 ; cbd5
wcbd6:: ds 1 ; cbd6
wcbd7:: ds 1 ; cbd7
wcbd8:: ds 1 ; cbd8
wcbd9:: ds 1 ; cbd9
wcbda:: ds 1 ; cbda
wcbdb:: ds 1 ; cbdb
wcbdc:: ds 1 ; cbdc
wcbdd:: ds 1 ; cbdd
wcbde:: ds 1 ; cbde
wcbdf:: ds 1 ; cbdf
wcbe0:: ds 1 ; cbe0
wcbe1:: ds 1 ; cbe1
wcbe2:: ds 1 ; cbe2
wcbe3:: ds 1 ; cbe3
wcbe4:: ds 1 ; cbe4
wcbe5:: ds 1 ; cbe5
wcbe6:: ds 1 ; cbe6
wcbe7:: ds 1 ; cbe7
wcbe8:: ds 1 ; cbe8
wcbe9:: ds 1 ; cbe9
wcbea:: ds 1 ; cbea
wcbeb:: ds 1 ; cbeb
wcbec:: ds 1 ; cbec

wLastPlayerMove:: ds 1 ; cbed
wLastEnemyMove:: ds 1 ; cbee

wcbef:: ds 1 ; cbef
wcbf0:: ds 1 ; cbf0
wcbf1:: ds 1 ; cbf1
wcbf2:: ds 1 ; cbf2
wcbf3:: ds 1 ; cbf3
wcbf4:: ds 1 ; cbf4
wcbf5:: ds 1 ; cbf5
wcbf6:: ds 1 ; cbf6
wcbf7:: ds 1 ; cbf7
wcbf8:: ds 1 ; cbf8
wcbf9:: ds 1 ; cbf9
wcbfa:: ds 1 ; cbfa
wcbfb:: ds 1 ; cbfb
wcbfc:: ds 1 ; cbfc
wcbfd:: ds 1 ; cbfd
wcbfe:: ds 1 ; cbfe
wcbff:: ds 1 ; cbff
wcc00:: ds 1 ; cc00
wcc01:: ds 1 ; cc01
wcc02:: ds 1 ; cc02
wcc03:: ds 1 ; cc03
wcc04:: ds 1 ; cc04
wcc05:: ds 1 ; cc05
wcc06:: ds 1 ; cc06
wcc07:: ds 1 ; cc07
wcc08:: ds 1 ; cc08
wcc09:: ds 1 ; cc09
wcc0a:: ds 1 ; cc0a
wcc0b:: ds 1 ; cc0b
wcc0c:: ds 1 ; cc0c
wcc0d:: ds 1 ; cc0d
wcc0e:: ds 1 ; cc0e
wcc0f:: ds 1 ; cc0f
wcc10:: ds 1 ; cc10
wcc11:: ds 1 ; cc11
wcc12:: ds 1 ; cc12
wcc13:: ds 1 ; cc13
ENDU

wBGMapBuffer:: ds 1 ; cc14

wcc15:: ds 1 ; cc15
wcc16:: ds 1 ; cc16
wcc17:: ds 1 ; cc17
wcc18:: ds 1 ; cc18
wcc19:: ds 1 ; cc19
wcc1a:: ds 1 ; cc1a
wcc1b:: ds 1 ; cc1b
wcc1c:: ds 1 ; cc1c
wcc1d:: ds 1 ; cc1d
wcc1e:: ds 1 ; cc1e
wcc1f:: ds 1 ; cc1f
wcc20:: ds 1 ; cc20
wcc21:: ds 1 ; cc21
wcc22:: ds 1 ; cc22
wcc23:: ds 1 ; cc23
wcc24:: ds 1 ; cc24
wcc25:: ds 1 ; cc25
wcc26:: ds 1 ; cc26
wcc27:: ds 1 ; cc27
wcc28:: ds 1 ; cc28
wcc29:: ds 1 ; cc29
wcc2a:: ds 1 ; cc2a
wcc2b:: ds 1 ; cc2b
wcc2c:: ds 1 ; cc2c
wcc2d:: ds 1 ; cc2d
wcc2e:: ds 1 ; cc2e
wcc2f:: ds 1 ; cc2f
wcc30:: ds 1 ; cc30
wcc31:: ds 1 ; cc31
wcc32:: ds 1 ; cc32
wcc33:: ds 1 ; cc33
wcc34:: ds 1 ; cc34
wcc35:: ds 1 ; cc35
wcc36:: ds 1 ; cc36
wcc37:: ds 1 ; cc37
wcc38:: ds 1 ; cc38
wcc39:: ds 1 ; cc39
wcc3a:: ds 1 ; cc3a
wcc3b:: ds 1 ; cc3b

wBGMapPalBuffer:: ds 1 ; cc3c

wcc3d:: ds 1 ; cc3d
wcc3e:: ds 1 ; cc3e
wcc3f:: ds 1 ; cc3f
wcc40:: ds 1 ; cc40
wcc41:: ds 1 ; cc41
wcc42:: ds 1 ; cc42
wcc43:: ds 1 ; cc43
wcc44:: ds 1 ; cc44
wcc45:: ds 1 ; cc45
wcc46:: ds 1 ; cc46
wcc47:: ds 1 ; cc47
wcc48:: ds 1 ; cc48
wcc49:: ds 1 ; cc49
wcc4a:: ds 1 ; cc4a
wcc4b:: ds 1 ; cc4b
wcc4c:: ds 1 ; cc4c
wcc4d:: ds 1 ; cc4d
wcc4e:: ds 1 ; cc4e
wcc4f:: ds 1 ; cc4f
wcc50:: ds 1 ; cc50
wcc51:: ds 1 ; cc51
wcc52:: ds 1 ; cc52
wcc53:: ds 1 ; cc53
wcc54:: ds 1 ; cc54
wcc55:: ds 1 ; cc55
wcc56:: ds 1 ; cc56
wcc57:: ds 1 ; cc57
wcc58:: ds 1 ; cc58
wcc59:: ds 1 ; cc59
wcc5a:: ds 1 ; cc5a
wcc5b:: ds 1 ; cc5b
wcc5c:: ds 1 ; cc5c
wcc5d:: ds 1 ; cc5d
wcc5e:: ds 1 ; cc5e
wcc5f:: ds 1 ; cc5f
wcc60:: ds 1 ; cc60
wcc61:: ds 1 ; cc61
wcc62:: ds 1 ; cc62
wcc63:: ds 1 ; cc63

wBGMapBufferPtrs:: ds 1 ; cc64

wcc65:: ds 1 ; cc65
wcc66:: ds 1 ; cc66
wcc67:: ds 1 ; cc67
wcc68:: ds 1 ; cc68
wcc69:: ds 1 ; cc69
wcc6a:: ds 1 ; cc6a
wcc6b:: ds 1 ; cc6b
wcc6c:: ds 1 ; cc6c
wcc6d:: ds 1 ; cc6d
wcc6e:: ds 1 ; cc6e
wcc6f:: ds 1 ; cc6f
wcc70:: ds 1 ; cc70
wcc71:: ds 1 ; cc71
wcc72:: ds 1 ; cc72
wcc73:: ds 1 ; cc73
wcc74:: ds 1 ; cc74
wcc75:: ds 1 ; cc75
wcc76:: ds 1 ; cc76
wcc77:: ds 1 ; cc77
wcc78:: ds 1 ; cc78
wcc79:: ds 1 ; cc79
wcc7a:: ds 1 ; cc7a
wcc7b:: ds 1 ; cc7b
wcc7c:: ds 1 ; cc7c
wcc7d:: ds 1 ; cc7d
wcc7e:: ds 1 ; cc7e
wcc7f:: ds 1 ; cc7f
wcc80:: ds 1 ; cc80
wcc81:: ds 1 ; cc81
wcc82:: ds 1 ; cc82
wcc83:: ds 1 ; cc83
wcc84:: ds 1 ; cc84
wcc85:: ds 1 ; cc85
wcc86:: ds 1 ; cc86
wcc87:: ds 1 ; cc87
wcc88:: ds 1 ; cc88
wcc89:: ds 1 ; cc89
wcc8a:: ds 1 ; cc8a
wcc8b:: ds 1 ; cc8b

wDefaultSGBLayout:: db ; cc8c

wPlayerHPPal:: db ; cc8d
wEnemyHPPal:: db ; cc8e

wcc8f:: ds 1 ; cc8f
wcc90:: ds 1 ; cc90
wcc91:: ds 1 ; cc91
wcc92:: ds 1 ; cc92
wcc93:: ds 1 ; cc93
wcc94:: ds 1 ; cc94
wcc95:: ds 1 ; cc95
wcc96:: ds 1 ; cc96
wcc97:: ds 1 ; cc97
wcc98:: ds 1 ; cc98
wcc99:: ds 1 ; cc99
wcc9a:: ds 1 ; cc9a
wcc9b:: ds 1 ; cc9b
wcc9c:: ds 1 ; cc9c

wSGBPals:: ds 1 ; cc9d

wcc9e:: ds 1 ; cc9e
wcc9f:: ds 1 ; cc9f
wcca0:: ds 1 ; cca0
wcca1:: ds 1 ; cca1
wcca2:: ds 1 ; cca2
wcca3:: ds 1 ; cca3
wcca4:: ds 1 ; cca4
wcca5:: ds 1 ; cca5
wcca6:: ds 1 ; cca6
wcca7:: ds 1 ; cca7
wcca8:: ds 1 ; cca8
wcca9:: ds 1 ; cca9
wccaa:: ds 1 ; ccaa
wccab:: ds 1 ; ccab
wccac:: ds 1 ; ccac
wccad:: ds 1 ; ccad
wccae:: ds 1 ; ccae
wccaf:: ds 1 ; ccaf
wccb0:: ds 1 ; ccb0
wccb1:: ds 1 ; ccb1
wccb2:: ds 1 ; ccb2
wccb3:: ds 1 ; ccb3
wccb4:: ds 1 ; ccb4
wccb5:: ds 1 ; ccb5
wccb6:: ds 1 ; ccb6
wccb7:: ds 1 ; ccb7
wccb8:: ds 1 ; ccb8
wccb9:: ds 1 ; ccb9
wccba:: ds 1 ; ccba
wccbb:: ds 1 ; ccbb
wccbc:: ds 1 ; ccbc
wccbd:: ds 1 ; ccbd
wccbe:: ds 1 ; ccbe
wccbf:: ds 1 ; ccbf
wccc0:: ds 1 ; ccc0
wccc1:: ds 1 ; ccc1
wccc2:: ds 1 ; ccc2
wccc3:: ds 1 ; ccc3
wccc4:: ds 1 ; ccc4
wccc5:: ds 1 ; ccc5
wccc6:: ds 1 ; ccc6
wccc7:: ds 1 ; ccc7
wccc8:: ds 1 ; ccc8
wccc9:: ds 1 ; ccc9
wccca:: ds 1 ; ccca
wcccb:: ds 1 ; cccb
wcccc:: ds 1 ; cccc

wAttrmap:: ; cccd
	ds SCREEN_HEIGHT * SCREEN_WIDTH
wAttrmapEnd:: ; ce35

wTileAnimBuffer::
wce35:: ds 1 ; ce35
wce36:: ds 1 ; ce36
wce37:: ds 1 ; ce37
wce38:: ds 1 ; ce38
wce39:: ds 1 ; ce39
wce3a:: ds 1 ; ce3a
wce3b:: ds 1 ; ce3b
wce3c:: ds 1 ; ce3c
wce3d:: ds 1 ; ce3d
wce3e:: ds 1 ; ce3e
wce3f:: ds 1 ; ce3f
wce40:: ds 1 ; ce40
wce41:: ds 1 ; ce41
wce42:: ds 1 ; ce42
wce43:: ds 1 ; ce43
wce44:: ds 1 ; ce44
wce45:: ds 1 ; ce45
wce46:: ds 1 ; ce46
wce47:: ds 1 ; ce47
wce48:: ds 1 ; ce48
wce49:: ds 1 ; ce49
wce4a:: ds 1 ; ce4a
wce4b:: ds 1 ; ce4b
wce4c:: ds 1 ; ce4c
wce4d:: ds 1 ; ce4d
wce4e:: ds 1 ; ce4e
wce4f:: ds 1 ; ce4f
wce50:: ds 1 ; ce50
wce51:: ds 1 ; ce51
wce52:: ds 1 ; ce52

wMonType:: ds 1 ; ce53
wCurSpecies:: ds 1 ; ce54
wNamedObjectTypeBuffer:: ds 1 ; ce55

wce56:: ds 1 ; ce56
wJumptableIndex:: ds 1 ; ce57
wce58:: ds 1 ; ce58
wce59:: ds 1 ; ce59
wce5a:: ds 1 ; ce5a

wRequested2bppSize:: db
wRequested2bppSource:: dw
wRequested2bppDest:: dw

wRequested1bppSize:: db
wRequested1bppSource:: dw
wRequested1bppDest:: dw

wSecondsSince:: db
wMinutesSince:: db
wHoursSince:: db
wDaysSince:: db

	ds 12

wce75:: ds 1 ; ce75
wce76:: ds 1 ; ce76

wPlayerStepVectorX:: ds 1 ; ce77
wPlayerStepVectorY:: ds 1 ; ce78
wPlayerStepFlags:: ds 1 ; ce79
wPlayerStepDirection:: ds 1 ; ce7a

wce7b:: ds 1 ; ce7b
wce7c:: ds 1 ; ce7c
wce7d:: ds 1 ; ce7d
wce7e:: ds 1 ; ce7e

wMovementObject:: ds 1 ; ce7f
wMovementDataBank:: ds 1 ; ce80
wMovementDataAddress:: ds 2 ; ce81

wce83:: ds 1 ; ce83
wce84:: ds 1 ; ce84
wce85:: ds 1 ; ce85
wce86:: ds 1 ; ce86
wce87:: ds 1 ; ce87
wce88:: ds 1 ; ce88
wce89:: ds 1 ; ce89
wce8a:: ds 1 ; ce8a
wce8b:: ds 1 ; ce8b
wce8c:: ds 1 ; ce8c
wce8d:: ds 1 ; ce8d
wce8e:: ds 1 ; ce8e
wce8f:: ds 1 ; ce8f
wce90:: ds 1 ; ce90
wce91:: ds 1 ; ce91
wce92:: ds 1 ; ce92
wce93:: ds 1 ; ce93
wce94:: ds 1 ; ce94
wce95:: ds 1 ; ce95
wce96:: ds 1 ; ce96

wTileDown:: ds 1 ; ce97
wTileUp:: ds 1 ; ce98
wTileLeft:: ds 1 ; ce99
wTileRight:: ds 1 ; ce9a
wTilePermissions:: ds 1 ; ce9b

wce9c:: ds 1 ; ce9c
wce9d:: ds 1 ; ce9d
wce9e:: ds 1 ; ce9e
wce9f:: ds 1 ; ce9f
wcea0:: ds 1 ; cea0
wcea1:: ds 1 ; cea1
wcea2:: ds 1 ; cea2
wcea3:: ds 1 ; cea3
wcea4:: ds 1 ; cea4
wcea5:: ds 1 ; cea5
wcea6:: ds 1 ; cea6
wcea7:: ds 1 ; cea7
wcea8:: ds 1 ; cea8
wcea9:: ds 1 ; cea9
wceaa:: ds 1 ; ceaa
wceab:: ds 1 ; ceab
wceac:: ds 1 ; ceac
wcead:: ds 1 ; cead
wceae:: ds 1 ; ceae
wceaf:: ds 1 ; ceaf
wceb0:: ds 1 ; ceb0
wceb1:: ds 1 ; ceb1
wceb2:: ds 1 ; ceb2
wceb3:: ds 1 ; ceb3
wceb4:: ds 1 ; ceb4
wceb5:: ds 1 ; ceb5
wceb6:: ds 1 ; ceb6
wceb7:: ds 1 ; ceb7
wceb8:: ds 1 ; ceb8
wceb9:: ds 1 ; ceb9
wceba:: ds 1 ; ceba
wcebb:: ds 1 ; cebb

wToolgearBuffer:: ds SCREEN_WIDTH ; cebc

wced0:: ds 1 ; ced0
wced1:: ds 1 ; ced1
wced2:: ds 1 ; ced2
wced3:: ds 1 ; ced3
wced4:: ds 1 ; ced4
wced5:: ds 1 ; ced5
wced6:: ds 1 ; ced6

wced7:: ds 1 ; ced7
wced8:: ds 1 ; ced8
wced9:: ds 1 ; ced9
wceda:: ds 1 ; ceda
wcedb:: ds 1 ; cedb

wWindowData::
wWindowStackPointer:: ds 2 ; cedc
wMenuJoypad:: ds 1 ; cede
wMenuSelection:: ds 1 ; cedf
wcee0:: ds 1 ; cee0
wWhichIndexSet:: ds 1 ; cee1
wcee2:: ds 1 ; cee2
wcee3:: ds 1 ; cee3
wcee4:: ds 1 ; cee4
wcee5:: ds 1 ; cee5
wcee6:: ds 1 ; cee6
wcee7:: ds 1 ; cee7
wcee8:: ds 1 ; cee8
wcee9:: ds 1 ; cee9
wceea:: ds 1 ; ceea
wceeb:: ds 1 ; ceeb

wMenuHeader::
wMenuFlags::
wceec:: ds 1 ; ceec
wMenuBorderTopCoord:: ds 1 ; ceed
wMenuBorderLeftCoord:: ds 1 ; ceee
wMenuBorderBottomCoord:: ds 1 ; ceef
wMenuBorderRightCoord:: ds 1 ; cef0
wMenuDataPointer:: ds 2 ; cef1
wMenuCursorBuffer:: ds 1 ; cef3
wcef4:: ds 1 ; cef4
wcef5:: ds 1 ; cef5
wcef6:: ds 1 ; cef6
wcef7:: ds 1 ; cef7
wcef8:: ds 1 ; cef8
wcef9:: ds 1 ; cef9
wcefa:: ds 1 ; cefa
wcefb:: ds 1 ; cefb
wMenuHeaderEnd::

wMenuData::
wMenuDataFlags:: ds 1 ; cefc
wMenuDataItems:: ds 1 ; cefd
wMenuDataIndicesPointer:: ds 1 ; cefe
wMenuDataBank:: ds 1 ; ceff
wMenuDataDisplayFunctionPointer:: ds 2 ; cf00
wMenuDataPointerTableAddr:: ds 1 ; cf02
wcf03:: ds 1 ; cf03
wcf04:: ds 1 ; cf04
wcf05:: ds 1 ; cf05
wcf06:: ds 1 ; cf06
wcf07:: ds 1 ; cf07
wcf08:: ds 1 ; cf08
wcf09:: ds 1 ; cf09
wcf0a:: ds 1 ; cf0a
wcf0b:: ds 1 ; cf0b
wMenuDataEnd::

wMenuData3::
w2DMenuCursorInitY:: ds 1 ; cf0c
w2DMenuCursorInitX:: ds 1 ; cf0d
w2DMenuNumRows:: ds 1 ; cf0e
w2DMenuNumCols:: ds 1 ; cf0f
w2DMenuFlags1:: ds 1 ; cf10
w2DMenuFlags2:: ds 1 ; cf11
w2DMenuCursorOffsets:: ds 1 ; cf12
wMenuJoypadFilter:: ds 1 ; cf13
wMenuCursorY:: ds 1 ; cf14
wMenuCursorX:: ds 1 ; cf15
wcf16:: ds 1 ; cf16
wCursorCurrentTile:: ds 1 ; cf17
wcf18:: ds 1 ; cf18
wcf19:: ds 1 ; cf19
wcf1a:: ds 1 ; cf1a
wcf1b:: ds 1 ; cf1b
wMenuData3End::

wOverworldDelay:: ds 1 ; cf1c
wTextDelayFrames:: ds 1 ; cf1d
wVBlankOccurred:: ds 1 ; cf1e

wcf1f:: ds 1 ; cf1f
wDefaultSpawnpoint:: ds 1 ; cf20

UNION ; cf21
; movement buffer data
wMovementBufferCount:: db
wMovementBufferObject:: db
wUnusedMovementBufferBank:: db
wUnusedMovementBufferPointer:: dw
wMovementBuffer:: ds 1; cf26

NEXTU ; cf21
; bug-catching contest
wBugContestResults::
	bugcontestwinner wBugContestFirstPlace
	bugcontestwinner wBugContestSecondPlace
	bugcontestwinner wBugContestThirdPlace
wBugContestWinnersEnd::
	bugcontestwinner wBugContestTemp
	ds 4
wBugContestWinnerName:: ds NAME_LENGTH

NEXTU ; cf21
wDebugMusicTrack:: db
	ds 2
wDebugSFXTrack:: db

NEXTU
; trade
wCurTradePartyMon:: db
wCurOTTradePartyMon:: db
wBufferTrademonNick:: ds MON_NAME_LENGTH

NEXTU ; cf21
wcf21:: ds 1 ; cf21
wcf22:: ds 1 ; cf22
wcf23:: ds 1 ; cf23

wcf24:: ds 1 ; cf24
wcf25:: ds 1 ; cf25
wcf26:: ds 1 ; cf26
wcf27:: ds 1 ; cf27
wcf28:: ds 1 ; cf28
wcf29:: ds 1 ; cf29
wcf2a:: ds 1 ; cf2a
wcf2b:: ds 1 ; cf2b
wcf2c:: ds 1 ; cf2c
wcf2d:: ds 1 ; cf2d
wcf2e:: ds 1 ; cf2e
wcf2f:: ds 1 ; cf2f
wcf30:: ds 1 ; cf30
wcf31:: ds 1 ; cf31
wcf32:: ds 1 ; cf32
wcf33:: ds 1 ; cf33
wcf34:: ds 1 ; cf34
wcf35:: ds 1 ; cf35
wcf36:: ds 1 ; cf36
wcf37:: ds 1 ; cf37
wcf38:: ds 1 ; cf38
wcf39:: ds 1 ; cf39
wcf3a:: ds 1 ; cf3a

ENDU

wcf3b:: ds 1 ; cf3b
wcf3c:: ds 1 ; cf3c
wcf3d:: ds 1 ; cf3d
wcf3e:: ds 1 ; cf3e
wcf3f:: ds 1 ; cf3f
wcf40:: ds 1 ; cf40
wcf41:: ds 1 ; cf41
wcf42:: ds 1 ; cf42
wcf43:: ds 1 ; cf43
wcf44:: ds 1 ; cf44
wcf45:: ds 1 ; cf45
wcf46:: ds 1 ; cf46
wcf47:: ds 1 ; cf47
wcf48:: ds 1 ; cf48
wcf49:: ds 1 ; cf49
wcf4a:: ds 1 ; cf4a
wcf4b:: ds 1 ; cf4b
wcf4c:: ds 1 ; cf4c
wcf4d:: ds 1 ; cf4d
wcf4e:: ds 1 ; cf4e
wcf4f:: ds 1 ; cf4f
wcf50:: ds 1 ; cf50
wcf51:: ds 1 ; cf51
wcf52:: ds 1 ; cf52

wSeenTrainerBank:: ; cf53
wcf53:: ds 1 ; cf53
wCallerContact::
wSeenTrainerDistance:: ds 1 ; cf54
wSeenTrainerDirection:: ds 1 ; cf55

wTempTrainer:: ; cf56
wcf56:: ds 1 ; cf56
wcf57:: ds 1 ; cf57
wcf58:: ds 1 ; cf58
wcf59:: ds 1 ; cf59
wcf5a:: ds 1 ; cf5a
wcf5b:: ds 1 ; cf5b
wWinTextPointer:: ds 2 ; cf5c
wLossTextPointer:: ds 2 ; cf5e
wcf60:: ds 1 ; cf60
wcf61:: ds 1 ; cf61
wRunningTrainerBattleScript:: ds 1 ; cf62
wTempTrainerEnd::

wcf63:: ds 1 ; cf63
wcf64:: ds 1 ; cf64

wBoxAlignment:: ds 1 ; cf65

wcf66:: ds 1 ; cf66
wcf67:: ds 1 ; cf67
wcf68:: ds 1 ; cf68
wcf69:: ds 1 ; cf69
wcf6a:: ds 1 ; cf6a
wcf6b:: ds 1 ; cf6b
wTileAnimationTimer:: ds 1 ; cf6c
wcf6d:: ds 1 ; cf6d
wcf6e:: ds 1 ; cf6e
wcf6f:: ds 1 ; cf6f
wcf70:: ds 1 ; cf70
wcf71:: ds 1 ; cf71
wMonOrItemNameBuffer:: ds 1 ; cf72
wcf73:: ds 1 ; cf73
wcf74:: ds 1 ; cf74
wcf75:: ds 1 ; cf75
wcf76:: ds 1 ; cf76
wcf77:: ds 1 ; cf77
wcf78:: ds 1 ; cf78
wcf79:: ds 1 ; cf79
wcf7a:: ds 1 ; cf7a
wcf7b:: ds 1 ; cf7b
wcf7c:: ds 1 ; cf7c
wcf7d:: ds 1 ; cf7d
wcf7e:: ds 1 ; cf7e
wcf7f:: ds 1 ; cf7f
wcf80:: ds 1 ; cf80
wcf81:: ds 1 ; cf81
wcf82:: ds 1 ; cf82
wcf83:: ds 1 ; cf83
wcf84:: ds 1 ; cf84
wcf85:: ds 1 ; cf85
wcf86:: ds 1 ; cf86

wStringBuffer1:: ds 11 ; cf87
wStringBuffer2:: ds 11 ; cf92
wStringBuffer3:: ds 11 ; cf9d

wcfa8:: ds 1 ; cfa8
wcfa9:: ds 1 ; cfa9
wcfaa:: ds 1 ; cfaa
wcfab:: ds 1 ; cfab
wcfac:: ds 1 ; cfac
wcfad:: ds 1 ; cfad
wcfae:: ds 1 ; cfae
wcfaf:: ds 1 ; cfaf
wcfb0:: ds 1 ; cfb0
wcfb1:: ds 1 ; cfb1
wcfb2:: ds 1 ; cfb2
wcfb3:: ds 1 ; cfb3
wcfb4:: ds 1 ; cfb4
wcfb5:: ds 1 ; cfb5
wcfb6:: ds 1 ; cfb6
wcfb7:: ds 1 ; cfb7
wcfb8:: ds 1 ; cfb8
wcfb9:: ds 1 ; cfb9
wcfba:: ds 1 ; cfba
wcfbb:: ds 1 ; cfbb
wcfbc:: ds 1 ; cfbc
wcfbd:: ds 1 ; cfbd
wcfbe:: ds 1 ; cfbe
wcfbf:: ds 1 ; cfbf

wCurBattleMon:: ds 1 ; cfc0

wcfc1:: ds 1 ; cfc1
wcfc2:: ds 1 ; cfc2
wPartyMenuCursor:: ds 1 ; cfc3
wcfc4:: ds 1 ; cfc4
wcfc5:: ds 1 ; cfc5
wcfc6:: ds 1 ; cfc6
wcfc7:: ds 1 ; cfc7
wcfc8:: ds 1 ; cfc8
wcfc9:: ds 1 ; cfc9
wcfca:: ds 1 ; cfca
wcfcb:: ds 1 ; cfcb
wcfcc:: ds 1 ; cfcc
wcfcd:: ds 1 ; cfcd
wcfce:: ds 1 ; cfce
wcfcf:: ds 1 ; cfcf

wcfd0:: ds 1 ; cfd0
wcfd1:: ds 1 ; cfd1

wQueuedScriptBank:: ds 1 ; cfd2
wQueuedScriptAddr:: ds 2 ; cfd3

wPredefID:: ds 1 ; cfd5
wPredefTemp:: dw ; cfd6
wPredefAddress:: dw ; cfd8

wFarCallBCBuffer:: ds 1 ; cfda
wcfdb:: ds 1 ; cfdb
wcfdc:: ds 1 ; cfdc
wNumMoves:: ds 1 ; cfdd

wcfde:: ds 1 ; cfde

wVramState:: ds 1 ; cfdf

wcfe0:: ds 1 ; cfe0
wcfe1:: ds 1 ; cfe1
wcfe2:: ds 1 ; cfe2

wBattleResult:: ds 1 ; cfe3

wcfe4:: ds 1 ; cfe4
wcfe5:: ds 1 ; cfe5
wcfe6:: ds 1 ; cfe6
wcfe7:: ds 1 ; cfe7
wcfe8:: ds 1 ; cfe8
wcfe9:: ds 1 ; cfe9
wcfea:: ds 1 ; cfea
wcfeb:: ds 1 ; cfeb
wcfec:: ds 1 ; cfec
wcfed:: ds 1 ; cfed
wcfee:: ds 1 ; cfee
wcfef:: ds 1 ; cfef
wcff0:: ds 1 ; cff0
wcff1:: ds 1 ; cff1
wcff2:: ds 1 ; cff2
wcff3:: ds 1 ; cff3
wcff4:: ds 1 ; cff4
wcff5:: ds 1 ; cff5
wcff6:: ds 1 ; cff6
wcff7:: ds 1 ; cff7
wcff8:: ds 1 ; cff8
wcff9:: ds 1 ; cff9
wcffa:: ds 1 ; cffa
wcffb:: ds 1 ; cffb
wCurItem:: ds 1 ; cffc
wcffd:: ds 1 ; cffd

wCurPartySpecies:: ds 1 ; cffe
wCurPartyMon:: ds 1 ; cfff

SECTION "WRAM1", WRAMX, BANK[$1]
wd000:: ds 1 ; d000
wd001:: ds 1 ; d001
wPokemonWithdrawDepositParameter:: ds 1 ; d002
wItemQuantityChangeBuffer:: ds 1 ; d003
wd004:: ds 1 ; d004
wd005:: ds 1 ; d005
wd006:: ds 1 ; d006
wd007:: ds 1 ; d007
wd008:: ds 1 ; d008
wd009:: ds 1 ; d009
wd00a:: ds 1 ; d00a
wd00b:: ds 1 ; d00b
wd00c:: ds 1 ; d00c
wd00d:: ds 1 ; d00d
wd00e:: ds 1 ; d00e
wd00f:: ds 1 ; d00f
wd010:: ds 1 ; d010
wd011:: ds 1 ; d011
wd012:: ds 1 ; d012
wd013:: ds 1 ; d013
wd014:: ds 1 ; d014
wd015:: ds 1 ; d015
wd016:: ds 1 ; d016
wd017:: ds 1 ; d017
wd018:: ds 1 ; d018
wd019:: ds 1 ; d019
wd01a:: ds 1 ; d01a
wd01b:: ds 1 ; d01b
wd01c:: ds 1 ; d01c
wd01d:: ds 1 ; d01d
wd01e:: ds 1 ; d01e
wd01f:: ds 1 ; d01f
wd020:: ds 1 ; d020
wd021:: ds 1 ; d021
wd022:: ds 1 ; d022
wd023:: ds 1 ; d023

wTempMonLevel:: ds 1 ; d024

wd025:: ds 1 ; d025
wd026:: ds 1 ; d026
wd027:: ds 1 ; d027
wd028:: ds 1 ; d028
wd029:: ds 1 ; d029
wd02a:: ds 1 ; d02a
wd02b:: ds 1 ; d02b
wd02c:: ds 1 ; d02c
wd02d:: ds 1 ; d02d
wd02e:: ds 1 ; d02e
wd02f:: ds 1 ; d02f
wd030:: ds 1 ; d030
wd031:: ds 1 ; d031
wd032:: ds 1 ; d032
wd033:: ds 1 ; d033
wd034:: ds 1 ; d034
wd035:: ds 1 ; d035
wd036:: ds 1 ; d036
wd037:: ds 1 ; d037
wd038:: ds 1 ; d038
wd039:: ds 1 ; d039

wCurPartyLevel:: db

wScrollingMenuListSize:: db

wLinkMode:: db
; 0 not in link battle
; 1 link battle

wNextWarpNumber:: ds 1 ; d03d
wNextMapGroup:: ds 1 ; d03e
wNextMapNumber:: ds 1 ; d03f
wPrevWarpNumber:: ds 1 ; d040
wPrevMapGroup:: ds 1 ; d041
wPrevMapNumber:: ds 1 ; d042

wd043:: ds 1 ; d043
wd044:: ds 1 ; d044
wd045:: ds 1 ; d045
wd046:: ds 1 ; d046
wd047:: ds 1 ; d047
wd048:: ds 1 ; d048
wd049:: ds 1 ; d049
wd04a:: ds 1 ; d04a
wd04b:: ds 1 ; d04b
wd04c:: ds 1 ; d04c

wBGMapAnchor:: dw ; d04d

wUsedSprites:: ds SPRITE_GFX_LIST_CAPACITY * 2
wUsedSpritesEnd::
	ds 8

wOverworldMapAnchor:: dw
wd071:: ds 1 ; d071
wd072:: ds 1 ; d072

wd073:: ds 1 ; d073
wd074:: ds 1 ; d074

wEnvironment:: db ; d075

wd076:: ds 1 ; d076
wd077:: ds 1 ; d077

wMapBorderBlock:: ds 1 ; d078
wd079:: ds 1 ; d079
wMapWidth:: ds 1 ; d07a

wd07b:: ds 1 ; d07b
wd07c:: ds 1 ; d07c
wd07d:: ds 1 ; d07d
wd07e:: ds 1 ; d07e
wd07f:: ds 1 ; d07f
wd080:: ds 1 ; d080
wd081:: ds 1 ; d081
wd082:: ds 1 ; d082
wd083:: ds 1 ; d083
wd084:: ds 1 ; d084
wd085:: ds 1 ; d085
wd086:: ds 1 ; d086
wd087:: ds 1 ; d087
wd088:: ds 1 ; d088
wd089:: ds 1 ; d089
wd08a:: ds 1 ; d08a
wd08b:: ds 1 ; d08b
wd08c:: ds 1 ; d08c
wd08d:: ds 1 ; d08d
wd08e:: ds 1 ; d08e
wd08f:: ds 1 ; d08f
wd090:: ds 1 ; d090
wd091:: ds 1 ; d091
wd092:: ds 1 ; d092
wd093:: ds 1 ; d093
wd094:: ds 1 ; d094
wd095:: ds 1 ; d095
wd096:: ds 1 ; d096
wd097:: ds 1 ; d097
wd098:: ds 1 ; d098
wd099:: ds 1 ; d099
wd09a:: ds 1 ; d09a
wd09b:: ds 1 ; d09b
wd09c:: ds 1 ; d09c
wd09d:: ds 1 ; d09d
wd09e:: ds 1 ; d09e
wd09f:: ds 1 ; d09f
wd0a0:: ds 1 ; d0a0
wd0a1:: ds 1 ; d0a1
wd0a2:: ds 1 ; d0a2
wd0a3:: ds 1 ; d0a3
wd0a4:: ds 1 ; d0a4
wd0a5:: ds 1 ; d0a5
wd0a6:: ds 1 ; d0a6
wd0a7:: ds 1 ; d0a7
wd0a8:: ds 1 ; d0a8
wd0a9:: ds 1 ; d0a9
wd0aa:: ds 1 ; d0aa
wd0ab:: ds 1 ; d0ab
wd0ac:: ds 1 ; d0ac
wd0ad:: ds 1 ; d0ad
wd0ae:: ds 1 ; d0ae
wd0af:: ds 1 ; d0af
wd0b0:: ds 1 ; d0b0
wd0b1:: ds 1 ; d0b1
wd0b2:: ds 1 ; d0b2
wd0b3:: ds 1 ; d0b3

wTileset::
wTilesetBank:: db ; d0b4
wTilesetAddress:: dw ; d0b5
wTilesetBlocksBank:: db ; d0b7
wTilesetBlocksAddress:: dw ; d0b8
wTilesetCollisionBank:: db ; d0ba
wTilesetCollisionAddress:: dw ; d0bb
wTilesetAnim:: dw ; d0bd
wd0bf:: ds 2 ; d0bf
wTilesetPalettes:: dw ; d0c1
wTilesetEnd::

wd0c3:: ds 1 ; d0c3
wd0c4:: ds 1 ; d0c4

UNION
; Debug
wDebugItem::
wDebugClockCurrentOption:: ; d0c5
wd0c5:: ds 1 ; d0c5
wDebugItemQuantity::
wDebugClockCurrentOptionBackup:: ds 1 ; d0c6
wd0c7:: ds 1 ; d0c7
wDebugClockDayLo:: ds 1 ; d0c8
wDebugClockHours:: ds 1 ; d0c9
wDebugClockMinutes:: ds 1 ; d0ca
wDebugClockSeconds::  ds 1 ; d0cb
wDebugClockResetValue:: ds 1 ; d0cc

wd0cd:: ds 1 ; d0cd
wd0ce:: ds 1 ; d0ce
wd0cf:: ds 1 ; d0cf
wd0d0:: ds 1 ; d0d0
wd0d1:: ds 1 ; d0d1
wd0d2:: ds 1 ; d0d2
wd0d3:: ds 1 ; d0d3
wd0d4:: ds 1 ; d0d4
wd0d5:: ds 1 ; d0d5
wd0d6:: ds 1 ; d0d6
wd0d7:: ds 1 ; d0d7
wd0d8:: ds 1 ; d0d8
wd0d9:: ds 1 ; d0d9
wd0da:: ds 1 ; d0da
wd0db:: ds 1 ; d0db
wd0dc:: ds 1 ; d0dc
wd0dd:: ds 1 ; d0dd
wd0de:: ds 1 ; d0de

NEXTU
; field move data
wFieldMoveData::
wFieldMoveJumptableIndex:: db
wEscapeRopeOrDigType::
wSurfingPlayerState::
wFishingRodUsed:: db
wCutWhirlpoolOverworldBlockAddr:: dw
wCutWhirlpoolReplacementBlock:: db
wCutWhirlpoolAnimationType::
wStrengthSpecies::
wFishingResult:: db
	ds 1
wFieldMoveDataEnd::
ENDU

wTempEnemyMonSpecies:: ds 1 ; d0df
wTempBattleMonSpecies:: ds 1 ; d0e0

wEnemyMon:: battle_struct wEnemyMon ; d0e1

wd101:: ds 1 ; d101
wd102:: ds 1 ; d102
wd103:: ds 1 ; d103
wd104:: ds 1 ; d104
wd105:: ds 1 ; d105
wd106:: ds 1 ; d106
wd107:: ds 1 ; d107
wBattleMode:: ds 1 ; d108
wd109:: ds 1 ; d109

wOtherTrainerClass:: ds 1 ; d10a

wBattleType:: ds 1 ; d10b
wd10c:: ds 1 ; d10c
wd10d:: ds 1 ; d10d
wd10e:: ds 1 ; d10e

wTrainerClass:: ds 1 ; d10f

wUnownLetter:: ds 1 ; d110

wd111:: ds 1 ; d111

wCurBaseData::
wBaseDexNo:: ds 1 ; d112
wd113:: ds 1 ; d113
wd114:: ds 1 ; d114
wd115:: ds 1 ; d115
wd116:: ds 1 ; d116
wd117:: ds 1 ; d117
wd118:: ds 1 ; d118
wBaseType::
wBaseType1:: db
wBaseType2:: db
wd11b:: ds 1 ; d11b
wd11c:: ds 1 ; d11c
wd11d:: ds 1 ; d11d
wd11e:: ds 1 ; d11e
wd11f:: ds 1 ; d11f
wd120:: ds 1 ; d120
wd121:: ds 1 ; d121
wd122:: ds 1 ; d122
wBasePicSize:: ds 1 ; d123
wBaseUnusedFrontpic:: ds 1 ; d124
wd125:: ds 1 ; d125
wd126:: ds 1 ; d126
wd127:: ds 1 ; d127
wd128:: ds 1 ; d128
wd129:: ds 1 ; d129
wd12a:: ds 1 ; d12a
wd12b:: ds 1 ; d12b
wd12c:: ds 1 ; d12c
wd12d:: ds 1 ; d12d
wd12e:: ds 1 ; d12e
wd12f:: ds 1 ; d12f
wd130:: ds 1 ; d130
wd131:: ds 1 ; d131
wCurBaseDataEnd::

wd132:: ds 1 ; d132
wCurDamage:: ds 1 ; d133
wd134:: ds 1 ; d134
wd135:: ds 1 ; d135
wd136:: ds 1 ; d136
wd137:: ds 1 ; d137
wd138:: ds 1 ; d138
wd139:: ds 1 ; d139
wd13a:: ds 1 ; d13a
wListMoves_MoveIndicesBuffer:: ds NUM_MOVES ; d13b
wTMHMMove:: ds 1 ; d13f
wd140:: ds 1 ; d140
wd141:: ds 1 ; d141
wd142:: ds 1 ; d142

; d143 has many different short-term uses
wNamedObjectIndexBuffer::
wDeciramBuffer::
wTempByteValue::
wNumSetBits::
wTypeMatchup::
wCurType::
wTempSpecies::
wTempIconSpecies::
wTempTMHM::
wTempPP::
wNextBoxOrPartyIndex::
wChosenCableClubRoom::
wBreedingCompatibility::
wMoveGrammar::
wApplyStatLevelMultipliersToEnemy::
wUsePPUp::
wd143:: db

wd144:: ds 1 ; d144
wd145:: ds 1 ; d145
wd146:: ds 1 ; d146

wROMBankBackup:: ds 1 ; d147
wBuffer:: ds 1 ; d148
wTimeOfDay:: ds 1 ; d149

wd14a:: ds 1 ; d14a
wd14b:: ds 1 ; d14b
wd14c:: ds 1 ; d14c
wd14d:: ds 1 ; d14d
wd14e:: ds 1 ; d14e
wd14f:: ds 1 ; d14f
wd150:: ds 1 ; d150
wd151:: ds 1 ; d151
wScriptBank:: ds 1 ; d152
wd153:: ds 1 ; d153
wd154:: ds 1 ; d154
wd155:: ds 1 ; d155
wd156:: ds 1 ; d156
wd157:: ds 1 ; d157
wd158:: ds 1 ; d158
wd159:: ds 1 ; d159
wd15a:: ds 1 ; d15a
wd15b:: ds 1 ; d15b
wd15c:: ds 1 ; d15c
wd15d:: ds 1 ; d15d
wd15e:: ds 1 ; d15e
wd15f:: ds 1 ; d15f
wd160:: ds 1 ; d160
wd161:: ds 1 ; d161
wd162:: ds 1 ; d162
wd163:: ds 1 ; d163
wd164:: ds 1 ; d164

wScriptVar:: ds 1 ; d165

wd166:: ds 1 ; d166
wd167:: ds 1 ; d167
wd168:: ds 1 ; d168
wd169:: ds 1 ; d169
wd16a:: ds 1 ; d16a
wd16b:: ds 1 ; d16b
wd16c:: ds 1 ; d16c
wd16d:: ds 1 ; d16d
wd16e:: ds 1 ; d16e
wd16f:: ds 1 ; d16f
wd170:: ds 1 ; d170
wd171:: ds 1 ; d171
wd172:: ds 1 ; d172
wd173:: ds 1 ; d173
wd174:: ds 1 ; d174
wMapReentryScriptQueueFlag::
wd175:: ds 1 ; d175
wd176:: ds 1 ; d176
wd177:: ds 1 ; d177
wd178:: ds 1 ; d178
wd179:: ds 1 ; d179
wd17a:: ds 1 ; d17a
wd17b:: ds 1 ; d17b
wd17c:: ds 1 ; d17c
wd17d:: ds 1 ; d17d
wd17e:: ds 1 ; d17e
wd17f:: ds 1 ; d17f
wd180:: ds 1 ; d180
wd181:: ds 1 ; d181
wd182:: ds 1 ; d182
wd183:: ds 1 ; d183
wd184:: ds 1 ; d184

wBugContestMinsRemaining:: ds 1 ; d185
wBugContestSecsRemaining:: ds 1 ; d186

wd187:: ds 1 ; d187
wd188:: ds 1 ; d188
wd189:: ds 1 ; d189
wd18a:: ds 1 ; d18a
wd18b:: ds 1 ; d18b
wd18c:: ds 1 ; d18c
wd18d:: ds 1 ; d18d
wd18e:: ds 1 ; d18e
wd18f:: ds 1 ; d18f
wd190:: ds 1 ; d190
wd191:: ds 1 ; d191
wd192:: ds 1 ; d192
wd193:: ds 1 ; d193
wd194:: ds 1 ; d194
wd195:: ds 1 ; d195
wd196:: ds 1 ; d196
wd197:: ds 1 ; d197
wd198:: ds 1 ; d198
wd199:: ds 1 ; d199
wd19a:: ds 1 ; d19a
wd19b:: ds 1 ; d19b
wd19c:: ds 1 ; d19c
wd19d:: ds 1 ; d19d
wd19e:: ds 1 ; d19e
wd19f:: ds 1 ; d19f
wd1a0:: ds 1 ; d1a0
wd1a1:: ds 1 ; d1a1
wd1a2:: ds 1 ; d1a2
wd1a3:: ds 1 ; d1a3
wd1a4:: ds 1 ; d1a4
wd1a5:: ds 1 ; d1a5
wd1a6:: ds 1 ; d1a6
wd1a7:: ds 1 ; d1a7
wd1a8:: ds 1 ; d1a8
wd1a9:: ds 1 ; d1a9
wd1aa:: ds 1 ; d1aa

wOptions:: ds 1 ; d1ab

wSaveFileExists:: ds 1 ; d1ac

wTextboxFrame:: ds 1 ; d1ad
wTextboxFlags:: ds 1 ; d1ae

wGBPrinter:: ds 1 ; d1af
wOptions2:: ds 3 ; d1b0

wOptionsEnd::

wd1b3:: ds 1 ; d1b3
wd1b4:: ds 1 ; d1b4

wPlayerName:: ds 1 ; d1b5

wd1b6:: ds 1 ; d1b6
wd1b7:: ds 1 ; d1b7
wd1b8:: ds 1 ; d1b8
wd1b9:: ds 1 ; d1b9
wd1ba:: ds 1 ; d1ba
wd1bb:: ds 1 ; d1bb
wd1bc:: ds 1 ; d1bc
wd1bd:: ds 1 ; d1bd
wd1be:: ds 1 ; d1be
wd1bf:: ds 1 ; d1bf
wd1c0:: ds 1 ; d1c0
wd1c1:: ds 1 ; d1c1
wd1c2:: ds 1 ; d1c2
wd1c3:: ds 1 ; d1c3
wd1c4:: ds 1 ; d1c4
wd1c5:: ds 1 ; d1c5
wd1c6:: ds 1 ; d1c6
wd1c7:: ds 1 ; d1c7
wd1c8:: ds 1 ; d1c8
wd1c9:: ds 1 ; d1c9
wd1ca:: ds 1 ; d1ca
wd1cb:: ds 1 ; d1cb
wd1cc:: ds 1 ; d1cc
wd1cd:: ds 1 ; d1cd
wd1ce:: ds 1 ; d1ce
wd1cf:: ds 1 ; d1cf
wd1d0:: ds 1 ; d1d0
wd1d1:: ds 1 ; d1d1
wd1d2:: ds 1 ; d1d2
wd1d3:: ds 1 ; d1d3
wd1d4:: ds 1 ; d1d4
wd1d5:: ds 1 ; d1d5
wd1d6:: ds 1 ; d1d6
wd1d7:: ds 1 ; d1d7
wd1d8:: ds 1 ; d1d8
wd1d9:: ds 1 ; d1d9
wd1da:: ds 1 ; d1da
wd1db:: ds 1 ; d1db
wd1dc:: ds 1 ; d1dc

wGameTimeCap::     ds 1 ; d1dd
wGameTimeHours::   ds 2 ; d1de
wGameTimeMinutes:: ds 1 ; d1e0
wGameTimeSeconds:: ds 1 ; d1e1
wGameTimeFrames::  ds 1 ; d1e2

	ds 2

wCurDay:: ds 1 ; d1e5

	ds 1

wObjectFollow_Leader:: ds 1 ; d1e7
wObjectFollow_Follower:: ds 1 ; d1e8

wd1e9:: ds 1 ; d1e9
wd1ea:: ds 1 ; d1ea
wd1eb:: ds 1 ; d1eb
wd1ec:: ds 1 ; d1ec
wd1ed:: ds 1 ; d1ed
wd1ee:: ds 1 ; d1ee
wd1ef:: ds 1 ; d1ef

wObjectStructs:: ; d1f0
wPlayerStruct::   object_struct wPlayer
wObject1Struct::  object_struct wObject1
wObject2Struct::  object_struct wObject2
wObject3Struct::  object_struct wObject3
wObject4Struct::  object_struct wObject4
wObject5Struct::  object_struct wObject5
wObject6Struct::  object_struct wObject6
wObject7Struct::  object_struct wObject7
wObject8Struct::  object_struct wObject8
wObject9Struct::  object_struct wObject9
wObject10Struct:: object_struct wObject10
UNION
	ds 18
wPlayerData1End::
wPlayerData2::
	ds 1
NEXTU
wObject11Struct:: object_struct wObject11
wObject12Struct:: object_struct wObject12
wObjectStructsEnd::
ENDU

wd3f8:: ds 1 ; d3f8
wd3f9:: ds 1 ; d3f9
wd3fa:: ds 1 ; d3fa
wd3fb:: ds 1 ; d3fb
wd3fc:: ds 1 ; d3fc
wd3fd:: ds 1 ; d3fd
wd3fe:: ds 1 ; d3fe
wd3ff:: ds 1 ; d3ff
wd400:: ds 1 ; d400
wd401:: ds 1 ; d401
wd402:: ds 1 ; d402
wd403:: ds 1 ; d403
wd404:: ds 1 ; d404
wd405:: ds 1 ; d405
wd406:: ds 1 ; d406
wd407:: ds 1 ; d407
wd408:: ds 1 ; d408
wd409:: ds 1 ; d409
wd40a:: ds 1 ; d40a
wd40b:: ds 1 ; d40b
wd40c:: ds 1 ; d40c
wd40d:: ds 1 ; d40d
wd40e:: ds 1 ; d40e
wd40f:: ds 1 ; d40f
wd410:: ds 1 ; d410
wd411:: ds 1 ; d411
wd412:: ds 1 ; d412
wd413:: ds 1 ; d413
wd414:: ds 1 ; d414
wd415:: ds 1 ; d415
wd416:: ds 1 ; d416
wd417:: ds 1 ; d417
wd418:: ds 1 ; d418
wd419:: ds 1 ; d419
wd41a:: ds 1 ; d41a
wd41b:: ds 1 ; d41b
wd41c:: ds 1 ; d41c
wd41d:: ds 1 ; d41d
wd41e:: ds 1 ; d41e
wd41f:: ds 1 ; d41f
wd420:: ds 1 ; d420
wd421:: ds 1 ; d421
wd422:: ds 1 ; d422
wd423:: ds 1 ; d423
wd424:: ds 1 ; d424
wd425:: ds 1 ; d425
wd426:: ds 1 ; d426
wd427:: ds 1 ; d427
wd428:: ds 1 ; d428
wd429:: ds 1 ; d429
wd42a:: ds 1 ; d42a
wd42b:: ds 1 ; d42b
wd42c:: ds 1 ; d42c
wd42d:: ds 1 ; d42d
wd42e:: ds 1 ; d42e
wd42f:: ds 1 ; d42f
wd430:: ds 1 ; d430
wd431:: ds 1 ; d431
wd432:: ds 1 ; d432
wd433:: ds 1 ; d433
wd434:: ds 1 ; d434
wd435:: ds 1 ; d435
wd436:: ds 1 ; d436
wd437:: ds 1 ; d437

; TODO these should be wMapObject1 etc.
wMapObjects:: ; d438
wPlayerObject:: map_object wPlayer  ; d438
wMap1Object::   map_object wMap1    ; d448
wMap2Object::   map_object wMap2    ; d458
wMap3Object::   map_object wMap3    ; d468
wMap4Object::   map_object wMap4    ; d478
wMap5Object::   map_object wMap5    ; d488
wMap6Object::   map_object wMap6    ; d498
wMap7Object::   map_object wMap7    ; d4a8
wMap8Object::   map_object wMap8    ; d4b8
wMap9Object::   map_object wMap9    ; d4c8
wMap10Object::  map_object wMap10   ; d4d8
wMap11Object::  map_object wMap11   ; d4e8
wMap12Object::  map_object wMap12   ; d4f8
wMap13Object::  map_object wMap13   ; d508
wMap14Object::  map_object wMap14   ; d518
wMap15Object::  map_object wMap15   ; d528
wMapObjectsEnd:: ; d538

wd538:: ds 1 ; d538
wd539:: ds 1 ; d539
wd53a:: ds 1 ; d53a
wd53b:: ds 1 ; d53b
wd53c:: ds 1 ; d53c
wd53d:: ds 1 ; d53d
wd53e:: ds 1 ; d53e
wd53f:: ds 1 ; d53f
wd540:: ds 1 ; d540
wd541:: ds 1 ; d541
wd542:: ds 1 ; d542
wd543:: ds 1 ; d543
wd544:: ds 1 ; d544
wd545:: ds 1 ; d545
wd546:: ds 1 ; d546
wd547:: ds 1 ; d547
wd548:: ds 1 ; d548
wd549:: ds 1 ; d549
wd54a:: ds 1 ; d54a
wd54b:: ds 1 ; d54b
wd54c:: ds 1 ; d54c
wd54d:: ds 1 ; d54d
wd54e:: ds 1 ; d54e
wd54f:: ds 1 ; d54f
wd550:: ds 1 ; d550
wd551:: ds 1 ; d551
wd552:: ds 1 ; d552
wd553:: ds 1 ; d553
wd554:: ds 1 ; d554
wd555:: ds 1 ; d555
wd556:: ds 1 ; d556
wd557:: ds 1 ; d557
wEnteredMapFromContinue:: db
	ds 2
wTimeOfDayPal:: db
wd55c:: ds 1 ; d55c
wd55d:: ds 1 ; d55d
wd55e:: ds 1 ; d55e
wd55f:: ds 1 ; d55f
wd560:: ds 1 ; d560
wTimeOfDayPalset:: ds 1 ; d561
wd562:: ds 1 ; d562
wd563:: ds 1 ; d563

wStatusFlags:: ds 1 ; d564
wStatusFlags2:: ds 1 ; d565

wMoney:: ds 3 ; d566

wMomsMoney:: ds 1 ; d569
wd56a:: ds 1 ; d56a
wd56b:: ds 1 ; d56b
wd56c:: ds 1 ; d56c

wCoins:: ds 2 ; d56d

wBadges::
wJohtoBadges:: ds 1 ; d56f
wKantoBadges:: ds 1 ; d570

wTMsHMs:: ds NUM_TMS + NUM_HMS ; d571
wTMsHMsEnd::

wNumItems:: ds 1 ; d5aa
wItems:: ds MAX_ITEMS * 2 + 1 ; d5ab
wItemsEnd::

wNumKeyItems:: ds 1 ; d5d4
wKeyItems:: ds MAX_KEY_ITEMS + 1 ; d5d5
wKeyItemsEnd::

wNumBalls:: ds 1 ; d5ef
wBalls:: ds MAX_BALLS * 2 + 1 ; d5f0
wBallsEnd::

wNumPCItems::
wPCItems:: ds MAX_PC_ITEMS * 2 + 1 ; d609
wPCItemsEnd::

wd66e:: ds 1 ; d66e
wd66f:: ds 1 ; d66f
wd670:: ds 1 ; d670
wd671:: ds 1 ; d671
wd672:: ds 1 ; d672
wd673:: ds 1 ; d673
wd674:: ds 1 ; d674

wPlayerState:: ds 1 ; d675

wd676:: ds 1 ; d676
wd677:: ds 1 ; d677
wTradeFlags:: ds 1 ; d678
wd679:: ds 1 ; d679
wd67a:: ds 1 ; d67a
wd67b:: ds 1 ; d67b
wd67c:: ds 1 ; d67c
wd67d:: ds 1 ; d67d
wd67e:: ds 1 ; d67e
wd67f:: ds 1 ; d67f
wd680:: ds 1 ; d680
wd681:: ds 1 ; d681
wd682:: ds 1 ; d682
wd683:: ds 1 ; d683
wd684:: ds 1 ; d684
wd685:: ds 1 ; d685
wd686:: ds 1 ; d686
wd687:: ds 1 ; d687
wd688:: ds 1 ; d688
wd689:: ds 1 ; d689
wd68a:: ds 1 ; d68a
wd68b:: ds 1 ; d68b
wd68c:: ds 1 ; d68c
wd68d:: ds 1 ; d68d
wd68e:: ds 1 ; d68e
wd68f:: ds 1 ; d68f
wd690:: ds 1 ; d690
wd691:: ds 1 ; d691
wd692:: ds 1 ; d692
wd693:: ds 1 ; d693
wd694:: ds 1 ; d694
wd695:: ds 1 ; d695
wd696:: ds 1 ; d696
wd697:: ds 1 ; d697
wd698:: ds 1 ; d698
wd699:: ds 1 ; d699
wd69a:: ds 1 ; d69a
wd69b:: ds 1 ; d69b
wd69c:: ds 1 ; d69c
wd69d:: ds 1 ; d69d
wd69e:: ds 1 ; d69e
wd69f:: ds 1 ; d69f
wd6a0:: ds 1 ; d6a0
wd6a1:: ds 1 ; d6a1
wd6a2:: ds 1 ; d6a2
wd6a3:: ds 1 ; d6a3
wd6a4:: ds 1 ; d6a4
wd6a5:: ds 1 ; d6a5
wd6a6:: ds 1 ; d6a6
wd6a7:: ds 1 ; d6a7
wd6a8:: ds 1 ; d6a8
wd6a9:: ds 1 ; d6a9
wd6aa:: ds 1 ; d6aa
wd6ab:: ds 1 ; d6ab
wd6ac:: ds 1 ; d6ac
wd6ad:: ds 1 ; d6ad
wd6ae:: ds 1 ; d6ae
wd6af:: ds 1 ; d6af
wd6b0:: ds 1 ; d6b0
wd6b1:: ds 1 ; d6b1
wd6b2:: ds 1 ; d6b2
wd6b3:: ds 1 ; d6b3
wd6b4:: ds 1 ; d6b4
wd6b5:: ds 1 ; d6b5
wd6b6:: ds 1 ; d6b6
wd6b7:: ds 1 ; d6b7
wd6b8:: ds 1 ; d6b8
wd6b9:: ds 1 ; d6b9
wd6ba:: ds 1 ; d6ba
wd6bb:: ds 1 ; d6bb
wd6bc:: ds 1 ; d6bc
wd6bd:: ds 1 ; d6bd
wd6be:: ds 1 ; d6be
wd6bf:: ds 1 ; d6bf
wd6c0:: ds 1 ; d6c0
wd6c1:: ds 1 ; d6c1
wd6c2:: ds 1 ; d6c2
wd6c3:: ds 1 ; d6c3
wd6c4:: ds 1 ; d6c4
wd6c5:: ds 1 ; d6c5
wd6c6:: ds 1 ; d6c6
wd6c7:: ds 1 ; d6c7
wd6c8:: ds 1 ; d6c8
wd6c9:: ds 1 ; d6c9
wd6ca:: ds 1 ; d6ca
wd6cb:: ds 1 ; d6cb
wd6cc:: ds 1 ; d6cc
wd6cd:: ds 1 ; d6cd
wd6ce:: ds 1 ; d6ce
wd6cf:: ds 1 ; d6cf
wd6d0:: ds 1 ; d6d0
wd6d1:: ds 1 ; d6d1
wd6d2:: ds 1 ; d6d2
wd6d3:: ds 1 ; d6d3
wd6d4:: ds 1 ; d6d4
wd6d5:: ds 1 ; d6d5
wd6d6:: ds 1 ; d6d6
wd6d7:: ds 1 ; d6d7
wd6d8:: ds 1 ; d6d8
wd6d9:: ds 1 ; d6d9
wd6da:: ds 1 ; d6da
wd6db:: ds 1 ; d6db
wd6dc:: ds 1 ; d6dc
wd6dd:: ds 1 ; d6dd
wd6de:: ds 1 ; d6de
wd6df:: ds 1 ; d6df
wd6e0:: ds 1 ; d6e0
wd6e1:: ds 1 ; d6e1
wd6e2:: ds 1 ; d6e2
wd6e3:: ds 1 ; d6e3
wd6e4:: ds 1 ; d6e4
wd6e5:: ds 1 ; d6e5
wd6e6:: ds 1 ; d6e6
wd6e7:: ds 1 ; d6e7
wd6e8:: ds 1 ; d6e8
wd6e9:: ds 1 ; d6e9
wd6ea:: ds 1 ; d6ea
wd6eb:: ds 1 ; d6eb
wd6ec:: ds 1 ; d6ec
wd6ed:: ds 1 ; d6ed
wd6ee:: ds 1 ; d6ee
wd6ef:: ds 1 ; d6ef
wd6f0:: ds 1 ; d6f0
wd6f1:: ds 1 ; d6f1
wd6f2:: ds 1 ; d6f2
wd6f3:: ds 1 ; d6f3
wd6f4:: ds 1 ; d6f4
wd6f5:: ds 1 ; d6f5
wd6f6:: ds 1 ; d6f6
wd6f7:: ds 1 ; d6f7
wd6f8:: ds 1 ; d6f8
wd6f9:: ds 1 ; d6f9
wd6fa:: ds 1 ; d6fa
wd6fb:: ds 1 ; d6fb
wd6fc:: ds 1 ; d6fc
wd6fd:: ds 1 ; d6fd
wd6fe:: ds 1 ; d6fe
wd6ff:: ds 1 ; d6ff
wd700:: ds 1 ; d700
wd701:: ds 1 ; d701
wd702:: ds 1 ; d702
wd703:: ds 1 ; d703
wd704:: ds 1 ; d704
wd705:: ds 1 ; d705
wd706:: ds 1 ; d706
wd707:: ds 1 ; d707
wd708:: ds 1 ; d708
wd709:: ds 1 ; d709
wd70a:: ds 1 ; d70a
wd70b:: ds 1 ; d70b
wd70c:: ds 1 ; d70c
wd70d:: ds 1 ; d70d
wd70e:: ds 1 ; d70e
wd70f:: ds 1 ; d70f
wd710:: ds 1 ; d710
wd711:: ds 1 ; d711
wd712:: ds 1 ; d712
wd713:: ds 1 ; d713
wd714:: ds 1 ; d714
wd715:: ds 1 ; d715
wd716:: ds 1 ; d716
wd717:: ds 1 ; d717
wd718:: ds 1 ; d718
wd719:: ds 1 ; d719
wd71a:: ds 1 ; d71a
wd71b:: ds 1 ; d71b
wd71c:: ds 1 ; d71c
wd71d:: ds 1 ; d71d
wd71e:: ds 1 ; d71e
wd71f:: ds 1 ; d71f
wd720:: ds 1 ; d720
wd721:: ds 1 ; d721
wd722:: ds 1 ; d722
wd723:: ds 1 ; d723
wd724:: ds 1 ; d724
wd725:: ds 1 ; d725
wd726:: ds 1 ; d726
wd727:: ds 1 ; d727
wd728:: ds 1 ; d728
wd729:: ds 1 ; d729
wd72a:: ds 1 ; d72a
wd72b:: ds 1 ; d72b
wd72c:: ds 1 ; d72c
wd72d:: ds 1 ; d72d
wd72e:: ds 1 ; d72e
wd72f:: ds 1 ; d72f
wd730:: ds 1 ; d730
wd731:: ds 1 ; d731
wd732:: ds 1 ; d732
wd733:: ds 1 ; d733
wd734:: ds 1 ; d734
wd735:: ds 1 ; d735
wd736:: ds 1 ; d736
wd737:: ds 1 ; d737
wd738:: ds 1 ; d738
wd739:: ds 1 ; d739
wd73a:: ds 1 ; d73a
wd73b:: ds 1 ; d73b
wd73c:: ds 1 ; d73c
wd73d:: ds 1 ; d73d
wd73e:: ds 1 ; d73e
wd73f:: ds 1 ; d73f
wd740:: ds 1 ; d740
wd741:: ds 1 ; d741
wd742:: ds 1 ; d742
wd743:: ds 1 ; d743
wd744:: ds 1 ; d744
wd745:: ds 1 ; d745
wd746:: ds 1 ; d746
wd747:: ds 1 ; d747
wd748:: ds 1 ; d748
wd749:: ds 1 ; d749
wd74a:: ds 1 ; d74a
wd74b:: ds 1 ; d74b
wd74c:: ds 1 ; d74c
wd74d:: ds 1 ; d74d
wd74e:: ds 1 ; d74e
wd74f:: ds 1 ; d74f
wd750:: ds 1 ; d750
wd751:: ds 1 ; d751
wd752:: ds 1 ; d752
wd753:: ds 1 ; d753
wd754:: ds 1 ; d754
wd755:: ds 1 ; d755
wd756:: ds 1 ; d756
wd757:: ds 1 ; d757
wd758:: ds 1 ; d758
wd759:: ds 1 ; d759
wd75a:: ds 1 ; d75a
wd75b:: ds 1 ; d75b
wd75c:: ds 1 ; d75c
wd75d:: ds 1 ; d75d
wd75e:: ds 1 ; d75e
wd75f:: ds 1 ; d75f
wd760:: ds 1 ; d760
wd761:: ds 1 ; d761
wd762:: ds 1 ; d762
wd763:: ds 1 ; d763
wd764:: ds 1 ; d764
wd765:: ds 1 ; d765
wd766:: ds 1 ; d766
wd767:: ds 1 ; d767
wd768:: ds 1 ; d768
wd769:: ds 1 ; d769
wd76a:: ds 1 ; d76a
wd76b:: ds 1 ; d76b
wd76c:: ds 1 ; d76c
wd76d:: ds 1 ; d76d
wd76e:: ds 1 ; d76e
wd76f:: ds 1 ; d76f
wd770:: ds 1 ; d770
wd771:: ds 1 ; d771
wd772:: ds 1 ; d772
wd773:: ds 1 ; d773
wd774:: ds 1 ; d774
wd775:: ds 1 ; d775
wd776:: ds 1 ; d776
wd777:: ds 1 ; d777
wd778:: ds 1 ; d778
wd779:: ds 1 ; d779
wd77a:: ds 1 ; d77a
wd77b:: ds 1 ; d77b
wd77c:: ds 1 ; d77c
wd77d:: ds 1 ; d77d
wd77e:: ds 1 ; d77e
wd77f:: ds 1 ; d77f
wd780:: ds 1 ; d780
wd781:: ds 1 ; d781
wd782:: ds 1 ; d782
wd783:: ds 1 ; d783
wd784:: ds 1 ; d784
wd785:: ds 1 ; d785
wd786:: ds 1 ; d786
wd787:: ds 1 ; d787
wd788:: ds 1 ; d788
wd789:: ds 1 ; d789
wd78a:: ds 1 ; d78a
wd78b:: ds 1 ; d78b
wd78c:: ds 1 ; d78c
wd78d:: ds 1 ; d78d
wd78e:: ds 1 ; d78e
wd78f:: ds 1 ; d78f
wd790:: ds 1 ; d790
wd791:: ds 1 ; d791
wd792:: ds 1 ; d792
wd793:: ds 1 ; d793
wd794:: ds 1 ; d794
wd795:: ds 1 ; d795
wd796:: ds 1 ; d796
wd797:: ds 1 ; d797
wd798:: ds 1 ; d798
wd799:: ds 1 ; d799
wd79a:: ds 1 ; d79a
wd79b:: ds 1 ; d79b
wd79c:: ds 1 ; d79c
wd79d:: ds 1 ; d79d
wd79e:: ds 1 ; d79e
wd79f:: ds 1 ; d79f
wd7a0:: ds 1 ; d7a0
wd7a1:: ds 1 ; d7a1
wd7a2:: ds 1 ; d7a2
wd7a3:: ds 1 ; d7a3
wd7a4:: ds 1 ; d7a4
wd7a5:: ds 1 ; d7a5
wd7a6:: ds 1 ; d7a6
wd7a7:: ds 1 ; d7a7
wd7a8:: ds 1 ; d7a8
wd7a9:: ds 1 ; d7a9

wEventFlags:: flag_array NUM_EVENTS ; d7aa

wUnusedLinkCommunicationByte:: db

wGameTimerPause:: ds 1 ; d8ab

wd8ac:: ds 1 ; d8ac

wd8ad:: ds 1 ; d8ad
wd8ae:: ds 1 ; d8ae
wd8af:: ds 1 ; d8af
wd8b0:: ds 1 ; d8b0
wd8b1:: ds 1 ; d8b1
wd8b2:: ds 1 ; d8b2
wd8b3:: ds 1 ; d8b3
wd8b4:: ds 1 ; d8b4
wd8b5:: ds 1 ; d8b5
wd8b6:: ds 1 ; d8b6
wd8b7:: ds 1 ; d8b7
wd8b8:: ds 1 ; d8b8
wd8b9:: ds 1 ; d8b9
wd8ba:: ds 1 ; d8ba
wd8bb:: ds 1 ; d8bb
wd8bc:: ds 1 ; d8bc
wd8bd:: ds 1 ; d8bd
wd8be:: ds 1 ; d8be
wd8bf:: ds 1 ; d8bf
wd8c0:: ds 1 ; d8c0
wd8c1:: ds 1 ; d8c1
wd8c2:: ds 1 ; d8c2
wd8c3:: ds 1 ; d8c3
wd8c4:: ds 1 ; d8c4
wd8c5:: ds 1 ; d8c5
wd8c6:: ds 1 ; d8c6
wd8c7:: ds 1 ; d8c7
wd8c8:: ds 1 ; d8c8
wd8c9:: ds 1 ; d8c9
wd8ca:: ds 1 ; d8ca
wd8cb:: ds 1 ; d8cb
wd8cc:: ds 1 ; d8cc
wd8cd:: ds 1 ; d8cd
wd8ce:: ds 1 ; d8ce
wd8cf:: ds 1 ; d8cf
wd8d0:: ds 1 ; d8d0
wd8d1:: ds 1 ; d8d1
wd8d2:: ds 1 ; d8d2
wd8d3:: ds 1 ; d8d3
wd8d4:: ds 1 ; d8d4
wd8d5:: ds 1 ; d8d5
wd8d6:: ds 1 ; d8d6
wd8d7:: ds 1 ; d8d7
wd8d8:: ds 1 ; d8d8
wd8d9:: ds 1 ; d8d9
wd8da:: ds 1 ; d8da
wd8db:: ds 1 ; d8db
wd8dc:: ds 1 ; d8dc
wd8dd:: ds 1 ; d8dd
wd8de:: ds 1 ; d8de
wd8df:: ds 1 ; d8df
wd8e0:: ds 1 ; d8e0
wd8e1:: ds 1 ; d8e1
wd8e2:: ds 1 ; d8e2
wd8e3:: ds 1 ; d8e3
wd8e4:: ds 1 ; d8e4
wd8e5:: ds 1 ; d8e5
wd8e6:: ds 1 ; d8e6
wd8e7:: ds 1 ; d8e7
wd8e8:: ds 1 ; d8e8
wd8e9:: ds 1 ; d8e9
wd8ea:: ds 1 ; d8ea
wd8eb:: ds 1 ; d8eb
wd8ec:: ds 1 ; d8ec
wd8ed:: ds 1 ; d8ed
wd8ee:: ds 1 ; d8ee
wd8ef:: ds 1 ; d8ef
wd8f0:: ds 1 ; d8f0
wd8f1:: ds 1 ; d8f1
wd8f2:: ds 1 ; d8f2
wd8f3:: ds 1 ; d8f3
wd8f4:: ds 1 ; d8f4
wd8f5:: ds 1 ; d8f5
wd8f6:: ds 1 ; d8f6
wd8f7:: ds 1 ; d8f7
wd8f8:: ds 1 ; d8f8
wd8f9:: ds 1 ; d8f9
wd8fa:: ds 1 ; d8fa
wd8fb:: ds 1 ; d8fb
wd8fc:: ds 1 ; d8fc
wd8fd:: ds 1 ; d8fd
wd8fe:: ds 1 ; d8fe
wd8ff:: ds 1 ; d8ff
wd900:: ds 1 ; d900
wd901:: ds 1 ; d901
wd902:: ds 1 ; d902
wd903:: ds 1 ; d903
wd904:: ds 1 ; d904

wBikeFlags:: ds 1 ; d905
wd906:: ds 1 ; d906
wCurrentMapTriggerPointer:: ds 2 ; d907

wCurCaller::
wd909:: ds 1 ; d909
wd90a:: ds 1 ; d90a

wCurMapWarpCount:: ds 1 ; d90b
wCurMapWarpsPointer:: ds 2 ; d90c

wd90e:: ds 1 ; d90e
wd90f:: ds 1 ; d90f
wd910:: ds 1 ; d910
wd911:: ds 1 ; d911
wd912:: ds 1 ; d912
wd913:: ds 1 ; d913
wd914:: ds 1 ; d914
wd915:: ds 1 ; d915
wd916:: ds 1 ; d916
wd917:: ds 1 ; d917
wd918:: ds 1 ; d918
wd919:: ds 1 ; d919
wd91a:: ds 1 ; d91a
wd91b:: ds 1 ; d91b
wd91c:: ds 1 ; d91c
wd91d:: ds 1 ; d91d
wd91e:: ds 1 ; d91e
wd91f:: ds 1 ; d91f
wd920:: ds 1 ; d920
wd921:: ds 1 ; d921
wd922:: ds 1 ; d922
wd923:: ds 1 ; d923
wd924:: ds 1 ; d924
wd925:: ds 1 ; d925
wd926:: ds 1 ; d926
wWhichMomItem::
wd927:: ds 1 ; d927
wWhichMomItemSet::
wd928:: ds 1 ; d928
wMomItemTriggerBalance::
wd929:: ds 1 ; d929
wd92a:: ds 1 ; d92a
wd92b:: ds 1 ; d92b

wd92c:: ds 1 ; d92c
wd92d:: ds 1 ; d92d
wDailyFlags1:: ds 1 ; d92e
wDailyFlags2:: ds 1 ; d92f
wd930:: ds 1 ; d930
wd931:: ds 1 ; d931
wd932:: ds 1 ; d932
wd933:: ds 1 ; d933
wd934:: ds 1 ; d934
wd935:: ds 1 ; d935
wd936:: ds 1 ; d936
wd937:: ds 1 ; d937
wd938:: ds 1 ; d938
wd939:: ds 1 ; d939
wd93a:: ds 1 ; d93a
wd93b:: ds 1 ; d93b
wd93c:: ds 1 ; d93c
wd93d:: ds 1 ; d93d
wd93e:: ds 1 ; d93e
wd93f:: ds 1 ; d93f
wd940:: ds 1 ; d940
wSpecialPhoneCallID:: db ; d941
	ds 3
wBugContestStartTime:: ds 4 ; d945

wd949:: ds 1 ; d949
wd94a:: ds 1 ; d94a
wd94b:: ds 1 ; d94b
wd94c:: ds 1 ; d94c
wd94d:: ds 1 ; d94d
wd94e:: ds 1 ; d94e
wd94f:: ds 1 ; d94f
wd950:: ds 1 ; d950
wd951:: ds 1 ; d951
wd952:: ds 1 ; d952
wd953:: ds 1 ; d953
wd954:: ds 1 ; d954
wd955:: ds 1 ; d955
wd956:: ds 1 ; d956
wd957:: ds 1 ; d957
wd958:: ds 1 ; d958
wd959:: ds 1 ; d959
wd95a:: ds 1 ; d95a
wd95b:: ds 1 ; d95b
wd95c:: ds 1 ; d95c
wd95d:: ds 1 ; d95d
wd95e:: ds 1 ; d95e
wd95f:: ds 1 ; d95f
wd960:: ds 1 ; d960
wd961:: ds 1 ; d961
wd962:: ds 1 ; d962
wd963:: ds 1 ; d963
wd964:: ds 1 ; d964
wd965:: ds 1 ; d965
wd966:: ds 1 ; d966
wd967:: ds 1 ; d967
wd968:: ds 1 ; d968
wd969:: ds 1 ; d969
wd96a:: ds 1 ; d96a
wd96b:: ds 1 ; d96b
wd96c:: ds 1 ; d96c
wd96d:: ds 1 ; d96d
wd96e:: ds 1 ; d96e
wd96f:: ds 1 ; d96f
wd970:: ds 1 ; d970
wd971:: ds 1 ; d971
wd972:: ds 1 ; d972
wd973:: ds 1 ; d973
wd974:: ds 1 ; d974
wd975:: ds 1 ; d975
wd976:: ds 1 ; d976
wd977:: ds 1 ; d977
wd978:: ds 1 ; d978
wd979:: ds 1 ; d979
wd97a:: ds 1 ; d97a
wd97b:: ds 1 ; d97b
wd97c:: ds 1 ; d97c
wd97d:: ds 1 ; d97d
wd97e:: ds 1 ; d97e
wd97f:: ds 1 ; d97f
wd980:: ds 1 ; d980
wd981:: ds 1 ; d981
wd982:: ds 1 ; d982
wd983:: ds 1 ; d983
wd984:: ds 1 ; d984
wd985:: ds 1 ; d985
wd986:: ds 1 ; d986
wHappinessStepCount:: ds 1 ; d987
wd988:: ds 1 ; d988

wParkBallsRemaining:: ds 1 ; d989

wd98a:: ds 1 ; d98a
wd98b:: ds 1 ; d98b
wd98c:: ds 1 ; d98c
wd98d:: ds 1 ; d98d
wd98e:: ds 1 ; d98e
wd98f:: ds 1 ; d98f
wd990:: ds 1 ; d990
wd991:: ds 1 ; d991
wd992:: ds 1 ; d992
wd993:: ds 1 ; d993
wd994:: ds 1 ; d994
wd995:: ds 1 ; d995
wd996:: ds 1 ; d996
wd997:: ds 1 ; d997
wd998:: ds 1 ; d998
wd999:: ds 1 ; d999
wd99a:: ds 1 ; d99a
wd99b:: ds 1 ; d99b
wd99c:: ds 1 ; d99c
wd99d:: ds 1 ; d99d
wd99e:: ds 1 ; d99e
wd99f:: ds 1 ; d99f
wd9a0:: ds 1 ; d9a0
wd9a1:: ds 1 ; d9a1
wd9a2:: ds 1 ; d9a2
wd9a3:: ds 1 ; d9a3
wd9a4:: ds 1 ; d9a4
wd9a5:: ds 1 ; d9a5
wd9a6:: ds 1 ; d9a6
wd9a7:: ds 1 ; d9a7
wd9a8:: ds 1 ; d9a8
wd9a9:: ds 1 ; d9a9
wd9aa:: ds 1 ; d9aa
wd9ab:: ds 1 ; d9ab
wd9ac:: ds 1 ; d9ac
wd9ad:: ds 1 ; d9ad
wd9ae:: ds 1 ; d9ae
wd9af:: ds 1 ; d9af
wd9b0:: ds 1 ; d9b0
wd9b1:: ds 1 ; d9b1
wd9b2:: ds 1 ; d9b2
wd9b3:: ds 1 ; d9b3
wd9b4:: ds 1 ; d9b4
wd9b5:: ds 1 ; d9b5
wd9b6:: ds 1 ; d9b6
wd9b7:: ds 1 ; d9b7

wDigWarpNumber:: ds 1 ; d9b8
wDigMapGroup:: ds 1 ; d9b9
wDigMapNumber:: ds 1 ; d9ba

wBackupWarpNumber:: ds 1 ; d9bb
wBackupMapGroup:: ds 1 ; d9bc
wBackupMapNumber:: ds 1 ; d9bd

wd9be:: ds 1 ; d9be
wd9bf:: ds 1 ; d9bf
wd9c0:: ds 1 ; d9c0
wd9c1:: ds 1 ; d9c1
wd9c2:: ds 1 ; d9c2
wd9c3:: ds 1 ; d9c3
wd9c4:: ds 1 ; d9c4
wd9c5:: ds 1 ; d9c5

wMapGroup:: ds 1 ; d9c6
wMapNumber:: ds 1 ; d9c7
wYCoord:: ds 1 ; d9c8
wXCoord:: ds 1 ; d9c9

wd9ca:: ds 1 ; d9ca
wd9cb:: ds 1 ; d9cb
wd9cc:: ds 1 ; d9cc
wd9cd:: ds 1 ; d9cd
wd9ce:: ds 1 ; d9ce
wd9cf:: ds 1 ; d9cf
wd9d0:: ds 1 ; d9d0
wd9d1:: ds 1 ; d9d1
wd9d2:: ds 1 ; d9d2
wd9d3:: ds 1 ; d9d3
wd9d4:: ds 1 ; d9d4
wd9d5:: ds 1 ; d9d5
wd9d6:: ds 1 ; d9d6
wd9d7:: ds 1 ; d9d7
wd9d8:: ds 1 ; d9d8
wd9d9:: ds 1 ; d9d9
wd9da:: ds 1 ; d9da
wd9db:: ds 1 ; d9db
wd9dc:: ds 1 ; d9dc
wd9dd:: ds 1 ; d9dd
wd9de:: ds 1 ; d9de
wd9df:: ds 1 ; d9df
wd9e0:: ds 1 ; d9e0
wd9e1:: ds 1 ; d9e1
wd9e2:: ds 1 ; d9e2
wd9e3:: ds 1 ; d9e3
wd9e4:: ds 1 ; d9e4
wd9e5:: ds 1 ; d9e5
wd9e6:: ds 1 ; d9e6
wd9e7:: ds 1 ; d9e7

SECTION "Party", WRAMX, BANK[1]

wPokemonData::

wPartyCount:: ds 1 ; d9e8
wPartySpecies:: ds PARTY_LENGTH ; d9ee
wPartyEnd:: ds 1 ; d9ef

wPartyMons::
wPartyMon1:: party_struct wPartyMon1 ; d9f0
wPartyMon2:: party_struct wPartyMon2 ; da20
wPartyMon3:: party_struct wPartyMon3 ; da50
wPartyMon4:: party_struct wPartyMon4 ; da80
wPartyMon5:: party_struct wPartyMon5 ; dab0
wPartyMon6:: party_struct wPartyMon6 ; dbe0

wPartyMonOT::
wPartyMon1OT:: ds NAME_LENGTH ; db10
wPartyMon2OT:: ds NAME_LENGTH ; db16
wPartyMon3OT:: ds NAME_LENGTH ; db1c
wPartyMon4OT:: ds NAME_LENGTH ; db22
wPartyMon5OT:: ds NAME_LENGTH ; db28
wPartyMon6OT:: ds NAME_LENGTH ; db2e

wPartyMonNicknames::
wPartyMon1Nickname:: ds MON_NAME_LENGTH ; db34
wPartyMon2Nickname:: ds MON_NAME_LENGTH ; db3a
wPartyMon3Nickname:: ds MON_NAME_LENGTH ; db40
wPartyMon4Nickname:: ds MON_NAME_LENGTH ; db46
wPartyMon5Nickname:: ds MON_NAME_LENGTH ; db4c
wPartyMon6Nickname:: ds MON_NAME_LENGTH ; db52
wPartyMonNicknamesEnd::

wdb58:: ds 1 ; db58
wdb59:: ds 1 ; db59
wdb5a:: ds 1 ; db5a
wdb5b:: ds 1 ; db5b
wdb5c:: ds 1 ; db5c
wdb5d:: ds 1 ; db5d
wdb5e:: ds 1 ; db5e
wdb5f:: ds 1 ; db5f
wdb60:: ds 1 ; db60
wdb61:: ds 1 ; db61
wdb62:: ds 1 ; db62
wdb63:: ds 1 ; db63
wdb64:: ds 1 ; db64
wdb65:: ds 1 ; db65
wdb66:: ds 1 ; db66
wdb67:: ds 1 ; db67
wdb68:: ds 1 ; db68
wdb69:: ds 1 ; db69
wdb6a:: ds 1 ; db6a
wdb6b:: ds 1 ; db6b
wdb6c:: ds 1 ; db6c
wdb6d:: ds 1 ; db6d
wdb6e:: ds 1 ; db6e
wdb6f:: ds 1 ; db6f
wdb70:: ds 1 ; db70
wdb71:: ds 1 ; db71
wdb72:: ds 1 ; db72
wdb73:: ds 1 ; db73
wdb74:: ds 1 ; db74
wdb75:: ds 1 ; db75
wdb76:: ds 1 ; db76
wdb77:: ds 1 ; db77

wPokedexCaught:: flag_array NUM_POKEMON ; db78
wEndPokedexCaught::

wPokedexSeen::   flag_array NUM_POKEMON ; db98
wEndPokedexSeen::

wdbb8:: ds 1 ; dbb8
wdbb9:: ds 1 ; dbb9
wdbba:: ds 1 ; dbba
wdbbb:: ds 1 ; dbbb
wdbbc:: ds 1 ; dbbc
wdbbd:: ds 1 ; dbbd
wdbbe:: ds 1 ; dbbe
wdbbf:: ds 1 ; dbbf
wdbc0:: ds 1 ; dbc0
wdbc1:: ds 1 ; dbc1
wdbc2:: ds 1 ; dbc2
wdbc3:: ds 1 ; dbc3
wdbc4:: ds 1 ; dbc4
wdbc5:: ds 1 ; dbc5
wdbc6:: ds 1 ; dbc6
wdbc7:: ds 1 ; dbc7
wdbc8:: ds 1 ; dbc8
wdbc9:: ds 1 ; dbc9
wdbca:: ds 1 ; dbca
wdbcb:: ds 1 ; dbcb
wdbcc:: ds 1 ; dbcc
wdbcd:: ds 1 ; dbcd
wdbce:: ds 1 ; dbce
wdbcf:: ds 1 ; dbcf
wdbd0:: ds 1 ; dbd0
wdbd1:: ds 1 ; dbd1
wdbd2:: ds 1 ; dbd2
wdbd3:: ds 1 ; dbd3

wDayCareMan::
; bit 7: active
; bit 6: egg ready
; bit 5: monsters are compatible
; bit 0: monster 1 in day-care
	db

wBreedMon1Nick:: ds MON_NAME_LENGTH
wBreedMon1OT::   ds NAME_LENGTH
wBreedMon1::     box_struct wBreedMon1

wDayCareLady::
; bit 7: active
; bit 0: monster 2 in day-care
	db

wStepsToEgg::
	db
wBreedMotherOrNonDitto::
;  z: yes
; nz: no
	db

wBreedMon2Nick:: ds MON_NAME_LENGTH
wBreedMon2OT::   ds NAME_LENGTH
wBreedMon2::     box_struct wBreedMon2

wEggNick:: ds MON_NAME_LENGTH
wEggOT::   ds NAME_LENGTH
wEggMon::  box_struct wEggMon

wBugContestSecondPartySpecies:: db
wContestMon:: party_struct wContestMon

wdc8d:: ds 1 ; dc8d
wdc8e:: ds 1 ; dc8e
wdc8f:: ds 1 ; dc8f
wdc90:: ds 1 ; dc90
wdc91:: ds 1 ; dc91
wdc92:: ds 1 ; dc92
wdc93:: ds 1 ; dc93
wdc94:: ds 1 ; dc94
wdc95:: ds 1 ; dc95
wdc96:: ds 1 ; dc96
wdc97:: ds 1 ; dc97
wdc98:: ds 1 ; dc98
wdc99:: ds 1 ; dc99
wdc9a:: ds 1 ; dc9a
wdc9b:: ds 1 ; dc9b
wdc9c:: ds 1 ; dc9c
wdc9d:: ds 1 ; dc9d
wdc9e:: ds 1 ; dc9e
wdc9f:: ds 1 ; dc9f
wdca0:: ds 1 ; dca0
wdca1:: ds 1 ; dca1
wdca2:: ds 1 ; dca2
wdca3:: ds 1 ; dca3
wdca4:: ds 1 ; dca4
wdca5:: ds 1 ; dca5
wdca6:: ds 1 ; dca6
wdca7:: ds 1 ; dca7
wdca8:: ds 1 ; dca8
wdca9:: ds 1 ; dca9
wdcaa:: ds 1 ; dcaa
wdcab:: ds 1 ; dcab
wdcac:: ds 1 ; dcac
wdcad:: ds 1 ; dcad
wdcae:: ds 1 ; dcae
wdcaf:: ds 1 ; dcaf
wdcb0:: ds 1 ; dcb0

UNION
	ds 2
wdcb3:: db
	ds 19
wDebugFightMonLevel:: db

NEXTU
; enemy party
wOTPlayerName:: ds NAME_LENGTH
wOTPlayerID:: dw
	ds 13
wOTPartyCount::   db
wOTPartySpecies:: ds PARTY_LENGTH
wOTPartyEnd::     db ; older code doesn't check PartyCount
ENDU

; ot party mons
wOTPartyMons::
wOTPartyMon1:: party_struct wOTPartyMon1 ; dcce
wOTPartyMon2:: party_struct wOTPartyMon2 ; dcfe
wOTPartyMon3:: party_struct wOTPartyMon3 ; dd2e
wOTPartyMon4:: party_struct wOTPartyMon4 ; dd5e
wOTPartyMon5:: party_struct wOTPartyMon5 ; dd8e
wOTPartyMon6:: party_struct wOTPartyMon6 ; ddbe

wddee:: ds 1 ; ddee
wddef:: ds 1 ; ddef
wddf0:: ds 1 ; ddf0
wddf1:: ds 1 ; ddf1
wddf2:: ds 1 ; ddf2
wddf3:: ds 1 ; ddf3
wddf4:: ds 1 ; ddf4
wddf5:: ds 1 ; ddf5
wddf6:: ds 1 ; ddf6
wddf7:: ds 1 ; ddf7
wddf8:: ds 1 ; ddf8
wddf9:: ds 1 ; ddf9
wddfa:: ds 1 ; ddfa
wddfb:: ds 1 ; ddfb
wddfc:: ds 1 ; ddfc
wddfd:: ds 1 ; ddfd
wddfe:: ds 1 ; ddfe
wddff:: ds 1 ; ddff
wde00:: ds 1 ; de00
wde01:: ds 1 ; de01
wde02:: ds 1 ; de02
wde03:: ds 1 ; de03
wde04:: ds 1 ; de04
wde05:: ds 1 ; de05
wde06:: ds 1 ; de06
wde07:: ds 1 ; de07
wde08:: ds 1 ; de08
wde09:: ds 1 ; de09
wde0a:: ds 1 ; de0a
wde0b:: ds 1 ; de0b
wde0c:: ds 1 ; de0c
wde0d:: ds 1 ; de0d
wde0e:: ds 1 ; de0e
wde0f:: ds 1 ; de0f
wde10:: ds 1 ; de10
wde11:: ds 1 ; de11
wde12:: ds 1 ; de12
wde13:: ds 1 ; de13
wde14:: ds 1 ; de14
wde15:: ds 1 ; de15
wde16:: ds 1 ; de16
wde17:: ds 1 ; de17
wde18:: ds 1 ; de18
wde19:: ds 1 ; de19
wde1a:: ds 1 ; de1a
wde1b:: ds 1 ; de1b
wde1c:: ds 1 ; de1c
wde1d:: ds 1 ; de1d
wde1e:: ds 1 ; de1e
wde1f:: ds 1 ; de1f
wde20:: ds 1 ; de20
wde21:: ds 1 ; de21
wde22:: ds 1 ; de22
wde23:: ds 1 ; de23
wde24:: ds 1 ; de24
wde25:: ds 1 ; de25
wde26:: ds 1 ; de26
wde27:: ds 1 ; de27
wde28:: ds 1 ; de28
wde29:: ds 1 ; de29
wde2a:: ds 1 ; de2a
wde2b:: ds 1 ; de2b
wde2c:: ds 1 ; de2c
wde2d:: ds 1 ; de2d
wde2e:: ds 1 ; de2e
wde2f:: ds 1 ; de2f
wde30:: ds 1 ; de30
wde31:: ds 1 ; de31
wde32:: ds 1 ; de32
wde33:: ds 1 ; de33
wde34:: ds 1 ; de34
wde35:: ds 1 ; de35
wde36:: ds 1 ; de36
wde37:: ds 1 ; de37
wde38:: ds 1 ; de38
wde39:: ds 1 ; de39
wde3a:: ds 1 ; de3a
wde3b:: ds 1 ; de3b
wde3c:: ds 1 ; de3c
wde3d:: ds 1 ; de3d
wde3e:: ds 1 ; de3e
wde3f:: ds 1 ; de3f
wde40:: ds 1 ; de40
wde41:: ds 1 ; de41
wde42:: ds 1 ; de42
wde43:: ds 1 ; de43
wde44:: ds 1 ; de44
wde45:: ds 1 ; de45
wde46:: ds 1 ; de46
wde47:: ds 1 ; de47
wde48:: ds 1 ; de48
wde49:: ds 1 ; de49
wde4a:: ds 1 ; de4a
wde4b:: ds 1 ; de4b
wde4c:: ds 1 ; de4c
wde4d:: ds 1 ; de4d
wde4e:: ds 1 ; de4e
wde4f:: ds 1 ; de4f
wde50:: ds 1 ; de50
wde51:: ds 1 ; de51
wde52:: ds 1 ; de52
wde53:: ds 1 ; de53
wde54:: ds 1 ; de54
wde55:: ds 1 ; de55
wde56:: ds 1 ; de56
wde57:: ds 1 ; de57
wde58:: ds 1 ; de58
wde59:: ds 1 ; de59
wde5a:: ds 1 ; de5a
wde5b:: ds 1 ; de5b
wde5c:: ds 1 ; de5c
wde5d:: ds 1 ; de5d
wde5e:: ds 1 ; de5e
wde5f:: ds 1 ; de5f
wde60:: ds 1 ; de60
wde61:: ds 1 ; de61
wde62:: ds 1 ; de62
wde63:: ds 1 ; de63
wde64:: ds 1 ; de64
wde65:: ds 1 ; de65
wde66:: ds 1 ; de66
wde67:: ds 1 ; de67
wde68:: ds 1 ; de68
wde69:: ds 1 ; de69
wde6a:: ds 1 ; de6a
wde6b:: ds 1 ; de6b
wde6c:: ds 1 ; de6c
wde6d:: ds 1 ; de6d
wde6e:: ds 1 ; de6e
wde6f:: ds 1 ; de6f
wde70:: ds 1 ; de70
wde71:: ds 1 ; de71
wde72:: ds 1 ; de72
wde73:: ds 1 ; de73
wde74:: ds 1 ; de74
wde75:: ds 1 ; de75
wde76:: ds 1 ; de76
wde77:: ds 1 ; de77
wde78:: ds 1 ; de78
wde79:: ds 1 ; de79
wde7a:: ds 1 ; de7a
wde7b:: ds 1 ; de7b
wde7c:: ds 1 ; de7c
wde7d:: ds 1 ; de7d
wde7e:: ds 1 ; de7e
wde7f:: ds 1 ; de7f
wde80:: ds 1 ; de80
wde81:: ds 1 ; de81
wde82:: ds 1 ; de82
wde83:: ds 1 ; de83
wde84:: ds 1 ; de84
wde85:: ds 1 ; de85
wde86:: ds 1 ; de86
wde87:: ds 1 ; de87
wde88:: ds 1 ; de88
wde89:: ds 1 ; de89
wde8a:: ds 1 ; de8a
wde8b:: ds 1 ; de8b
wde8c:: ds 1 ; de8c
wde8d:: ds 1 ; de8d
wde8e:: ds 1 ; de8e
wde8f:: ds 1 ; de8f
wde90:: ds 1 ; de90
wde91:: ds 1 ; de91
wde92:: ds 1 ; de92
wde93:: ds 1 ; de93
wde94:: ds 1 ; de94
wde95:: ds 1 ; de95
wde96:: ds 1 ; de96
wde97:: ds 1 ; de97
wde98:: ds 1 ; de98
wde99:: ds 1 ; de99
wde9a:: ds 1 ; de9a
wde9b:: ds 1 ; de9b
wde9c:: ds 1 ; de9c
wde9d:: ds 1 ; de9d
wde9e:: ds 1 ; de9e
wde9f:: ds 1 ; de9f
wdea0:: ds 1 ; dea0
wdea1:: ds 1 ; dea1
wdea2:: ds 1 ; dea2
wdea3:: ds 1 ; dea3
wdea4:: ds 1 ; dea4
wdea5:: ds 1 ; dea5
wdea6:: ds 1 ; dea6
wdea7:: ds 1 ; dea7
wdea8:: ds 1 ; dea8
wdea9:: ds 1 ; dea9
wdeaa:: ds 1 ; deaa
wdeab:: ds 1 ; deab
wdeac:: ds 1 ; deac
wdead:: ds 1 ; dead
wdeae:: ds 1 ; deae
wdeaf:: ds 1 ; deaf
wdeb0:: ds 1 ; deb0
wdeb1:: ds 1 ; deb1
wdeb2:: ds 1 ; deb2
wdeb3:: ds 1 ; deb3
wdeb4:: ds 1 ; deb4
wdeb5:: ds 1 ; deb5
wdeb6:: ds 1 ; deb6
wdeb7:: ds 1 ; deb7
wdeb8:: ds 1 ; deb8
wdeb9:: ds 1 ; deb9
wdeba:: ds 1 ; deba
wdebb:: ds 1 ; debb
wdebc:: ds 1 ; debc
wdebd:: ds 1 ; debd
wdebe:: ds 1 ; debe
wdebf:: ds 1 ; debf
wdec0:: ds 1 ; dec0
wdec1:: ds 1 ; dec1
wdec2:: ds 1 ; dec2
wdec3:: ds 1 ; dec3
wdec4:: ds 1 ; dec4
wdec5:: ds 1 ; dec5
wdec6:: ds 1 ; dec6
wdec7:: ds 1 ; dec7
wdec8:: ds 1 ; dec8
wdec9:: ds 1 ; dec9
wdeca:: ds 1 ; deca
wdecb:: ds 1 ; decb
wdecc:: ds 1 ; decc
wdecd:: ds 1 ; decd
wdece:: ds 1 ; dece
wdecf:: ds 1 ; decf
wded0:: ds 1 ; ded0
wded1:: ds 1 ; ded1
wded2:: ds 1 ; ded2
wded3:: ds 1 ; ded3
wded4:: ds 1 ; ded4
wded5:: ds 1 ; ded5
wded6:: ds 1 ; ded6
wded7:: ds 1 ; ded7
wded8:: ds 1 ; ded8
wded9:: ds 1 ; ded9
wdeda:: ds 1 ; deda
wdedb:: ds 1 ; dedb
wdedc:: ds 1 ; dedc
wdedd:: ds 1 ; dedd
wdede:: ds 1 ; dede
wdedf:: ds 1 ; dedf
wdee0:: ds 1 ; dee0
wdee1:: ds 1 ; dee1
wdee2:: ds 1 ; dee2
wdee3:: ds 1 ; dee3
wdee4:: ds 1 ; dee4
wdee5:: ds 1 ; dee5
wdee6:: ds 1 ; dee6
wdee7:: ds 1 ; dee7
wdee8:: ds 1 ; dee8
wdee9:: ds 1 ; dee9
wdeea:: ds 1 ; deea
wdeeb:: ds 1 ; deeb
wdeec:: ds 1 ; deec
wdeed:: ds 1 ; deed
wdeee:: ds 1 ; deee
wdeef:: ds 1 ; deef
wdef0:: ds 1 ; def0
wdef1:: ds 1 ; def1
wdef2:: ds 1 ; def2
wdef3:: ds 1 ; def3
wdef4:: ds 1 ; def4
wdef5:: ds 1 ; def5
wdef6:: ds 1 ; def6
wdef7:: ds 1 ; def7
wdef8:: ds 1 ; def8
wdef9:: ds 1 ; def9
wdefa:: ds 1 ; defa
wdefb:: ds 1 ; defb
wdefc:: ds 1 ; defc
wdefd:: ds 1 ; defd
wdefe:: ds 1 ; defe
wdeff:: ds 1 ; deff
wdf00:: ds 1 ; df00
wdf01:: ds 1 ; df01
wdf02:: ds 1 ; df02
wdf03:: ds 1 ; df03
wdf04:: ds 1 ; df04
wdf05:: ds 1 ; df05
wdf06:: ds 1 ; df06
wdf07:: ds 1 ; df07
wdf08:: ds 1 ; df08
wdf09:: ds 1 ; df09
wdf0a:: ds 1 ; df0a
wdf0b:: ds 1 ; df0b
wdf0c:: ds 1 ; df0c
wdf0d:: ds 1 ; df0d
wdf0e:: ds 1 ; df0e
wdf0f:: ds 1 ; df0f
wdf10:: ds 1 ; df10
wdf11:: ds 1 ; df11
wdf12:: ds 1 ; df12
wdf13:: ds 1 ; df13
wdf14:: ds 1 ; df14
wdf15:: ds 1 ; df15
wdf16:: ds 1 ; df16
wdf17:: ds 1 ; df17
wdf18:: ds 1 ; df18
wdf19:: ds 1 ; df19
wdf1a:: ds 1 ; df1a
wdf1b:: ds 1 ; df1b
wdf1c:: ds 1 ; df1c
wdf1d:: ds 1 ; df1d
wdf1e:: ds 1 ; df1e
wdf1f:: ds 1 ; df1f
wdf20:: ds 1 ; df20
wdf21:: ds 1 ; df21
wdf22:: ds 1 ; df22
wdf23:: ds 1 ; df23
wdf24:: ds 1 ; df24
wdf25:: ds 1 ; df25
wdf26:: ds 1 ; df26
wdf27:: ds 1 ; df27
wdf28:: ds 1 ; df28
wdf29:: ds 1 ; df29
wdf2a:: ds 1 ; df2a
wdf2b:: ds 1 ; df2b
wdf2c:: ds 1 ; df2c
wdf2d:: ds 1 ; df2d
wdf2e:: ds 1 ; df2e
wdf2f:: ds 1 ; df2f
wdf30:: ds 1 ; df30
wdf31:: ds 1 ; df31
wdf32:: ds 1 ; df32
wdf33:: ds 1 ; df33
wdf34:: ds 1 ; df34
wdf35:: ds 1 ; df35
wdf36:: ds 1 ; df36
wdf37:: ds 1 ; df37
wdf38:: ds 1 ; df38
wdf39:: ds 1 ; df39
wdf3a:: ds 1 ; df3a
wdf3b:: ds 1 ; df3b
wdf3c:: ds 1 ; df3c
wdf3d:: ds 1 ; df3d
wdf3e:: ds 1 ; df3e
wdf3f:: ds 1 ; df3f
wdf40:: ds 1 ; df40
wdf41:: ds 1 ; df41
wdf42:: ds 1 ; df42
wdf43:: ds 1 ; df43
wdf44:: ds 1 ; df44
wdf45:: ds 1 ; df45
wdf46:: ds 1 ; df46
wdf47:: ds 1 ; df47
wdf48:: ds 1 ; df48
wdf49:: ds 1 ; df49
wdf4a:: ds 1 ; df4a
wdf4b:: ds 1 ; df4b
wdf4c:: ds 1 ; df4c
wdf4d:: ds 1 ; df4d
wdf4e:: ds 1 ; df4e
wdf4f:: ds 1 ; df4f
wdf50:: ds 1 ; df50
wdf51:: ds 1 ; df51
wdf52:: ds 1 ; df52
wdf53:: ds 1 ; df53
wdf54:: ds 1 ; df54
wdf55:: ds 1 ; df55
wdf56:: ds 1 ; df56
wdf57:: ds 1 ; df57
wdf58:: ds 1 ; df58
wdf59:: ds 1 ; df59
wdf5a:: ds 1 ; df5a
wdf5b:: ds 1 ; df5b
wdf5c:: ds 1 ; df5c
wdf5d:: ds 1 ; df5d
wdf5e:: ds 1 ; df5e
wdf5f:: ds 1 ; df5f
wdf60:: ds 1 ; df60
wdf61:: ds 1 ; df61
wdf62:: ds 1 ; df62
wdf63:: ds 1 ; df63
wdf64:: ds 1 ; df64
wdf65:: ds 1 ; df65
wdf66:: ds 1 ; df66
wdf67:: ds 1 ; df67
wdf68:: ds 1 ; df68
wdf69:: ds 1 ; df69
wdf6a:: ds 1 ; df6a
wdf6b:: ds 1 ; df6b
wdf6c:: ds 1 ; df6c
wdf6d:: ds 1 ; df6d
wdf6e:: ds 1 ; df6e
wdf6f:: ds 1 ; df6f
wdf70:: ds 1 ; df70
wdf71:: ds 1 ; df71
wdf72:: ds 1 ; df72
wdf73:: ds 1 ; df73
wdf74:: ds 1 ; df74
wdf75:: ds 1 ; df75
wdf76:: ds 1 ; df76
wdf77:: ds 1 ; df77
wdf78:: ds 1 ; df78
wdf79:: ds 1 ; df79
wdf7a:: ds 1 ; df7a
wdf7b:: ds 1 ; df7b
wdf7c:: ds 1 ; df7c
wdf7d:: ds 1 ; df7d
wdf7e:: ds 1 ; df7e
wdf7f:: ds 1 ; df7f
wdf80:: ds 1 ; df80
wdf81:: ds 1 ; df81
wdf82:: ds 1 ; df82
wdf83:: ds 1 ; df83
wdf84:: ds 1 ; df84
wdf85:: ds 1 ; df85
wdf86:: ds 1 ; df86
wdf87:: ds 1 ; df87
wdf88:: ds 1 ; df88
wdf89:: ds 1 ; df89
wdf8a:: ds 1 ; df8a
wdf8b:: ds 1 ; df8b
wdf8c:: ds 1 ; df8c
wdf8d:: ds 1 ; df8d
wdf8e:: ds 1 ; df8e
wdf8f:: ds 1 ; df8f
wdf90:: ds 1 ; df90
wdf91:: ds 1 ; df91
wdf92:: ds 1 ; df92
wdf93:: ds 1 ; df93
wdf94:: ds 1 ; df94
wdf95:: ds 1 ; df95
wdf96:: ds 1 ; df96
wdf97:: ds 1 ; df97
wdf98:: ds 1 ; df98
wdf99:: ds 1 ; df99
wdf9a:: ds 1 ; df9a
wdf9b:: ds 1 ; df9b
wdf9c:: ds 1 ; df9c
wdf9d:: ds 1 ; df9d
wdf9e:: ds 1 ; df9e
wdf9f:: ds 1 ; df9f
wdfa0:: ds 1 ; dfa0
wdfa1:: ds 1 ; dfa1
wdfa2:: ds 1 ; dfa2
wdfa3:: ds 1 ; dfa3
wdfa4:: ds 1 ; dfa4
wdfa5:: ds 1 ; dfa5
wdfa6:: ds 1 ; dfa6
wdfa7:: ds 1 ; dfa7
wdfa8:: ds 1 ; dfa8
wdfa9:: ds 1 ; dfa9
wdfaa:: ds 1 ; dfaa
wdfab:: ds 1 ; dfab
wdfac:: ds 1 ; dfac
wdfad:: ds 1 ; dfad
wdfae:: ds 1 ; dfae
wdfaf:: ds 1 ; dfaf
wdfb0:: ds 1 ; dfb0
wdfb1:: ds 1 ; dfb1
wdfb2:: ds 1 ; dfb2
wdfb3:: ds 1 ; dfb3
wdfb4:: ds 1 ; dfb4
wdfb5:: ds 1 ; dfb5
wdfb6:: ds 1 ; dfb6
wdfb7:: ds 1 ; dfb7
wdfb8:: ds 1 ; dfb8
wdfb9:: ds 1 ; dfb9
wdfba:: ds 1 ; dfba
wdfbb:: ds 1 ; dfbb
wdfbc:: ds 1 ; dfbc
wdfbd:: ds 1 ; dfbd
wdfbe:: ds 1 ; dfbe
wdfbf:: ds 1 ; dfbf
wdfc0:: ds 1 ; dfc0
wdfc1:: ds 1 ; dfc1
wdfc2:: ds 1 ; dfc2
wdfc3:: ds 1 ; dfc3
wdfc4:: ds 1 ; dfc4
wdfc5:: ds 1 ; dfc5
wdfc6:: ds 1 ; dfc6
wdfc7:: ds 1 ; dfc7
wdfc8:: ds 1 ; dfc8
wdfc9:: ds 1 ; dfc9
wdfca:: ds 1 ; dfca
wdfcb:: ds 1 ; dfcb
wdfcc:: ds 1 ; dfcc
wdfcd:: ds 1 ; dfcd
wdfce:: ds 1 ; dfce
wdfcf:: ds 1 ; dfcf
wdfd0:: ds 1 ; dfd0
wdfd1:: ds 1 ; dfd1
wdfd2:: ds 1 ; dfd2
wdfd3:: ds 1 ; dfd3
wdfd4:: ds 1 ; dfd4
wdfd5:: ds 1 ; dfd5
wdfd6:: ds 1 ; dfd6
wdfd7:: ds 1 ; dfd7
wdfd8:: ds 1 ; dfd8
wdfd9:: ds 1 ; dfd9
wdfda:: ds 1 ; dfda
wdfdb:: ds 1 ; dfdb
wdfdc:: ds 1 ; dfdc
wdfdd:: ds 1 ; dfdd
wdfde:: ds 1 ; dfde
wdfdf:: ds 1 ; dfdf
wdfe0:: ds 1 ; dfe0
wdfe1:: ds 1 ; dfe1
wdfe2:: ds 1 ; dfe2
wdfe3:: ds 1 ; dfe3
wdfe4:: ds 1 ; dfe4
wdfe5:: ds 1 ; dfe5
wdfe6:: ds 1 ; dfe6
wdfe7:: ds 1 ; dfe7
wdfe8:: ds 1 ; dfe8
wdfe9:: ds 1 ; dfe9
wdfea:: ds 1 ; dfea
wdfeb:: ds 1 ; dfeb
wdfec:: ds 1 ; dfec
wdfed:: ds 1 ; dfed
wdfee:: ds 1 ; dfee
wdfef:: ds 1 ; dfef
wdff0:: ds 1 ; dff0
wdff1:: ds 1 ; dff1
wdff2:: ds 1 ; dff2
wdff3:: ds 1 ; dff3
wdff4:: ds 1 ; dff4
wdff5:: ds 1 ; dff5
wdff6:: ds 1 ; dff6
wdff7:: ds 1 ; dff7
wdff8:: ds 1 ; dff8
wdff9:: ds 1 ; dff9
wdffa:: ds 1 ; dffa
wdffb:: ds 1 ; dffb
wdffc:: ds 1 ; dffc
wdffd:: ds 1 ; dffd
wdffe:: ds 1 ; dffe
wdfff:: ds 1 ; dfff

INCLUDE "sram.asm"

INCLUDE "hram.asm"