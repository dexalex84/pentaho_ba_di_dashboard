#!/bin/sh

run_count=100000
sleep_time_sec=2
iteration=0
for i in $( eval echo {1..$run_count} )
do
     iteration=$((iteration + 1))
     echo running package update_rates.kjb iteration: $iteration
     /opt/pentaho/data-integration/kitchen.sh -file /opt/pentaho/app/update_all.kjb
     echo wait $sleep_time_sec seconds...
     sleep $sleep_time_sec
done
