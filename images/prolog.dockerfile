FROM quine/base

RUN apt-get update -qq && apt-get install -y swi-prolog

ADD server.go ./
RUN go get . || true
ADD steps.json ./
