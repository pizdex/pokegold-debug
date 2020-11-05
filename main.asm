INCLUDE "constants.asm"

SECTION "bank1", ROMX

INCLUDE "engine/link/place_waiting_text.asm"

DebugMenu:
	farcall _DebugMenu
	jp StartTitleScreen

INCLUDE "engine/gfx/load_push_oam.asm"
INCLUDE "engine/overworld/map_objects.asm"
INCLUDE "engine/menus/main_menu.asm"
INCLUDE "engine/menus/intro_menu.asm"
INCLUDE "engine/overworld/init_map.asm"
INCLUDE "engine/pokemon/learn.asm"
INCLUDE "engine/pokemon/correct_nick_errors.asm"
INCLUDE "engine/math/math.asm"
INCLUDE "data/items/attributes.asm"
INCLUDE "data/items/names.asm"
INCLUDE "engine/overworld/npc_movement.asm"
INCLUDE "engine/events/happiness_egg.asm"
INCLUDE "engine/events/shuckle.asm"
INCLUDE "engine/events/haircut.asm"


SECTION "bank2",ROMX,BANK[$02]

INCLUDE "engine/tilesets/map_palettes.asm"
INCLUDE "gfx/tileset_palette_maps.asm"
INCLUDE "engine/gfx/blank_screen.asm"
INCLUDE "engine/debug/debug_password_menu.asm"
INCLUDE "engine/overworld/player_object.asm"
INCLUDE "engine/math/sine.asm"
INCLUDE "engine/predef.asm"
INCLUDE "engine/gfx/color.asm"


SECTION "bank3",ROMX,BANK[$03]

INCLUDE "engine/events/checktime.asm"
INCLUDE "engine/events/engine_flags.asm"
INCLUDE "engine/overworld/variables.asm"
INCLUDE "engine/events/specials.asm"
INCLUDE "engine/smallflag.asm"

INCLUDE "banks/bank03.asm"


SECTION "bank4",ROMX,BANK[$04]

INCLUDE "banks/bank04.asm"


SECTION "bank5",ROMX,BANK[$05]

INCLUDE "banks/bank05.asm"


SECTION "bank6",ROMX,BANK[$06]
	dr $18000, $1C000


SECTION "bank7",ROMX,BANK[$07]
	dr $1c000, $20000


SECTION "bank8",ROMX,BANK[$08]
	dr $20000, $24000


SECTION "bank9",ROMX,BANK[$09]

INCLUDE "banks/bank09.asm"


SECTION "bankA",ROMX,BANK[$0A]

INCLUDE "banks/bank0a.asm"


SECTION "bankB",ROMX,BANK[$0B]
	dr $2C000, $30000


SECTION "bankC",ROMX,BANK[$0C]
	dr $30000, $34000


SECTION "bankD",ROMX,BANK[$0D]
	dr $34000, $38000


SECTION "bankE",ROMX,BANK[$0E]

INCLUDE "banks/bank0e.asm"


SECTION "bankF",ROMX,BANK[$0F]

INCLUDE "banks/bank0f.asm"


SECTION "bank10",ROMX,BANK[$10]
	dr $40000, $44000


SECTION "bank11",ROMX,BANK[$11]
	dr $44000, $48000


SECTION "bank12",ROMX,BANK[$12]
	dr $48000, $4C000


SECTION "bank13",ROMX,BANK[$13]
INCBIN "baserom.gbc",$4C000,$4000


SECTION "bank14",ROMX,BANK[$14]

INCLUDE "banks/bank14.asm"


SECTION "bank15",ROMX,BANK[$15]
INCBIN "baserom.gbc",$54000,$4000


SECTION "bank16",ROMX,BANK[$16]
INCBIN "baserom.gbc",$58000,$4000


SECTION "bank17",ROMX,BANK[$17]
INCBIN "baserom.gbc",$5C000,$4000


SECTION "bank18",ROMX,BANK[$18]
INCBIN "baserom.gbc",$60000,$4000


SECTION "bank19",ROMX,BANK[$19]
INCBIN "baserom.gbc",$64000,$4000


SECTION "bank1A",ROMX,BANK[$1A]
INCBIN "baserom.gbc",$68000,$4000


SECTION "bank1B",ROMX,BANK[$1B]
INCBIN "baserom.gbc",$6C000,$4000


SECTION "bank1C",ROMX,BANK[$1C]
INCBIN "baserom.gbc",$70000,$4000


SECTION "bank1D",ROMX,BANK[$1D]
INCBIN "baserom.gbc",$74000,$4000


SECTION "bank1E",ROMX,BANK[$1E]
INCBIN "baserom.gbc",$78000,$4000


SECTION "bank1F",ROMX,BANK[$1F]
INCBIN "baserom.gbc",$7C000,$4000


SECTION "bank20",ROMX,BANK[$20]
INCBIN "baserom.gbc",$80000,$4000


SECTION "bank21",ROMX,BANK[$21]
INCBIN "baserom.gbc",$84000,$4000


SECTION "bank22",ROMX,BANK[$22]
INCBIN "baserom.gbc",$88000,$4000


SECTION "bank23",ROMX,BANK[$23]

INCLUDE "banks/bank23.asm"


SECTION "bank24",ROMX,BANK[$24]

INCLUDE "banks/bank24.asm"


SECTION "bank25",ROMX,BANK[$25]

INCLUDE "banks/bank25.asm"


SECTION "bank26",ROMX,BANK[$26]
INCBIN "baserom.gbc",$98000,$4000


SECTION "bank27",ROMX,BANK[$27]
INCBIN "baserom.gbc",$9C000,$4000


SECTION "bank28",ROMX,BANK[$28]
INCBIN "baserom.gbc",$A0000,$4000


SECTION "bank29",ROMX,BANK[$29]
INCBIN "baserom.gbc",$A4000,$4000


SECTION "bank2A",ROMX,BANK[$2A]
INCBIN "baserom.gbc",$A8000,$4000


SECTION "bank2B",ROMX,BANK[$2B]
INCBIN "baserom.gbc",$AC000,$4000


SECTION "bank2C",ROMX,BANK[$2C]
INCBIN "baserom.gbc",$B0000,$4000


SECTION "bank2D",ROMX,BANK[$2D]
INCBIN "baserom.gbc",$B4000,$4000


SECTION "bank2E",ROMX,BANK[$2E]
INCBIN "baserom.gbc",$B8000,$4000


SECTION "bank2F",ROMX,BANK[$2F]
INCBIN "baserom.gbc",$BC000,$4000


SECTION "bank30",ROMX,BANK[$30]
INCBIN "baserom.gbc",$C0000,$4000


SECTION "bank31",ROMX,BANK[$31]
INCBIN "baserom.gbc",$C4000,$4000


SECTION "bank32",ROMX,BANK[$32]
INCBIN "baserom.gbc",$C8000,$4000


SECTION "bank33",ROMX,BANK[$33]

INCLUDE "banks/bank33.asm"


SECTION "bank34",ROMX,BANK[$34]
INCBIN "baserom.gbc",$D0000,$4000


SECTION "bank35",ROMX,BANK[$35]
INCBIN "baserom.gbc",$D4000,$4000


SECTION "bank36",ROMX,BANK[$36]
INCBIN "baserom.gbc",$D8000,$4000


SECTION "bank37",ROMX,BANK[$37]
INCBIN "baserom.gbc",$DC000,$4000


SECTION "bank38",ROMX,BANK[$38]

INCLUDE "banks/bank38.asm"


SECTION "bank39",ROMX,BANK[$39]
INCBIN "baserom.gbc",$E4000,$4000


SECTION "bank3A",ROMX,BANK[$3A]
INCBIN "baserom.gbc",$E8000,$4000


SECTION "bank3B",ROMX,BANK[$3B]
INCBIN "baserom.gbc",$EC000,$4000


SECTION "bank3C",ROMX,BANK[$3C]
INCBIN "baserom.gbc",$F0000,$4000


SECTION "bank3D",ROMX,BANK[$3D]
INCBIN "baserom.gbc",$F4000,$4000


SECTION "bank3E",ROMX,BANK[$3E]

INCLUDE "engine/gfx/load_font.asm"
INCLUDE "data/collision/collision_permissions.asm"

INCLUDE "banks/bank3e.asm"


SECTION "bank3F",ROMX,BANK[$3F]

INCLUDE "engine/debug/debug_clock_menu.asm"
INCLUDE "engine/debug/debug_menu.asm"
INCLUDE "engine/debug/debug_menu_overworld.asm"
INCLUDE "engine/debug/debug_fight_menu.asm"
INCLUDE "engine/debug/debug_sound_menu.asm"
INCLUDE "engine/tilesets/tileset_anims.asm"
INCLUDE "engine/debug/debug_toolgear_update.asm"
INCLUDE "engine/events/npc_trade.asm"
INCLUDE "engine/events/mom_phone.asm"
INCLUDE "engine/link/mystery_gift_3.asm"
INCLUDE "engine/debug/debug_color_picker.asm"
