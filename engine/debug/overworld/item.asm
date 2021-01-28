QuickDebug_ItemOption:
	call LoadStandardMenuHeader
	call DebugItem_LoadDefaultItem
.loop
	call DebugItem_Main
	jr nc, .loop
; B was pressed
	call ExitMenu
	ld a, QUICKMENU_UPDATE
	ret

DebugItem_LoadDefaultItem:
	ld a, 1
	ld [wDebugItem], a
	ld [wDebugItemQuantity], a
	ret

DebugItem_Main:
.loop
	call DebugItem_PrintTextbox
	call WaitBGMap
	call DebugItem_Joypad
	ret c ; Pressing B sets carry
	jr z, .loop
; Pressing A unsets the zero flag
; Place selected item into Bag
	ld a, [wDebugItem]
	and a
	ret z
	call DebugItem_GiveSelectedItem
	and a
	ret

DebugItem_GiveSelectedItem:
	ld hl, wNumItems
; Load selected item
	ld a, [wDebugItem]
	ld [wCurItem], a
; Load selected item quantity
	ld a, [wDebugItemQuantity]
	ld [wItemQuantityChange], a
	call ReceiveItem
	jr c, .success
; Failed to receive item
	ld hl, .CantPlaceItemText
	call MenuTextboxWaitButton
	ret

.success
	ld de, SFX_FULL_HEAL
	call PlaySFX
	ld hl, .PlacedItemText
	call MenuTextboxWaitButton
	ret

.CantPlaceItemText:
; "That item can't be put in the PACK."
	text "どうぐを りュックに"
	line "いれられません!"
	done

.PlacedItemText:
 ; "The [wStringBuffer1] was put in the PACK."
	text_ram wStringBuffer1
	text "を "
	line "リュックにいれました"
	done

DebugItem_Joypad:
.joypad_loop
	call JoyTextDelay_ForcehJoyDown
	ld a, c
; DPAD
	bit D_UP_F, a
	jr nz, .increment_item
	bit D_DOWN_F, a
	jr nz, .decrement_item
	bit D_LEFT_F, a
	jr nz, .decrement_quantity
	bit D_RIGHT_F, a
	jr nz, .increment_quantity
; BUTTONS
	bit B_BUTTON_F, a
	jr nz, .exit
	bit A_BUTTON_F, a
	jr nz, .receive_item
; LOOP
	jr .joypad_loop

.increment_item:
	ld hl, wDebugItem
	ld a, [hl]
	cp NUM_TOTAL_ITEMS
	jr z, .max
	inc [hl]
	xor a
	ret

.max
	ld [hl], 1
	xor a
	ret

.decrement_item:
	ld hl, wDebugItem
	ld a, [hl]
	cp 1
	jr z, .min
	dec [hl]
	xor a
	ret

.min
	ld [hl], NUM_TOTAL_ITEMS
	xor a
	ret

.decrement_quantity:
	ld hl, wDebugItemQuantity
	dec [hl]
	jr nz, .above_0
	ld [hl], MAX_ITEM_STACK
.above_0
	xor a
	ret

.increment_quantity:
	ld hl, wDebugItemQuantity
	inc [hl]
; BUG: Item quantity is never loaded into 'a', and the initial value
; means that the quantity can be always be incremented (even past 99!)
	cp MAX_ITEM_STACK + 1
	jr c, .below_100
	ld [hl], 1
.below_100
	xor a
	ret

.exit
	scf
	ret

.receive_item
	ld a, 1
	and a
	ret

DebugItem_PrintTextbox:
	ld hl, wOptions
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	ldh a, [hBGMapMode]
	push af
	xor a
	ldh [hBGMapMode], a
; Get the name of the selected item
	ld a, [wDebugItem]
	ld [wNamedObjectIndex], a
	call GetItemName
; Print the data into a textbox
	ld hl, .ItemNameAndQuantityText
	call PrintText
	pop af
	ldh [hBGMapMode], a
	pop af
	ld [wOptions], a
	ret

.ItemNameAndQuantityText:
	text "ばんごう@" ; Number
	text_decimal wDebugItem, 1, 3
	text_start
	line "@"
	text_ram wStringBuffer1
	text "  ×@"
	text_decimal wDebugItemQuantity, 1, 2
	text_end
