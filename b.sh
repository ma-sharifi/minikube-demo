#!/usr/bin/env bash

ECHO "#Building jar..."
time mvn clean package
ECHO "#Building docker image..."
time docker build --build-arg JAR_FILE=target/minikube-demo.jar -t minikube-demo:1.0 .
docker run -i --rm -p 8080:8080 minikube-demo:1.0