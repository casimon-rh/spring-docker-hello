#!/bin/bash
oc new-build --strategy docker --binary --name jboss-demo --docker-image registry.redhat.io/jboss-eap-7/eap73-openjdk11-openshift-rhel8 2>/dev/null
rm -f jboss-demo/demo.war
mvn clean package -f ../pom.xml
cp ../target/demo.war jboss-demo/demo.war
oc start-build jboss-demo --from-dir jboss-demo --follow
oc new-app -i jboss-demo

# oc set probe dc/jboss-demo --remove --readiness --liveness
# oc set probe dc/jboss-demo --liveness --get-url=http://:8080/ --initial-delay-seconds=140
# oc set probe dc/jboss-demo --readiness --get-url=http://:8080/ --initial-delay-seconds=140


oc create route edge --service=jboss-demo
