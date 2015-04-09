# docker-compose-modis
Scripts to construct docker containers and populate with a stream of data based on MODIS.

## Build
Construct the GeoServer container by running build:

```docker-compose build```

## Daemonize
Create daemonized instance of the PostGIS and GeoServer containers:

```docker-compose up -d```

## Initialize
Populate the PostGIS with MODIS data and GeoServer with layer exposing table:

```bash initial-modis.sh```

## Prosper
Identify your GeoServer containers IP and start consuming the services:

```docker inspect `docker ps | grep geoserver | cut -f 1 -d " "` | grep IPA | cut -d "\"" -f 4```
