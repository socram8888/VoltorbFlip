
ASM6 = asm6
ASM6OPTS = -l -L
PYTHON3 = python3

# Disable built-in wildcard rules
.SUFFIXES:

RLE := $(patsubst %,%.rle,$(wildcard *.nam))

all: game.nes

game.nes: *.s65 pattern.chr $(RLE)
	$(ASM6) $(ASM6OPTS) game.s65 game.nes

%.rle: %
	$(PYTHON3) util/rlecompress.py < $< > $@

clean:
	$(RM) game.nes
	$(RM) *.rle
