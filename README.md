# Pentaho example with full stack enterprise services Dashboards, ETL, DWH, SourceDB on Docker
 
## Services:

 1) app_pentaho_ba - installed Pentaho BA. Access to console via URL http://[ip_of_docker_host]:8080/pentaho/Home
 2) db_repo - PostgreSQL server with Pentaho BA system repos
 3) db_dwh - PostgreSQL server with DWH DB "warehouse" - source for our dashboards (access via psql/PG Admin port 5432 from outside and inside farm)
 4) db_source_system - PostgreSQL server with Source System DB. This db is made for store data collected from web via app_source_system (access via psql/PG Admin port 5442 from outside farm/ 5423 from containers )
 5)


 
