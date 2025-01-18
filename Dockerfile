# Build stage
FROM openjdk:23-jdk AS build
WORKDIR /app
COPY . .

# Compile Java files
RUN javac -d out src/main/MainClass.java && \
    echo "Main-Class: MainClass" > manifest.txt && \
    jar cvfm demo.jar manifest.txt -C out .

# Run stage
FROM openjdk:23-jdk-slim
WORKDIR /app
COPY --from=build /app/demo.jar demo.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "demo.jar"]
