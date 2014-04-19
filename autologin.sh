#!/bin/bash
# author: sunheehnus
# NEEDS SUPER USER PRIVILEGE
# para1: username (default autologin user)
# para2: cnt (tty's cnt. user autologin tty${cnt})
#
# Usage:
# 	sudo ./autologin.sh sunheehnus 1
# 	sunheehnus will autologin on tty1

cd /usr/bin
touch autologin
chmod +x autologin
echo "#!/bin/bash
/bin/login -f $1" > autologin

cd /etc/init/
stable=`grep -v exec tty${2}.conf`
change=`grep exec tty${2}.conf`

echo "$stable" >"tty${2}.conf"
echo "$change"| while read oneline
do
	[[ $oneline == "#"* ]] && echo "$oneline"
	[[ $oneline == "#"* ]] || echo "# $oneline"
done >>"tty${2}.conf"
echo "exec /sbin/getty -n -l /usr/bin/autologin -8 38400 tty${2}" >>"tty${2}.conf"

echo "After reboot it will work."
