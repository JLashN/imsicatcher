#!/bin/bash
sleep 5
it=0
pid_dos=0
pid_tres=0
password=monitorgsm

echo $password | sudo -S chmod 777 /sys/module/usbcore/parameters/usbfs_memory_mb
echo 0 > /sys/module/usbcore/parameters/usbfs_memory_mb
nombrearchivo=/home/monitorgsm/Desktop/Final/file.txt

while :
do
	if [ $(($it % 5)) -eq 0 ]; then
		uno=0
		while [ $uno -eq 0 ]; do
			echo "Escaneo la banda 900"
			/home/monitorgsm/Desktop/Final/reinicio.sh&
			pid_monitor=$!
			echo $password | sudo -S /home/monitorgsm/Desktop/Final/grgsm_scanner > /home/monitorgsm/Desktop/Final/lista
			pid_scanner=$!
			echo "Termino de escanear la banda"
			lista=$(tail -n 1 /home/monitorgsm/Desktop/Final/lista)
			uno=${lista%%,*}
			aux=${lista%,*}
			dos=${aux#*,}
			tres=${lista##*,}
			echo $password | sudo -S kill $pid_scanner
			kill $pid_monitor
		done
	fi

	echo $password | sudo -S tshark -i lo -Y 'gsmtap and gsm_a.ccch' -a duration:60 -V -T fields -e frame.time -e gsmtap.signal_dbm -e gsmtap.antenna -e e212.imsi > $nombrearchivo&
	grgsm_livemon_headless --collectorport=4729 --serverport=4729 --args="rtl=0" -f $uno&
	pid_uno=$!
	it=$((it+1))
	sleep 60
	kill $pid_uno
	echo "Envio los datos a la plataforma"
	/home/monitorgsm/Desktop/Final/sender.py $nombrearchivo
	echo "Enviados"

done
