FROM maven:3-eclipse-temurin-22 AS builder

# Thư mục làm việc bên trong container (tùy đặt tên, cho dễ cứ để /app)
WORKDIR /app

# Copy file cấu hình Maven
COPY pom.xml .

# Copy source code
COPY src ./src

RUN mvn clean package -DskipTests

FROM tomcat:jdk25
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=builder /app/target/NewWebProject-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD [ "catalina.sh", "run" ]