FROM ubuntu:15.04
MAINTAINER David Gageot <david@gageot.net>

RUN apt-get update -qq && apt-get install -y \
	openjdk-8-jdk \
	git \
	golang

ENV GOPATH $HOME/go
ENV CLASSPATH .
EXPOSE 8080
CMD ["go", "run", "server.go"]

RUN mkdir /tmp/quine
WORKDIR /quine-relay

ADD steps.json ./
ADD server.go ./
RUN go get . || true
