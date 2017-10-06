#!/bin/sh
i=1
while [ $i -lt 250 ]
do
	ping -q -c4 190.$i.77.7 > /dev/null
	if [ $? -eq 0 ]
	then
		echo "190.$i.77.7" >> ips
	fi
	i=`expr $i + 1`
done
