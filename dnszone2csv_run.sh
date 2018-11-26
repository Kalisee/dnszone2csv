#!/bin/bash
# cmd: bash bindcsv_run.sh 
# converted csv will be in dnsdumps_output
# Make sure AWK and SED are downloaded 
# May take up to 15 seconds for program to complete
echo "$(mkdir -p dnsdumps_output/dnsdumps_input)" 
for f in dnsdumps_input/*
do

	if [ ${f: -5} == ".yaml" ]; then
		echo "yaml converting..."
		echo "$(cat $f | tr " " "\n" | grep .com > $fIGNOREME.txt)"
	
		while read p; do
			echo "$(host $p|grep " has address "| sed 's/has address/,/g')"
		done < $fIGNOREME.txt > dnsdumps_output/$f.csv

	else 
		echo "bind converting..."
		echo "$(awk 'BEGIN {print "Hostname, A Record, IP Address"} {print $1,$4,$5}' OFS=, $f > dnsdumps_output/$f.csv)" 
	fi

done
