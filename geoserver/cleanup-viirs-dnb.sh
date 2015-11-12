#!/bin/bash

VIIRS_DIR='/srv/geoserver/mosaics/viirs-dnb'

# Remove the entire mosaic workspace
curl -v -u admin:geoserver -XDELETE http://localhost:8080/geoserver/rest/workspaces/mosaic?recurse=true

# Remove all generated garbage from the mosaic configuration directory
rm -fr ${VIIRS_DIR}
