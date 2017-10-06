#!/bin/sh
cat $1 | \
while read LINE ; do
	nc -z -w5 $LINE 8099
	if [ $? -eq 0 ] ; then
		echo $LINE >> proxy
	fi
done
