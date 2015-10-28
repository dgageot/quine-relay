FROM quine/base

RUN apt-get update -qq && apt-get install -y lua5.2

ADD server.go ./
RUN go get . || true
ADD steps.json ./
