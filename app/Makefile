PROJECT_NAME ?= <CHANGE-ME-project-name>
VERSION=$(shell cat VERSION)

BUILD_IMAGE_NAME = $(PROJECT_NAME)-build

APP_DIR ?= $(PWD)
BIN_DIR = $(APP_DIR)/bin
RELEASE_DIR = $(APP_DIR)/release

BUILD_USER = builder
CURRENT_USER_UID = 1000

BUILD_ARGS=-i -ldflags="-X main.version=${VERSION} -X main.projectName=${PROJECT_NAME}"

.PHONY: create_build_image deps update_deps release_dir bin_dir test run clean

default: bin_dir test
	go build ${BUILD_ARGS} -o $(BIN_DIR)/${PROJECT_NAME}

run: test
	go run main.go $(filter-out $@, $(MAKECMDGOALS))

static: release_dir test
	CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo ${BUILD_ARGS} -o ${RELEASE_DIR}/${PROJECT_NAME}_linux_$(VERSION)

release: create_build_image
	mkdir -p ${RELEASE_DIR}
	docker build --build-arg PROJECT_NAME=${PROJECT_NAME} --build-arg CURRENT_USER_UID=${CURRENT_USER_UID} --build-arg BUILD_USER=${BUILD_USER} -f Dockerfile -t ${BUILD_IMAGE_NAME} .
	docker run --rm -v ${RELEASE_DIR}:/release -e BUILD_USER=${BUILD_USER} ${BUILD_IMAGE_NAME} make extract_releases

install_govendor:
	go get -u github.com/kardianos/govendor

test: deps
	go test -cover

clean:
	rm -rf $(BIN_DIR) $(RELEASE_DIR)

deps:
	govendor fetch +missing

update_deps:
	govendor update +e

bin_dir:
	mkdir -p $(BIN_DIR)

release_dir:
	mkdir -p ${RELEASE_DIR}
