ARG BASE_IMAGE=oraclelinux:7-slim
FROM ${BASE_IMAGE}
USER root

#Container Additional Environment Variables
ENV PATH=.:$PATH \
     DB_SHIPHOME=LINUX.X64_180000_db_home.zip \
     ORACLE_BASE=/opt/app/oracle \
     ORACLE_HOME=/opt/app/oracle/product/18.1.0/dbhome_1 \
     ORA_INVENTORY=/opt/app/oraInventory \
     SOFTWARE_HOME=/home/oracle/software \
     PDB_NAME=oggatl \
     ORACLE_PWD=Welcome1 \
     LD_LIBRARY_PATH=.:$ORACLE_HOME/lib 

#Command during the build
#RUN sed -i -e '/^\[main\]/aproxy=http://www-proxy.us.oracle.com:80' /etc/yum.conf
RUN yum install -y oracle-database-preinstall-18c
RUN yum install -y java-1.8.0-openjdk-headless vim-minimal util-linux.x86_64 zip unzip tar ssh 
RUN yum reinstall -y glibc-common
RUN yum update -y
RUN yum clean all

#DB SHIPHOME
RUN echo " Creating Oracle Home directories\n"  && \
         mkdir -pv ${ORACLE_BASE} && \
         mkdir -pv ${ORACLE_HOME} && \
         mkdir -pv ${ORA_INVENTORY} && \
         chown -R oracle:oinstall ${ORACLE_BASE} && \
         chown -R oracle:oinstall ${ORA_INVENTORY}

RUN echo " Creating software directory ${SOFTWARE_HOME} \n" && \
         mkdir -pv ${SOFTWARE_HOME} && \
         mkdir -pv ${SOFTWARE_HOME}/ora-response && \
         chown -R oracle:oinstall ${SOFTWARE_HOME}
         
RUN echo " Adding Oracle Software \n"
ADD ${DB_SHIPHOME} ${SOFTWARE_HOME}
ADD install.sh ${SOFTWARE_HOME}
ADD install1.sh ${SOFTWARE_HOME}
ADD ./ora-response/* ${SOFTWARE_HOME}/ora-response/

RUN chown -R oracle:oinstall ${SOFTWARE_HOME}
RUN ls -ltrd ${SOFTWARE_HOME} && ls -ltrd ${SOFTWARE_HOME}

USER oracle
RUN sh ${SOFTWARE_HOME}/install.sh

USER root
RUN ${ORA_INVENTORY}/orainstRoot.sh
RUN ${ORACLE_HOME}/root.sh

USER oracle
RUN sh ${SOFTWARE_HOME}/install1.sh

EXPOSE 22
EXPOSE 1521

ENTRYPOINT /bin/bash
