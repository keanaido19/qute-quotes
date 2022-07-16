FROM openjdk:11
MAINTAINER keaton naidoo <keanaido021@student.wethinkcode.co.za>

WORKDIR app
COPY target/Server*.jar QuteQuotesServer.jar

EXPOSE 5050
CMD ["java", "-jar", "QuteQuotesServer.jar","-p","5050"]
