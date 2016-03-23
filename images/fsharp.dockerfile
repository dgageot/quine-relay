FROM dgageot/quine

RUN apt-get update -qq && apt-get install -y fsharp

COPY . ./
