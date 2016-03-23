FROM dgageot/quine

RUN apt-get update -qq && apt-get install -y openjdk-8-jdk

COPY . ./
