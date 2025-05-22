#!/usr/bin/bash

script_name=$(basename -- "$0")

echo "------------" >> alarm_dialer.log
date -u >> alarm_dialer.log

if pidof -x "$script_name" -o $$ >/dev/null;then
   echo "Another instance of this script is already running" >> alarm_dialer.log
   exit 1
fi

for number in `cat alarm_numbers.txt`
do
	[ "${number:0:1}" = "#" ] && continue
	echo "Calling $number" >> alarm_dialer.log
	(echo "+++"; sleep 1; echo "ATDT$number"; sleep 15; echo "ATH") >/dev/ttyACM0
	date -u >> alarm_dialer.log
	sleep 5
done
