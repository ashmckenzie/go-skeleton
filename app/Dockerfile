FROM golang:latest
MAINTAINER ash@the-rebellion.net

ARG PROJECT_NAME
ARG CURRENT_USER_UID
ARG BUILD_USER

ENV PROJECT_NAME ${PROJECT_NAME}
ENV APP_HOME /app
ENV GOPATH /app
ENV RELEASE_DIR /release
ENV PATH ${GOPATH}/bin:${PATH}

RUN apt-get -qq update && apt-get -qq install -y sudo bash
RUN useradd -d ${APP_HOME} -u ${CURRENT_USER_UID} builder

RUN mkdir -p ${APP_HOME} ${GOPATH} ${RELEASE_DIR}
WORKDIR ${APP_HOME}

COPY . ${APP_HOME}/
RUN ln -s . src

RUN chown -R builder ${APP_HOME} ${GOPATH}

# Docker doesn't seem to support WORKDIR ${APP_HOME}/src
RUN cd ${APP_HOME}/src ; make install_govendor
RUN cd ${APP_HOME}/src ; make static

RUN echo "extract_releases:\n\tinstall -o ${BUILD_USER} /app/release/* ${RELEASE_DIR}/" >> Makefile
