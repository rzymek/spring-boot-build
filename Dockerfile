FROM openjdk:11-jdk as build
WORKDIR /build
COPY .mvn .mvn
COPY mvnw pom.xml ./
ARG SPRING
RUN sed -i "s/%SPRING%/$SPRING/g" pom.xml && \
    ./mvnw package -Dspring-boot.repackage.skip &&  rm -r target pom.xml
