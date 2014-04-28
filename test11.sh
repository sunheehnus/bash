#!/bin/bash

# -d check if it is a directory
if [ -d $HOME ]
then
	echo "Your home directory exists"
	cd $HOME
	ls -a
else
	echo "There is a problem with your HOME directory"
fi

# -e check if it exists (either a file or a directory)
if [ -e $HOME ]
then
	echo "OK on the directory, now to check the file"
	if [ -e $HOME/test ]
	then
		echo "Appending date to existing file"
		date >> $HOME/test
	else
		echo "Creating new file"
		date > $HOME/test
	fi
else
	echo "Sorry, you do not have a HOME directory"
fi
cat $HOME/test
rm $HOME/test

# -f check if it is a file
if [ -e $HOME ]
then
	echo "The object exists, is it a file?"
	if [ -f $HOME ]
	then
		echo "Yes, it is a file!"
	else
		echo "No, it is not a file!"
		if [ -f $HOME/.bash_history ]
		then
			echo "But this is a file!"
		fi
	fi
else
	echo "Sorry, the object does not exist"
fi

# -r check if it is readable
pwfile=/etc/shadow
if [ -f $pwfile ]
then
	if [ -r $pwfile ]
	then
		tail $pwfile
	else
		echo "Sorry, I am unable to read the $pwfile file"
	fi
else
	echo "Sorry, the file $file does not exist"
fi

# -s check if it exists and not empty
file=test4s
if [ -s $file ]
then
	echo "The $file exists and has data in it"
else
	echo "The $file does not exist or it is empty"
	touch $file

	if [ -s $file ]
	then
		echo "The $file file has data in it"
	else
		echo "The $file does not exist or it is empty"
		date > $file

		if [ -s $file ]
		then
			echo "The $file file has data in it"
		else
			echo "WHY?"
		fi
	fi
fi
cat $file
rm $file

# -w check if it is writable
logfile=$HOME/test
touch $logfile
chmod u-w $logfile
now=`date +%Y%m%d-%H%M`
if [ -w $logfile ]
then
	echo "The program ran at: $now" >$logfile
	echo "The first attempt succeeded"
else
	echo "The first attempt failed"
fi

chmod u+w $logfile
if [ -w $logfile ]
then
	echo "The program ran at: $now" >$logfile
	echo "The second attempt succeeded"
else
	echo "The second attempt failed"
fi
cat $logfile
rm $logfile

# -x check if it is executable
if [ -f $HOME/a.out ]
then
	if [ -x $HOME/a.out ]
	then
		echo "You can run the file:"
		$HOME/a.out
	else
		echo "Sorry, you are unable to execute it."
	fi
fi

# -O check if it is of your own
if [ -O /etc/passwd ]
then
	echo "/etc/passwd is yours"
else
	echo "Sorry, you are not the owner of /etc/passwd"
fi

# -G check if it is owned by your group
if [ -G /etc/passwd ]
then
	echo "You are in the same group as the file"
else
	echo "The file is not owned by your group"
fi

# file1 -nt file2 ---> file1 is newer than file2
# file1 -ot file2 ---> file1 is older than file2
