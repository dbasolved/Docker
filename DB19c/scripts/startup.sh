#!/bin/sh

echo $ORACLE_HOME
cd $ORACLE_HOME/bin
./lsnrctl start
./sqlplus -silent / as sysdba <<EOF
startup
select open_mode from v\$database;
alter pluggable database all open read write;
exit
EOF
