#!/bin/bash
function scandir() {
	if ! [ -d $1 ] ; then
		echo "$1 is not a dir"
		return
	fi
	for file in `ls $1`
	do
		if [ -d $1"/"$file ] ; then
			echo $1"/"$file
			scandir $1"/"$file $2
		else
			echo $1"/"$file >> $2
		fi
	done
}
if [ -z "$1" ] || [ -z "$2" ] ; then
	echo "pls input two params"
	exit 0
fi
echo "reading : "$1
if [ -d $1 ] ; then
	echo "as dir"
	scandir $1 $2
else
	echo "as dir list"
	cat $1 | while read line
	do
		echo "reading dir : "$line
		scandir $line $2
	done
fi
echo "read done. pls check $2"
