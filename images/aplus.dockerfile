FROM dgageot/quine:base

RUN apt-get update -qq && apt-get install -y aplus-fsf

COPY . ./
