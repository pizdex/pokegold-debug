; Special routines can be used with the "special" map script command.
; They often use wScriptVar for arguments and return values.

add_special: MACRO
; Some ROM0 specials have a nonzero bank.
\1Special::
IF _NARG == 1
	dba \1
ELSE
	dbw \2, \1
ENDC
ENDM

SpecialsPointers::
	dbw $25, $7aad

; Communications
	dbw $0a, $5b89
	dbw $0a, $5bb2
	dbw $0a, $5c33
	dbw $0a, $5cd8
	dbw $0a, $5cf4
	dbw $0a, $5d68
	dbw $0a, $5d60
	dbw $0a, $5b40
	dbw $0a, $5b92
	dbw $0a, $5b9b
	dbw $0a, $5aae
	dbw $0a, $5b2e
	dbw $0a, $5d36
	dbw $0a, $5d4b
	dbw $0a, $5d21
	dbw $0a, $5db5
	dbw $03, $4436
	dbw $03, $4449
	dbw $0a, $659d

; Map events
	dbw $03, $44a4
	dbw $31, $7c15
	dbw $04, $7f56
	dbw $04, $7f75
	dbw $04, $7a43
	dbw $3e, $7c4e
	dbw $3e, $7dd7
	dbw $03, $46b3
	dbw $05, $57e5
	dbw $03, $4427
	dbw $05, $6ce5
	dbw $05, $6d39
	dbw $05, $71b8
	dbw $0b, $55e2
	dbw $05, $6760
	dbw $23, $4edf
	dbw $03, $43df
	dbw $24, $494b
	dbw $03, $4400
	dbw $03, $440d
	dbw $03, $44af
	dbw $03, $44ba
	dbw $03, $44cd
	dbw $03, $44da
	dbw $03, $44e7
	dbw $03, $454b
	dbw $23, $440e
	dbw $23, $4427
	dbw $23, $4403
	dbw $23, $441c
	dbw $02, $0d2b
	dbw $00, $345c
	dbw $00, $0359
	dbw $00, $0ea1
	dbw $00, $193c
	dbw $00, $0d80
	dbw $03, $4381
	dbw $03, $4394
	dbw $03, $3e28
	dbw $00, $3e8f
	dbw $00, $3ef7
	dbw $04, $65a4
	dbw $02, $4c97
	dbw $03, $439c
	dbw $03, $43aa
	dbw $03, $43b8
	dbw $03, $43c6
	dbw $03, $455f
	dbw $05, $7ef0
	dbw $05, $7f0f
	dbw $04, $7eec
	dbw $03, $456c
	dbw $09, $756d
	dbw $09, $75c5
	dbw $01, $7e52
	dbw $01, $7ec4
	dbw $01, $7f42
	dbw $03, $459e
	dbw $09, $4aab
	dbw $09, $4ad4
	dbw $09, $4a6b
	dbw $31, $7a5a
	dbw $03, $45b9
	dbw $03, $45a7
	dbw $31, $7c03
	dbw $03, $45d1
	dbw $03, $43f9
	dbw $03, $441a
	dbw $01, $7cdd
	dbw $01, $7cfc
	dbw $0a, $6aad
	dbw $0a, $6b54
	dbw $0a, $6b9c
	dbw $05, $41f8
	dbw $3e, $7983
	dbw $03, $45ec
	dbw $01, $7f5e
	dbw $01, $7f63
	dbw $01, $7f68
	dbw $03, $4621
	dbw $09, $682c
	dbw $03, $4627
	dbw $03, $4668
	dbw $05, $76c7
	dbw $0a, $688d
	dbw $03, $463e
	dbw $03, $464e
	dbw $03, $465b
	dbw $03, $4380
