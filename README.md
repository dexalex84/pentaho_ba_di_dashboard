# Pentaho example with full stack enterprise services Dashboards, ETL, DWH, SourceDB on Docker
 
## Services:

 1) app_pentaho_ba - installed Pentaho BA. Access to console via URL http://[ip_of_docker_host]:8080/pentaho/Home
 2) db_repo - PostgreSQL server with Pentaho BA system repos
 3) db_dwh - PostgreSQL server with DWH DB "warehouse" - source for our dashboards (access via psql/PG Admin [ip_of_docker_host]:5432 from outside and db_dwh:5432 inside containers)
 4) db_source_system - PostgreSQL server with Source System DB. This db is made for store data collected from web via app_source_system (access via psql/PG Admin [ip_of_docker_host]:5442 from outside farm / db_source_system:5423 from containers )
 5) app_pentaho_di - Pentaho Data Integration Server. Used to run Kettle integration packages with transfer data from db_source_system to db_dwh 
 6) app_source_system - CentOS server with java app which collect data from web and save it to db_source_system
 
## Instruction
 
 1) clone repo to local folder, go to this folder 
 2) run '''docker-compose up -d''' to create dockr images and start containers
 3) run '''prepare_environment.sh''' to init services. 
 4) Start Pentaho BA run '''docker-compose exec -T app_pentaho_ba /opt/pentaho/pentaho-server/start-pentaho-debug.sh''' (or with out T, or with out -debug).
    That need some time 
    See tomcat logs via '''docker-compose exec app_pentaho_ba tail -f tomcat/logs/catalina.out'''
    Wait untill see a row "INFO [main] org.apache.coyote.AbstractProtocol.start Starting ProtocolHandler ["http-nio-8080"]" in catalina.out
 5) Start source system app '''docker-compose exec -d -T app_source_system /opt/curr_rates_loader/start.sh'''
 6) Start Kettle intagration packages '''docker-compose exec -T app_pentaho_di /opt/pentaho/app/start.sh'''
 7) Import dash boards to Pentaho BA '''./import_dashboard.sh''' 
 
 ## Related docs and projects
 
 


 
