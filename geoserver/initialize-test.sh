#!/bin/bash

$CATALINA_HOME/bin/startup.sh && sleep 5

curl -v -u admin:geoserver -XPOST -H "Content-type: text/xml" -d "<workspace><name>test</name></workspace>" http://localhost:8080/geoserver/rest/workspaces

curl -v -u admin:geoserver -XPOST -T test-store.xml -H "Content-type: text/xml" http://localhost:8080/geoserver/rest/workspaces/test/datastores

$CATALINA_HOME/bin/shutdown.sh && sleep 5
