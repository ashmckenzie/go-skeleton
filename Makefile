PROJECT_NAME ?= <CHANGE-ME-project-name>
VERSION=$(shell cat VERSION)

DOCKER_HUB_USERNAME ?= <CHANGE-ME-docker_hub_username
DOCKER_REGISTRY ?= index.docker.io
DOCKER_IMAGE_VERSION ?= latest

DOCKER_IMAGE_NAME = ${DOCKER_HUB_USERNAME}/${PROJECT_NAME}
DOCKER_FILE = Dockerfile
DOCKER_PORTS ?= -p 5000:5000
DOCKER_ENVS=
DOCKER_BUILD_ARGS=--build-arg PROJECT_NAME=${PROJECT_NAME} --build-arg VERSION=${VERSION}
DOCKER_OPTS=${DOCKER_PORTS} ${DOCKER_ENVS}

.PHONY: run shell attach clean

build:
	make -C app release
	docker build -f ${DOCKER_FILE} ${DOCKER_BUILD_ARGS} -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VERSION} .

run: build
	docker run --rm -ti ${DOCKER_OPTS} ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VERSION}

shell: build
	docker run --rm -ti ${DOCKER_OPTS} ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VERSION} bash

attach: build
	docker exec -ti `docker ps | grep '${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VERSION}' | awk '{ print $$1 }'` bash

push: build
	docker tag ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VERSION} ${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VERSION} && docker push ${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VERSION}

clean:
	docker rmi ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VERSION}
