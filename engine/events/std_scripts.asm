add_stdscript: MACRO
\1StdScript::
	dba \1
ENDM

StdScripts::
	add_stdscript PokecenterNurseScript
	add_stdscript DifficultBookshelfScript
	add_stdscript PictureBookshelfScript
	add_stdscript MagazineBookshelfScript
	add_stdscript TeamRocketOathScript
	add_stdscript IncenseBurnerScript
	add_stdscript MerchandiseShelfScript
	add_stdscript TownMapScript
	add_stdscript WindowScript
	dbw $36, $4128
	dbw $36, $412f
	dbw $36, $4132
	dbw $36, $413a
	dbw $36, $4142
	dbw $36, $4154
	dbw $36, $4158
	dbw $36, $415c
	dbw $36, $415f
	add_stdscript GoldenrodRocketsScript
	add_stdscript RadioTowerRocketsScript
	dbw $36, $414b
	dbw $36, $4162
	dbw $36, $41d0
	dbw $36, $41e8
	dbw $36, $4342
	dbw $36, $44a8
	dbw $36, $44ac
	dbw $36, $44b0
	dbw $36, $44b9
	dbw $36, $44bf
	dbw $36, $44c5
	dbw $36, $44cb
	dbw $36, $44d1
	dbw $36, $44d5
	dbw $36, $44d9
	dbw $36, $44e2
	dbw $36, $44e8
	dbw $36, $44ee
	dbw $36, $44f4
	dbw $36, $44fa
	dbw $36, $4503
	dbw $36, $4510
	dbw $36, $4519
	dbw $36, $4145
	dbw $36, $4522
	dbw $36, $45c9

PokecenterNurseScript:
	opentext
	checktime MORN
	iftrue .morn
	checktime DAY
	iftrue .day
	checktime NITE
	iftrue .nite
	sjump .ok

.morn
	writetext NurseMornText
	promptbutton
	sjump .ok

.day
	writetext NurseDayText
	promptbutton
	sjump .ok

.nite
	writetext NurseNiteText
	promptbutton
	sjump .ok

.ok
	writetext NurseAskHealText
	yesorno
	iffalse .done

	writetext NurseTakePokemonText
	pause 20
	turnobject LAST_TALKED, LEFT
	pause 10
	db $0f, $1b, $00
	playmusic MUSIC_NONE
	setval HEALMACHINE_POKECENTER
	special HealMachineAnim
	pause 30
	special RestartMapMusic
	turnobject LAST_TALKED, DOWN
	pause 10

	checkphonecall ; elm already called about pokerus
	iftrue .no
	checkflag ENGINE_CAUGHT_POKERUS
	iftrue .no
	db $0f, $4d, $00
	iftrue .pokerus
.no
	writetext NurseReturnPokemonText
	pause 20

.done
	writetext NurseGoodbyeText

	turnobject LAST_TALKED, UP
	pause 10
	turnobject LAST_TALKED, DOWN
	pause 10

	waitbutton
	closetext
	end

.pokerus
	writetext NursePokerusText
	waitbutton
	closetext
	setflag ENGINE_CAUGHT_POKERUS
	specialphonecall SPECIALCALL_POKERUS
	end

DifficultBookshelfScript:
	jumptext $4720 ; TEMP

PictureBookshelfScript:
	jumptext $4732 ; TEMP

MagazineBookshelfScript:
	jumptext $473e ; TEMP

TeamRocketOathScript:
	jumptext $4761 ; TEMP

IncenseBurnerScript:
	jumptext $4791 ; TEMP

MerchandiseShelfScript:
	jumptext $47a8 ; TEMP

TownMapScript:
	opentext
	writetext $47bb ; TEMP
	waitbutton
	db $0f, $26, $00 ; TODO
	closetext
	end

WindowScript:
	dr $d8125, $d81b2

GoldenrodRocketsScript:
	clearevent EVENT_GOLDENROD_CITY_ROCKET_TAKEOVER
	end

RadioTowerRocketsScript:
	dr $d81b6, $d85ec


NurseMornText:
	text "おはよう ございます!"
	line "# センター です!"
	done

NurseDayText:
	dr $d8604, $d8617

NurseNiteText:
	dr $d8617, $d8633

NurseAskHealText:
	dr $d8633, $d865f

NurseTakePokemonText:
	dr $d865f, $d8674

NurseReturnPokemonText:
	dr $d8674, $d869a

NurseGoodbyeText:
	dr $d869a, $d86c2

NursePokerusText:
	dr $d86c2, $d9000
