
ASM6 = asm6
ASM6OPTS = -l -L

all: game.nes

game.nes: *.s65 chr.bin
	$(ASM6) $(ASM6OPTS) game.s65 game.nes
