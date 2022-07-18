all: maven_clean maven_validate maven_compile maven_test maven_package \
docker_compose client_app_snap

.PHONY: all maven_clean maven_validate maven_compile maven_test maven_package\
 docker_compose client_app_snap

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

client_app_snap:
	cd app; snapcraft --use-lxd;