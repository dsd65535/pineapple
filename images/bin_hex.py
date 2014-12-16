f=open('memb.dat','r')
g=open('memh2.dat','w')
for line in f:
 g.write(hex(int(line,2))+','+'\n')
