#!/bin/bash

total()
{
	local oldworkplace=`pwd`
	cd $1
	local workplace=`pwd`
	for file in `ls $1`
	do
		cnt=$[$cnt+1]
		file=`echo $file| sed "s:^:${workplace}/:"`
		echo $file
		if [ -d $file ]
		then
			total $file
		fi
	done
	cd $oldworkplace
}

cnt=0
total $1
echo $cnt
