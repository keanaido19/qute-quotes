FROM openjdk:11
MAINTAINER keaton naidoo <keanaido021@student.wethinkcode.co.za>

WORKDIR app
COPY target/Server*.jar QuteQuotesServer.jar
COPY Quote.sqlite Quote.sqlite

EXPOSE 5000
CMD ["java", "-jar", "QuteQuotesServer.jar"]
