FROM dgageot/quine:base

RUN apt-get update -qq && apt-get install -y pike7.8

COPY . ./
