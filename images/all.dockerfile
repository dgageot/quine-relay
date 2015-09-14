FROM ubuntu:15.04
MAINTAINER David Gageot <david@gageot.net>

RUN apt-get update -qq && apt-get install -y \
	git \
	golang

ENV GOPATH $HOME/go
ENV CLASSPATH .
ENV PATH /quine-relay/vendor/local/bin:$PATH:/usr/games
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
EXPOSE 8080
CMD ["go", "run", "server.go"]

RUN mkdir /tmp/quine
WORKDIR /quine-relay

ADD server.go ./
RUN go get . || true

RUN apt-get update -qq && apt-get install -y \
	afnix \
	algol68g \
	aplus-fsf \
	asymptote \
	ats-lang-anairiats \
	bash \
	bc \
	bf \
	bsdgames \
	clisp \
	clojure1.6 \
	cmake \
	coffeescript \
	dc \
	ecere-sdk \
	emacs24 \
	erlang \
	f2c \
	falconpl \
	fp-compiler \
	fsharp \
	g++ \
	gambas3-script \
	gap \
	gauche \
	gawk \
	gcc \
	gdc \
	genius \
	gforth \
	gfortran \
	ghc \
	ghostscript \
	gnat \
	gnu-smalltalk \
	gnuplot \
	gobjc \
	gpt \
	gri \
	groff \
	icont \
	iconx \
	intercal \
	iverilog \
	libgd2-xpm-dev \
	libpng12-dev \
	lisaac \
	llvm \
	lua5.2 \
	make \
	mlton \
	mono-devel \
	mono-mcs \
	mono-vbnc \
	nasm \
	openjdk-8-jdk \
	pari-gp \
	perl \
	php5-cli \
	pike7.8 \
	python \
	r-base \
	regina-rexx \
	ruby2.1 \
	slsh \
	spl-core \
	swi-prolog \
	tcc

RUN (curl -sSL https://github.com/mame/quine-relay/archive/b2599cb4d01fb796b5266d6af285953747848deb.tar.gz | tar zx --strip-components 1) \
	&& make -C vendor

ADD steps.json ./
