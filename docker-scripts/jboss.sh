#!/bin/bash
mvn clean package -f ../pom.xml
docker build --compress -f ./docker/jboss.dockerfile -t demo-jboss ..
docker run -e MY_APPLICATION_NAME=jboss --rm -p 8080:8080 -it demo-jboss 