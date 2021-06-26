FROM openjdk:8u292-oraclelinux7

USER root

ENV KEYCLOAK_VERSION=14.0.0
ENV KEYCLOAK_FILE_NAME=keycloak-${KEYCLOAK_VERSION}
ENV KEYCLOAK_HOME=/opt/jboss/${KEYCLOAK_FILE_NAME}
ENV KEYCLOAK_USER=admin
ENV KEYCLOAK_PASSWORD=admin
ENV KEYCLOAK_CONFIG_PATH=${KEYCLOAK_HOME}/standalone/configuration/

RUN mkdir -p ${KEYCLOAK_HOME}

RUN groupadd -r jboss -g 1000 && useradd -u 1000 -r -g jboss -m -d /opt/jboss/keycloak-14.0.0 -s /sbin/nologin -c "JBoss user" jboss && \
    chmod 755 /opt/jboss/keycloak-14.0.0

RUN mkdir -p /home/root/download
WORKDIR /home/root/download

RUN yum -y install unzip 
RUN yum -y install wget
RUN wget -O /home/root/download/${KEYCLOAK_FILE_NAME}.zip https://github.com/keycloak/keycloak/releases/download/$KEYCLOAK_VERSION/$KEYCLOAK_FILE_NAME.zip
RUN unzip /home/root/download/${KEYCLOAK_FILE_NAME}.zip -d /opt/jboss/
RUN rm $KEYCLOAK_FILE_NAME.zip
RUN chown -R jboss:0 ${KEYCLOAK_HOME}
RUN chmod -R g+rw ${KEYCLOAK_HOME}

COPY standalone.xml ${KEYCLOAK_CONFIG_PATH}

RUN ${KEYCLOAK_HOME}/bin/add-user-keycloak.sh -r master -u admin -p admin

EXPOSE 8080 9990

VOLUME [ "/opt/jboss/keycloak-14.0.0" ]

USER jboss

CMD [ "/opt/jboss/keycloak-14.0.0/bin/standalone.sh", "-b", "0.0.0.0"]

