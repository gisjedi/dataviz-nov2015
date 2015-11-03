#!/bin/bash

# Pull down VIIRS tiffs for mosaic
VIIRS_DIR='/srv/geoserver/mosiacs/viirs-dnb'
mkdir -p ${VIIRS_DIR}
cd ${VIIRS_DIR}

FTP_URL='ftp://ftp.ssec.wisc.edu/pub/eosdb/npp/viirs/'
ACCEPT_PATTERN='npp_viirs_adaptive_dnb*.tif'
# -nc No clobber, i.e. don't retrieve existing files
# -nd No directories. Flatten the tree and place all files in current directory
# -np No parent. Don't ascend the directory tree.
# --follow-ftp Traverse FTP links
# -A Accept pattern to use for files.
# -r Recursively search the directory tree.

wget -nc -nd -np --follow-ftp -A ${ACCEPT_PATTERN} -r ${FTP_URL}


#DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
#curl -v -u admin:geoserver -XDELETE http://localhost:8080/geoserver/rest/workspaces/test?recurse=true
#curl -v -u admin:geoserver -XPOST -H "Content-type: text/xml" -d "<workspace><name>test</name></workspace>" http://localhost:8080/geoserver/rest/workspaces
#curl -v -u admin:geoserver -XPOST -T ${DIR}/test-store.xml -H "Content-type: text/xml" http://localhost:8080/geoserver/rest/workspaces/test/datastores
#curl -v -u admin:geoserver -XPOST -T ${DIR}/modis-2015.xml -H "Content-type: text/xml" http://localhost:8080/geoserver/rest/workspaces/test/datastores/test/featuretypes
#curl -v -u admin:geoserver -XPOST -T ${DIR}/modis-2015_daycount.xml -H "Content-type: text/xml" http://localhost:8080/geoserver/rest/workspaces/test/datastores/test/featuretypes
