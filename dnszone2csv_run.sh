#!/bin/bash
# put dns dump files into "dnsdumps_input"
# cmd: bash bindcsv_run.sh 
# converted csv will be under "dnsdumps_output"
# Make sure AWK and SED are downloaded 
# May take up to 15 seconds for program to complete

#Conversion Output Directory
echo "$(mkdir -p dnsdumps_output/dnsdumps_input)" 

#Loop through files in dnsdumps_input
for f in dnsdumps_input/*
do
	#checks file extension, then grabs the urls/ip addresses
	if [ ${f: -5} == ".yaml" ]; then
		echo "yaml converting..."
		echo "$(cat $f | tr " " "\n" | grep .com > $fIGNOREME.txt)"
	
		#takes urls, vpc, etc from files-- findsa all IPs associated-- then outputs to CSV
		while read p; do
			echo "$(host $p|grep " has address "| sed 's/has address/,/g')"
		done < $fIGNOREME.txt > dnsdumps_output/$f.csv

		#converts bind file to CSV, adding titles Hostname, A Record, etc.
	else 
		echo "bind converting..."
		echo "$(awk 'BEGIN {print "Hostname, A Record, IP Address"} {print $1,$4,$5}' OFS=, $f > dnsdumps_output/$f.csv)" 
	fi
done
		#Directory cleanup
		echo "$(mv -f ./dnsdumps_output/dnsdumps_input/*.csv ./dnsdumps_output)" 
		echo "$(rm -rf ./dnsdumps_output/\*.csv ./dnsdumps_output/dnsdumps_input/ )" 
exit
