FROM dgageot/quine

RUN apt-get update -qq && apt-get install -y f2c gcc

COPY . ./
