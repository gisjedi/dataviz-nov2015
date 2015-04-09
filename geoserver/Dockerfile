#--------- Generic stuff all our Dockerfiles should start with so we get caching ------------
FROM tomcat:7-jre7
MAINTAINER Jonathan Meyer<jon@gisjedi.com> 

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

EXPOSE 8080
CMD ["catalina.sh", "run"]
