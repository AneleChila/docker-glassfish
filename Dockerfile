#Need to move this image to alpine
FROM ubuntu:trusty

LABEL maintainer="anelechila@gmail.com"

# Install Oracle Java 7
ENV JAVA_VER 7
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle

RUN echo 'deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main' >> /etc/apt/sources.list && \
    echo 'deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main' >> /etc/apt/sources.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C2518248EEA14886 && \
    apt-get update && \
    echo openjdk-${JAVA_VER}-jre shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections && \
    apt-get install -y --force-yes --no-install-recommends openjdk-${JAVA_VER}-jre && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists && \
    rm -rf /var/cache/openjdk-${JAVA_VER}-installer

RUN apt-get update && \
    apt-get install -y wget unzip pwgen expect && \
    wget --no-check-certificate http://download.oracle.com/glassfish/3.1.2/release/glassfish-3.1.2.zip && \
    unzip glassfish-3.1.2.zip -d /opt && \
    rm glassfish-3.1.2.zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV PATH /opt/glassfish3/bin:$PATH

ADD run.sh /run.sh
ADD change_admin_password.sh /change_admin_password.sh
ADD change_admin_password_func.sh /change_admin_password_func.sh
ADD enable_secure_admin.sh /enable_secure_admin.sh
ADD mysql-connector-java-5.1.47.jar /mysql-connector-java-5.1.47.jar
RUN chmod +x /*.sh


# 4848 (administration), 8080 (HTTP listener), 8181 (HTTPS listener)
EXPOSE 4848 8080 8181

CMD ["/run.sh"]
