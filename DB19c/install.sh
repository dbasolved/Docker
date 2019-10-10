#!/bin/bash

echo
echo 'INSTALLER: Started up'
echo

#set environment variables in .bashrc
echo "export ORACLE_BASE=${ORACLE_BASE}" >> /home/oracle/.bashrc && \
echo "export ORACLE_HOME=${ORACLE_HOME}" >> /home/oracle/.bashrc && \
echo "export LD_LIBRARY_PATH=${ORACLE_HOME}/lib:${LD_LIBRARY_PATH}" >> /home/oracle/.bashrc && \
echo "export ORACLE_SID=${ORACLE_SID}" >> /home/oracle/.bashrc && \
echo "export PATH=\$PATH:\$ORACLE_HOME/bin:\$LD_LIBRARY_PATH:\$OGG_HOME/bin" >> /home/oracle/.bashrc

#unzip database software and install configure database
unzip ${SOFTWARE_HOME}/${DB_SHIPHOME} -d ${ORACLE_HOME}
cp ${SOFTWARE_HOME}/ora-response/dbinstall.rsp.tmpl ${SOFTWARE_HOME}/ora-response/db_install.rsp
sed -i -e "s|###ORACLE_BASE###|${ORACLE_BASE}|g" ${SOFTWARE_HOME}/ora-response/db_install.rsp && \
sed -i -e "s|###ORACLE_HOME###|${ORACLE_HOME}|g" ${SOFTWARE_HOME}/ora-response/db_install.rsp && \
sed -i -e "s|###ORA_INVENTORY###|${ORA_INVENTORY}|g" ${SOFTWARE_HOME}/ora-response/db_install.rsp
${ORACLE_HOME}/runInstaller -silent -ignorePrereqFailure -waitforcompletion -responseFile ${SOFTWARE_HOME}/ora-response/db_install.rsp
rm -rf ${ORACLE_HOME}/apex && \
rm -rf ${ORACLE_HOME}/sqldeveloper && \
rm -rf ${ORACLE_HOME}/lib/*.zip && \
rm -rf ${ORACLE_HOME}/inventory/backup/* && \
rm -rf ${ORACLE_HOME}/network/tools/help && \
rm -rf ${ORACLE_HOME}/assistants/dbua && \
rm -rf ${ORACLE_HOME}/dmu && \
rm -rf ${ORACLE_HOME}/install/pilot && \
rm -rf ${ORACLE_HOME}/suptools && \
rm -f ${SOFTWARE_HOME}/ora-response/db_install.rsp && \
rm -f ${SOFTWARE_HOME}/${DB_SHIPHOME}

echo
echo 'INSTALLER: Done'
echo
