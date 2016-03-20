FROM quine/base

RUN apt-get update -qq && apt-get install -y curl make unzip cmake gcc g++ gdc libgd2-xpm-dev groff	ruby2.1 bf

RUN (curl -sSL https://github.com/mame/quine-relay/archive/86f3b4d17faac3b9626dd35eaaada055e12769fa.tar.gz | tar zx --strip-components 1) \
	&& make -C vendor

COPY . ./
