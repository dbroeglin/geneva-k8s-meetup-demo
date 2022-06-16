#
# Build stage
#
FROM maven:3.8.6-jdk-11-slim AS build
WORKDIR /build
COPY pom.xml .
COPY src ./src
RUN mvn clean package

#
# Package stage
#
FROM openjdk:11-jre-slim
COPY --from=build /build/target/*.jar /demo.jar
EXPOSE 8080
CMD ["java", "-jar", "demo.jar"]