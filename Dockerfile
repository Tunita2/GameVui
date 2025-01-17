FROM openjdk:23-jdk AS build
COPY . .
RUN project clean package -DskipTests

FROM openjdk:23-jdk-slim
COPY --from=build /utilz/demo-0.0.1-SNAPSHOT.jar demo.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","demo.jar"]