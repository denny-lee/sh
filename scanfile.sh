#!/bin/bash
function scandir() {
	local fpath="$1"
#	fpath=`echo "$1"|sed s/[[:space:]]/\\\\\\\\\\\\\ /g`
#	echo "fpath is : $fpath"
	if [ -f "$fpath" ] ; then
		echo "$1 is a file"
		echo $fpath >> $2
		return
	fi
	if ! [ -d "$fpath" ] ; then
		echo "$fpath is not a dir"
		return
	fi
	for file in `ls "$fpath"`
	do
		if [ -d "$fpath/$file" ] ; then
			echo $1"/"$file
			scandir $1"/"$file $2
		elif [ -f "$fpath/$file" ] ; then
			echo $1"/"$file >> $2
		else
			echo "* cannot parse: $1/$file" >> $2
		fi
	done
}
if [ -z "$2" ] ; then
	outfile="output.txt"
	echo $outfile
else
	outfile=$2
fi
if [ -z "$1" ] || [ -z "$outfile" ] ; then
	echo "pls input two params"
	exit 0
fi
echo "reading : "$1
if [ -d $1 ] ; then
	echo "as dir"
	scandir "$1" $outfile
else
	echo "as dir list"
	cat $1 | while read line
	do
		echo "reading dir : "$line
		scandir "$line" $outfile
	done
fi
echo "read done. pls check $outfile"
