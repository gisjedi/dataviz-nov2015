#!/bin/bash

POST_CONTAINER=`docker-compose ps -q postgis`
GEOSERVER_CONTAINER=`docker-compose ps -q geoserver`
docker exec ${GEOSERVER_CONTAINER} apt-get update -y
docker exec ${GEOSERVER_CONTAINER} apt-get install curl wget -y
docker exec ${GEOSERVER_CONTAINER} bash /tmp/geoserver/cleanup-viirs-dnb.sh
docker exec ${POST_CONTAINER} su - postgres -c "bash /tmp/postgis/initial-viirs-dnb.sh"

docker exec ${GEOSERVER_CONTAINER} bash /tmp/geoserver/initial-viirs-dnb.sh
