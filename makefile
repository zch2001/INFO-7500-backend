# Variables
PROJECT_NAME=bitcoin-be
DOCKERHUB=zch2001
PROJECT_VERSION=$(VERSION)
DOCKER_IMAGE_NAME=$(DOCKERHUB)/$(PROJECT_NAME):$(PROJECT_VERSION)
DOCKER_CONTAINER_NAME=$(PROJECT_NAME)-container

# Buld docker image
.PHONY: docker-build
docker-build:
	docker build -t $(DOCKER_IMAGE_NAME) .

# Push docker image to docker hub
.PHONY: docker-push
docker-push:
	docker push $(DOCKER_IMAGE_NAME)

# Run docker container
.PHONY: docker-run
docker-run:
	docker run -d \
	--network bitExp-network \
	--name $(DOCKER_CONTAINER_NAME) \
	-p 5000:5000 \
	-e MYSQL_HOST=$(MYSQL_HOST) \
	-e MYSQL_USER=$(MYSQL_USER) \
	-e MYSQL_PASSWORD=$(MYSQL_PASSWORD) \
	-e MYSQL_DB=bitcoin_explorer \
	-e REDIS_HOST=$(REDIS_HOST) \
	-e REDIS_PORT=$(REDIS_PORT) \
	-e REDIS_PASSWORD=$(REDIS_PASSWORD) \
	$(DOCKER_IMAGE_NAME)

# Clean docker container
.PHONY: docker-clean
docker-clean:
	docker stop $(DOCKER_CONTAINER_NAME)
	docker rm $(DOCKER_CONTAINER_NAME)

# Release by tag version and y/n to confirm
.PHONY: release
release:
	git tag -a $(PROJECT_VERSION) -m "Release version $(PROJECT_VERSION)"
	git push origin $(PROJECT_VERSION)