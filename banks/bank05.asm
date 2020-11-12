unk_005_4000:
	dr $14000, $14032

GetTimeOfDay::
	dr $14032, $14089

StartClock::
	dr $14089, $140ae

ClockContinue::
	dr $140ae, $140d1

_InitTime::
	dr $140d1, $1410e

_UpdatePlayerSprite::
	dr $1410e, $1411d

_RefreshSprites::
	dr $1411d, $1412e

_ClearSprites::
	dr $1412e, $1413f

RefreshSprites::
	dr $1413f, $142e9

_DoesSpriteHaveFacings::
	dr $142e9, $14306

_GetSpritePalette::
	dr $14306, $149ea

CheckWarpCollision::
	dr $149ea, $149ff

CheckDirectionalWarp::
	dr $149ff, $14e28

TryLoadSaveFile::
	dr $14e28, $15301

_LoadMapPart::
	dr $15301, $153f8

RunMapSetupScript::
	dr $153f8, $15586

CheckUpdatePlayerSprite::
	dr $15586, $15632

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

CheckBreedmonCompatibility:
	dr $178f0, $18000
