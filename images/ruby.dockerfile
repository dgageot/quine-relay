FROM dgageot/quine:base

RUN apt-get update -qq && apt-get install -y ruby2.1

COPY . ./
