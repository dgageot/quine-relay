FROM quine/base

RUN apt-get update -qq && apt-get install -y clojure1.6

COPY server.go ./
RUN go get . || true
COPY steps.json ./
