#!/usr/bin/env python3

import sys

def output_literal(out, data):
	if not data:
		return

	out.write(bytes([len(data)]))
	data.reverse()
	out.write(data)

def output_rle(out, byte, count):
	tag = count + 125
	assert(tag >= 0x80 and tag <= 0xFF)

	out.write(bytes([tag]))
	out.write(byte)

def output_end(out):
	out.write(b'\x00')

def compress(infile, outfile):
	literal = bytearray()

	while True:
		read = infile.read(1)
		if len(read) == 0:
			output_literal(outfile, literal)
			break

		if len(literal) >= 2 and read[0] == literal[-1] and read[0] == literal[-2]:
			output_literal(outfile, literal[:-2])
			literal = bytearray()

			count = 3
			while count < 130:
				next = infile.read(1)
				if len(next) == 0:
					break
				if next != read:
					literal.extend(next)
					break
				count = count + 1

			output_rle(outfile, read, count)
		else:
			literal.extend(read)
			if len(literal) == 127:
				output_literal(outfile, literal)
				literal = bytearray()

	output_end(outfile)

def main():
	compress(sys.stdin.buffer, sys.stdout.buffer)

if __name__ == '__main__':
	main()
