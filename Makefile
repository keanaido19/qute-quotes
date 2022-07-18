all: maven_clean maven_validate maven_compile maven_test maven_package \
docker_compose flutter_build

.PHONY: all maven_clean maven_validate maven_compile maven_test maven_package\
 docker_compose flutter_build

maven_clean:
	mvn clean

maven_validate:
	mvn validate

maven_compile:
	mvn compile

maven_test:
	mvn test

maven_package:
	mvn package -DskipTests

docker_compose:
	docker compose build

flutter_build:
	cd app && snapcraft
