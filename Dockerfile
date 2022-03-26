FROM 7.4.1-jdk11-alpine AS build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build --no-daemon

FROM openjdk:17-alpine

EXPOSE 80

RUN mkdir /app

COPY --from=build /home/gradle/src/build/libs/*.jar /app/cabinet.jar

ENTRYPOINT ["java","/app/cabinet.jar"]