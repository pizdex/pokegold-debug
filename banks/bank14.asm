unk_014_4000:
	dr $50000, $5001d

SelectTradeOrDayCareMon::
	dr $5001d, $50970

INCLUDE "engine/pokemon/tempmon.asm"

Call_014_4a33:
	dr $50a33, $51308

GetGender::
	dr $51308, $5147a

unk_014_547a:
	dr $5147a, $5188d

unk_014_588d:
	dr $5188d, $51aac

BaseData:
	dr $51aac, $54000
