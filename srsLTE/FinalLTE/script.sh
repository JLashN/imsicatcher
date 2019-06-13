#!/bin/bash

## Esperamos al arrancar 5 segundos para que se inicialicen todos los drivers
sleep 5

## Definimos it que va a a ser el contador de iteraciones
it=0

## Definimos step para saber cada cuantas iteraciones escaneamos antes del estudio
step=2

## Definimos tiempodesniffing para saber cuanto tiempo escuchamos cada frecuencia
tiempodesniffing=300

## Cogemos las variables de memoria persistente

maximosescaneos=$(cat ~/srsLTE/FinalLTE/maximosEscaneos)
numerodeescaneos=$(cat ~/srsLTE/FinalLTE/numeroDeEscaneos)

while :
do

	##Definimos el escaneo de frecuencias de antes del escaneo

	if [ $(($it % $step)) == 0 ] && [ $maximosescaneos -gt  $numerodeescaneos ]; then

		## Definimos uno como 0 para la condicion de parada del siguiente bucle
		uno=0

		## Reseteamos it para que no se nos salga de rango (por si acaso aunque no se va a dar el caso)
		it=0

		while [ $uno == 0 ]; do
			echo "Escaneo la banda 3 y la banda 20"

			## Aqui escaneo la banda 3
			~/srsLTE/FinalLTE/cell_search -b 3 > ~/srsLTE/FinalLTE/escaneo.txt

			## Aqui guardo las frecuencias de downlink de la banda 3 en un archivo para luego extraerlas
			~/srsLTE/FinalLTE/extractordevector.py ~/srsLTE/FinalLTE/escaneo.txt > ~/srsLTE/FinalLTE/vectordeescaneo.txt

			## Aqui registro las frecuencias de la banda 3 en un archivo para luego analizarlas
			~/srsLTE/FinalLTE/extractordevector.py ~/srsLTE/FinalLTE/escaneo.txt >> ~/srsLTE/FinalLTE/registro3.txt

			## Aqui escaneo la banda 20
			~/srsLTE/FinalLTE/cell_search -b 20 > ~/srsLTE/FinalLTE/escaneo.txt

			## Aqui guardo las frecuencias de downlink de la banda 20 en un archivo para luego extraerlas (hago un append para utilizar todas las frecuencias)
			~/srsLTE/FinalLTE/extractordevector.py ~/srsLTE/FinalLTE/escaneo.txt >> ~/srsLTE/FinalLTE/vectordeescaneo.txt

			## Aqui registro las frecuencias de la banda 20 en un archivo para luego analizarlas
			~/srsLTE/FinalLTE/extractordevector.py ~/srsLTE/FinalLTE/escaneo.txt >> ~/srsLTE/FinalLTE/registro20.txt

			echo "Termino de escanear las bandas"

			## Selecciono una frecuencia de las que he escaneado previamente para coger datos
			uno=$(~/srsLTE/FinalLTE/selectordefrecuencia.py ~/srsLTE/FinalLTE/vectordeescaneo.txt)
		done

		## Aumento el numero de escaneos que hemos realizado
		numerodeescaneos=$(($numerodeescaneos+1))

		## Lo guardamos en el archivo por si se reinicia el pc o cualquier cosa
		echo $numerodeescaneos > ~/srsLTE/FinalLTE/numeroDeEscaneos

	fi

	if [ $maximosescaneos ==  $numerodeescaneos ]; then

		## Eliminamos el anterior vector de escaneo
		rm ~/srsLTE/FinalLTE/vectordeescaneo.txt

		## Genero el nuevo vector de escaneo
		~/srsLTE/FinalLTE/estudio.py 20
		~/srsLTE/FinalLTE/estudio.py 3

		## Aumento el numero de escaneos que hemos realizado
		numerodeescaneos=$(($numerodeescaneos+1))

		## Lo guardamos en el archivo por si se reinicia el pc o cualquier cosa
		echo $numerodeescaneos > ~/srsLTE/FinalLTE/numeroDeEscaneos
	
	fi



	## Selecciono una frecuencia de las que he escaneado previamente para coger datos
	uno=$(~/srsLTE/FinalLTE/selectordefrecuencia.py ~/srsLTE/FinalLTE/vectordeescaneo.txt)

	## Escuchamos en la frecuencia previa (en background)
	~/srsLTE/FinalLTE/pdsch_ue -d -f $uno -r fffe&

	## Guardamos el pid del proceso anterior para luego matarlo
	pid_uno=$!

	## Si estamos aun aprendiendo las frecuencias...
	if [ $maximosescaneos -gt  $numerodeescaneos ]; then
		## Aumentamos la iteracion en la que nos encontramos
		it=$((it+1))
	
	fi

	## Esperamos escuchando tiempodesniffing segundos
	sleep $tiempodesniffing

	## Matamos el proceso que escucha
	kill $pid_uno

	## Registramos cuantos datos de LTE hemos escuchado
	echo $uno $(du -sh captura.txt) >> ~/srsLTE/FinalLTE/registrodatos.txt

	echo "Envio los datos a la plataforma"

	## Descodificamos los datos escuchados
	~/srsLTE/FinalLTE/descodificador.py captura.txt ~/srsLTE/FinalLTE/descodificado.txt

	## Enviamos los datos descodificados por lotes
	~/srsLTE/FinalLTE/sender.py ~/srsLTE/FinalLTE/descodificado.txt

	## Eliminamos los datos descodificados
	rm ~/srsLTE/FinalLTE/descodificado.txt

	echo "Enviados"

done

