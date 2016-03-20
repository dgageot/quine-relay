FROM quine/base

RUN apt-get update -qq && apt-get install -y php5-cli

COPY . ./
