#!/bin/bash

echo
echo 'INSTALLER: GoldenGate Install Started'
echo

#set environment variables in .bashrc
echo "export OGG_HOME=${OGG_HOME}" >> /home/oracle/.bashrc && \
#echo "export OGG_DEPLOYMENT_HOME=${OGG_DEPLOYMENT_HOME}" >> /home/oracle/.bashrc && \
echo "export TNS_ADMIN=${TNS_ADMIN}" >> /home/oracle/.bashrc && \
echo "export PATH=\$PATH:\$ORACLE_HOME/bin:\$LD_LIBRARY_PATH:\$OGG_HOME/bin" >> /home/oracle/.bashrc


cp ${SOFTWARE_HOME}/ora-response/oggcore.rsp.tmpl ${SOFTWARE_HOME}/ora-response/oggcore.rsp
sed -i -e "s|###DB_VERSION###|${DB_VERSION}|g" ${SOFTWARE_HOME}/ora-response/oggcore.rsp && \
sed -i -e "s|###OGG_HOME###|${OGG_HOME}|g" ${SOFTWARE_HOME}/ora-response/oggcore.rsp 
export OGG_BIN=${SOFTWARE_HOME}/${GG_UNZIP_HOME}/fbo_ggs_Linux_x64_shiphome/Disk1
${OGG_BIN}/runInstaller -silent -ignoreSysPrereqs -ignorePrereq -showProgress -waitForCompletion -responseFile ${SOFTWARE_HOME}/ora-response/oggcore.rsp
sleep 60
rm -f ${SOFTWARE_HOME}/ora-response/oggcore.rsp

echo
echo 'INSTALLER: Done'
echo
