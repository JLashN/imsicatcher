#!/usr/bin/env python
# -*- coding: utf-8 -*-
 
import sys
import numpy as np
import requests 
import json
import datetime
from requests.auth import HTTPBasicAuth

def convertirFecha(fecha):
	'''
	Convierte Dec 12, 2018 22:10:55.101962908 CET
	en 2018-12-12T22:10:55.101Z
	'''

	fechaSeparada = fecha.split(' ')
	corregidor=0
	if fechaSeparada[1]=='':
		corregidor=1
	
	fechaEnBuenFormato = fechaSeparada[2+corregidor]+"-"
	if fechaSeparada[0]=='Dec':
		fechaEnBuenFormato += "12-"
	elif fechaSeparada[0]=='Nov':
		fechaEnBuenFormato += "11-"
	elif fechaSeparada[0]=='Oct':
		fechaEnBuenFormato += "10-"
	elif fechaSeparada[0]=='Sep':
		fechaEnBuenFormato += "09-"
	elif fechaSeparada[0]=='Aug':
		fechaEnBuenFormato += "08-"
	elif fechaSeparada[0]=="Jul":
		fechaEnBuenFormato += "07-"
	elif fechaSeparada[0]=='Jun':
		fechaEnBuenFormato += "06-"
	elif fechaSeparada[0]=='May':
		fechaEnBuenFormato += "05-"
	elif fechaSeparada[0]=='Apr':
		fechaEnBuenFormato += "04-"
	elif fechaSeparada[0]=='Mar':
		fechaEnBuenFormato += "03-"
	elif fechaSeparada[0]=='Feb':
		fechaEnBuenFormato += "02-"
	elif fechaSeparada[0]=='Jan':
		fechaEnBuenFormato += "01-"
	else:
		fechaEnBuenFormato += "?-"
	if corregidor==1:
		fechaEnBuenFormato+="0"
	fechaEnBuenFormato= fechaEnBuenFormato + fechaSeparada[1+corregidor][:-1] + "T"
	fechaEnBuenFormato= fechaEnBuenFormato + fechaSeparada[3+corregidor][0:12] + "Z"

	return fechaEnBuenFormato






if len(sys.argv)<2:
	print "FALTAN ARGUMENTOS"
	sys.exit(-11)


archivo = open(sys.argv[1],"r+")
fechas = []
pwr = []
gsmtapantenna = []
imsi = []

for i in archivo:
	linea = i.split("\t")
	if (len(linea)>3) and (linea[3]!='\n'):
		fechas.append(convertirFecha(linea[0]))
		pwr.append(linea[1])
		gsmtapantenna.append(linea[2])
		miImsi = linea[3].split(",")
		miImsi = miImsi[0].split("\n")
		miImsi = miImsi[0]
		imsi.append(miImsi)

archivo.close()
controlledProperty = "location"
category = "Sensor"
coordenadas = "42.798486, -1.633073"
type = "Device"
URL = "https://smartna.nasertic.es/upna/v2/op/update/"
headers = {'content-type': 'application/json', 'fiware-service': 'upna', 'fiware-servicepath': '/imsi_sensor/4/' }
currentDT = datetime.datetime.now()
timeExpired = currentDT.strftime("%Y-%m-%dT%H:")+str(int(currentDT.strftime("%M"))+2)+currentDT.strftime(":%SZ")

for i in range(len(fechas)):
	id = imsi[i]
	mcc = id[0:3]
	mnc = id[3:5]
	msin = id[5:]
	observation_time = fechas[i]
	data = { "actionType": "APPEND", "entities": [{ "id": id, "type": type,
				"observation_time": {
					"type": "DateTime",
					"value": observation_time
				},
				"MSIN": {
					"type": "Text",
					"value": msin
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
				"imsi_energy": {
					"type": "Float",
					"value": pwr[i]
				},
				"mcc": {
					"type": "Text",
					"value": mcc
				},
				"mnc": {
					"type": "Text",
					"value": mnc
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
		]
	}
	data_string = json.dumps(data)
	print data_string
	r = requests.post(URL, data=data_string, headers=headers,auth=("upna","pxy99zl$"))
	print r.text



