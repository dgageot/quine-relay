FROM quine/base

RUN apt-get update -qq && apt-get install -y rhino

ADD server.go ./
RUN go get . || true
ADD steps.json ./
