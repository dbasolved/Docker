ARG BASE_IMAGE=oraclelinux:latest

FROM ${BASE_IMAGE}
USER root

LABEL version=1.0 \
      maintainer="Bobby Curtis, MBA - curtisbl@gmail.com/bobby.curtis@oracle.com" \
      description="Builds an Oracle Database image on top of Oracle Linux"
      
#Container Additional Environment Variables
ENV PATH=.:$PATH \
     DB_SHIPHOME=LINUX.X64_193000_db_home.zip \
     ORACLE_BASE=/opt/app/oracle \
     ORACLE_HOME=/opt/app/oracle/product/19.3.0/dbhome_1 \
     ORACLE_SID=orcl \
     ORA_INVENTORY=/opt/app/oraInventory \
     SOFTWARE_HOME=/home/oracle/software \
     SCRIPT_HOME=/home/oracle/scripts \
     PDB_NAME=oggtst \
     ORACLE_PWD=Welcome1 \
     LD_LIBRARY_PATH=.:$ORACLE_HOME/lib 

#Command during the build
#RUN sed -i -e '/^\[main\]/aproxy=http://www-proxy.us.oracle.com:80' /etc/yum.conf
RUN yum install -y oracle-database-preinstall-19c \
                    java-1.8.0-openjdk-headless \ 
                    vim-minimal \
                    util-linux.x86_64 \
                    zip \
                    unzip \
                    tar \
                    ssh \
                    tigervnc-server \
                    xterm
RUN yum reinstall -y glibc-common

#DB SHIPHOME
RUN echo " Creating Oracle Home directories\n"  && \
         mkdir -pv ${ORACLE_BASE} && \
         mkdir -pv ${ORACLE_HOME} && \
         mkdir -pv ${ORA_INVENTORY} && \
         chown -R oracle:oinstall ${ORACLE_BASE} && \
         chown -R oracle:oinstall ${ORA_INVENTORY}

RUN echo " Creating software directory ${SOFTWARE_HOME} \n" && \
         mkdir -pv ${SCRIPT_HOME} && \
         mkdir -pv ${SOFTWARE_HOME} && \
         mkdir -pv ${SOFTWARE_HOME}/ora-response && \
         chown -R oracle:oinstall ${SCRIPT_HOME} && \
         chown -R oracle:oinstall ${SOFTWARE_HOME} 
         
RUN echo " Adding Oracle Software \n"
COPY ./ORASoftware/${DB_SHIPHOME} ${SOFTWARE_HOME}
COPY install.sh ${SOFTWARE_HOME}
COPY install1.sh ${SOFTWARE_HOME}
COPY ./scripts/* ${SCRIPT_HOME}/
COPY ./ora-response/* ${SOFTWARE_HOME}/ora-response/

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
