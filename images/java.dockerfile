FROM quine/base

RUN apt-get update -qq && apt-get install -y openjdk-8-jdk

ADD server.go ./
RUN go get . || true
ADD steps.json ./
