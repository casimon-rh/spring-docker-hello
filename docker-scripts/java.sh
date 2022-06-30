#!/bin/bash
#? Etapa de construcción
mvn clean package -f ../pom.xml -P jar
podman build --compress -f ./docker/java.dockerfile -t demo-java ..
#? Etapa de despliegue
podman run -e MY_APPLICATION_NAME=java --rm -p 8080:8080 -it demo-java 