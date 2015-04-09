#--------- Generic stuff all our Dockerfiles should start with so we get caching ------------
FROM mdillon/postgis 
MAINTAINER Jonathan Meyer<jon@gisjedi.com>

RUN apt-get update \
      && apt-get install -y wget unzip  

#-------------Application Specific Stuff ----------------------------------------------------

# Next line a workaround for https://github.com/dotcloud/docker/issues/963

RUN mkdir -p /docker-entrypoint-initdb.d
COPY ./initial-data.sh /docker-entrypoint-initdb.d/initial-data.sh
