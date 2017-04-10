#!/bin/sh
nohup java -jar ./app/get-currency-web.jar -b ./app/parser/phantomjs -H db_source_system -d system_a -U postgres -W postgres -p 5432 -lf -t 5 </dev/null &>/dev/null &
