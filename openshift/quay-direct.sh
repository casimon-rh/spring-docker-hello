#!/bin/bash
oc import-image casimon/spring-hello:latest --from=quay.io/casimon/spring-hello:latest --confirm
oc new-app -i spring-hello

oc set probe deployment/spring-hello --remove --readiness --liveness
oc set probe deployment/spring-hello --liveness --get-url=http://:8080/demo/actuator/health --initial-delay-seconds=240
oc set probe deployment/spring-hello --readiness --get-url=http://:8080/demo/actuator/health --initial-delay-seconds=240

oc create route edge --service=spring-hello


oc create cm s2i-appconfig --from-literal=MY_APPLICATION_NAME=java
oc set env deployment/spring-hello --from=configmap/s2i-appconfig