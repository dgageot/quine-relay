FROM dgageot/quine:base

RUN apt-get update -qq && apt-get install -y mono-devel \
	mono-mcs \
	mono-vbnc

COPY . ./
