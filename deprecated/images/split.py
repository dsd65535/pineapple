f=open('memh.dat','r')
g=open('mem.dat','w')
for line in f:
    line='0x'+(7-len(line))*"0"+line[2:]
    g.write('0x0'+line[2:4]+',\n')
    g.write('0x0'+line[4:6]+',\n')
f.close()
g.close()
