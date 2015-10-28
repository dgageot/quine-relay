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

RUN apt-get update -qq && apt-get install -y \
	aplus-fsf \
	asymptote \
	ats-lang-anairiats \
	bash \
	bsdgames \
	bf \
	clisp \
	cmake \
	ecere-sdk \
	f2c \
	falconpl \
	fp-compiler \
	fsharp \
	g++ \
	gambas3-script \
	gauche \
	gawk \
	gcc \
	gdc \
	gforth \
	gfortran \
	ghc \
	ghostscript \
	gnu-smalltalk \
	gobjc \
	gpt \
	gri \
	groff \
	iconx \
	intercal \
	iverilog \
	libgd2-xpm-dev \
	libpng12-dev \
	lisaac \
	llvm \
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
	tcc

RUN (curl -sSL https://github.com/mame/quine-relay/archive/b2599cb4d01fb796b5266d6af285953747848deb.tar.gz | tar zx --strip-components 1) \
	&& make -C vendor

ADD server.go ./
RUN go get . || true
ADD steps.json ./
