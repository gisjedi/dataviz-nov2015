# DataViz Nov 2015 
Scripts to construct docker containers and populate with up to date MODIS and VIIRS DNB data. Compose support for a full stand up of OGC Preview and GeoServer fronting PostGIS.

## Build
Construct the GeoServer and Apache containers by running build:

```docker-compose build```

## Daemonize
Create daemonized instance of the containers:

```docker-compose up -d```

## Initialize
Populate PostGIS with MODIS data and GeoServer with layer exposing table:

```bash initial-modis.sh```

Populate PostGIS with VIIRS data footprints and GeoServer with layer exposing GeoTIFFs:

```bash initial-viirs-dnb.sh```

## Prosper
Access your newly constructed containers on either http://localhost (Linux only) or identify the IP of your virtualized docker host (Mac / Windows):

```docker-machine ip default```
