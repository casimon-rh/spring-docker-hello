#!/bin/bash
oc import-image jboss-eap-7/eap73-openjdk11-openshift-rhel8:latest --from=registry.redhat.io/jboss-eap-7/eap73-openjdk11-openshift-rhel8 --confirm
oc new-app eap73-openjdk11-openshift-rhel8~https://github.com/casimon-rh/spring-docker-hello --name jboss-s2i

# oc set probe dc/jboss-s2i --remove --readiness --liveness
# oc set probe dc/jboss-s2i --liveness --get-url=http://:8080/ --initial-delay-seconds=240
# oc set probe dc/jboss-s2i --readiness --get-url=http://:8080/ --initial-delay-seconds=240

oc create route edge --service=jboss-s2i