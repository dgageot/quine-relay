FROM dgageot/quine

RUN apt-get update -qq && apt-get install -y clojure1.6

COPY . ./
