INCLUDE "macros/const.asm"
INCLUDE "macros/predef.asm"
INCLUDE "macros/rst.asm"
INCLUDE "macros/data.asm"
INCLUDE "macros/code.asm"
INCLUDE "macros/gfx.asm"
INCLUDE "macros/coords.asm"

INCLUDE "macros/scripts/audio.asm"
INCLUDE "macros/scripts/maps.asm"
INCLUDE "macros/scripts/events.asm"
INCLUDE "macros/scripts/text.asm"
INCLUDE "macros/scripts/movement.asm"
INCLUDE "macros/scripts/battle_commands.asm"
INCLUDE "macros/scripts/battle_anims.asm"
INCLUDE "macros/scripts/gfx_anims.asm"

INCLUDE "macros/legacy.asm"

dr: macro
; IF DEF(GOLD)
INCBIN "baserom.gbc", \1, \2 +- \1
; ELSE
; IF DEF(SILVER)
; INCBIN "baserom-silver.gbc", \1, \2 +- \1
; ENDC
; ENDC
ENDM
