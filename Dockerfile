FROM ubuntu:15.04
MAINTAINER David Gageot <david@gageot.net>

RUN apt-get update -qq && apt-get install -y \
	git \
	golang

ENV GOPATH $HOME/go
ENV CLASSPATH .
ENV PATH /quine-relay/vendor/local/bin:$PATH:/usr/games
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
ENV GO15VENDOREXPERIMENT 1
EXPOSE 8080
CMD ["go", "run", "server.go"]
WORKDIR $GOPATH/src/github.com/quine-relay
RUN mkdir /tmp/quine
