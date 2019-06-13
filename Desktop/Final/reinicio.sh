#!/bin/bash
umbralcpu=5
umbraltiempo=15
maximotiempo=60
nombrearchivo=aux.txt
sleep 1
while :
do
	ps axu | grep grgsm_scanner > $nombrearchivo
	frase=$(sed -n 2p $nombrearchivo)
	IFS=' ' read -a array <<< "$frase"
	cpu="${array[2]}"
	fechainicio="${array[8]}"
	minutosinicio=${fechainicio#*:}
	minutosinicio=${minutosinicio#0*}
	horainicio=${fechainicio%:*}
	horainicio=${horainicio#0*}
	IFS=' ' read -a array <<< $(date)
	fechaactual="${array[3]}"
	horaactual=${fechaactual%%:*}
	horaactual=${horaactual#0*}
	aux=${fechaactual%:*}
	minutosactuales=${aux#*:}
	minutosactuales=${minutosactuales#0*}
	if [ $horainicio -gt $horaactual ]; then
		horaactual=$(($horaactual + 24))
	fi
	tiempotranscurrido=$((($horaactual - $horainicio) * 60))
	tiempotranscurrido=$((($minutosactuales - $minutosinicio) + $tiempotranscurrido))
	echo inicio: $horainicio:$minutosinicio ahora: $horaactual:$minutosactuales tiempo: $tiempotranscurrido cpu: $cpu
	if [ $tiempotranscurrido -gt $umbraltiempo ] && [ $umbralcpu -gt $cpu ]; then
		reboot
	fi
	if [ $tiempotranscurrido -gt $maximotiempo ]; then
		reboot
	fi
	sleep 20
	

done
