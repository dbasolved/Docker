#!/bin/bash

echo
echo 'INSTALLER: Started up'
echo

#set environment variables in .bashrc
echo "export OGG_HOME=${OGG_HOME}" >> /home/oracle/.bashrc && \
echo "export OGG_DEPLOYMENT_HOME=${OGG_DEPLOYMENT_HOME}" >> /home/oracle/.bashrc && \
echo "export PATH=\$PATH:\$ORACLE_HOME/bin:\$LD_LIBRARY_PATH:\$OGG_HOME/bin" >> /home/oracle/.bashrc

#unzip database software and install configure database
#unzip ${SOFTWARE_HOME}/${OGG_SHIPHOME} -d ./${GG_UNZIP_HOME}
#cp ${SOFTWARE_HOME}/ora-response/oggcore.rsp.tmpl ${SOFTWARE_HOME}/ora-response/oggcore.rsp
#sed -i -e "s|###DB_VERSION###|${DB_VERSION}|g" ${SOFTWARE_HOME}/ora-response/oggcore.rsp && \
#sed -i -e "s|###OGG_HOME###|${OGG_HOME}|g" ${SOFTWARE_HOME}/ora-response/oggcore.rsp 
#${ORACLE_HOME}/runInstaller -silent -responseFile ${SOFTWARE_HOME}/ora-response/oggcore.rsp
#rm -f ${SOFTWARE_HOME}/ora-response/oggcore.rsp

echo
echo 'INSTALLER: Done'
echo
