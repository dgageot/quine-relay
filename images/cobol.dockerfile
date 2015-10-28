FROM quine/base

RUN apt-get update -qq && apt-get install -y open-cobol

ADD server.go ./
RUN go get . || true
ADD steps.json ./
