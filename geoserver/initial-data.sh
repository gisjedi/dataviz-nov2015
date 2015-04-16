#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
curl -v -u admin:geoserver -XDELETE http://localhost:8080/geoserver/rest/workspaces/test?recurse=true
curl -v -u admin:geoserver -XPOST -H "Content-type: text/xml" -d "<workspace><name>test</name></workspace>" http://localhost:8080/geoserver/rest/workspaces
curl -v -u admin:geoserver -XPOST -T ${DIR}/test-store.xml -H "Content-type: text/xml" http://localhost:8080/geoserver/rest/workspaces/test/datastores
curl -v -u admin:geoserver -XPOST -T ${DIR}/modis-2015.xml -H "Content-type: text/xml" http://localhost:8080/geoserver/rest/workspaces/test/datastores/test/featuretypes
curl -v -u admin:geoserver -XPOST -T ${DIR}/modis-2015_daycount.xml -H "Content-type: text/xml" http://localhost:8080/geoserver/rest/workspaces/test/datastores/test/featuretypes
