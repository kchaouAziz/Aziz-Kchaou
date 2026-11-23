FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY target/Aziz-Kchaou-1.0-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
