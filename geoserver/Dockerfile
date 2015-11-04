#--------- Generic stuff all our Dockerfiles should start with so we get caching ------------
FROM tomcat:7-jre7
MAINTAINER Jonathan Meyer<jon@gisjedi.com>

RUN  export DEBIAN_FRONTEND=noninteractive
ENV  DEBIAN_FRONTEND noninteractive
RUN  dpkg-divert --local --rename --add /sbin/initctl

#-------------Application Specific Stuff ----------------------------------------------------

RUN apt-get -y install unzip curl gdal-bin

ENV GEOSERVER_VERSION 2.7.3
ENV MARLIN_VERSION 0.4.5

ENV GEOSERVER_ZIP_URL http://downloads.sourceforge.net/project/geoserver/GeoServer/$GEOSERVER_VERSION/geoserver-$GEOSERVER_VERSION-war.zip

# Install GeoServer into Tomcat
RUN set -x \
	&& curl -fSL "$GEOSERVER_ZIP_URL" -o geoserver-war.zip \
	&& unzip geoserver-war.zip geoserver.war -d $CATALINA_HOME/webapps \
	&& rm geoserver-war.zip

# High performance configuration for GeoServer
ENV MARLIN_OPTS "-Xbootclasspath/p:$CATALINA_HOME/lib/marlin-$MARLIN_VERSION-sun-java2d.jar -Xbootclasspath/a:$CATALINA_HOME/lib/marlin-$MARLIN_VERSION.jar -Dsun.java2d.renderer=org.marlin.pisces.PiscesRenderingEngine"
ENV CATALINA_OPTS "$MARLIN_OPTS -server -Xms2048m -Xmx2048m -XX:PermSize=128m -XX:MaxPermSize=128m -XX:NewRatio=2 -XX:SoftRefLRUPolicyMSPerMB=36000 -XX:+UseParallelGC -XX:+UseParallelOldGC -XX:+AggressiveOpts -Duser.timezone=GMT -Djava.awt.headless=true"

# Install Marlin into Tomcat libs
ENV MARLIN_URL_BASE https://github.com/bourgesl/marlin-renderer/releases/download/v$MARLIN_VERSION
RUN curl -fSL "$MARLIN_URL_BASE"/marlin-$MARLIN_VERSION.jar -o $CATALINA_HOME/lib/marlin-$MARLIN_VERSION.jar \
	&& curl -fSL "$MARLIN_URL_BASE"/marlin-$MARLIN_VERSION-sun-java2d.jar -o $CATALINA_HOME/lib/marlin-$MARLIN_VERSION-sun-java2d.jar
ENV GEOSERVER_DATA_DIR /srv/geoserver
ENV JAVA_HOME /usr/

EXPOSE 8080
CMD ["catalina.sh", "run"]