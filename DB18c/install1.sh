#!/bin/bash

echo
echo 'INSTALLER1: Started up'
echo

#configure LISTENER
cp ${SOFTWARE_HOME}/ora-response/netca.rsp.tmpl ${SOFTWARE_HOME}/ora-response/netca.rsp
${ORACLE_HOME}/bin/netca -silent -responseFile ${SOFTWARE_HOME}/ora-response/netca.rsp
rm -f ./ora-response/netca.rsp

#configure Database
cp ${SOFTWARE_HOME}/ora-response/dbca.rsp.tmpl ${SOFTWARE_HOME}/ora-response/dbca.rsp
sed -i -e "s|###ORACLE_SID###|${ORACLE_SID}|g" ${SOFTWARE_HOME}/ora-response/dbca.rsp && \
sed -i -e "s|###PDB_NAME###|${PDB_NAME}|g" ${SOFTWARE_HOME}/ora-response/dbca.rsp && \
sed -i -e "s|###ORACLE_PWD###|${ORACLE_PWD}|g" ${SOFTWARE_HOME}/ora-response/dbca.rsp
${ORACLE_HOME}/bin/dbca -silent -createDatabase -responseFile ${SOFTWARE_HOME}/ora-response/dbca.rsp


echo
echo 'INSTALLER1: Done'
echo
