
ASM6 = asm6
ASM6OPTS = -l -L
PYTHON3 = python3

# Disable built-in wildcard rules
.SUFFIXES:

RLE := $(patsubst %,%.rle,$(wildcard *.nam))

all: voltorbflip.nes

voltorbflip.nes: *.s65 pattern.chr $(RLE)
	$(ASM6) $(ASM6OPTS) inesrom.s65 voltorbflip.nes

%.rle: %
	$(PYTHON3) util/rlecompress.py < $< > $@

clean:
	$(RM) voltorbflip.nes
	$(RM) *.rle
