#!/bin/bash
#date & time:01/27/13 13:41
#Author:sunheehnus
#Description: Para #1:TargetFolderName	Para #2:PicsCnt	Para #3:Preffix	Para #4:index
#			  DownHoopPics Pistons 28 http://photo.hupu.com/nba p19262
#Version:1.0
if [ $# -ne 4 ]
then
	echo "Para error!"
	exit 1
fi

piccnts=$2

prefix=$3

dirname=$4

echo "You are downloading \"$1\" pics ..."

raw_name="raw_$1$(echo $(md5sum <<EOF
date
EOF
)|awk '{print $1}')"

raw_URLs="$raw_name"_URLs

Pics="$1"
if [ -d "$Pics" ]
then
	Pics="$1$(echo $(md5sum <<EOF
date
EOF
)|awk '{print $1}')"
fi

mkdir "$raw_URLs"
mkdir "$Pics"

sleep 3

for index in $(seq 1 ${piccnts})
do
	curname="${dirname}"-"${index}".html
	wget -P ~/"${raw_URLs}" "${prefix}"/"${curname}"
	echo
	picURL=$(cat ~/"${raw_URLs}"/"${curname}"| grep img | head -2 | tail -1)
	picURL=${picURL#*\"}
	picURL=${picURL%\"*}
	wget -P ~/"${Pics}" $picURL
	picName=${picURL##*\/}
	mv ~/"${Pics}"/"${picName}" ~/"${Pics}"/"${index}.jpg"
done
rm -r "$raw_URLs"
exit 0
