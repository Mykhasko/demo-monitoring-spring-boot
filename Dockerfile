FROM gradle:8.14-jdk24-alpine AS build
WORKDIR /home/gradle/project

# Copy the Gradle wrapper and configuration files
COPY --chown=gradle:gradle gradlew .
COPY --chown=gradle:gradle gradle gradle
COPY --chown=gradle:gradle settings.gradle .
COPY --chown=gradle:gradle build.gradle .

RUN gradle dependencies --no-daemon

# Copy the source code and resources
COPY --chown=gradle:gradle src src

COPY --chown=gradle:gradle . .
RUN gradle build --no-daemon

FROM eclipse-temurin:24-jre-alpine AS runtime
# Set the environment variable for the Spring Boot profile
ARG SPRING_BOOT_PROFILE=docker
# Set the environment variable for the log file path
# will be overridden by the environment variable LOG_FILE_PATH in compose file
ENV LOG_FILE_PATH="/var/log/demo-monitoring-spring-boot"
# Create spring group and user with specific UID and GID that greater than 1000 (need for Podman compatibility)
# This is to ensure compatibility with Podman, which requires non-root users to have UIDs
# and GIDs greater than 1000.
RUN addgroup -S -g 1001 spring && adduser -S -u 1001 -G spring spring
# Set the working directory
WORKDIR /app
# Create the directory for logs that Promtail will access
RUN mkdir /var/log/demo-monitoring-spring-boot && chown spring:spring /var/log/demo-monitoring-spring-boot
# If you want to use a different directory for logs, uncomment the line below and comment the above line
# RUN mkdir /app/log && chown spring:spring /app/log

COPY --from=build /home/gradle/project/build/libs/*.jar app.jar
# Use non-root user
USER spring:spring

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "-Dspring.profiles.active=${SPRING_BOOT_PROFILE}","app.jar"]