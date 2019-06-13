#!/usr/bin/env python
# -*- coding: utf-8 -*-
 
import sys
import numpy as np
import requests 
import json
import datetime
from requests.auth import HTTPBasicAuth

mandadosSimultaneamente = 250

if len(sys.argv)<2:
	print("FALTAN ARGUMENTOS")
	sys.exit(-11)

archivo = open(sys.argv[1],"r+")
fechas = []
mmec = []
mtmsi = []

for i in archivo:
	linea = i.split(" ")
	if (len(linea)>3) and (linea[3]!='\n'):
		fechas.append(linea[0])
		mmec.append(linea[2])
		mtmsi.append(linea[3][:-1])

archivo.close()
controlledProperty = "location"
category = "Sensor"
coordenadas = "42.798486, -1.633073"
type = "Device"
URL = "https://smartna.nasertic.es/upna/v2/op/update/"
headers = {'content-type': 'application/json', 'fiware-service': 'upna', 'fiware-servicepath': '/imsi_sensor/40/' }
currentDT = datetime.datetime.now()
timeExpired = currentDT.strftime("%Y-%m-%dT%H:")+str(int(currentDT.strftime("%M"))+2)+currentDT.strftime(":%SZ")
data = '{ "actionType": "APPEND", "entities": ['

for i in range(len(fechas)):
	id = mmec[i]+mtmsi[i]
	observation_time = fechas[i]
	aux = { "id": id, "type": type,
				"observation_time": {
					"type": "DateTime",
					"value": observation_time
				},
				"MMEC": {
					"type": "Text",
					"value": mmec[i]
				},
				"MTMSI": {
					"type": "Text",
					"value": mtmsi[i]
				},
				"STMSI": {
					"type": "Text",
					"value": id
				},
				"category": {
					"type": "StructuredValue",
					"value": [
						category
					]
				},
				"controlledProperty": {
					"type": "StructuredValue",
					"value": [
						controlledProperty
					]
				},
				"sensor_location": {
					"type": "StructuredValue",
					"value": {
						"value": coordenadas,
						"type": "geo:point"
					}
				},
				"dateExpires": {
					"type": "DateTime",
					"value": timeExpired
				}
			}

	aux_string = json.dumps(aux)
	data=data+aux_string+","
	if (i%mandadosSimultaneamente == 0):
		data=data[:-1]+']}'
		#print data
		r = requests.post(URL, data=data, headers=headers,auth=("upna","pxy99zl$"))
		print(r.text)
		data='{ "actionType": "APPEND", "entities": ['

if data!='{ "actionType": "APPEND", "entities": [':
	data=data[:-1]+']}'
	#print data
	r = requests.post(URL, data=data, headers=headers,auth=("upna","pxy99zl$"))
	print(r.text)


