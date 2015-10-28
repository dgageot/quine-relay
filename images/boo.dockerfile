FROM ubuntu:15.04
MAINTAINER David Gageot <david@gageot.net>

RUN apt-get update -qq && apt-get install -y \
	git \
	golang

ENV GOPATH $HOME/go
ENV CLASSPATH .
ENV PATH /quine-relay/vendor/local/bin:$PATH:/usr/games
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
EXPOSE 8080
CMD ["go", "run", "server.go"]

RUN mkdir /tmp/quine
WORKDIR /quine-relay

RUN apt-get update -qq && apt-get install -y boo

ADD server.go ./
RUN go get . || true
ADD steps.json ./
