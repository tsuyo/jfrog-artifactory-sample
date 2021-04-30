FROM platform.tsuyo.org/hello-docker/openjdk:17-jdk-alpine

RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} hello.jar

ENTRYPOINT ["java", "-jar", "/hello.jar"]
