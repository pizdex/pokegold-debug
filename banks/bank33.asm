INCLUDE "engine/events/bug_contest/display_stats.asm"

    ld c, 6
jr_033_40e7:
    call Call_033_41ca
    dec c
    jr nz, jr_033_40e7

    call Call_033_47f7
    call Call_033_41b1
    call Call_033_41ca
    ld hl, hVBlank
    ld a, [hl]
    push af
    ld [hl], $01
    call Call_033_4114
    pop af
    ldh [hVBlank], a
    ld a, $01
    ldh [hBGMapMode], a
    call Call_033_41ca
    call Call_033_41ca
    call Call_033_41ca
    call WaitSFX
    ret

Call_033_4114:
	dr $cc114, $cc15a

Call_033_415a:
	dr $cc15a, $cc17a

Call_033_417a:
	dr $cc17a, $cc1b1

Call_033_41b1:
	dr $cc1b1, $cc1ca

Call_033_41ca:
	dr $cc1ca, $cc7f7

Call_033_47f7:
	dr $cc7f7, $ccfa4

Call_033_4fa4:
	dr $ccfa4, $d0000
