# Pentaho example with full stack enterprise services Dashboards, ETL, DWH, SourceDB, SourceApp on Docker
 
## Services:

 1) app_pentaho_ba - installed Pentaho BA. Access to console via URL http://[ip_of_docker_host]:8080/pentaho/Home
 2) db_repo - PostgreSQL server with Pentaho BA system repos
 3) db_dwh - PostgreSQL server with DWH DB "warehouse" - source for our dashboards (access via psql/PG Admin [ip_of_docker_host]:5432 from outside and db_dwh:5432 inside containers)
 4) db_source_system - PostgreSQL server with Source System DB. This db is made for store data collected from web via app_source_system (access via psql/PG Admin [ip_of_docker_host]:5442 from outside farm / db_source_system:5423 from containers )
 5) app_pentaho_di - Pentaho Data Integration Server. Used to run Kettle integration packages with transfer data from db_source_system to db_dwh 
 6) app_source_system - CentOS server with java app which collect data from web and save it to db_source_system
 
## Instruction
 
 1) clone repo to local folder, change directory to this folder 
 2) run ```docker-compose up -d``` to create docekr images and start containers
 3) run ```prepare_environment.sh``` to init services. 
 4) Start Pentaho BA ```docker-compose exec -T app_pentaho_ba /opt/pentaho/pentaho-server/start-pentaho-debug.sh``` (or with out T, or with out -debug).
    This need some time from 5 to 10 minutes
    See tomcat logs via ```docker-compose exec app_pentaho_ba tail -f tomcat/logs/catalina.out```
    Wait untill see a row ```INFO [main] org.apache.coyote.AbstractProtocol.start Starting ProtocolHandler ["http-nio-8080"]``` in catalina.out
 5) Start source system app ```docker-compose exec -d -T app_source_system /opt/curr_rates_loader/start.sh```
 6) Start Kettle integration packages ```docker-compose exec -T app_pentaho_di /opt/pentaho/app/start.sh```
 7) Import dashboards to Pentaho BA ```./import_dashboard.sh```
 8) Go to http://[ip_of_docker_host]:8080/pentaho/Home log as admin (Evaluate as Admin). Browse files OPEN public/currencies.
 
 ## Related docs and projects
 - https://github.com/dexalex84/pentaho_7_0_ba_pg_files
 - https://github.com/dexalex84/get-currency-rates
 - https://github.com/dexalex84/pentaho-simple-dwh-job
 - http://redmine.webdetails.org/projects/5/wiki/FAQ_Main_Changes_New_Features_CCC_v2
 - http://community.pentaho.com/ctools/ccc/#type=line&anchor=time-series-line
 - https://docs.docker.com/
 - http://phantomjs.org/api/command-line.html
 
 ## Troubleshoot
 1) use notices at the end of ```prepare_environment.sh```!
 2) see logs:
  - View Pentaho BA / Tomcat logs
    ```echo docker-compose exec app_pentaho_ba tail -f tomcat/logs/catalina.out```
  - View app logs
    ```echo docker-compose exec app_source_system  tail -f web_parse.log```
  - View kettle log
    ```echo docker-compose exec app_pentaho_di tail -f ../app/kettle.log```
    
 
 
