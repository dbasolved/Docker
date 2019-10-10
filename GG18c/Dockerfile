ARG BASE_IMAGE=db18c:18.3.0
FROM ${BASE_IMAGE}
USER root

#Container Additional Environment Variables
ENV PATH=.:$PATH \
     OGG_SHIPHOME=fbo_ggs_Linux_x64_services_shiphome.zip \
     ORACLE_SID=orcl \
     ORACLE_BASE=/opt/app/oracle \
     ORACLE_HOME=/opt/app/oracle/product/18.1.0/dbhome_1 \
     OGG_HOME=/opt/app/oracle/product/18.1.0/oggcore_1 \
     JAVA_HOME=/opt/app/oracle/product/18.1.0/oggcore_1/jdk \
     ORA_INVENTORY=/opt/app/oraInventory \
     OGG_DEPLOYMENT_HOME=/opt/app/oracle/gg_deployments \
     SOFTWARE_HOME=/home/oracle/software \
     LD_LIBRARY_PATH=$ORACLE_HOME/lib \
     DB_VERSION=ORA18c \
     GG_UNZIP_HOME=ogg18cma

ENV HOSTNAME ora18c-ogg18c

#Command during the build
#RUN sed -i -e '/^\[main\]/aproxy=http://www-proxy.us.oracle.com:80' /etc/yum.conf 
RUN yum install -y nginx
RUN yum reinstall -y glibc-common
RUN yum update -y
RUN yum clean all

#DB SHIPHOME
RUN echo " Creating Oracle Home directories\n"  && \
         mkdir -pv ${SOFTWARE_HOME}/${GG_UNZIP_HOME} && \
         mkdir -pv ${OGG_HOME} && \
         mkdir -pv ${OGG_DEPLOYMENT_HOME} && \
         chown -R oracle:oinstall ${SOFTWARE_HOME} &&\
         chown -R oracle:oinstall ${OGG_HOME} && \
         chown -R oracle:oinstall ${OGG_DEPLOYMENT_HOME}

RUN echo " Adding Oracle Software \n"
ADD ${OGG_SHIPHOME} ${SOFTWARE_HOME}
ADD ./ora-response/oggcore.rsp.tmpl ${SOFTWARE_HOME}/ora-response/
ADD ./python/ggSelfSignCerts.py ${SOFTWARE_HOME}/python/
ADD ./ogg_install.sh ${SOFTWARE_HOME}

RUN chown -R oracle:oinstall ${SOFTWARE_HOME}
RUN ls -ltrd ${SOFTWARE_HOME} && ls -ltrd ${SOFTWARE_HOME}

USER oracle
RUN sh ${SOFTWARE_HOME}/ogg_install.sh

EXPOSE 22
EXPOSE 80
EXPOSE 443
EXPOSE 1521
EXPOSE 16000-16005
EXPOSE 17001-17005

ENTRYPOINT /bin/bash
