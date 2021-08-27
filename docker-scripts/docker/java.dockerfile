FROM registry.access.redhat.com/ubi8/openjdk-8-runtime:1.9
COPY target/demo.jar .
ENV MY_APPLICATION_NAME demo
CMD ["java","-jar","demo.jar"]