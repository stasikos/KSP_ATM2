#!/bin/bash

# Creates new mission directory with files

if [ -z "$1" ] ; then
	echo "Please specify short mission name in quotes as first parameter"
	exit 1
fi

TIME_UT=$(grep -E "^\s+UT = " ../../persistent.sfs | sed -re 's/.*UT = ([0-9]+)\..*/\1/')
TIME_DAYS=$(($TIME_UT/(60*60*6)))
YEAR=$((1 + $TIME_DAYS/426))
DAY=$(($TIME_DAYS%426))
SERIAL=$(cat serial.txt)
SERIAL=$(($SERIAL+1))
echo $SERIAL > serial.txt
echo "Days: $TIME_DAYS, Year: $YEAR, Day: $DAY"

SHORT_DESC=$(echo "$1" | sed -e 's/ /_/g')

MISSION_DIR=$(printf "Y%03dD%03d_GA%04d_%s" $YEAR $DAY $SERIAL "$SHORT_DESC")
MISSION_PLANNED=$(printf "Year %d, day %d" $YEAR $DAY)
echo "$MISSION_DIR"
mkdir "$MISSION_DIR"
cd "$MISSION_DIR"
sed -e "s/%MISSION_PLANNED%/$MISSION_PLANNED/" ../plan_template.txt > plan.txt
vim plan.txt
cd -
