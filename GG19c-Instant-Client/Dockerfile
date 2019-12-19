ARG BASE_IMAGE=oraclelinux:latest

FROM ${BASE_IMAGE}
USER root

LABEL version=1.0 \
      maintainer="Bobby Curtis, MBA - curtisbl@gmail.com/bobby.curtis@oracle.com" \
      description="Builds an Oracle GoldenGate 19c image on top of Oracle Linux"
      
#Command during the build
#RUN sed -i -e '/^\[main\]/aproxy=http://www-proxy.us.oracle.com:80' /etc/yum.conf 
RUN yum install -y  openssh \
                    oracle-database-preinstall-19c \
                    nginx \
                    tigervnc-server \
                    xterm \
                    vim \
                    lsof \
                    sudo
RUN yum reinstall -y glibc-common

#Container Additional Environment Variables
ENV  SOFTWARE_HOME=/software \
     GG_UNZIP_HOME=ogg19cma \
     ORA_INVENTORY=/opt/app/oraInventory \
     ORACLE_BASE=/opt/app/oracle \
     ORACLE_HOME=/opt/app/oracle/product/19.1.0/client_1 \
     ORACLE_HOME_19C=/opt/app/oracle/product/19.1.0/client_1 \
     ORACLE_HOME_18C=/opt/app/oracle/product/18.3.0/client_1 \
     ORACLE_HOME_19C_LIB=/opt/app/oracle/product/19.1.0/client_1/lib \
     ORACLE_HOME_18C_LIB=/opt/app/oracle/product/18.5.0/client_1/lib \
     OGG_HOME=/opt/app/oracle/product/19.1.0/oggcore_1 \
     OGG_DEPLOYMENT_HOME=/opt/app/oracle/gg_deployments \
     TNS_ADMIN=/opt/app/oracle/network/admin 

#Create Directory Structure
RUN echo " Creating Oracle Home directories"  && \
         mkdir -pv ${SOFTWARE_HOME} && \
         mkdir -pv ${SOFTWARE_HOME}/${GG_UNZIP_HOME} && \
         mkdir -pv ${ORA_INVENTORY} && \
         mkdir -pv ${ORACLE_BASE} && \
         mkdir -pv ${ORACLE_HOME_19C} && \
         mkdir -pv ${ORACLE_HOME_18C} && \
         mkdir -pv ${ORACLE_HOME_19C_LIB} && \
         mkdir -pv ${ORACLE_HOME_18C_LIB} && \
         mkdir -pv ${OGG_HOME} && \
         mkdir -pv ${OGG_DEPLOYMENT_HOME} && \
         mkdir -pv ${TNS_ADMIN}

RUN      chown -R oracle:oinstall ${SOFTWARE_HOME} &&\
         chown -R oracle:oinstall ${ORA_INVENTORY} && \
         chown -R oracle:oinstall ${ORACLE_BASE} && \
         chown -R oracle:oinstall ${ORACLE_HOME_19C} && \
         chown -R oracle:oinstall ${ORACLE_HOME_18C} && \
         chown -R oracle:oinstall ${ORACLE_HOME_19C_LIB} && \
         chown -R oracle:oinstall ${ORACLE_HOME_18C_LIB} && \
         chown -R oracle:oinstall ${OGG_HOME} && \
         chown -R oracle:oinstall ${OGG_DEPLOYMENT_HOME} && \
         chown -R oracle:oinstall ${TNS_ADMIN}

#Container Additional Environment Variables
ENV  PATH=.:$PATH \
     OGG_SHIPHOME=191004_fbo_ggs_Linux_x64_services_shiphome.zip \
     ORACLE_CLIENT_SHIPHOME_19C=instantclient-basic-linux.x64-19.3.0.0.0dbru.zip \
     ORACLE_CLIENT_SHIPHOME_18C=instantclient-basic-linux.x64-18.5.0.0.0dbru.zip \
     ORACLE_HOME=/opt/app/oracle/product/19.1.0/client_1 \
     ORACLE_HOME_19C=/opt/app/oracle/product/19.1.0/client_1 \
     ORACLE_HOME_18C=/opt/app/oracle/product/18.5.0/client_1 \
     JAVA_HOME=/opt/app/oracle/product/19.1.0/oggcore_1/jdk \
     LD_LIBRARY_PATH=${ORACLE_HOME}/lib \
     DB_VERSION=ORA19c \
     HOSTNAME=ogg19c

RUN echo " Adding Oracle Software "
COPY ./ORASoftware/${OGG_SHIPHOME} ${SOFTWARE_HOME}
COPY ./ORASoftware/${ORACLE_CLIENT_SHIPHOME_19C} ${SOFTWARE_HOME}
COPY ./ORASoftware/${ORACLE_CLIENT_SHIPHOME_18C} ${SOFTWARE_HOME}
COPY ./ora-response/* ${SOFTWARE_HOME}/ora-response/
COPY ./python/* ${SOFTWARE_HOME}/python/
COPY ./scripts/* ${SOFTWARE_HOME}/scripts/
COPY ./ogg_install.sh ${SOFTWARE_HOME}

RUN chown -R oracle:oinstall ${SOFTWARE_HOME}
RUN ls -ltrd ${SOFTWARE_HOME}

USER oracle
WORKDIR ${SOFTWARE_HOME}
RUN ls -ltr ./*
RUN unzip -q -o -j ./${ORACLE_CLIENT_SHIPHOME_18C} -d ${ORACLE_HOME_18C_LIB}
RUN ls -ltr ${ORACLE_HOME_18C_LIB}
RUN rm -f ${ORACLE_CLIENT_SHIPHOME_18C}

USER oracle
WORKDIR ${SOFTWARE_HOME}
RUN unzip -q -o -j ./${ORACLE_CLIENT_SHIPHOME_19C} -d ${ORACLE_HOME_19C_LIB}
RUN ls -ltr ${ORACLE_HOME_19C_LIB}
RUN rm -f ${ORACLE_CLIENT_SHIPHOME_19C}

USER oracle
WORKDIR ${SOFTWARE_HOME}
RUN unzip -q ./${OGG_SHIPHOME} -d ${SOFTWARE_HOME}/${GG_UNZIP_HOME}
RUN sh ${SOFTWARE_HOME}/ogg_install.sh

USER root
RUN /opt/app/oracle/oraInventory/orainstRoot.sh

USER oracle
RUN rm -f ${OGG_SHIPHOME}

EXPOSE 22
ENTRYPOINT /bin/bash
