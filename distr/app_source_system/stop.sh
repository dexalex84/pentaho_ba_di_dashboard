#!/bin/sh
kill $(ps aux | grep '[.]/start.sh' | awk '{print $2}' )
kill $(ps aux | grep [g]et-currency-web.jar | awk '{print $2}' )
kill $(ps aux | grep [p]hantomjs | awk '{print $2}' )
