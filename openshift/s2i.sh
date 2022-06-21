#!/bin/bash
oc import-image jboss-eap-7/eap73-openjdk11-openshift-rhel8:latest --from=registry.redhat.io/jboss-eap-7/eap73-openjdk11-openshift-rhel8 --confirm
oc new-app eap73-openjdk11-openshift-rhel8~https://github.com/casimon-rh/spring-docker-hello --name jboss-s2i

oc set probe deployment/jboss-s2i --remove --readiness --liveness
oc set probe deployment/jboss-s2i --liveness --get-url=http://:8080/demo/actuator/health --initial-delay-seconds=120
oc set probe deployment/jboss-s2i --readiness --get-url=http://:8080/demo/actuator/health --initial-delay-seconds=120

oc create route edge --service=jboss-s2i


oc create cm s2i-appconfig --from-literal=MY_APPLICATION_NAME=s2i-jboss
oc set env deployment/jboss-s2i --from=configmap/s2i-appconfig