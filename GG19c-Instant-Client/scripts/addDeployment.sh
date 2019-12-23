#!/bin/bash

cp ${SOFTWARE_HOME}/ora-response/oggca_deployment.rsp.tmpl ${SOFTWARE_HOME}/ora-response/oggca_deployment.rsp 
sed -i -e "s|###DEPLOYMENT_NAME###|Atlanta|g" ${SOFTWARE_HOME}/ora-response/oggca_deployment.rsp
sed -i -e "s|###PWD###|WElcome12345##|g" ${SOFTWARE_HOME}/ora-response/oggca_deployment.rsp
sed -i -e "s|###CREATESM###|true|g" ${SOFTWARE_HOME}/ora-response/oggca_deployment.rsp
sed -i -e "s|###SMPORT###|16000|g" ${SOFTWARE_HOME}/ora-response/oggca_deployment.rsp
sed -i -e "s|###ASPORT###|16001|g" ${SOFTWARE_HOME}/ora-response/oggca_deployment.rsp
sed -i -e "s|###DSPORT###|16002|g" ${SOFTWARE_HOME}/ora-response/oggca_deployment.rsp
sed -i -e "s|###RSPORT###|16003|g" ${SOFTWARE_HOME}/ora-response/oggca_deployment.rsp
sed -i -e "s|###PMPORT###|16004|g" ${SOFTWARE_HOME}/ora-response/oggca_deployment.rsp
sed -i -e "s|###PMUDPPORT###|16005|g" ${SOFTWARE_HOME}/ora-response/oggca_deployment.rsp
echo
$OGG_HOME/bin/oggca.sh -silent -responseFile ${SOFTWARE_HOME}/ora-response/oggca_deployment.rsp
rm -f ${SOFTWARE_HOME}/ora-response/oggca_deployment.rsp
