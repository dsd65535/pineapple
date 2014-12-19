from PIL import Image
import Tkinter, tkFileDialog

root = Tkinter.Tk()
root.withdraw()

f=open(tkFileDialog.askopenfilename(),'r')
first = False
there = False
temp=0
data=[]
for line in f:
    if there:
        first=~first
        i= int(line[0:3],16)
        if first: temp=(2**8)*i
        if ~first:
            temp+=i
            b=temp%(2**5)
            temp=(temp-b)/(2**5)
            g=temp%(2**6)
            temp=(temp-g)/(2**6)
            r=temp
            r=255*r/(2**5-1)
            g=255*g/(2**6-1)
            b=255*b/(2**5-1)
            data.append((r,g,b))
    if line=="12C,\n": there=True

print "Pixels: "+str(len(data))

img = Image.new( 'RGB', (128,160), "black") # create a new black image
pixels = img.load() # create the pixel map
 
for j in range(img.size[1]):    # for every pixel:
    for i in range(img.size[0]):
        pixels[i,j] = data[j*128+i] # set the colour accordingly
 
img.show()
