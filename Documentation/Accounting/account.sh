#!/bin/bash

# Should track our income and expenses like accountants do
# Not very accurate, but better than nothing

LASTLINE=$(tail -1 grossbook.txt)
CURRENTFUNDS=$(grep -A4 "name = Funding" ../../persistent.sfs | grep "funds = " | sed -re 's/.*funds = ([0-9]+)\..*/\1/')
OLDFUNDS=$(echo "$LASTLINE" | awk '{print $1}')

if [ -z "$OLDFUNDS" ]; then
	OLDFUNDS="0"
fi

CHANGE=$(($CURRENTFUNDS - $OLDFUNDS))
echo "Now: $CURRENTFUNDS Was: $OLDFUNDS Change: $CHANGE"
if [ $CHANGE -ne "0" ] ; then
	echo "Seems our account changed for $CHANGE, can you describe why?"
	read REASON
	echo -e "${CURRENTFUNDS}\t${CHANGE}\t${REASON}" >> grossbook.txt
else
	echo "Seems nothing is changed, so why you bother?"
fi

