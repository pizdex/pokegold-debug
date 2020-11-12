QuickDebug_ElevatorOption:
	call DebugElevator
	ld a, QUICKMENU_UPDATE
	ret

DebugElevator:
	ld b, BANK(DebugElevator_FloorData)
	ld de, DebugElevator_FloorData
	farcall Elevator
	ret

DebugElevator_FloorData:
	db 6 ; floors
	elevfloor FLOOR_6F, 2, CELADON_DEPT_STORE_6F
	elevfloor FLOOR_5F, 3, CELADON_DEPT_STORE_5F
	elevfloor FLOOR_4F, 3, CELADON_DEPT_STORE_4F
	elevfloor FLOOR_3F, 3, CELADON_DEPT_STORE_3F
	elevfloor FLOOR_2F, 3, CELADON_DEPT_STORE_2F
	elevfloor FLOOR_1F, 4, CELADON_DEPT_STORE_1F
	db -1 ; end
