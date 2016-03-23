FROM dgageot/quine

RUN apt-get update -qq && apt-get install -y lua5.2

COPY . ./
