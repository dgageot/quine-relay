FROM dgageot/quine:base

RUN apt-get update -qq && apt-get install -y bsdgames

ENV PATH /root/go/src/github.com/dgageot/quine-relay/vendor/local/bin:$PATH

ENV PATH $PATH:/usr/games

COPY . ./
