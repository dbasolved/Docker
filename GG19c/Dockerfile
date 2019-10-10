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
                    lsof 
RUN yum reinstall -y glibc-common

#Container Additional Environment Variables
ENV  SOFTWARE_HOME=/software \
     OC19C_UNZIP_HOME=ora19cclient \
     OC18C_UNZIP_HOME=ora18cclient \
     GG_UNZIP_HOME=ogg19cma \
     ORA_INVENTORY=/opt/app/oraInventory \
     ORACLE_BASE=/opt/app/oracle \
     ORACLE_HOME=/opt/app/oracle/product/19.1.0/clienthome_1 \
     OGG_HOME=/opt/app/oracle/product/19.1.0/oggcore_1 \
     OGG_DEPLOYMENT_HOME=/opt/app/oracle/gg_deployments \
     TNS_ADMIN=/opt/app/oracle/network/admin 

#Create Directory Structure
RUN echo " Creating Oracle Home directories\n"  && \
         mkdir -pv ${SOFTWARE_HOME}/${OC19C_UNZIP_HOME} && \
         mkdir -pv ${SOFTWARE_HOME}/${OC18C_UNZIP_HOME} && \
         mkdir -pv ${SOFTWARE_HOME}/${GG_UNZIP_HOME} && \
         mkdir -pv ${ORA_INVENTORY} && \
         mkdir -pv ${ORACLE_HOME} && \
         mkdir -pv ${OGG_HOME} && \
         mkdir -pv ${OGG_DEPLOYMENT_HOME} && \
         mkdir -pv ${TNS_ADMIN} && \
         chown -R oracle:oinstall ${SOFTWARE_HOME} &&\
         chown -R oracle:oinstall ${ORA_INVENTORY} && \
         chown -R oracle:oinstall ${ORACLE_BASE} && \
         chown -R oracle:oinstall ${ORACLE_HOME} && \
         chown -R oracle:oinstall ${OGG_HOME} && \
         chown -R oracle:oinstall ${OGG_DEPLOYMENT_HOME} && \
         chown -R oracle:oinstall ${TNS_ADMIN}

#Container Additional Environment Variables
ENV  PATH=.:$PATH \
     OGG_SHIPHOME=V983321-01-MA-191002.zip \
     ORACLE_CLIENT_SHIPHOME_19c=LINUX.X64_193000_client.zip \
     ORACLE_CLIENT_SHIPHOME_18c=LINUX.X64_180000_client.zip \
     ORACLE_HOME_19C=/opt/app/oracle/product/19.1.0/clienthome_1 \
     ORACLE_HOME_18C=/opt/app/oracle/product/18.1.0/clienthome_1 \
     JAVA_HOME=/opt/app/oracle/product/19.1.0/oggcore_1/jdk \
     LD_LIBRARY_PATH=$ORACLE_HOME/lib \
     DB_VERSION=ORA19c \
     HOSTNAME=ogg19c

RUN echo " Adding Oracle Software \n"
COPY ./ORASoftware/${OGG_SHIPHOME} ${SOFTWARE_HOME}
COPY ./ORASoftware/${ORACLE_CLIENT_SHIPHOME_19c} ${SOFTWARE_HOME}
COPY ./ORASoftware/${ORACLE_CLIENT_SHIPHOME_18c} ${SOFTWARE_HOME}
COPY ./ora-response/client_install_19c.rsp.tmpl ${SOFTWARE_HOME}/ora-response/
COPY ./ora-response/client_install_18c.rsp.tmpl ${SOFTWARE_HOME}/ora-response/
COPY ./ora-response/oggcore.rsp.tmpl ${SOFTWARE_HOME}/ora-response/
COPY ./python/* ${SOFTWARE_HOME}/python/
COPY ./scripts/* ${SOFTWARE_HOME}/scripts/
COPY ./client_install_19c.sh ${SOFTWARE_HOME}
COPY ./client_install_18c.sh ${SOFTWARE_HOME}
COPY ./ogg_install.sh ${SOFTWARE_HOME}

RUN chown -R oracle:oinstall ${SOFTWARE_HOME}
RUN ls -ltrd ${SOFTWARE_HOME}

USER oracle
WORKDIR ${SOFTWARE_HOME}
RUN ls -ltr ./*
RUN unzip ./${ORACLE_CLIENT_SHIPHOME_19c} -d ${SOFTWARE_HOME}/${OC19C_UNZIP_HOME}
RUN sh ${SOFTWARE_HOME}/client_install_19c.sh
RUN rm -f ${ORACLE_CLIENT_SHIPHOME_19c}

USER root
WORKDIR ${ORA_INVENTORY}
RUN ./orainstRoot.sh

USER oracle
WORKDIR ${SOFTWARE_HOME}
RUN unzip ./${ORACLE_CLIENT_SHIPHOME_18c} -d ${SOFTWARE_HOME}/${OC18C_UNZIP_HOME}
RUN sh ${SOFTWARE_HOME}/client_install_18c.sh
RUN rm -f ${ORACLE_CLIENT_SHIPHOME_18c}

USER root
WORKDIR ${ORA_INVENTORY}
RUN ./orainstRoot.sh

USER oracle
WORKDIR ${SOFTWARE_HOME}
RUN unzip ./${OGG_SHIPHOME} -d ${SOFTWARE_HOME}/${GG_UNZIP_HOME}
RUN sh ${SOFTWARE_HOME}/ogg_install.sh
RUN rm -f ${OGG_SHIPHOME}

USER root
WORKDIR ${ORA_INVENTORY}
RUN ./orainstRoot.sh
WORKDIR /

EXPOSE 22
ENTRYPOINT /bin/bash
