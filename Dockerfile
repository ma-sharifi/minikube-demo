#Start with a base image containing Java runtime
FROM openjdk:17.0.1-jdk-slim
# Add Maintainer Info
LABEL maintainer="Mahdi Sharifi <mahdi.elu@gmail.com> "
VOLUME /tmp
#ARG JAR_FILE. You have to pass it as a docker build argumanet JAR_FILE=target/minikube-demo.jar
ARG JAR_FILE
## Add the application's jar to the container
COPY ${JAR_FILE} minikube-demo.jar
ENTRYPOINT ["java","-jar","/minikube-demo.jar"]