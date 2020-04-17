roms := MONSGD.gbc

rom_obj := \
home.o \
main.o \
wram.o \

### Build tools

ifeq (,$(shell which sha1sum))
SHA1 := shasum
else
SHA1 := sha1sum
endif

RGBDS ?=
RGBASM  ?= $(RGBDS)rgbasm
RGBFIX  ?= $(RGBDS)rgbfix
RGBGFX  ?= $(RGBDS)rgbgfx
RGBLINK ?= $(RGBDS)rgblink

PYTHON := python
gfx := $(PYTHON) tools/gfx.py


### Build targets

.SUFFIXES:
.PHONY: all clean tidy pngs compare tools
.SECONDEXPANSION:
.PRECIOUS:
.SECONDARY:

all: $(roms)

tidy:
	rm -f $(roms) $(rom_obj) $(roms:.gbc=.map) $(roms:.gbc=.sym)
	$(MAKE) clean -C tools/

clean:
	rm -f $(roms) $(rom_obj) $(roms:.gbc=.map) $(roms:.gbc=.sym)
	find gfx -iname "*.png" -delete
	$(MAKE) clean -C tools/

compare: $(roms)
	@$(SHA1) -c roms.sha1

tools:
	$(MAKE) -C tools/

RGBASMFLAGS = -L -Weverything
$(rom_obj):    RGBASMFLAGS +=

# The dep rules have to be explicit or else missing files won't be reported.
# As a side effect, they're evaluated immediately instead of when the rule is invoked.
# It doesn't look like $(shell) can be deferred so there might not be a better way.
define DEP
$1: $2 $$(shell tools/scan_includes $2)
	$$(RGBASM) $$(RGBASMFLAGS) -o $$@ $$<
endef

# Build tools when building the rom.
# This has to happen before the rules are processed, since that's when scan_includes is run.
ifeq (,$(filter clean tools,$(MAKECMDGOALS)))

$(info $(shell $(MAKE) -C tools))

$(foreach obj, $(rom_obj), $(eval $(call DEP,$(obj),$(obj:.o=.asm))))

endif

MONSGD.gbc: $(rom_obj) MONSGD.link
	$(RGBLINK) -n MONSGD.sym -m MONSGD.map -l MONSGD.link -o $@ $(rom_obj)
	$(RGBFIX) -csv -i AAUJ -k 01 -l 0x33 -m 0x10 -p 0 -r 3 -t "POKEMON_GLD" $@

pngs:
	find gfx -iname "*.lz"      -exec $(gfx) unlz {} +
	find gfx -iname "*.[12]bpp" -exec $(gfx) png  {} +
	find gfx -iname "*.[12]bpp" -exec touch {} +
	find gfx -iname "*.lz"      -exec touch {} +
	find gfx/pokemon gfx/trainers -iname "*.[1,2]bpp" -delete