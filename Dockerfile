# FROM adoptopenjdk/openjdk11

# EXPOSE 8080

# ENV APP_HOME /usr/src/app

# COPY target/*.jar $APP_HOME/app.jar

# WORKDIR $APP_HOME

# CMD ["java", "-jar", "app.jar"]

FROM adoptopenjdk/openjdk11 AS builder

WORKDIR /app

COPY . .  
RUN mvn package -DskipTests

# Combine the lines:
FROM openjdk:11-slim COPY --from=builder /app/target/*.jar $APP_HOME/app.jar

WORKDIR $APP_HOME

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]