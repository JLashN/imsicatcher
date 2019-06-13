#!/usr/bin/python

from libmich.asn1.processor import * ;

def decodePCCH(pcchHex) :
	load_module('RRCLTE');
	ASN1.ASN1Obj.CODEC=PER;
	PER.VARIANT = 'U' ;
	pcch = GLOBAL.TYPE['PCCH-Message'] ;
	buf = pcchHex.decode('hex');
	pcch.decode(buf);
	return pcch;


import sys

if len(sys.argv)<3:
	print "FALTAN ARGUMENTOS"
	sys.exit(-11)

fps = open(sys.argv[2],"w+")
with open (sys.argv[1]) as fp:
	for line in fp :
		if line.startswith("["):
			line = line[1:-4] #S t r i p p i n g l i n e
			line = line.replace(" ","")
			fps.write(decodePCCH(line))


fps.close()

