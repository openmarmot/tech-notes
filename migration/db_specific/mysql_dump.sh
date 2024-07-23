
#andrew notes
# - last update April 26 2018
# - this works great. very fast imports
# https://mariadb.com/kb/en/library/mysqldump/#options

MYSQL_USER=root
MYSQL_PASS=PASS
MYSQL_CONN="-u${MYSQL_USER} -p${MYSQL_PASS}"
#
# Collect all database names except for
# mysql, information_schema, and performance_schema
#
SQL="SELECT schema_name FROM information_schema.schemata WHERE schema_name NOT IN"
SQL="${SQL} ('mysql','information_schema','performance_schema')"

DBLISTFILE=/tmp/DatabasesToDump.txt
mysql ${MYSQL_CONN} -ANe"${SQL}" > ${DBLISTFILE}

DBLIST=""
for DB in `cat ${DBLISTFILE}` ; do DBLIST="${DBLIST} ${DB}" ; done

MYSQLDUMP_OPTIONS="--routines --triggers --single-transaction"
mysqldump ${MYSQL_CONN} ${MYSQLDUMP_OPTIONS} --databases ${DBLIST} > all-dbs.sql