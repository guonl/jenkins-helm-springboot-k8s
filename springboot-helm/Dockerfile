FROM openjdk:8-jdk-alpine
MAINTAINER guonl <nianlei.guo@tigerobo.com>

#日志问题，通过挂在磁盘解决
COPY target/springboot-helm-0.0.1-SNAPSHOT.jar /app.jar
EXPOSE 8080
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]