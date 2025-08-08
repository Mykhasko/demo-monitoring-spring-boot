# Spring Boot Gradle Project

This is a sample Spring Boot application using Gradle.

## Requirements

- JDK 24
- Gradle
- Docker Compose (Podman) if needed for infrastructure

## Build and Run

```sh
./gradlew build
./gradlew bootRun
```

## Run Tests
```sh
./gradlew test
```

## Infrastructure (Docker Compose)

For Docker compose, you can use the following command to build and run the application:

```bash
docker compose up --build
```

1. Loki
2. Promtail
3. Grafana
4. Spring Boot Application

for access to Grafana, you can use the following URL:

```
http://localhost:3000
_______________________________
username: admin
password: admin
_______________________________
```

