FROM dl-common-docker.artifactory-ehv.ta.philips.com/gradle:jdk11-hotspot as builder
WORKDIR application

COPY --chown=gradle:gradle . /src
WORKDIR /src
RUN gradle build --no-daemon -x test

#COPY build/libs/*.jar application.jar
RUN java -Djarmode=layertools -jar build/libs/demo-0.0.1-SNAPSHOT.jar extract

FROM dl-common-docker.artifactory-ehv.ta.philips.com/adoptopenjdk:11-jre-hotspot

WORKDIR application

COPY --from=builder src/spring-boot-loader/ ./
COPY --from=builder src/dependencies/ ./
COPY --from=builder src/snapshot-dependencies/ ./
COPY --from=builder src/application/ ./

EXPOSE 8080

ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]
