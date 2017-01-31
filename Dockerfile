FROM alpine
MAINTAINER ash@the-rebellion.net

RUN apk --update add bash curl unzip wget

ARG PROJECT_NAME
ARG VERSION

ENV PROJECT_NAME ${PROJECT_NAME}
ENV VERSION ${VERSION}
ENV APP_HOME /app

RUN mkdir ${APP_HOME}

WORKDIR /usr/local/bin

RUN curl -Lqs https://bin.equinox.io/c/ekMN3bCZFUn/forego-stable-linux-amd64.tgz | tar xzf -
RUN chmod 755 /usr/local/bin/*

WORKDIR ${APP_HOME}

COPY Procfile ${APP_HOME}/
COPY release/ ${APP_HOME}/

CMD forego start
