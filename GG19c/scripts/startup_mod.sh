echo $ORACLE_HOME
cd $ORACLE_HOME/bin
./sqlplus -silent / as sysdba <<EOF
shutdown immediate;
startup mount;
alter database archivelog;
alter database open;
alter database add supplemental log data;
alter database force logging;
alter system switch logfile;
alter system set enable_goldengate_replication=true scope=both;
select open_mode from v\$database;
alter pluggable database all open read write;
exit
EOF