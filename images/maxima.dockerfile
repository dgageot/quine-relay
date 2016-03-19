FROM fedora:20
MAINTAINER David Gageot <david@gageot.net>
LABEL demo="quine-relay"

RUN yum -y update && yum -y install \
	git \
	golang

ENV GOPATH /root/go
ENV CLASSPATH .
ENV PATH /root/go/src/github.com/dgageot/quine-relay/vendor/local/bin:$PATH:/usr/games
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
ENV GO15VENDOREXPERIMENT 1
EXPOSE 8080
CMD ["go", "run", "server.go"]
WORKDIR /root/go/src/github.com/dgageot/quine-relay
RUN mkdir /tmp/quine

RUN yum -y update &&  yum -y install maxima

COPY . ./
