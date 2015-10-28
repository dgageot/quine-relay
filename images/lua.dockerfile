FROM quine/base

RUN apt-get update -qq && apt-get install -y lua5.2

COPY server.go ./
RUN go get . || true
COPY steps.json ./
