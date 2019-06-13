#!/usr/bin/python

import sys

if len(sys.argv)<3:
	print "FALTAN ARGUMENTOS"
	sys.exit(-11)

fps = open(sys.argv[2],"w+")
i = 0; #El numero de lineas que llevo procesadas
with open (sys.argv[1]) as fp:
    for line in fp :
        aux = line.split("\t")
	if len(aux)>1:
		line = aux[1]
		line = line[1:-4] #S t r i p p i n g l i n e			            
		line = line.replace(" ","")
					    
		#If the hex number has 15 bytes,22 bytes or 28 bytes (30,44,56 char), then the UE have 2,3 or 4 tmsis.
		if(len(line)==18):
		    #First i write number of message, then the mmec (S-tmsi) and then the m-tmsi
		    fps.write(aux[0]+" "+str(i)+" "+str(int(line[3:5],16))+" "+str(int(line[5:13],16))+"\n")
		if (len(line)==30):
		    #First i write number of message, then the mmec (S-tmsi) and then the m-tmsi
		    fps.write(aux[0]+" "+str(i)+" "+str(int(line[3:5],16))+" "+str(int(line[5:13],16))+"\n")
		    fps.write(aux[0]+" "+str(i)+" "+str(int(line[14:16],16))+" "+str(int(line[16:24],16))+"\n")
		if (len(line)==44):
		    #First i write number of message, then the mmec (S-tmsi) and then the m-tmsi
		    fps.write(aux[0]+" "+str(i)+" "+str(int(line[3:5],16))+" "+str(int(line[5:13],16))+"\n")
		    fps.write(aux[0]+" "+str(i)+" "+str(int(line[14:16],16))+" "+str(int(line[16:24],16))+"\n")
		    fps.write(aux[0]+" "+str(i)+" "+str(int(line[25:27],16))+" "+str(int(line[27:35],16))+"\n")

		if (len(line)==56):
		    #First i write number of message, then the mmec (S-tmsi) and then the m-tmsi
		    fps.write(aux[0]+" "+str(i)+" "+str(int(line[3:5],16))+" "+str(int(line[5:13],16))+"\n")
		    fps.write(aux[0]+" "+str(i)+" "+str(int(line[14:16],16))+" "+str(int(line[16:24],16))+"\n")
		    fps.write(aux[0]+" "+str(i)+" "+str(int(line[25:27],16))+" "+str(int(line[27:35],16))+"\n")
		    fps.write(aux[0]+" "+str(i)+" "+str(int(line[36:38],16))+" "+str(int(line[38:46],16))+"\n")

        i+=1
			


fps.close()

