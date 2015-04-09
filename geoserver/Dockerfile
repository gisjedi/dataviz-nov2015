#--------- Generic stuff all our Dockerfiles should start with so we get caching ------------
FROM tomcat:7-jre7
MAINTAINER Jonathan Meyer<jon@gisjedi.com> 

RUN  export DEBIAN_FRONTEND=noninteractive
ENV  DEBIAN_FRONTEND noninteractive
RUN  dpkg-divert --local --rename --add /sbin/initctl

#-------------Application Specific Stuff ----------------------------------------------------

RUN apt-get -y install unzip

# A little logic that will fetch the geoserver zip file if it
# is not available locally in the resources dir and
RUN if [ ! -f /tmp/resources/geoserver.zip ]; then \
    wget -c http://downloads.sourceforge.net/project/geoserver/GeoServer/2.7.0/geoserver-2.7.0-war.zip -O /tmp/geoserver.zip; \
    fi; \
    unzip /tmp/geoserver.zip geoserver.war -d $CATALINA_HOME/webapps && mkdir -p /opt/geoserver/data
ENV GEOSERVER_DATA_DIR /opt/geoserver/data
ENV JAVA_HOME /usr/

ADD initialize-test.sh /tmp/geoserver/initialize-test.sh
ADD test-store.xml /tmp/geoserver/test-store.xml
RUN chmod 0755 /tmp/geoserver/initialize-test.sh
RUN cd /tmp/geoserver && ./initialize-test.sh

EXPOSE 8080
CMD ["catalina.sh", "run"]
