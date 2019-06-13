#!/usr/bin/python

from libmich.asn1.processor import * ;

def decodePCCH(pcchHex) :
	load_module('RRCLTE');
	ASN1.ASN1Obj.CODEC=PER;
	PER.VARIANT = 'U' ;
	pcch = GLOBAL.TYPE['PCCH-Message'] ;
	buf = pcchHex.decode('hex');
	pcch.decode(buf);
	show(pcch);



line= "[41 08 0f 5c 91 5d b0 80 f7 00 af 7c 08 0c 64 b9 f1 38 00 00 00 00 ];"

line = line[1:-3] #S t r i p p i n g l i n e
line = line.replace(" ","")
print len(line)
decodePCCH(line)

