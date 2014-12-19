from PIL import Image
import math
import Tkinter, tkFileDialog
from subprocess import call

horizontal=True

root = Tkinter.Tk()
root.withdraw()

filename = tkFileDialog.askopenfilename()

r_bits = 5
g_bits = 6
b_bits = 5

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


im = Image.open(filename)
pixels = im.load()

with open("mem.dat", 'w') as f:
    if horizontal:
    	for x in range(0, im.size[0]):
	    	for y in range(0, im.size[1]):
		    	f.write(rgbToHex(pixels[x, y])+"\n")
    else:
    	for y in range(0, im.size[1]):
	    	for x in range(0, im.size[0]):
		    	f.write(rgbToHex(pixels[x, y])+"\n")

f=open('mem.dat','r')
g=open('mem.coe','w')
g.write('memory_initialization_radix=16;\nmemory_initialization_vector=\n')
g.write('200,\n101,\n200,\n111,\n200,\n1B1,\n001,\n02C,\n02D,\n1B2,\n001,\n02C,\n02D,\n1B3,\n001,\n02C,\n02D,\n001,\n02C,\n02D,\n1B4,\n007,\n1C0,\n0A2,\n002,\n084,\n1C1,\n0C5,\n1C2,\n00A,\n000,\n1C3,\n08A,\n02A,\n1C4,\n08A,\n0EE,\n1C5,\n00E,\n120,\n136,\n0C8,\n13A,\n005,\n12A,\n000,\n000,\n000,\n07F,\n12B,\n000,\n000,\n000,\n09F,\n1E0,\n002,\n01c,\n007,\n012,\n037,\n032,\n029,\n02d,\n029,\n025,\n02B,\n039,\n000,\n001,\n003,\n010,\n1E1,\n003,\n01d,\n007,\n006,\n02E,\n02C,\n029,\n02D,\n02E,\n02E,\n037,\n03F,\n000,\n000,\n002,\n010,\n113,\n200,\n129,\n200,\n136,\n0C0,\n')
g.write('12A,\n000,\n000,\n000,\n07F,\n12B,\n000,\n000,\n000,\n09F,\n12C,\n')
for line in f:
    line='0x'+(7-len(line))*"0"+line[2:]
    g.write('0'+line[2:4]+',\n')
    g.write('0'+line[4:6]+',\n')
f.close()
g.close()

#call(["rm", "mem.dat"])

filename = tkFileDialog.askopenfilename()
call(["mv", "mem.coe", filename])
