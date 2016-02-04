#!/bin/bash

LANDSAT_DIR='/srv/geoserver/mosaics/landsat'

# Remove the entire mosaic workspace
curl -v -u admin:geoserver -XDELETE http://localhost:8080/geoserver/rest/workspaces/mosaic?recurse=true

# Remove all generated garbage from the mosaic configuration directory
rm -fr ${LANDSAT_DIR}
