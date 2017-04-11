 echo copy from unzipped Penntaho BA distr files to host common folder START...
 echo cp app_pentaho_ba:/opt/pentaho/pentaho-server/data/postgresql ./init/db_repo
 echo 
 docker cp app_pentaho_ba:/opt/pentaho/pentaho-server/data/postgresql ./init/db_repo
 echo END	
 echo
 echo copy these files to db_repo container START...
 echo cp init/db_repo/postgresql db_repo:/tmp
 echo

 docker cp init/db_repo/postgresql db_repo:/tmp
 echo END
 echo
	
 echo run thiese file on db_repo PostgreSQL Server START...
 docker-compose exec db_repo psql -U postgres -f "/tmp/postgresql/create_repository_postgresql.sql"
 docker-compose exec db_repo psql -U postgres -f "/tmp/postgresql/create_quartz_postgresql.sql"
 docker-compose exec db_repo psql -U postgres -f "/tmp/postgresql/create_jcr_postgresql.sql"
 echo END
 echo

 echo copy customized Pentaho BA Server files to app_pentaho_ba container START
 docker cp init/app_pentaho_ba app_pentaho_ba:/tmp
 docker-compose exec app_pentaho_ba cp /tmp/app_pentaho_ba/pentaho-server/ /opt/pentaho/pentaho-server/ -r
 echo END
 echo

 echo copy DB creating scripts to db_source_system START
 docker cp ./init/db_source_system/* db_source_system:/tmp
 echo create SOURCE SYSTEM DB
 docker-compose exec  db_source_system psql -h localhost -U postgres -f "/tmp/create_source_db.sql"
 echo END
 echo 

 echo copy DB creating scripts to db_dwh START
 echo create DWH DB
 docker cp ./init/db_dwh/create_tables.sql db_dwh:/tmp 
 docker cp ./init/db_dwh/create_database.sql db_dwh:/tmp

 docker-compose exec  db_dwh psql -h localhost -U postgres -f "/tmp/create_database.sql"
 docker-compose exec  db_dwh psql -h localhost -U postgres -d warehouse -f "/tmp/create_tables.sql"
 echo END

 echo copy Pentaho BA Dashboards to server
 docker cp init/app_pentaho_ba/dashboards/ app_pentaho_ba:/tmp/

 docker-compose exec app_pentaho_ba  ./import-export.sh --import --url=http://app_pentaho_ba:8080/pentaho --username=admin --password=password --charset=UTF-8 --path=/public --file-path=/tmp/dashboards/Currencies.cda.zip --overwrite=true --permission=true --retainOwnership=true

 docker-compose exec app_pentaho_ba  ./import-export.sh --import --url=http://app_pentaho_ba:8080/pentaho --username=admin --password=password --charset=UTF-8 --path=/public --file-path=/tmp/dashboards/Currencies.cdfde.zip --overwrite=true --permission=true --retainOwnership=true

 docker-compose exec app_pentaho_ba  ./import-export.sh --import --url=http://app_pentaho_ba:8080/pentaho --username=admin --password=password --charset=UTF-8 --path=/public --file-path=/tmp/dashboards/Currencies.wcdf.zip --overwrite=true --permission=true --retainOwnership=true

 echo 

 echo ===============================================================================	
 echo Pentaho BA: 
 echo ===========================
 echo Start server by command:
 echo docker-compose exec -T app_pentaho_ba /opt/pentaho/pentaho-server/start-pentaho.sh
 echo 
 echo View Pentaho BA / Tomcat logs
 echo docker-compose exec app_pentaho_ba tail -f tomcat/logs/catalina.out
 echo
 echo Source System App:
 echo ===========================
 echo Start source server app by command:
 echo docker-compose exec -d -T app_source_system /opt/curr_rates_loader/start.sh
 echo 
 echo and stop by commmand:
 echo docker-compose exec -d -T app_source_system /opt/curr_rates_loader/stop.sh
 echo 
 echo View app logs
 echo docker-compose exec app_source_system  tail -f web_parse.log
 echo
 echo Pentaho Kettle Integration:
 echo ===========================
 echo start Pentaho Kettle Integration job by command:
 echo docker-compose exec -T app_pentaho_di /opt/pentaho/app/start.sh
 echo 
 echo and stop by command
 echo docker-compose exec -T app_pentaho_di /opt/pentaho/app/stop.sh
 echo 
 echo View kettle log
 echo docker-compose exec app_pentaho_di tail -f ../app/kettle.log
 echo 
 echo ===============================================================================



