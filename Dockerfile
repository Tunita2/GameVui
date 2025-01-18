# Build stage
FROM openjdk:23-jdk AS build
WORKDIR /app
COPY . .
# Compile Java files và tạo JAR
RUN javac -d out src/**/*.java && \
    jar -cvf demo.jar -C out .

# Run stage
FROM openjdk:23-jdk-slim
WORKDIR /app
COPY --from=build /app/demo.jar demo.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "demo.jar"]
