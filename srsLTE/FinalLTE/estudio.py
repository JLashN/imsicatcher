#!/usr/bin/python
import sys
import random
from sklearn import cluster
import numpy as np

RUTA = "/home/monitorgsm/srsLTE/FinalLTE/"

if len(sys.argv)<2:
	print("FALTAN ARGUMENTOS")
	sys.exit(-11)

bandas = {"3": 4, "20": 3, "6": 3}
bandaactual = sys.argv[1]
bandaactual = str(bandaactual)

## Quitamos la coma final si la hay
archivo = open(RUTA+"registro"+bandaactual+".txt","r+")
linea = archivo.readline()
if linea[-2] == ',':
    linea = linea[:-2]
    archivo.close()
    archivo = open(RUTA+"registro"+bandaactual+".txt","w")
    archivo.write(linea)

archivo.close()



datos = np.loadtxt(RUTA+"registro"+bandaactual+".txt",delimiter=",")
datossinpulir = datos.reshape(-1,1)
indice = list(set(datos))
estadisticadatos = np.zeros((len(indice),3))
estadisticadatos[:,0] = np.array(indice)
for i in range(len(indice)):
    datoabuscar = indice[i]
    estadisticadatos[i,1] = np.sum(datos == indice[i])
orden = np.argsort(estadisticadatos,axis=0)[:,1]
datos = estadisticadatos[orden[::-1],:]
print datos[0:5,:]

clasificador = cluster.KMeans(n_clusters=bandas[bandaactual])
prediccion = clasificador.fit_predict(datossinpulir)
datos[:,2] = clasificador.predict(datos[:,0].reshape(-1,1))
aux = np.zeros((len(datossinpulir),1))
datosamostrar = np.hstack((datossinpulir.reshape(-1,1),aux))

archivo = open(RUTA+"vectordeescaneo.txt","a+")
for i in range(bandas[bandaactual]):
    aux = datos[:,2] == i
    aux = np.hstack((datos[:,0][aux].reshape(-1,1),datos[:,1][aux].reshape(-1,1)))
    ordenauxiliar = aux.argsort(axis=0)[:,1]
    aux = aux[ordenauxiliar[::-1],:]
    print "La primera frecuencia del cluster "+str(i)+" es "+str(aux[0,0])+" con "+str(aux[0,1])
    archivo.write("{},".format(aux[0,0]))
    if aux.shape[0] > 1:   
        print "La segunda frecuencia del cluster "+str(i)+" es "+str(aux[1,0])+" con "+str(aux[1,1])
        if aux.shape[0] > 2:
            print "La tercera frecuencia del cluster "+str(i)+" es "+str(aux[2,0])+" con "+str(aux[2,1])
    print
archivo.close()