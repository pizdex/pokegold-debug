unk_023_4000:
	dr $8c000, $8c3b8

DummyPredef35::
DummyPredef36::
	dr $8c3b8, $8c3b9

UpdateTimeOfDayPal:
	dr $8c3b9, $8c3c9

_TimeOfDayPals::
	dr $8c3c9, $8c3fa

_UpdateTimePals::
	dr $8c3fa, $8c403

FadeInPalettes:
	dr $8c403, $8c40e

FadeOutPalettes:
	dr $8c40e, $8c44c

ReplaceTimeOfDayPals::
	dr $8c44c, $8c576

unk_023_4576:
	dr $8c576, $8d25a

_InitSpriteAnimStruct::
	dr $8d25a, $8d395

_ReinitSpriteAnimFrame::
	dr $8d395, $90000
