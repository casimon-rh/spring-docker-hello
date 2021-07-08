#!/bin/bash
mvn clean package -f ../pom.xml -P jar
docker build --compress -f ./docker/java.dockerfile -t demo-java ..
docker run --rm -p 8080:8080 -it demo-java 