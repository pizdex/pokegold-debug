npctrade: MACRO
; dialog set, requested mon, offered mon, nickname, dvs, item, OT ID, OT name, gender requested
	db \1, \2, \3, \4, \5, \6, \7
	shift
	dw \7
	db \8, \9
ENDM

NPCTrades:
; entries correspond to NPCTRADE_* constants
	npctrade TRADE_DIALOGSET_COLLECTOR, DROWZEE,    MACHOP,     "きんにく",	$37, $66, GOLD_BERRY,   37460, "ナオキ",	TRADE_GENDER_EITHER
	npctrade TRADE_DIALOGSET_COLLECTOR, BELLSPROUT, ONIX,       "ブルブル",	$96, $66, BITTER_BERRY, 48926, "コンタ",	TRADE_GENDER_EITHER
	npctrade TRADE_DIALOGSET_HAPPY,     KRABBY,     VOLTORB,    "ビリー@",		$98, $88, PRZCUREBERRY, 29189, "ゲン@",	TRADE_GENDER_EITHER
	npctrade TRADE_DIALOGSET_NEWBIE,    DRAGONAIR,  RHYDON,     "ドンドコ",	$77, $66, BITTER_BERRY, 00283, "ミサコ",	TRADE_GENDER_FEMALE
	npctrade TRADE_DIALOGSET_HAPPY,     GLOOM,      RAPIDASH,   "カケアシ",	$96, $66, BURNT_BERRY,  15616, "デンジ",	TRADE_GENDER_EITHER
	npctrade TRADE_DIALOGSET_NEWBIE,    CHANSEY,    AERODACTYL, "プッチー",	$96, $66, GOLD_BERRY,   26491, "キヨミ",	TRADE_GENDER_EITHER
