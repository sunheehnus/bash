#!/bin/bash
#date & time:02/05/13 19:48
#Author:sunheehnus
#Description:
#			  DynamicDesktop.sh /home/sunheehnus/Slam\ Dunk 60
#Version:1.0

if [ $# -ne 2 ]
then
	echo "Please input enough paras!"
	exit 1
fi

if [ ! -d "$1" ]
then
	echo "Your target folder is not a pic folder!"
	exit 2
fi

declare -i picnum=0
declare -a picnames
if ls "${1}/"*.jpg &>/dev/null
then
	for pic in "${1}/"*.jpg
	do
		picnames["$picnum"]="$pic"
		let 'picnum = picnum + 1'
	done
fi
if ls "${1}/"*.jpeg &>/dev/null
then
	for pic in "${1}/"*.jpeg
	do
		picnames["$picnum"]="$pic"
		let 'picnum = picnum + 1'
	done
fi

if [ $picnum -eq 0 ]
then
	echo "There are no available(*.jpg *.jpeg) pictures in your target folder!"
	exit 3
fi

interval_tmp=$(echo $2 | grep '[^[:digit:]]')
if [ -n "$interval_tmp" ]
then
	echo "Your time interval is not a number!"
	exit 4
fi
declare -i interval=$2
if [ $interval -lt "60" ]
then
	echo "Your time interval is too short!"
	exit 5
fi
declare -i interval_1="$interval-5"
declare -i interval_2="5"

prefix_name="/usr/share/backgrounds/"
name="bg"

cnt=0
while [ -d "${prefix_name}""${name}""${cnt}" ]
do
	let "cnt = cnt + 1"
done

dirname="${prefix_name}""${name}""${cnt}"

mkdir "$dirname"

cat > "$dirname""/default.xml" << EOF
<background>
  <starttime>
    <year>2009</year>
    <month>08</month>
    <day>04</day>
    <hour>00</hour>
    <minute>00</minute>
    <second>00</second>
  </starttime>
<!-- This animation will start at midnight. -->
EOF

for i in $(seq 1 $(echo ${picnum}-1|bc))
do
	now=$(echo ${i}-1|bc)
	next=$i
cat >> "$dirname""/default.xml" << EOF
  <static>
	<duration>${interval_1}.0</duration>
	<file>${picnames[$now]}</file>
  </static>
  <transition>
	<duration>${interval_2}.0</duration>
	<from>${picnames[$now]}</from>
	<to>${picnames[$next]}</to>
  </transition>
EOF
done

cat >> "$dirname""/default.xml" << EOF
  <static>
    <duration>${interval_1}.0</duration>
    <file>${picnames[$i]}</file>
  </static>
  <transition>
    <duration>${interval_2}.0</duration>
    <from>${picnames[$i]}</from>
    <to>${picnames[0]}</to>
  </transition>
</background>
EOF
cat >/usr/share/gnome-background-properties/"${name}""${cnt}""-wallpapers"".xml" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE wallpapers SYSTEM "gnome-wp-list.dtd">
<wallpapers>
  <wallpaper deleted="false">
    <name>Ubuntu 12.10 Community Wallpapers</name>
    <filename>${dirname}/default.xml</filename>
    <options>zoom</options>
  </wallpaper>
</wallpapers>
EOF
