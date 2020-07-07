unk_005_4000:
	dr $14000, $140ae

ClockContinue::
	dr $140ae, $14e28

TryLoadSaveFile::
	dr $14e28, $153f8

RunMapSetupScript::
	dr $153f8, $15632

INCLUDE "data/tilesets.asm"

PokemonCenterPC:
	dr $157e5, $16542

TakeMoney::
	dr $16542, $16553

CompareMoney::
	dr $16553, $1659b

AddMoney::
	dr $1659b, $1776c

LoadMysteryGiftBackgroundGFX::
	dr $1776c, $1778a

LoadMysteryGiftGFX2::
	dr $1778a, $178f0

unk_005_78f0:
	dr $178f0, $18000
