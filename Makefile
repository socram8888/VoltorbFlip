
ASM6 = asm6
ASM6OPTS = -l -L
PYTHON3 = python3

# Disable built-in wildcard rules
.SUFFIXES:

RLE := $(patsubst %,%.rle,$(wildcard *.nam *.pal))

all: voltorbflip.nes voltorbflip.nes.ram.nl

voltorbflip.nes: *.s65 pattern.chr $(RLE)
	$(ASM6) $(ASM6OPTS) inesrom.s65 voltorbflip.nes

%.rle: %
	$(PYTHON3) util/rlecompress.py < $< > $@

voltorbflip.nes.ram.nl: voltorbflip.nes
	# $$ is a single escaped dollar - yes, because Makefile using backslash
	# for escaping like the rest of the world would make things too easy
	sed -rn 's/^0(0[0-9A-F]{3})[\t ]+(.*): dsb .*/$$\\1#\\2#/p' < inesrom.lst > voltorbflip.nes.ram.nl

clean:
	$(RM) voltorbflip.nes
	$(RM) voltorbflip.nes.ram.nl
	$(RM) inesrom.lst
	$(RM) *.rle
