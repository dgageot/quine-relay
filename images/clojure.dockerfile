FROM quine/base

RUN apt-get update -qq && apt-get install -y clojure1.6

ADD server.go ./
RUN go get . || true
ADD steps.json ./
