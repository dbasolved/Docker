#!/bin/bash

cp ${SOFTWARE_HOME}/ora-response/oggca_deployment.rsp.tmpl ${SOFTWARE_HOME}/ora-response/oggca_deployment.rsp 
sed -i -e "s|###DEPLOYMENT_NAME###|Boston|g" ${SOFTWARE_HOME}/ora-response/oggca_deployment.rsp
sed -i -e "s|###PWD###|WElcome12345##|g" ${SOFTWARE_HOME}/ora-response/oggca_deployment.rsp
sed -i -e "s|HOST_SERVICEMANAGER=gg19c|HOST_SERVICEMANAGER=localhost|g" ${SOFTWARE_HOME}/ora-response/oggca_deployment.rsp
sed -i -e "s|###CREATESM###|false|g" ${SOFTWARE_HOME}/ora-response/oggca_deployment.rsp
sed -i -e "s|###SMPORT###|16000|g" ${SOFTWARE_HOME}/ora-response/oggca_deployment.rsp
sed -i -e "s|###ASPORT###|17001|g" ${SOFTWARE_HOME}/ora-response/oggca_deployment.rsp
sed -i -e "s|###DSPORT###|17002|g" ${SOFTWARE_HOME}/ora-response/oggca_deployment.rsp
sed -i -e "s|###RSPORT###|17003|g" ${SOFTWARE_HOME}/ora-response/oggca_deployment.rsp
sed -i -e "s|###PMPORT###|17004|g" ${SOFTWARE_HOME}/ora-response/oggca_deployment.rsp
sed -i -e "s|###PMUDPPORT###|17005|g" ${SOFTWARE_HOME}/ora-response/oggca_deployment.rsp
echo
$OGG_HOME/bin/oggca.sh -silent -responseFile ${SOFTWARE_HOME}/ora-response/oggca_deployment.rsp
rm -f ${SOFTWARE_HOME}/ora-response/oggca_deployment.rsp
