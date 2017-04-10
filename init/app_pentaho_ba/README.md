Files to customize Pentaho BA CE to work with PostgreSQL

to change name of DB server use that command:
if you need change localhost:5432 to db_repo:5432

do

find . -type f -exec sed -i 's/localhost:5432/db_repo:5432/g' {} +


