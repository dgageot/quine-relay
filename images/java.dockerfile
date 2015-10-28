FROM quine/base

RUN apt-get update -qq && apt-get install -y openjdk-8-jdk

COPY server.go ./
RUN go get . || true
COPY steps.json ./
