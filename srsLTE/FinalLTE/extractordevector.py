#!/usr/bin/python
from __future__ import print_function
import sys
import random

if len(sys.argv) < 2:
    print("FALTAN ARGUMENTOS")
    sys.exit(-11)

archivo = open(sys.argv[1], "r+")
modo = 0
for line in archivo:
    aux = line.split(" ")
    if(modo == 0):
        if((aux[0] == "Found") and (aux[1] != "CELL")):
            Frecuencias = int(aux[1])
            if(Frecuencias == 0):
                print(0, end="")
                exit(0)
            modo = 1
    else:
        if(Frecuencias != 0):
            frecuenciaactual = float(aux[2])
            frecuenciaactual = frecuenciaactual*(10**6)
            print(frecuenciaactual, end=",")
            Frecuencias -= 1
archivo.close()
