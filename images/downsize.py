f=open("memh2.dat",'r')
g=open('small.dat','w')
i=0
new=[]
temp=0
for line in f:
    temp+=int(line.rstrip('\n').rstrip(','),16)
    if i==9:
        new.append(temp/10)
        temp=0
    i=(i+1)%10
for item in new:
      g.write("%s,\n" % hex(item))
