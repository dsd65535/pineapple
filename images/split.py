f=open('memh.dat','r')
g=open('memh3.dat','w')
for line in f:
    line=(5-len(line))*"0"+line
    g.write('0x0'+line[0:2]+',\n')
    g.write('0x0'+line[2:4]+',\n')
f.close()
g.close()
