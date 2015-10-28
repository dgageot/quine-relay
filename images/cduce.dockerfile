FROM quine/base

RUN apt-get update -qq && apt-get install -y cduce

COPY server.go ./
RUN go get . || true
COPY steps.json ./
