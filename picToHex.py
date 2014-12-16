from PIL import Image
import math

r_bits = 5
g_bits = 6
b_bits = 5

numerals = "0123456789abcdef"
hexdec  = {int(v, 16): v for v in (x+y for x in numerals for y in numerals)}

def norm(num, bits):
	return math.trunc(num*(2**bits/256.0))

def rgbToBinary(triplet):
	r = format(norm(triplet[0], r_bits), '0'+str(r_bits)+'b')
	g = format(norm(triplet[1], g_bits), '0'+str(g_bits)+'b')
	b = format(norm(triplet[2], b_bits), '0'+str(b_bits)+'b')
	return r+g+b

def rgbToHex(triplet):
	binary = rgbToBinary(triplet)
	return hex(int(binary, 2))


filename = "kitteh.jpg"
im = Image.open(filename)
pixels = im.load()

with open("memb.dat", 'w') as f:
	for x in range(0, im.size[0]):
		for y in range(0, im.size[1]):
			f.write(rgbToBinary(pixels[x, y])+"\n")

with open("memh.dat", 'w') as f:
	for x in range(0, im.size[0]):
		for y in range(0, im.size[1]):
			f.write(rgbToHex(pixels[x, y])+"\n")
