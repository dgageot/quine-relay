FROM dgageot/quine:base

RUN apt-get update -qq && apt-get install -y intercal

COPY . ./
