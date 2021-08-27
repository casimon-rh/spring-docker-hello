#!/bin/bash
oc new-build --strategy docker --binary --name java-demo --docker-image registry.access.redhat.com/ubi8/openjdk-8-runtime 2>/dev/null
rm -f java-demo/demo.jar
mvn clean package -f ../pom.xml -P jar
cp ../target/demo.jar java-demo/demo.jar
oc start-build java-demo --from-dir java-demo --follow
oc new-app -i java-demo

oc set probe deployment/java-demo --remove --readiness --liveness
oc set probe deployment/java-demo --liveness --get-url=http://:8080/actuator/health --initial-delay-seconds=40
oc set probe deployment/java-demo --readiness --get-url=http://:8080/actuator/health --initial-delay-seconds=40

oc create route edge --service=java-demo

oc create cm appconfig --from-literal=MY_APPLICATION_NAME=java
oc set env deployment/java-demo --from=configmap/appconfig