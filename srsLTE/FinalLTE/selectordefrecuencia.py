#!/usr/bin/python
from __future__ import print_function
import sys
import random

if len(sys.argv)<2:
	print("FALTAN ARGUMENTOS")
	sys.exit(-11)

archivo = open (sys.argv[1],"r+")
line = archivo.readline()
line = line[:-1]
frecuencias = line.split(",")
frecuenciaelegida = frecuencias[random.randint(0,len(frecuencias)-1)]
print(frecuenciaelegida,end="")