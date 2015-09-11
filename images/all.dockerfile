FROM ubuntu:15.04
MAINTAINER David Gageot <david@gageot.net>

RUN apt-get update -qq && apt-get install -y \
	git \
	golang

ENV GOPATH $HOME/go
EXPOSE 8080
CMD ["go", "run", "server.go"]

RUN mkdir /tmp/quine
WORKDIR /quine-relay

ADD steps.json ./
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
	boo \
	bsdgames \
	cduce \
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
	groovy \
	haxe \
	icont \
	iconx \
	intercal \
	iverilog \
	jasmin-sable \
	julia \
	kaya \
	libgd2-xpm-dev \
	libpng12-dev \
	lisaac \
	llvm \
	lua5.2 \
	make \
	maven \
	maxima \
	mlton \
	mono-devel \
	mono-mcs \
	mono-vbnc \
	nasm \
	neko \
	nickle \
	ocaml \
	octave \
	open-cobol \
	pari-gp \
	parrot \
	perl \
	php5-cli \
	pike7.8 \
	python \
	r-base \
	ratfor \
	regina-rexx \
	rhino \
	ruby2.1 \
	scilab \
	slsh \
	spl-core \
	swi-prolog \
	tcc \
	tcl \
	ucblogo \
	valac \
	xsltproc \
	yorick \
	zoem

ENV PATH /quine-relay/vendor/local/bin:$PATH:/usr/games
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

RUN (curl -sSL https://github.com/mame/quine-relay/archive/b2599cb4d01fb796b5266d6af285953747848deb.tar.gz | tar zx --strip-components 1) \
	&& make -C vendor
