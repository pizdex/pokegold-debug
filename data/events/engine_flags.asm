engine_flag: MACRO
; location, bit
; (all locations are in WRAM bank 1)
	dwb \1 + (\2 / 8), 1 << (\2 % 8)
ENDM

EngineFlags:
; entries correspond to ENGINE_* constants

	; pokegear
	engine_flag wd66f, POKEGEAR_RADIO_CARD_F
	engine_flag wd66f, POKEGEAR_MAP_CARD_F
	engine_flag wd66f, POKEGEAR_PHONE_CARD_F
	engine_flag wd66f, POKEGEAR_EXPN_CARD_F
	engine_flag wd66f, POKEGEAR_OBTAINED_F

	; unknown
	dr $c05c, $c164
