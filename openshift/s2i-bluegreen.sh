#!/bin/bash
oc import-image ubi8/openjdk-8 --from=registry.access.redhat.com/ubi8/openjdk-8 --confirm
for color in $(echo "blue green"); do
  oc new-app openjdk-8-ubi8~https://github.com/casimon-rh/spring-docker-hello#$color --name java-$color -p JAVA_APP_JAR=demo.jar
  oc rollout pause deployment/java-$color
  oc set probe deployment/java-$color --remove --readiness --liveness
  oc set probe deployment/java-$color --liveness --get-url=http://:8080/actuator/health --initial-delay-seconds=240
  oc set probe deployment/java-$color --readiness --get-url=http://:8080/actuator/health --initial-delay-seconds=240
  oc create cm s2i-appconfig-$color --from-literal=MY_APPLICATION_NAME=java-$color
  oc set env deployment/java-$color --from=configmap/s2i-appconfig-$color
  oc rollout resume deployment/java-$color
done
# oc create route edge --service=java-colors