FROM registry.redhat.io/jboss-eap-7/eap73-openjdk11-openshift-rhel8:7.3.7
ENV MY_APPLICATION_NAME demo
COPY target/demo.war $JBOSS_HOME/standalone/deployments/demo.war