#!/bin/bash

# Creates report for mission

if [ -z "$1" ] ; then 
	echo "please specify mission serial number as 1-st argument"
fi

CODE=$(printf "GA%04d" $1)
echo $CODE

DIR=$(ls -1 | grep "$CODE")
if [ -d "$DIR" ]; then
	cd "$DIR"
	cat ../report_template.txt > report.txt
	vim report.txt
	cd -
	mv "$DIR" Finished
else
	echo "Seems your serial number is not valid or mission report is filled already"
fi
