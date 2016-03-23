FROM dgageot/quine

RUN apt-get update -qq && apt-get install -y pike7.8

COPY . ./
