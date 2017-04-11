#!/bin/sh
 echo copy Pentaho BA Dashboards to server
 docker cp init/app_pentaho_ba/dashboards/ app_pentaho_ba:/tmp/

 docker-compose exec -T app_pentaho_ba  ./import-export.sh --import --url=http://app_pentaho_ba:8080/pentaho --username=admin --password=password --charset=UTF-8 --path=/public --file-path=/tmp/dashboards/Currencies.cda.zip --overwrite=true --permission=true --retainOwnership=true

 docker-compose exec -T app_pentaho_ba  ./import-export.sh --import --url=http://app_pentaho_ba:8080/pentaho --username=admin --password=password --charset=UTF-8 --path=/public --file-path=/tmp/dashboards/Currencies.cdfde.zip --overwrite=true --permission=true --retainOwnership=true

 docker-compose exec -T app_pentaho_ba  ./import-export.sh --import --url=http://app_pentaho_ba:8080/pentaho --username=admin --password=password --charset=UTF-8 --path=/public --file-path=/tmp/dashboards/Currencies.wcdf.zip --overwrite=true --permission=true --retainOwnership=true

