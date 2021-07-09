#!/bin/bash
oc new-build --strategy docker --binary --name java-demo --docker-image registry.access.redhat.com/ubi8/openjdk-8-runtime 2>/dev/null
rm -f java-demo/demo.jar
mvn clean package -f ../pom.xml -P jar
cp ../target/demo.jar java-demo/demo.jar
oc start-build java-demo --from-dir java-demo --follow
oc new-app -i java-demo

# oc set probe dc/java-demo --remove --readiness --liveness
# oc set probe dc/java-demo --liveness --get-url=http://:8080/greeting --initial-delay-seconds=40
# oc set probe dc/java-demo --readiness --get-url=http://:8080/greeting --initial-delay-seconds=40

oc create route edge --service=java-demo
