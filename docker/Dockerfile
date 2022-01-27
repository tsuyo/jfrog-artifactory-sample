ARG URL
FROM ${URL}/openjdk:11-jre-slim

ARG JAR_FILE=maven/target/*-with-dependencies.jar
COPY ${JAR_FILE} hello.jar

ENTRYPOINT ["java", "-jar", "/hello.jar"]
